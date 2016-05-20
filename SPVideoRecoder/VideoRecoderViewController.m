//
//  VideoRecoderViewController.m
//  SPVideoRecoder
//
//  Created by Niraj Gat on 5/13/16.
//  Copyright © 2016 Niraj Gat. All rights reserved.
//

#import "VideoRecoderViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "AppDelegate.h"
#import "VideoRecording.h"
#import "VideoRecording+CoreDataProperties.h"
#import "VideoViewController.h"


@interface VideoRecoderViewController ()

@end

@implementation VideoRecoderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)onTakeVideoBtn:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        picker.allowsEditing = NO;
        
        NSArray *mediaTypes = [[NSArray alloc]initWithObjects:(NSString *)kUTTypeMovie, nil];
        
        picker.mediaTypes = mediaTypes;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    } else {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Oopss there is no camera" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alertView show];
    }

    
}


- (IBAction)submit:(id)sender {
    
    VideoViewController *vc=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"vc"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - Delegate Methods

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // user hit cancel
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // grab our movie URL
    NSURL *chosenMovie = [info objectForKey:UIImagePickerControllerMediaURL];
    
    // save it to the documents directory
    NSURL *fileURL = [self grabFileURL:@"video2.mov"];
    NSData *movieData = [NSData dataWithContentsOfURL:chosenMovie];
    [movieData writeToURL:fileURL atomically:YES];
    
    
    
    // insert into database
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    VideoRecording *recording = [NSEntityDescription insertNewObjectForEntityForName:@"VideoRecording"
                                                         inManagedObjectContext:context];
    
    NSString *filePath=[fileURL absoluteString];
    NSString *fileName=[fileURL lastPathComponent];
    
    recording.filename=fileName;
    recording.filepath=filePath;
    
   
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"error whiling inserting new person record: %@", [error localizedDescription]);
    }

    
    // save it to the Camera Roll

   // UISaveVideoAtPathToSavedPhotosAlbum([chosenMovie path], nil, nil, nil);
    
    // and dismiss the picker
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (NSURL*)grabFileURL:(NSString *)fileName {
    
    // find Documents directory
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    // append a file name to it
    documentsURL = [documentsURL URLByAppendingPathComponent:fileName];
    
    return documentsURL;
}



@end
