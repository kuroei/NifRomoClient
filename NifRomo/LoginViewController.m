//
//  LoginViewController.m
//  NifRomo
//
//  Created by sci01507 on 15-6-5.
//  Copyright (c) 2015年 iot.team. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.background = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.background.image = [UIImage imageNamed:@"01.png"];
    [self.view addSubview:self.background];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark IBActions

- (IBAction)ConnectAction:(id)sender {
	// Send the property to next ViewController
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"mainview"];
    
    viewController.host = self.host.text;
    viewController.port = self.port.text;
    viewController.username = self.username.text;
    viewController.pwd = self.pwd.text;
    viewController.clintid = self.clientid.text;
    viewController.pushid = self.pushid.text;
    
    [self presentViewController:viewController animated:YES completion:nil];
}

@end
