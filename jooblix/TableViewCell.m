//
//  TableViewCell.m
//  jooblix
//
//  Created by maxday on 2014-07-24.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import "TableViewCell.h"
#import "J2OUILabel.h"

#define WIDTH_LEFT_VIEW 55
#define HEIGHT_LEFT_VIEW 50
#define WIDTH_ICON 20
#define HEIGHT_ICON 15
#define PADDING_CLOCK_ICON 7
#define WIDTH_CLOCK 8
#define HEIGHT_CLOCK 8
#define WIDTH_CAL 8
#define HEIGHT_CAL 9
#define LABEL_TIME_WIDTH 25
#define LABEL_DATE_WIDTH 100
#define PADDING_CAL_ICON 190

@implementation TableViewCell

@synthesize leftView;
@synthesize iconView;
@synthesize leftName;
@synthesize taskTitle;
@synthesize clockView;
@synthesize time;
@synthesize ampm;
@synthesize calView;
@synthesize date;
@synthesize bottomBorder;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIColor* color = [UIColor colorWithRed:0.255 green:0.357 blue:0.447 alpha:1];
        UIColor* backgroundColor = [UIColor colorWithRed:0.941 green:0.949 blue:0.961 alpha:1];
        UIColor* borderColor = [UIColor colorWithRed:0.784 green:0.780 blue:0.80 alpha:1];
        
        [self setBackgroundColor:backgroundColor];
        
        leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_LEFT_VIEW, HEIGHT_LEFT_VIEW)];
        [leftView setBackgroundColor:[UIColor colorWithRed:0.549 green:0.757 blue:0.322 alpha:1]];

        
        leftName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_LEFT_VIEW, HEIGHT_LEFT_VIEW/2)];
        [leftName setText:@"MT01"];
        //[leftName setBackgroundColor:[UIColor blueColor]];
        [leftName setTextAlignment:NSTextAlignmentCenter];
        [leftName setTextColor:[UIColor whiteColor]];
        [leftName setFont:[UIFont fontWithName:@"Helvetica" size:14]];

        
        iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_ICON, HEIGHT_ICON)];
        [iconView setCenter:CGPointMake(WIDTH_LEFT_VIEW/2, 3*HEIGHT_LEFT_VIEW/4)];
        [iconView setImage:[UIImage imageNamed:@"jooblix-book"]];
        
        taskTitle = [[J2OUILabel alloc] initWithFrame:CGRectMake(WIDTH_LEFT_VIEW, 0, self.bounds.size.width-WIDTH_LEFT_VIEW, HEIGHT_LEFT_VIEW)];
        [taskTitle setBackgroundColor:[UIColor whiteColor]];
        [taskTitle setFont:[UIFont fontWithName:@"Helvetica" size:20]];
        [taskTitle setText:@"toto"];
        [taskTitle setTextColor:color];
        
        
        
        bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_LEFT_VIEW, self.bounds.size.width, 0.5)];
        [bottomBorder setBackgroundColor:borderColor];
        
        
        
        
        clockView = [[UIImageView alloc] initWithFrame:CGRectMake(PADDING_CLOCK_ICON, HEIGHT_LEFT_VIEW+PADDING_CLOCK_ICON, WIDTH_CLOCK, HEIGHT_CLOCK)];
        [clockView setImage:[UIImage imageNamed:@"jooblix-clock"]];
        
        time = [[UILabel alloc] initWithFrame:CGRectMake(5*PADDING_CLOCK_ICON/3 + WIDTH_CLOCK, HEIGHT_LEFT_VIEW+PADDING_CLOCK_ICON, LABEL_TIME_WIDTH, HEIGHT_CLOCK)];
        [time setFont:[UIFont fontWithName:@"Helvetica" size:9]];
        [time setText:@"08:15"];
        [time setTextColor:color];
        
        ampm = [[UILabel alloc] initWithFrame:CGRectMake(5*PADDING_CLOCK_ICON/3 + WIDTH_CLOCK + LABEL_TIME_WIDTH, HEIGHT_LEFT_VIEW+PADDING_CLOCK_ICON/2, LABEL_TIME_WIDTH, HEIGHT_CLOCK)];
        [ampm setFont:[UIFont fontWithName:@"Helvetica" size:7]];
        [ampm setText:@"AM"];
        [ampm setTextColor:color];
        
        
        calView = [[UIImageView alloc] initWithFrame:CGRectMake(PADDING_CAL_ICON, HEIGHT_LEFT_VIEW+PADDING_CLOCK_ICON, WIDTH_CAL, HEIGHT_CAL)];
        [calView setImage:[UIImage imageNamed:@"jooblix-cal"]];

        
        date = [[UILabel alloc] initWithFrame:CGRectMake(5*PADDING_CLOCK_ICON/3 + PADDING_CAL_ICON, HEIGHT_LEFT_VIEW+PADDING_CLOCK_ICON, LABEL_DATE_WIDTH, HEIGHT_CAL)];
        [date setFont:[UIFont fontWithName:@"Helvetica" size:9]];
        [date setText:@"Thuesday, 14th of July"];
        [date setTextColor:color];

        
        [self addSubview:leftView];
        [self addSubview:leftName];
        [self addSubview:iconView];
        [self addSubview:bottomBorder];
        [self addSubview:clockView];
        [self addSubview:taskTitle];
        [self addSubview:iconView];
        [self addSubview:time];
        [self addSubview:ampm];
        [self addSubview:calView];
        [self addSubview:date];
        
        
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
