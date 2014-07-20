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

@synthesize mainTableView;
@synthesize chooseView;
@synthesize managedObjectContext;
@synthesize data;
@synthesize dataUpdater;
@synthesize refreshButton;
@synthesize searchData;
@synthesize isFiltered;
@synthesize aSearchBar;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    searchData = [[NSMutableArray alloc] init];
    
    dataUpdater.fetchDelegate = self;
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"Liste", @"Group", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(60, 74, 200, 20);
    [segmentedControl addTarget:self action:@selector(changeViewAction:) forControlEvents: UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 1;
    [self.view addSubview:segmentedControl];
    
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
    
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, 320, 500)  style:UITableViewStylePlain];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    
    
    
    
    
	[self.view setBackgroundColor:[UIColor colorWithRed:(247.0f/255) green:(247.0f/255) blue:(247.0f/255) alpha:1]];
    
    [self fetchData];
    
    [self.view addSubview:mainTableView];
    
    

    
    aSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    aSearchBar.delegate = self;
    
    mainTableView.tableHeaderView = aSearchBar;
    
    UISearchDisplayController *searchController = [[UISearchDisplayController alloc] initWithSearchBar:aSearchBar contentsController:self];
    searchController.searchResultsDataSource = self;
    searchController.searchResultsDelegate = self;
    searchController.delegate = self;
    
    
  
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];



    
    
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
    [refreshButton setEnabled:NO];
    [dataUpdater refreshData:managedObjectContext];
}

-(void) reactivateRefresh {
    [refreshButton setEnabled:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return isFiltered ? searchData.count : data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jooblixCell"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"jooblixCell"];
    }
    cell.textLabel.text = isFiltered ? [[searchData objectAtIndex:indexPath.row] name] : [[data objectAtIndex:indexPath.row] name];
    return cell;
 }

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) fetchData {
    NSFetchRequest * fetchRequestGroup = [[NSFetchRequest alloc] init];
    [fetchRequestGroup setEntity:[NSEntityDescription entityForName:@"Task" inManagedObjectContext:managedObjectContext]];
    
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [fetchRequestGroup setSortDescriptors:[NSArray arrayWithObject:sortByName]];

    NSError * error = nil;
    data = [managedObjectContext executeFetchRequest:fetchRequestGroup error:&error];
    
    [self dismissKeyboard];
    isFiltered = NO;
    
    [mainTableView reloadData];
}

#pragma mark - SearchBar Delegate -
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length == 0)
        isFiltered = NO;
    else
        isFiltered = YES;
    
    NSMutableArray *tmpSearched = [[NSMutableArray alloc] init];
    
    for (Task *task in data) {
        
        //we are going for case insensitive search here
        NSRange range = [[task name] rangeOfString:searchText
                                      options:NSCaseInsensitiveSearch];
        
        if (range.location != NSNotFound)
            [tmpSearched addObject:task];
    }
    
    searchData = tmpSearched.copy;
    
    [self.mainTableView reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"searchBar button clicked");
}


- (void) dismissKeyboard {
    self.aSearchBar.text = @"";
    [self.aSearchBar resignFirstResponder];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [mainTableView setContentOffset:CGPointMake(0, 44)];
}


@end
