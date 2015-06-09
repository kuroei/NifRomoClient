//
//  AppDelegate.h
//  NifRomo
//
//  Created by sci01507 on 15-6-5.
//  Copyright (c) 2015年 iot.team. All rights reserved.
//

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
@property (nonatomic, strong) RMCoreRobotRomo3 *Romo3;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

    