//
//  ConversionControllerViewController.h
//  Ozone
//
//  Created by Mac on 7/20/15.
//  Copyright (c) 2015 davidkopala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RollingMenu.h"
#import "CalculationView.h"
#import "SideMenu.h"

@interface ConversionController : UIViewController <RollingMenuDelegate, CalculationDelegate, SideMenuDelegate>

@property (strong, nonatomic) IBOutlet RollingMenu *rollingView;
@property (strong, nonatomic) IBOutlet CalculationView *inputView1;
@property (strong, nonatomic) IBOutlet CalculationView *inputView2;
@property (strong, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong, nonatomic) IBOutlet UIView *BView;
@property (strong, nonatomic) IBOutlet UILabel *BLabel;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;

@end
