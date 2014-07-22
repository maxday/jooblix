//
//  ViewController.m
//  jooblix
//
//  Created by maxday on 2014-07-18.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import "ViewController.h"
#import "Task.h"

@interface ViewController ()
@end

@implementation ViewController

@synthesize segmentedControl;
@synthesize refreshButton;
@synthesize searchController;
@synthesize moc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        NSArray *itemArray = [NSArray arrayWithObjects: @"Liste", @"Group", nil];
        segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
        segmentedControl.frame = CGRectMake(60, 74, 200, 20);
        [segmentedControl addTarget:self action:@selector(changeViewAction:) forControlEvents: UIControlEventValueChanged];
        segmentedControl.selectedSegmentIndex = 1;
        
        refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshAction:)];
        
        UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
        
        self.navigationItem.leftBarButtonItem = refreshButton;
        self.navigationItem.rightBarButtonItem = addButton;
        
        
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
    [self.view addSubview:segmentedControl];
    [self.view setBackgroundColor:[UIColor colorWithRed:(247.0f/255) green:(247.0f/255) blue:(247.0f/255) alpha:1]];
    [self.view addSubview:searchController.view];
    
}

- (void) changeViewAction:(UISegmentedControl *) segment {
    if (segment.selectedSegmentIndex == 0) {
        NSLog(@"zero");
    } else {
        NSLog(@"one");
    }
}

- (void) addAction:(id) sender {
    NSLog(@"ADD");
}

- (void) refreshAction:(id) sender {
    NSLog(@"REFRESH");
}


- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSArray*) textChange:(NSString*) text onData:(NSArray*) data {

    NSMutableArray *tmpSearched = [[NSMutableArray alloc] init];
    for (Task *task in data) {
        NSRange range = [[task name] rangeOfString:text options:NSCaseInsensitiveSearch];
        if(range.location != NSNotFound)
            [tmpSearched addObject:task];
        }
    return tmpSearched.copy;
}

- (void) fetchData:(DataUpdater*) dataUpdater {
    NSLog(@"fetch called");
    [dataUpdater refreshData:moc];
}

- (NSArray*) getCoreData {

    NSLog(@"FETCH IT");
    
    NSFetchRequest * fetchRequestGroup = [[NSFetchRequest alloc] init];
    [fetchRequestGroup setEntity:[NSEntityDescription entityForName:@"Task" inManagedObjectContext:moc]];
        
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [fetchRequestGroup setSortDescriptors:[NSArray arrayWithObject:sortByName]];
        
    NSError * error = nil;
    return [moc executeFetchRequest:fetchRequestGroup error:&error];
    
}


@end