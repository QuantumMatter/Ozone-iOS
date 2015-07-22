//
//  SideMenu.h
//  Ozone
//
//  Created by Mac on 7/22/15.
//  Copyright (c) 2015 2B Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenu : UIView

@property id delegate;

-(id)init;

@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UILabel *label3;
@property (strong, nonatomic) IBOutlet UILabel *label4;

@end

@protocol SideMenuDelegate <NSObject>

-(void)sideMenu:(SideMenu *)sideMenu indexSelected:(NSInteger)index;

@end
