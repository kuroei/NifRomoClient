//
//  LoginViewController.h
//  NifRomo
//
//  Created by sci01507 on 15-6-5.
//  Copyright (c) 2015年 iot.team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

// UI
@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) IBOutlet UITextField *host;
@property (strong, nonatomic) IBOutlet UITextField *port;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *pwd;
@property (strong, nonatomic) IBOutlet UITextField *clientid;
@property (strong, nonatomic) IBOutlet UITextField *pushid;

@end
