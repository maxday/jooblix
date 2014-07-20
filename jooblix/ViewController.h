//
//  ViewController.h
//  jooblix
//
//  Created by maxday on 2014-07-18.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView* mainTableView;
@property (nonatomic, retain) UISegmentedControl* chooseView;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
