//
//  Group.h
//  jooblix
//
//  Created by maxday on 2014-07-20.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Task;

@interface Group : NSManagedObject

@property (nonatomic, retain) NSNumber * groupId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSSet *taskList;
@end

@interface Group (CoreDataGeneratedAccessors)

- (void)addTaskListObject:(Task *)value;
- (void)removeTaskListObject:(Task *)value;
- (void)addTaskList:(NSSet *)values;
- (void)removeTaskList:(NSSet *)values;

@end
