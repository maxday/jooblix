//
//  FetchProtocol.h
//  jooblix
//
//  Created by maxday on 2014-07-20.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FetchProtocol <NSObject>

- (void) fetchData;
-(void) reactivateRefresh;

@end
