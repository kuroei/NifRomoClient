/*
 Copyright 2015 NIFTY Corporation All Rights Reserved.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
*/

#import <NCMB/NCMB.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "AppDelegate.h"
#import "ViewController.h"
#import "Command.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // RTCEAGLVideoViewDelegate provides notifications on video frame dimensions
    [self.remoteView setDelegate:self];
    [self.localView setDelegate:self];
    //[self.view addSubview:self.localView];
    
    // Start the animation of z-kun
    self.animation = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview: self.animation];
    [self animation_standby];
    //
    
    // create the MQTT client with an unique identifier
    NSString *clientID = [UIDevice currentDevice].identifierForVendor.UUIDString;
    self.client = [[MQTTClient alloc] initWithClientId:clientID];
    
    // add the username and password
    self.client.password = self.pwd;
    self.client.username = self.username;
    self.client.port = (unsigned short) self.port.integerValue;
    
    
    // connect the MQTT client
    if ([self.clintid length] == 0){
        self.clintid = @"";
    }
    NSString *subTopic = [NSString stringWithFormat:@"%@/#", self.clintid];
    NSString *subTopicMove = [NSString stringWithFormat:@"%@/%@", self.clintid, kTopic];
    NSString *subTopicPiv = [NSString stringWithFormat:@"%@/%@", self.clintid, kTopicPic];
    [self.client connectToHost:self.host completionHandler:^(MQTTConnectionReturnCode code) {
        if (code ==  ConnectionAccepted) {
            // The client is connected when this completion handler is called
            [self.client subscribe:subTopic withCompletionHandler:^(NSArray *grantedQos) {
                // The client is effectively subscribed to the topic when this completion handler is called
            }];
        }
    }];
    
    // get the romo-driver obj from delegate
    AppDelegate *mydel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.romo3 = mydel.romo3;
    
    __block ViewController * blockSelf = self;
    // define the handler that will be called when MQTT messages are received by the client
    [self.client setMessageHandler:^(MQTTMessage *message) {
        NSString *topic = [message.topic lowercaseString];
        NSString *text = [message.payloadString lowercaseString];
        
        //NSLog(@"topic ->%@",topic);
        //NSLog(@"text ->%@",text);
        
        if ([topic  isEqual: subTopicMove]) {
            unsigned int status = (unsigned int) text.integerValue;
            
            if ( ( status & isForward ) > isStop ) {
                [blockSelf ->_romo3 driveForwardWithSpeed:0.3];
                [blockSelf animation_forward];
            }
            
            if ( ( status & isBack ) > isStop ) {
                [blockSelf ->_romo3 driveBackwardWithSpeed:0.3];
                [blockSelf animation_back];
            }
            
            if ( (status & isLeft ) > isStop) {
                [blockSelf ->_romo3 driveWithLeftMotorPower:-0.5 rightMotorPower:0.8];
                [blockSelf animation_left];
            }
            
            if ( (status & isRight) > isStop ) {
                [blockSelf ->_romo3 driveWithLeftMotorPower:0.8 rightMotorPower:-0.5];
                [blockSelf animation_right];
            }
            
            if ( (status & noForward & noBack & noLeft & noRight ) == status) {
                [blockSelf ->_romo3 stopDriving];
                [blockSelf animation_standby];
            }
            
            if ( (status & isUp ) > isStop) {
                [blockSelf ->_romo3 tiltWithMotorPower:0.2];
            }
            
            if ( (status & isDown ) > isStop ) {
                [blockSelf ->_romo3 tiltWithMotorPower:-0.2];
            }
            
            if( (status & noUp & noDown) == status ){
                [blockSelf ->_romo3 tiltWithMotorPower:0];
            }
            
        }
        
        if ([topic  isEqual: subTopicPiv]) {
                [blockSelf takeImageAndSendPush];
                [blockSelf animation_getPic];
        }
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // it will connect the webrtc server, by kuroei
    [self disconnect];
      self.rtcclient = [[ARDAppClient alloc] initWithDelegate:self];
    [self.rtcclient setServerHostUrl:@"https://apprtc.appspot.com"];
    [self.rtcclient connectToRoomWithId:[NSString stringWithFormat:@"6666%@", self.clintid] options:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark -- RMCoreDelegate Methods --


- (void)robotDidConnect:(RMCoreRobot *)robot
{
    // Currently the only kind of robot is Romo3, so this is just future-proofing
    if ([robot isKindOfClass:[RMCoreRobotRomo3 class]]) {
        self.Romo3 = (RMCoreRobotRomo3 *)robot;
        // Change Romo's LED to be solid at 80% power
        [self.romo3.LEDs setSolidWithBrightness:0.8];
    }
}

- (void)robotDidDisconnect:(RMCoreRobot *)robot
{
    [self.romo3.LEDs setSolidWithBrightness:0.0];
    if (robot == self.romo3) {
        self.romo3 = nil;
    }
}


#pragma mark -- Private Methods: Build the UI --

- (void)dealloc
{
    // disconnect the MQTT client
    [self.client disconnectWithCompletionHandler:^(NSUInteger code) {
        // The client is disconnected when this completion handler is called
        NSLog(@"MQTT is disconnected");
    }];
}

- (void)takeImageAndSendPush
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //formart filename
        [self.localView setHidden:false];
        NSDate *currentTime = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *resultString = [dateFormatter stringFromDate: currentTime];
        NSString *fileName = [resultString stringByAppendingString:@".jpg"];
        
        //init the mbaas file
        [NCMB setApplicationKey:NCMB_ApplicationKey clientKey:NCMB_ClientKey];
        //save to datastore
        NCMBObject *imageData = [NCMBObject objectWithClassName:@"image"];
        [imageData setObject:fileName forKey:@"imagetitle"];
        [imageData saveInBackgroundWithBlock:nil];

        // get pic from rtcview and send it to mbaas
        GLKView *tempview = self.localView.subviews[0];
        UIImage *image = [tempview snapshot];
        [self.localView setHidden:true];
        NSData *jpgData = [[NSData alloc] initWithData:UIImagePNGRepresentation(image)] ;
        NCMBFile *file = [NCMBFile fileWithName:fileName data:jpgData];
        [file saveInBackgroundWithBlock:nil];
        
        //Sendpush
        NSString *richUrlStr = [@"http://cy8srgt-ac3-app000.c4sa.net/romo-js/#/push/" stringByAppendingString:fileName];
        NCMBPush *push = [NCMBPush push];
        NSDictionary *data = @{};
        [push setData:data];
        [push setMessage:@"it`s a pic from romo"];
        [push setImmediateDeliveryFlag:true];
        [push setPushToAndroid:true];
        NCMBQuery *query = [NCMBInstallation query];
        [query whereKey:@"iot" equalTo:self.pushid]; //installation class setting: string "1"
        [push setRichUrl:richUrlStr];
        [push setSearchCondition:query];
        [push sendPushInBackgroundWithBlock:^(NSError *error) {
            NSLog(@"[Error] %@", error);
        }];
        
    });
}

#pragma mark - ths animation of z-kun

- (void)animation_standby
{
    NSLog(@"animation_standby");
    
    NSArray *myImages = [NSArray arrayWithObjects:
                         [UIImage imageNamed:@"01.png"],
                         [UIImage imageNamed:@"02.png"],
                         [UIImage imageNamed:@"03.png"],
                         [UIImage imageNamed:@"02.png"],
                         [UIImage imageNamed:@"01.png"],nil];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.animation stopAnimating];
        self.animation.animationImages = myImages;
        self.animation.animationDuration = 1.25;
        self.animation.animationRepeatCount = 0;
        [self.animation startAnimating];
    });

}

- (void)animation_forward
{
    NSArray *myImages = [NSArray arrayWithObjects:
                         [UIImage imageNamed:@"10.png"],
                         [UIImage imageNamed:@"11.png"],nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.animation stopAnimating];
        self.animation.animationImages = myImages;
        self.animation.animationDuration = 0.30;
        self.animation.animationRepeatCount = 0;
        [self.animation startAnimating];
    });
}



- (void)animation_back
{
    NSArray *myImages = [NSArray arrayWithObjects:
                         [UIImage imageNamed:@"10.png"],
                         [UIImage imageNamed:@"09.png"],nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.animation stopAnimating];
        self.animation.animationImages = myImages;
        self.animation.animationDuration = 0.30;
        self.animation.animationRepeatCount = 0;
        [self.animation startAnimating];
    });
}

- (void)animation_left
{
    NSArray *myImages = [NSArray arrayWithObjects:
                         [UIImage imageNamed:@"12.png"],
                         [UIImage imageNamed:@"09.png"],nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.animation stopAnimating];
        self.animation.animationImages = myImages;
        self.animation.animationDuration = 0.5;
        self.animation.animationRepeatCount = 0;
        [self.animation startAnimating];
    });
}

- (void)animation_right
{
    NSArray *myImages = [NSArray arrayWithObjects:
                         [UIImage imageNamed:@"14.png"],
                         [UIImage imageNamed:@"13.png"],nil];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.animation stopAnimating];
        self.animation.animationImages = myImages;
        self.animation.animationDuration = 0.5;
        self.animation.animationRepeatCount = 0;
        [self.animation startAnimating];
    });
}

- (void)animation_getPic
{
    NSArray *myImages = [NSArray arrayWithObjects:
                         [UIImage imageNamed:@"05.png"],
                         [UIImage imageNamed:@"07.png"],nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.animation stopAnimating];
        self.animation.animationImages = myImages;
        self.animation.animationDuration = 1;
        self.animation.animationRepeatCount = 1;
        [self.animation startAnimating];
    });
    
    NSArray * myImages2 = [NSArray arrayWithObjects:
                           [UIImage imageNamed:@"26.png"],
                           [UIImage imageNamed:@"27.png"],nil];

    dispatch_async(dispatch_get_main_queue(), ^{
        self.animation.animationImages = myImages2;
        self.animation.animationDuration = 0.5;
        self.animation.animationRepeatCount = 4;
        [self.animation startAnimating];
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.animation.image = [UIImage imageNamed:@"03.png"];
    });
}


# pragma mark - AppRTC

- (void)disconnect {
    if (self.rtcclient) {
        if (self.localVideoTrack) [self.localVideoTrack removeRenderer:self.localView];
        if (self.remoteVideoTrack) [self.remoteVideoTrack removeRenderer:self.remoteView];
        self.localVideoTrack = nil;
        [self.localView renderFrame:nil];
        self.remoteVideoTrack = nil;
        [self.remoteView renderFrame:nil];
        [self.rtcclient disconnect];
    }
}

- (void)remoteDisconnected {
    if (self.remoteVideoTrack) [self.remoteVideoTrack removeRenderer:self.remoteView];
    self.remoteVideoTrack = nil;
    [self.remoteView renderFrame:nil];
    //[self videoView:self.localView didChangeVideoSize:self.localVideoSize];
}


- (void)appClient:(ARDAppClient *)client didChangeState:(ARDAppClientState)state {
    switch (state) {
        case kARDAppClientStateConnected:
            NSLog(@"Client connected.");
            break;
        case kARDAppClientStateConnecting:
            NSLog(@"Client connecting.");
            break;
        case kARDAppClientStateDisconnected:
            NSLog(@"Client disconnected.");
            [self remoteDisconnected];
            break;
    }
}

- (void)appClient:(ARDAppClient *)client didReceiveLocalVideoTrack:(RTCVideoTrack *)localVideoTrack {
    self.localVideoTrack = localVideoTrack;
    [self.localVideoTrack addRenderer:self.localView];
}

- (void)appClient:(ARDAppClient *)client didReceiveRemoteVideoTrack:(RTCVideoTrack *)remoteVideoTrack {

}

- (void)appClient:(ARDAppClient *)client didError:(NSError *)error {
    // Handle the error
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:[NSString stringWithFormat:@"%@", error]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    [self disconnect];
}

- (void)videoView:(RTCEAGLVideoView *)videoView didChangeVideoSize:(CGSize)size {
    /* resize self.localView or self.remoteView based on the size returned */
}

#pragma mark - Clear Connection

- (void)applicationWillResignActive:(UIApplication*)application {
    [self disconnect];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    [self disconnect];
    
    // MQTT disconnected
    [self.client disconnectWithCompletionHandler:^(NSUInteger code) {
        // The client is disconnected when this completion handler is called
        NSLog(@"MQTT is disconnected");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
