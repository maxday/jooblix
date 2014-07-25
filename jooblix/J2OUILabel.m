//
//  J2OUILabel.m
//  jooblix
//
//  Created by maxday on 2014-07-24.
//  Copyright (c) 2014 MaximeDavid. All rights reserved.
//

#import "J2OUILabel.h"

@implementation J2OUILabel


- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 15, 0, 5};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}


@end
