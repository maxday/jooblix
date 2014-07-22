//
//  DataUpdater.h
//  jooblix
//
//  Created by maxday on 2014-07-19.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NotifyProtocol.h"

@interface DataUpdater : NSObject

    @property(nonatomic, weak) id notifyDelegate;

    - (void) sendUserToken;
    - (void)sendUserUUID;
    - (void) setUUID;
    - (void) refreshData:(NSManagedObjectContext*) managedObjectContext;
    - (void) joinGroup:(NSNumber*) groupId;

@end
