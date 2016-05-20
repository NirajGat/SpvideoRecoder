//
//  VideoViewController.h
//  SPVideoRecoder
//
//  Created by Niraj Gat on 5/16/16.
//  Copyright © 2016 Niraj Gat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@import MediaPlayer;

@interface VideoViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPageViewControllerDelegate>{
    
    NSMutableArray *recordingArray;
    
}

@property (weak, nonatomic) IBOutlet UITableView *contentView;

@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;

@property (strong, nonatomic) UIPageViewController *playerViewController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
