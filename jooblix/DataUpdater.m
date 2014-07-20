//
//  DataUpdater.m
//  jooblix
//
//  Created by maxday on 2014-07-19.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import "DataUpdater.h"
#import "Constant.h"
#import "AFHTTPRequestOperationManager.h"

@implementation DataUpdater

+ (void)sendUserToken {
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kCheckToken]) {
        NSLog(@"Already sent");
        return;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"token": [[NSUserDefaults standardUserDefaults] objectForKey:@"apnsToken"]};
    
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

@end
