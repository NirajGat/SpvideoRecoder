//
//  VideoRecoderViewController.h
//  SPVideoRecoder
//
//  Created by Niraj Gat on 5/13/16.
//  Copyright © 2016 Niraj Gat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@import MediaPlayer;

@interface VideoRecoderViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;

@property (weak, nonatomic) IBOutlet UIView *contentView;

- (IBAction)onTakeVideoBtn:(id)sender;

- (IBAction)submit:(id)sender;

@end
