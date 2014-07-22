//
//  JoinGroupViewController.h
//  jooblix
//
//  Created by maxday on 2014-07-22.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchProtocol.h"
#import "SearchableViewController.h"

@interface JoinGroupViewController : UIViewController<FetchProtocol>

@property (nonatomic, retain) SearchableViewController* searchController;
@property (strong, nonatomic) NSManagedObjectContext *moc;

@end
