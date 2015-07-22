//
//  RollingMenuCell.m
//  Ozone
//
//  Created by Mac on 7/20/15.
//  Copyright (c) 2015 davidkopala. All rights reserved.
//

#import "RollingMenuCell.h"

@implementation RollingMenuCell

@synthesize titleLabel;
@synthesize index;
@synthesize delegate;

-(id)init {
    self = [[[NSBundle mainBundle] loadNibNamed:@"RollingMenuCell" owner:self options:nil] objectAtIndex:0];
    return self;
}

-(void) setTitle:(NSString *)title {
    titleLabel.text = title;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
