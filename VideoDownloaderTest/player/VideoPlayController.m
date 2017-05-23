//
//  VideoPlayController.m
//  VideoDownloaderTest
//
//  Created by qianjn on 2017/4/18.
//  Copyright © 2017年 罗元丰. All rights reserved.
//

#import "VideoPlayController.h"
#import <MediaPlayer/MediaPlayer.h>
@interface VideoPlayController ()
@property (nonatomic, strong) MPMoviePlayerController *videoPlayer;
@end

@implementation VideoPlayController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.videoPlayer = [[MPMoviePlayerController alloc] init];
    [self.videoPlayer.view setFrame:self.view.bounds];
    self.videoPlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.videoPlayer.view];
    self.videoPlayer.contentURL = [NSURL fileURLWithPath:_playurl];
    [self.videoPlayer prepareToPlay];
    self.videoPlayer.shouldAutoplay = YES;
    self.videoPlayer.controlStyle = MPMovieControlStyleFullscreen;
    self.videoPlayer.repeatMode = MPMovieRepeatModeOne;
    
    
    [self.videoPlayer play];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doneButtonClick:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    
//    self.videoPlayer.view.layer.transform = CATransform3DMakeRotation(M_PI/2, 0, 0, 1);
//    self.videoPlayer.view.frame = self.view.bounds;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPlayer)];
    tap.numberOfTapsRequired = 2;
    [self.videoPlayer.view addGestureRecognizer:tap];
}

-(void)doneButtonClick:(NSNotification*)aNotification{
    NSNumber *reason = [aNotification.userInfo objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    
    if ([reason intValue] == MPMovieFinishReasonUserExited) {
        [self dismissPlayer];
    }
}

- (void)dismissPlayer
{
    [self.videoPlayer stop];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
