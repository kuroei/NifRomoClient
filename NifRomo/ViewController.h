//
//  ViewController.h
//  NifRomo
//
//  Created by sci01507 on 15-6-5.
//  Copyright (c) 2015年 iot.team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RMCore/RMCore.h>
#import <MQTTKit.h>

// import files for webrtc
#import <AppRTC/RTCEAGLVideoView.h>
#import <AppRTC/ARDAppClient.h>
#import <AVFoundation/AVFoundation.h>

// add the ARDAppClientDelegate, RTCEAGLVideoViewDelegate ,RMCoreDelegate to interface
@interface ViewController : UIViewController <RMCoreDelegate, UINavigationControllerDelegate, ARDAppClientDelegate, RTCEAGLVideoViewDelegate>

// property for romo
@property (nonatomic, strong) RMCoreRobotRomo3 *Romo3;

// UI
@property (strong, nonatomic) IBOutlet UIButton *backbtn;

// animation
@property (nonatomic, strong) UIImageView *animation;

// create a property for the MQTTClient that is used to send and receive the message
@property (nonatomic, strong) MQTTClient *client;

// property for webrtc client
@property (strong, nonatomic) ARDAppClient *rtcclient;
@property (strong, nonatomic) IBOutlet RTCEAGLVideoView *remoteView;
@property (strong, nonatomic) IBOutlet RTCEAGLVideoView *localView;
@property (strong, nonatomic) RTCVideoTrack *localVideoTrack;
@property (strong, nonatomic) RTCVideoTrack *remoteVideoTrack;


// property from  firstview
@property (nonatomic,retain) NSString * host;
@property (nonatomic,retain)  NSString * port;
@property (nonatomic,retain)  NSString * username;
@property (nonatomic,retain)  NSString * pwd;
@property (nonatomic,retain)  NSString * clintid;
@property (nonatomic,retain)  NSString * pushid;

@end

