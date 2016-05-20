//
//  VideoViewController.m
//  SPVideoRecoder
//
//  Created by Niraj Gat on 5/16/16.
//  Copyright © 2016 Niraj Gat. All rights reserved.
//

#import "VideoViewController.h"
#import "VideosTableViewCell.h"
#import "AppDelegate.h"
#import "VideoRecording+CoreDataProperties.h"
#import "VideoRecording.h"
#import <AVKit/AVKit.h>

@interface VideoViewController ()

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Register TableViewCell
    [self.tableView registerNib:[UINib nibWithNibName:@"VideosTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    recordingArray=[[NSMutableArray alloc]init];
    
    // fetch the all recording files from db and storing into in array
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"VideoRecording"];
    
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    [recordingArray removeAllObjects];
    [recordingArray addObjectsFromArray:array];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [recordingArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideosTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    VideoRecording *record =[recordingArray objectAtIndex:indexPath.row];
    cell.videoRecordingName.text=record.filename;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    VideoRecording *record =[recordingArray objectAtIndex:indexPath.row];
    
    // video URL creation
    NSString *path=record.filepath;
    NSURL *videoURL=[NSURL URLWithString:path];
    
    
    
    AVPlayer *video=[AVPlayer playerWithURL:videoURL];
    AVPlayerItem* playerItem = [AVPlayerItem playerItemWithURL:videoURL];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
    
    
    AVPlayerViewController *controller=[[AVPlayerViewController alloc]init];
    controller.player=video;
    [video play];
    [self presentViewController:controller animated:YES completion:nil];
    
    
  

}

-(void)itemDidFinishPlaying:(NSNotification *) notification {
   //  AVPlayerViewController *controller=[[AVPlayerViewController alloc]init];
    [self.view removeFromSuperview];
    
}














@end
