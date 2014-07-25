//
//  SearchableViewController.h
//  jooblix
//
//  Created by maxday on 2014-07-21.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import "SearchableViewController.h"
#import "TableViewCell.h"
#import "Task.h"
#import "Group.h"

@interface SearchableViewController ()

@end

@implementation SearchableViewController

@synthesize aTableView;
@synthesize data;
@synthesize dataUpdater;
@synthesize searchData;
@synthesize isFiltered;
@synthesize aSearchBar;
@synthesize tap;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, 500)  style:UITableViewStylePlain];
        aTableView.delegate = self;
        aTableView.dataSource = self;
        
        searchData = [[NSMutableArray alloc] init];
        
        aSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        aSearchBar.delegate = self;
        
        //UIColor* backgroundColor = [UIColor colorWithRed:0.941 green:0.949 blue:0.961 alpha:1];
        //aSearchBar.barTintColor = backgroundColor;
        aTableView.tableHeaderView = aSearchBar;
        
        UISearchDisplayController *searchController = [[UISearchDisplayController alloc] initWithSearchBar:aSearchBar contentsController:self];
        searchController.searchResultsDataSource = self;
        searchController.searchResultsDelegate = self;
        searchController.delegate = self;
        
        
        tap = [[UITapGestureRecognizer alloc]
               initWithTarget:self
               action:@selector(dismissKeyboard)];
        
        dataUpdater = [[DataUpdater alloc] init];
        dataUpdater.notifyDelegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [aTableView setSeparatorInset:UIEdgeInsetsZero];
    
    [self.view addSubview:aTableView];

    [self.delegate fetchData:dataUpdater];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return isFiltered ? searchData.count : data.count;
    //return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(isFiltered)
        return [self.delegate setUpCellInTableView:tableView andData:[searchData objectAtIndex:indexPath.row]];
    return [self.delegate setUpCellInTableView:tableView andData:[data objectAtIndex:indexPath.row]];
}

- (void) dismissKeyboard {
    self.aSearchBar.text = @"";
    [self.aSearchBar resignFirstResponder];
}

#pragma mark - SearchBar Delegate -
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length == 0)
        isFiltered = NO;
    else
        isFiltered = YES;
    
    searchData = [self.delegate textChange:searchText onData:data];
    
    [self.aTableView reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"searchBar button clicked");
}

-(void) refreshTable {
    data = [self.delegate getCoreData];
    [self.aTableView reloadData];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88.f;
}

@end
