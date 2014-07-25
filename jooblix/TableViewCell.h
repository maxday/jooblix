//
//  TableViewCell.h
//  jooblix
//
//  Created by maxday on 2014-07-24.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property(nonatomic, retain) UIView* leftView;
@property(nonatomic, retain) UILabel* leftName;
@property(nonatomic, retain) UILabel* time;
@property(nonatomic, retain) UILabel* ampm;
@property(nonatomic, retain) UIImageView* iconView;
@property(nonatomic, retain) UIImageView* clockView;
@property(nonatomic, retain) UIImageView* calView;
@property(nonatomic, retain) UILabel* taskTitle;
@property(nonatomic, retain) UILabel* date;

@property(nonatomic, retain) UIView* bottomBorder;

- (void) setColor:(NSNumber*) colorId;

@end
