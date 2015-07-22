//
//  SideMenu.m
//  Ozone
//
//  Created by Mac on 7/22/15.
//  Copyright (c) 2015 2B Technologies. All rights reserved.
//

#import "SideMenu.h"

@implementation SideMenu

@synthesize label1;
@synthesize label2;
@synthesize label3;
@synthesize label4;

@synthesize delegate;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)label1Pressed:(id)sender {
    [delegate sideMenu:self indexSelected:1];
}

- (IBAction)label2Pressed:(id)sender {
    [delegate sideMenu:self indexSelected:2];
}

- (IBAction)label3Pressed:(id)sender {
    [delegate sideMenu:self indexSelected:3];
}

- (IBAction)label4Pressed:(id)sender {
    [delegate sideMenu:self indexSelected:4];
}

-(id)init {
    self = [[[NSBundle mainBundle] loadNibNamed:@"SideMenu" owner:self options:nil] objectAtIndex:0];
    
    return self;
}

-(void) userTapped:(UITapGestureRecognizer *)recognizer {
    if (delegate != nil) {
        if ([recognizer.view isEqual:label1]) {
            [delegate sideMenu:self indexSelected:1];
        } else if ([recognizer.view isEqual:label2]) {
            [delegate sideMenu:self indexSelected:2];
        } else if([recognizer.view isEqual:label3]) {
            [delegate sideMenu:self indexSelected:3];
        } else if ([recognizer.view isEqual:label4]) {
            [delegate sideMenu:self indexSelected:4];
        }
    }
}

@end
