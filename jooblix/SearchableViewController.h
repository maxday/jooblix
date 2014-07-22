//
//  SearchableViewController.
//  jooblix
//
//  Created by maxday on 2014-07-21.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataUpdater.h"
#import "NotifyProtocol.h"
#import "FetchProtocol.h"

@interface SearchableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate, NotifyProtocol>

@property (nonatomic, retain) UITableView* aTableView;
@property (nonatomic, retain) DataUpdater* dataUpdater;
@property (nonatomic, retain) NSArray* searchData;
@property (nonatomic, retain) NSArray* data;
@property (nonatomic, retain) UISearchBar *aSearchBar;
@property (readwrite) BOOL isFiltered;
@property (nonatomic, retain) UITapGestureRecognizer *tap;

@property (weak, nonatomic) id delegate;





@end
