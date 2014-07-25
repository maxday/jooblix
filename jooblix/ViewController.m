//
//  ViewController.m
//  jooblix
//
//  Created by maxday on 2014-07-18.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import "ViewController.h"
#import "JoinGroupViewController.h"
#import "Task.h"
#import "TableViewCell.h"

@interface ViewController ()
@end

@implementation ViewController

@synthesize refreshButton;
@synthesize searchController;
@synthesize moc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIColor* blueGreenColor = [UIColor colorWithRed:0.216 green:0.737 blue:0.608 alpha:1];
        
        refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshAction:)];
        
        [refreshButton setTintColor:blueGreenColor];
        
        
        
        UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
        [addButton setTintColor:blueGreenColor];
        
        //UIView* item = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        UISwitch* listOrGroup = [[UISwitch alloc] init];
        [listOrGroup setTintColor:blueGreenColor];
        [listOrGroup setOnTintColor:blueGreenColor];
        //[item addSubview:listOrGroup];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:listOrGroup];
        //self.navigationItem.leftBarButtonItem = refreshButton;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:addButton, refreshButton, nil];
        
        
        
        
        searchController = [[SearchableViewController alloc] init];
        searchController.delegate = self;
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor colorWithRed:(247.0f/255) green:(247.0f/255) blue:(247.0f/255) alpha:1]];
    [self.view addSubview:searchController.view];
    
    
    CGFloat verticalOffset = 3;
    
    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:verticalOffset forBarMetrics:UIBarMetricsDefault];
    
    UIColor* barColor = [UIColor colorWithRed:0.18 green:0.282 blue:0.353 alpha:1];
    [[UINavigationBar appearance] setBarTintColor:barColor];
   // [[UINavigationBar appearance] setTranslucent:NO];
    
    UIFont *customFont = [UIFont fontWithName:@"Eurofurencelight" size:40];
    
    NSDictionary * navBarTitleTextAttributes =
    @{NSForegroundColorAttributeName : [UIColor whiteColor],
      NSFontAttributeName            : customFont };
    
    [[UINavigationBar appearance] setTitleTextAttributes:navBarTitleTextAttributes];
    
    self.navigationController.navigationBar.topItem.title = @"jooblix";

    
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
    
    JoinGroupViewController* joinController = [[JoinGroupViewController alloc] init];
    [joinController setMoc:moc];
    [self.navigationController pushViewController:joinController animated:YES];
    
    
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

- (UITableViewCell*) setUpCellInTableView:(UITableView *)tableView andData:(id)data {
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jooblixCell"];
    if (nil == cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"jooblixCell"];
    }
    
    Task* currentTask = (Task*) data;
    
    // [cell.date setText:[currentTask date]];
    [cell.time setText:[[currentTask time] substringToIndex:5]];
    [cell.taskTitle setText:[currentTask name]];
    //[cell setColor:[[currentTask groupId] colorId]];
    
    
    
    //cell.textLabel.text = isFiltered ? [[searchData objectAtIndex:indexPath.row] name] : [[data objectAtIndex:indexPath.row] name];
    //cell.textLabel.text = @"toto";
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


@end