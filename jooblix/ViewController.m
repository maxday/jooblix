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

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"Liste", @"Group", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(60, 74, 200, 20);
    [segmentedControl addTarget:self action:@selector(changeViewAction:) forControlEvents: UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 1;
    [self.view addSubview:segmentedControl];
    
    UIBarButtonItem* refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshAction:)];
    
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
    NSLog(@"ddddd-dj-REFRESH");
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jooblixCell"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"jooblixCell"];
    }
    [cell.textLabel setText:@"COUCOU"];
    return cell;
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
