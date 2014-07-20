//
//  ViewController.h
//  jooblix
//
//  Created by maxday on 2014-07-18.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataUpdater.h"
#import "FetchProtocol.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, FetchProtocol, UISearchDisplayDelegate, UISearchBarDelegate>

@property (nonatomic, retain) UITableView* mainTableView;
@property (nonatomic, retain) UISegmentedControl* chooseView;
@property (nonatomic, retain) DataUpdater* dataUpdater;
@property (nonatomic, retain) UIBarButtonItem* refreshButton;
@property (nonatomic, retain) NSMutableArray* searchData;
@property (nonatomic, retain) NSArray* data;
@property (nonatomic, retain) UISearchBar *aSearchBar;
@property (readwrite) BOOL isFiltered;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;



@end
