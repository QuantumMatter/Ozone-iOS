//
//  RollingMenu.h
//  Ozone
//
//  Created by Mac on 7/20/15.
//  Copyright (c) 2015 davidkopala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RollingMenuCell.h"

@protocol RollingMenuDelegate <NSObject>

-(NSString *)titleForCellAtIndex:(NSInteger)index;
-(NSInteger) numberOfCellsInMenu;
-(void) selectedCellChanged:(NSInteger)index;

@end

@interface RollingMenu : UIView <MenuCellDelegate>

-(id) initWithFrame:(CGRect)frame;
-(void) setSelectedPosition:(NSInteger)position;
-(void) loadData;
-(void) reloadData;

@property id <RollingMenuDelegate> delegate;

@end
