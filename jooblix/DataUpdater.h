//
//  DataUpdater.h
//  jooblix
//
//  Created by maxday on 2014-07-19.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ServerApiURL @"http://maxday.fr/jooblix/register.php"

@interface DataUpdater : NSObject
    + (void)sendUserToken;
    + (void) setUUID;
@end
