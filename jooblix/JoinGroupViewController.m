//
//  JoinGroupViewController.m
//  jooblix
//
//  Created by maxday on 2014-07-22.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import "JoinGroupViewController.h"
#import "Group.h"

@interface JoinGroupViewController ()

@end

@implementation JoinGroupViewController

@synthesize searchController;
@synthesize moc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
        CGFloat verticalOffset = 3;
        
        [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:verticalOffset forBarMetrics:UIBarMetricsDefault];
        
        UIFont *customFont = [UIFont fontWithName:@"Eurofurencelight" size:40];
        
        NSDictionary * navBarTitleTextAttributes =
        @{NSForegroundColorAttributeName : [UIColor blackColor],
          NSFontAttributeName            : customFont };
        
        [[UINavigationBar appearance] setTitleTextAttributes:navBarTitleTextAttributes];
        
        self.navigationController.navigationBar.topItem.title = @"jooblix";
        
        searchController = [[SearchableViewController alloc] init];
        searchController.delegate = self;
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:(247.0f/255) green:(247.0f/255) blue:(247.0f/255) alpha:1]];
    [self.view addSubview:searchController.view];
    
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSArray*) textChange:(NSString*) text onData:(NSArray*) data {
    
    NSMutableArray *tmpSearched = [[NSMutableArray alloc] init];
    for (Group *group in data) {
        NSRange range = [[group name] rangeOfString:text options:NSCaseInsensitiveSearch];
        if(range.location != NSNotFound)
            [tmpSearched addObject:group];
    }
    return tmpSearched.copy;
}

- (void) fetchData:(DataUpdater*) dataUpdater {
    NSLog(@"fetch called");
    [dataUpdater refreshAvailableGroup:moc];
}

- (NSArray*) getCoreData {
    
    NSLog(@"FETCH IT");
    
    NSFetchRequest * fetchRequestGroup = [[NSFetchRequest alloc] init];
    [fetchRequestGroup setEntity:[NSEntityDescription entityForName:@"AvailableGroup" inManagedObjectContext:moc]];
    
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [fetchRequestGroup setSortDescriptors:[NSArray arrayWithObject:sortByName]];
    
    NSError * error = nil;
    return [moc executeFetchRequest:fetchRequestGroup error:&error];
    
}


@end