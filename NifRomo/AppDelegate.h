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

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <RMCore/RMCore.h>

@class ViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,RMCoreDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic, strong) RMCoreRobotRomo3 *romo3;
//@property (nonatomic, strong) RMCoreRobot<HeadTiltProtocol, DriveProtocol, LEDProtocol> *romo3;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

    