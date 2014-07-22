//
//  FetchProtocol.h
//  jooblix
//
//  Created by maxday on 2014-07-20.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataUpdater.h"

@protocol FetchProtocol <NSObject>

- (void) fetchData:(DataUpdater*) dataUpdaters;
- (NSArray*) getCoreData;
- (NSArray*) textChange:(NSString*) text onData:(NSArray*) data;



@end
