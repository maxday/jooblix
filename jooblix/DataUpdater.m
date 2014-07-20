//
//  DataUpdater.m
//  jooblix
//
//  Created by maxday on 2014-07-19.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import "DataUpdater.h"
#import "Constant.h"
#import "Group.h"
#import "Task.h"
#import "AFHTTPRequestOperationManager.h"

@implementation DataUpdater

+ (void)sendUserToken {
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kCheckToken]) {
        NSLog(@"Token already sent");
        return;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"token": [[NSUserDefaults standardUserDefaults] objectForKey:kToken], @"uuid" : [[NSUserDefaults standardUserDefaults] objectForKey:kUUID]};
    
    [manager POST:ServerApiURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self saveToUserDefaults:kCheckToken andBool:[NSNumber numberWithBool:YES]];
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self saveToUserDefaults:kCheckToken andBool:[NSNumber numberWithBool:NO]];
        NSLog(@"Error: %@", error);
    }];
    
   }

+ (void)saveToUserDefaults:(NSString*)key andBool:(NSNumber*) boolValue {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:boolValue forKey:key];
    [standardUserDefaults synchronize];
}

+ (void)saveToUserDefaults:(NSString*)key andBString:(NSString*) stringValue {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:stringValue forKey:key];
    [standardUserDefaults synchronize];
}

+ (void) setUUID {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kCheckToken]) {
        NSLog(@"UUID already generated sent");
        return;
    }
    CFUUIDRef cfuuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString* generatedUUID = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, cfuuid));
    [self saveToUserDefaults:kUUID andBString:generatedUUID];
    NSLog(@"%@", generatedUUID);
}



+ (void) refreshData:(NSManagedObjectContext*) managedObjectContext {
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"uuid" : [[NSUserDefaults standardUserDefaults] objectForKey:kUUID]};
    
    
    [self clear:managedObjectContext];
    
    [manager GET:RefreshApiURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        [self prepareGroup:[responseObject objectForKey:@"data"] andContext:managedObjectContext];
        
        NSError *error = nil;
        [managedObjectContext save:&error];
        if (error != nil) {
            NSLog(@"Core data error");
        }
  
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


+ (void) prepareGroup:(NSArray*) array andContext:(NSManagedObjectContext*) managedObjectContext {
    
    [array enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        
        NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithDictionary:object];
        
        Group *group = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Group"
                        inManagedObjectContext:managedObjectContext];
        
        NSSet* set = [NSSet setWithArray:[object objectForKey:@"taskList"]];
        [dict setObject:[self contructSet:set andContext:managedObjectContext] forKey:@"taskList"];
        [group setValuesForKeysWithDictionary:dict];
        
    }];
    
}

+ (NSSet*) contructSet:(NSSet*) set andContext:(NSManagedObjectContext*) managedObjectContext {
    
    NSMutableSet* contructionSet = [[NSMutableSet alloc] initWithCapacity:[set count]];
    
    [set enumerateObjectsUsingBlock:^(id taskItem, BOOL *stop) {
        Task *task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:managedObjectContext];
        [task setValuesForKeysWithDictionary:taskItem];
        [contructionSet addObject:task];
    }];
    
    return contructionSet;
}

+ (void) clear:(NSManagedObjectContext*) managedObjectContext {
    
    NSFetchRequest * fetchRequestGroup = [[NSFetchRequest alloc] init];
    [fetchRequestGroup setEntity:[NSEntityDescription entityForName:@"Group" inManagedObjectContext:managedObjectContext]];
    [fetchRequestGroup setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError * error = nil;
    NSArray * group = [managedObjectContext executeFetchRequest:fetchRequestGroup error:&error];


    for (NSManagedObject * singleGroup in group) {
        [managedObjectContext deleteObject:singleGroup];
    }
    
}



@end
