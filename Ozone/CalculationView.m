//
//  CalculationView.m
//  Ozone
//
//  Created by Mac on 7/20/15.
//  Copyright (c) 2015 davidkopala. All rights reserved.
//

#import "CalculationView.h"

@implementation CalculationView

@synthesize titleLabel;
@synthesize inputField;
@synthesize delegate;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame {
    self = [[[NSBundle mainBundle] loadNibNamed:@"CalculationInput" owner:self options:nil] objectAtIndex:0];
    self.frame = frame;
    return self;
}

-(NSString *)getInput {
    return inputField.text;
}

- (IBAction)valueChanged:(id)sender {
    [delegate fieldsChanged];
}

@end
