//
//  CalculationView.h
//  Ozone
//
//  Created by Mac on 7/20/15.
//  Copyright (c) 2015 davidkopala. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalculationDelegate <NSObject>

-(void)fieldsChanged;

@end

@interface CalculationView : UIView

-(id)initWithFrame:(CGRect)frame;

-(NSString *)getInput;
@property (strong, nonatomic) IBOutlet UITextField *inputField;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property id <CalculationDelegate> delegate;

@end
