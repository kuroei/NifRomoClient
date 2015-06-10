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
