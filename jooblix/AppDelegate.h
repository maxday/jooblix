//
//  AppDelegate.h
//  jooblix
//
//  Created by maxday on 2014-07-18.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataUpdater.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (readonly, strong, nonatomic) DataUpdater *dataUpdater;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
