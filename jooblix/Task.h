//
//  Task.h
//  jooblix
//
//  Created by maxday on 2014-07-20.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Group;

@interface Task : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * taskId;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) Group *groupId;

@end
