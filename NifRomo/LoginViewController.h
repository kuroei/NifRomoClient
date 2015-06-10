/*
 Copyright 2014 NIFTY Corporation All Rights Reserved.
 
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
