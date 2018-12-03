//
//  ViewController.m
//  Squawkk
//
//  Created by Jason Terhorst on 12/3/18.
//  Copyright © 2018 Jason Terhorst. All rights reserved.
//

#import "ViewController.h"

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
{
    AVPlayer * _player;
    AVPlayerLayer * _playerLayer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSURL *videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"giphy" ofType:@"mp4"]];
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:videoURL];
    _player = [AVPlayer playerWithPlayerItem:item];
    
    CALayer *superlayer = self.view.layer;
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    [playerLayer setFrame:self.view.bounds];
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [superlayer addSublayer:playerLayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:item];
    
    [_player seekToTime:kCMTimeZero];
    [_player play];
}

-(void)playerDidFinishPlaying:(NSNotification *)notification {
    
    [_player seekToTime:kCMTimeZero];
    [_player play];
}

- (void)viewDidLayoutSubviews {
    _playerLayer.frame = self.view.layer.bounds;
    [super viewDidLayoutSubviews];
}

@end
