//
//  RollingMenuCell.h
//  Ozone
//
//  Created by Mac on 7/20/15.
//  Copyright (c) 2015 davidkopala. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuCellDelegate <NSObject>

-(void)userTappedCell:(NSInteger)index;

@end

@interface RollingMenuCell : UIView

-(id)init;
-(void) setTitle:(NSString *)title;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property NSInteger index;
@property id <MenuCellDelegate> delegate;

@end
