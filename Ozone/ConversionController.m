//
//  ConversionControllerViewController.m
//  Ozone
//
//  Created by Mac on 7/20/15.
//  Copyright (c) 2015 davidkopala. All rights reserved.
//

#import "ConversionController.h"
#import "RollingMenu.h"
#import "CalculationView.h"
#import "Conversion.h"

@interface ConversionController () {
    RollingMenu *rollingMenu;
    CalculationView *calcView1;
    CalculationView *calcView2;
    
    NSInteger selectedIndex;
    NSArray *calcArrays;
    
    NSString *value1;
    NSString *value2;
    
    NSArray *title01;
    NSArray *title02;
    NSArray *titleArray;
    
    SideMenu *sideMenu;
}

@end

@implementation ConversionController {
    CGFloat y;
}

@synthesize rollingView;
@synthesize inputView1;
@synthesize inputView2;
@synthesize resultLabel;
@synthesize BView;
@synthesize BLabel;
@synthesize toolbar;

- (IBAction)menuPressed:(id)sender {
    if (sideMenu == nil) {
        [self showMenu];
    } else {
        [self hideMenu];
    }
}

-(void) showMenu {
    sideMenu = [[SideMenu alloc] init];
    CGRect frame = CGRectMake(-150, y, 150, self.view.frame.size.height);
    sideMenu.frame = frame;
    sideMenu.delegate = self;
    //[self.view addSubview:sideMenu];
    [self.view addSubview:sideMenu];
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         sideMenu.frame = CGRectMake(0, y, 150, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         sideMenu.userInteractionEnabled = YES;
                     }];
}

-(void) hideMenu {
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         sideMenu.frame = CGRectMake(-150, y, 150, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [sideMenu removeFromSuperview];
                             sideMenu = nil;
                         }
                     }];
}

-(void) sideMenu:(SideMenu *)sideMenu indexSelected:(NSInteger)index {
    switch (index) {
        case 1:
            [self hideMenu];
            break;
            
        case 2:
            [self performSegueWithIdentifier:@"presentConversions" sender:self];
            break;
            
        default:
            break;
    }
}

- (void)viewDidLoad {
    y = toolbar.frame.size.height + toolbar.frame.origin.y;
    
    rollingMenu = [[RollingMenu alloc] initWithFrame:CGRectMake(0, 0 + y, self.view.bounds.size.width, 125)];
    rollingMenu.delegate = self;
    calcView1 = [[CalculationView alloc] initWithFrame:CGRectMake(15, 150 + y, 75, 200)];
    calcView1.delegate = self;
    CGRect frame = CGRectMake(self.view.bounds.size.width - 150, 150 + y, 75, 200);
    calcView2 = [[CalculationView alloc] initWithFrame:frame];
    calcView2.delegate = self;
    
              //X Y Width Height
    CGRectMake(0, 0, 0, 0);
    
    [self.view addSubview:rollingMenu];
    [self.view addSubview:calcView1];
    [self.view addSubview:calcView2];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userDidTap:)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
    [rollingMenu setSelectedPosition:1];
    selectedIndex = 1;
    
    title01 = @[@"GPM",
                @"SLPM",
                @"SLPM",
                @"SLPM",
                @"CFM",
                @"PSI"];
    
    title02 = @[@"PPM",
                @"% O3",
                @"% O3",
                @"g/m3",
                @"PPM",
                @"Measured Flow"];
    
    titleArray = @[@"Flow Rate",
                   @"Feedgas",
                   @"Dry Air Feedgas",
                   @"Output From Density",
                   @"PPM",
                   @"Adjusted Flow"];
    
    calcView1.titleLabel.text = [title01 objectAtIndex:selectedIndex];
    calcView2.titleLabel.text = [title02 objectAtIndex:selectedIndex];
    
    [rollingMenu loadData];
}

-(void)userDidTap:(UITapGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
    if (sideMenu != nil) {
        [self hideMenu];
    }
}

-(NSString *)titleForCellAtIndex:(NSInteger)index {
    return [titleArray objectAtIndex:index];
}

-(NSInteger)numberOfCellsInMenu {
    return 6;
}

-(void) selectedCellChanged:(NSInteger)index {
    selectedIndex = index;
    [self updateArray];
    resultLabel.text = [calcArrays objectAtIndex:selectedIndex];
    calcView1.titleLabel.text = [title01 objectAtIndex:selectedIndex];
    calcView2.titleLabel.text = [title02 objectAtIndex:selectedIndex];
    NSLog([NSString stringWithFormat:@"%ld", (long)index]);
}

-(void)fieldsChanged {
    value1 = calcView1.inputField.text;
    value2 = calcView2.inputField.text;
    [self updateArray];
    resultLabel.text = [NSString stringWithFormat:@"%@", [calcArrays objectAtIndex:selectedIndex]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateArray {
    calcArrays = @[[[[Conversion alloc] init] flowRateAndPPMWater:value1 PPM:value2],
                   [[[Conversion alloc] init] OutputOzoneGeneratorFeedgas:value1 percent:value2],
                   [[[Conversion alloc] init] OutputOZoneGeneratorDry:value1 percent:value2],
                   [[[Conversion alloc] init] OutputOzoneGenerator:value1 density:value2],
                   [[[Conversion alloc] init] OutputOzoneGeneratorPPM:value1 PPM:value2],
                   [[[Conversion alloc] init] AdjustedFlow:value1 Measured:value2]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
