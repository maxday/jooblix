//
//  ViewController.h
//  jooblix
//
//  Created by maxday on 2014-07-18.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchProtocol.h"
#import "SearchableViewController.h"

@interface ViewController : UIViewController <FetchProtocol>

@property (nonatomic, retain) UIBarButtonItem* refreshButton;
@property (nonatomic, retain) UISegmentedControl *segmentedControl;
@property (nonatomic, retain) SearchableViewController* searchController;
@property (strong, nonatomic) NSManagedObjectContext *moc;

@end
