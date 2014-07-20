//
//  DataUpdater.h
//  jooblix
//
//  Created by maxday on 2014-07-19.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataUpdater : NSObject
    + (void) sendUserToken;
    + (void) setUUID;
    + (void) refreshData:(NSManagedObjectContext*) managedObjectContext;
@end
