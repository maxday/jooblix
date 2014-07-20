//
//  ViewController.m
//  jooblix
//
//  Created by maxday on 2014-07-18.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

@synthesize mainTableView;
@synthesize chooseView;
@synthesize managedObjectContext;
@synthesize data;
@synthesize dataUpdater;
@synthesize refreshButton;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
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
    return [data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jooblixCell"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"jooblixCell"];
    }
    [cell.textLabel setText:[[data objectAtIndex:indexPath.row] name]];
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
    
    [mainTableView reloadData];
}

@end
