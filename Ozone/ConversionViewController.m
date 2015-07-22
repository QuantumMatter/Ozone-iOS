//
//  ConversionViewController.m
//  Ozone
//
//  Created by Mac on 7/2/15.
//  Copyright (c) 2015 davidkopala. All rights reserved.
//

#import "ConversionViewController.h"
#import "Calculations.h"
#import "SideMenu.h"

@interface ConversionViewController ()

@property (strong, nonatomic) IBOutlet UILabel *resultLabel;

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@property (strong, nonatomic) IBOutlet UITextField *concenInput;
@property (strong, nonatomic) IBOutlet UIButton *concenButton;

@property (strong, nonatomic) IBOutlet UITextField *tempInput;
@property (strong, nonatomic) IBOutlet UIButton *tempButton;

@property (strong, nonatomic) IBOutlet UITextField *pressureInput;
@property (strong, nonatomic) IBOutlet UIButton *pressureButton;
@property (strong, nonatomic) IBOutlet UIView *advancedView;
@property (strong, nonatomic) IBOutlet UIButton *advancedButton;
@property (strong, nonatomic) IBOutlet UIButton *calculateButton;

@end

@implementation ConversionViewController  {
    NSArray *titleArray;
    NSInteger titleIndex;
    
    NSArray *tempArray;
    NSInteger tempIndex;
    
    NSArray *pressureArray;
    NSInteger pressureIndex;
    
    NSArray *pickerData;
    SideMenu *sideMenu;
    
    UITapGestureRecognizer *tapGesture;
    
    UIView *pickerBG;
    
    bool advanced;
    
    CGRect frame;
}

-(void) sideMenu:(SideMenu *)sideMenu indexSelected:(NSInteger)index {
    switch (index) {
        case 1:
            [self performSegueWithIdentifier:@"presentCalculations" sender:self];
            break;
            
        case 2:
            [self hideMenu];
            break;
            
        default:
            break;
    }
}

- (IBAction)showAdvanced:(id)sender {
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    //[self.view removeConstraints:self.view.constraints];
    //calculateButton.translatesAutoresizingMaskIntoConstraints = YES;
    /*CGRect original = CGRectMake(calculateButton.frame.origin.x, calculateButton.frame.origin.y + advancedView.frame.size.height, calculateButton.frame.size.width, calculateButton.frame.size.height);
    self.view.autoresizesSubviews = NO;
    [calculateButton removeConstraints:calculateButton.constraints];
    [calculateButton setFrame:original];
     CGRect frame = CGRectMake(calculateButton.frame.origin.x, calculateButton.frame.origin.y + advancedView.frame.size.height, calculateButton.frame.size.width, calculateButton.frame.size.height);*/
    frame = CGRectMake(calculateButton.frame.origin.x, calculateButton.frame.origin.y + advancedView.frame.size.height, calculateButton.frame.size.width, calculateButton.frame.size.height);
    
    advanced = true;
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [advancedView setAlpha:1.0];
                         advancedButton.frame = CGRectMake(advancedButton.frame.origin.x, advancedButton.frame.origin.y + advancedView.frame.size.height, advancedButton.frame.size.width, advancedButton.frame.size.height);
                         [advancedButton setAlpha:0.0];
                         calculateButton.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         /*[advancedView setUserInteractionEnabled:YES];
                         [advancedButton setUserInteractionEnabled:NO];
                         [pickerView reloadAllComponents];
                         [calculateButton removeFromSuperview];
                         UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                         [button addTarget:self
                                    action:@selector(test:)
                          forControlEvents:UIControlEventTouchUpInside];
                         [button setTitle:@"Calculate" forState:UIControlStateNormal];
                         button.frame = frame;
                         [self.view addSubview:button];
                         //[pickerView reloadInputViews];*/
                         [pickerView reloadAllComponents];
                         
                     }];
    
    //[calculateButton setFrame:frame];
    /*NSTimer *timer = [NSTimer timerWithTimeInterval:0.01
                                             target:self
                                           selector:@selector(setCalculateFrame:)
                                           userInfo:nil
                                            repeats:YES];*/
}

-(void)setCalculateFrame:(NSTimer *)timer {
    calculateButton.frame = frame;
}

- (IBAction)menuPressed:(id)sender {
    [self.view endEditing:YES];
    if (sideMenu == nil) {
        tapGesture.enabled = NO;
        sideMenu = [[[NSBundle mainBundle] loadNibNamed:@"SideMenu" owner:self options:nil] objectAtIndex:0];
        sideMenu.delegate = self;
        sideMenu.frame = CGRectMake(self.view.frame.origin.x - 200, 72, 200, self.view.frame.size.height);
        [self.view addSubview:sideMenu];
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:(UIViewAnimationCurveLinear)
                         animations:^{
                             sideMenu.frame = CGRectMake(self.view.frame.origin.x, 72, 200, self.view.frame.size.height);
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    } else {
        [self hideMenu];
    }
}

-(void)hideMenu {
    [self.view endEditing:YES];
    tapGesture.enabled = YES;
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:(UIViewAnimationCurveLinear)
                     animations:^{
                         sideMenu.frame = CGRectMake(-200, 60, 200, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         [sideMenu removeFromSuperview];
                         sideMenu = nil;
                     }];
}

-(void)userSelectedMenuRow:(NSInteger)row {
    switch (row) {
        case 0:
            [self performSegueWithIdentifier:@"presentCalculations" sender:self];
            break;
            
        case 2:
            [self performSegueWithIdentifier:@"presentProperties" sender:self];
            break;
            
        case 3:
            [self performSegueWithIdentifier:@"present2B" sender:self];
            break;
            
        default:
            [self hideMenu];
            break;
    }
}

@synthesize pickerView;
@synthesize concenInput;
@synthesize concenButton;
@synthesize tempInput;
@synthesize tempButton;
@synthesize pressureButton;
@synthesize advancedView;
@synthesize calculateButton;
@synthesize advancedButton;

- (IBAction)concenPressed:(id)sender {
    [pickerView setUserInteractionEnabled:YES];
    /*pickerBG = [[UIView alloc] init];
    [pickerBG setBackgroundColor:[UIColor grayColor]];
    [pickerBG setAlpha:0.0];
    pickerBG.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    pickerView.layer.zPosition = 19;
    [self.view addSubview:pickerBG];*/
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:(UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [pickerView setAlpha:1.0];
                         //[pickerBG setAlpha:0.5];
                         //pickerBG.frame = CGRectMake(0, 300, pickerBG.frame.size.width, pickerBG.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

- (IBAction)tempPressed:(id)sender {
    [self.view endEditing:YES];
    [pickerView setUserInteractionEnabled:YES];
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:(UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [pickerView setAlpha:1.0];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

- (IBAction)pressurePressed:(id)sender {
    [self.view endEditing:YES];
    [pickerView setUserInteractionEnabled:YES];
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:(UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [pickerView setAlpha:1.0];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

- (IBAction)test:(id)sender {
    [self.view endEditing:YES];
    [pickerView setUserInteractionEnabled:NO];
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:(UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [pickerView setAlpha:0.0];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    Calculations *calc = [[Calculations alloc] init];
    calc.tUnit = [tempArray objectAtIndex:tempIndex];
    calc.pUnit = [pressureArray objectAtIndex:pressureIndex];
    calc.unit = [titleArray objectAtIndex:titleIndex];
    calc.concen = [concenInput.text integerValue];
    calc.pInput = [self.pressureInput.text integerValue];
    calc.tInput = [tempInput.text integerValue];
    NSArray *result = [[calc start] objectAtIndex:0];
    NSString *stringResult = @"";
    NSString *temp;
    for (int i = 0; i < [result count]; i++) {
        temp = [NSString stringWithFormat:@"%E", [[result objectAtIndex:i] doubleValue]];
        NSArray *notation = [temp componentsSeparatedByString:@"E"];
        if (([[notation objectAtIndex:1] integerValue] > 5) || ([[notation objectAtIndex:1] integerValue] < -3)) {
            temp = [self trimZeros:temp];
        } else {
            temp = [NSString stringWithFormat:@"%f", [[result objectAtIndex:i]doubleValue]];
        }
        stringResult = [NSString stringWithFormat:@"%@ %@: %@ \n", stringResult, [titleArray objectAtIndex:i], temp];
    }
    self.resultLabel.numberOfLines = 0;
    
    //CGSize labelSize = [self.resultLabel.text sizeWithAttributes:@{NSFontAttributeName:self.resultLabel.font}];
    
    //self.resultLabel.frame = CGRectMake(
    //                         self.resultLabel.frame.origin.x, self.resultLabel.frame.origin.y,
    //                         self.resultLabel.frame.size.width, labelSize.height);
    self.resultLabel.text = stringResult;
}

- (void)viewDidLoad {
    advanced = false;
    [super viewDidLoad];
    [advancedView setAlpha:0.0];
    advancedView.userInteractionEnabled = YES;
    [pickerView setAlpha:0.0];
    [pickerView setUserInteractionEnabled:NO];
    [pickerView setBackgroundColor:[UIColor grayColor]];
    pickerView.layer.zPosition = 10;
    [pressureButton setTitle:@"atm ▼" forState:UIControlStateNormal];
    titleIndex = 0;
    tempIndex = 2;
    titleArray = @[@"ppb",
                   @"pphm",
                   @"ppm",
                   @"vol %",
                   @"g/l",
                   @"µg/ml",
                   @"mg/m3",
                   @"µg/m3",
                   @"g/m3",
                   @"g/nm3",
                   @"wt/co2",
                   @"wt/cair",
                   @"moleFraction"];
    
    tempArray = @[@"°C",
                  @"°F",
                  @"K"];
    
    pressureArray = @[@"atm",
                      @"torr",
                      @"psia",
                      @"bar",
                      @"mbar",
                      @"pascal",
                      @"kilopascal",
                      @"inwater"];
    
    pickerData = @[titleArray,
                   tempArray,
                   pressureArray];
    
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapped:)];
    [self.view addGestureRecognizer:tapGesture];
}

-(void) userTapped:(UITapGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
    [pickerView setUserInteractionEnabled:NO];
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:(UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [pickerView setAlpha:0];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    if (sideMenu != nil) {
        [self hideMenu];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSString *) trimZeros:(NSString *)string {
    bool run = true;
    NSArray *stringArray = [string componentsSeparatedByString:@"E"];
    NSString *tempString = [stringArray objectAtIndex:0];
    while (run) {
        char temp = [tempString characterAtIndex:[tempString length] - 1];
        if (temp == '0') {
            tempString = [string substringToIndex:[tempString length] - 1];
        } else {
            run = false;
        }
        if (temp == '.') {
            tempString = [string substringToIndex:[tempString length] - 1];
        }
    }
    string = [NSString stringWithFormat:@"%@E%@", tempString, [stringArray objectAtIndex:1]];
    return string;
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (!advanced) {
        return 1;
    }
    return [pickerData count];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[pickerData objectAtIndex:component] count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[pickerData objectAtIndex:component] objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            titleIndex = row;
            [concenButton setTitle:[NSString stringWithFormat:@"%@ ▼", [titleArray objectAtIndex:row]] forState:UIControlStateNormal];
            break;
            
        case 1:
            tempIndex = row;
            [tempButton setTitle:[NSString stringWithFormat:@"%@ ▼", [tempArray objectAtIndex:row]] forState:UIControlStateNormal];
            break;
            
        case 2:
            pressureIndex = row;
            [pressureButton setTitle:[NSString stringWithFormat:@"%@ ▼", [pressureArray objectAtIndex:row]] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

@end
