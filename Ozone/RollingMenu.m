//
//  RollingMenu.m
//  Ozone
//
//  Created by Mac on 7/20/15.
//  Copyright (c) 2015 davidkopala. All rights reserved.
//

#import "RollingMenu.h"
#import "RollingMenuCell.h"

@implementation RollingMenu {
    NSInteger selectedIndex;
    NSMutableArray *cells;
    UISwipeGestureRecognizer *swipeRight;
    UISwipeGestureRecognizer *swipeLeft;
    UITapGestureRecognizer *tap;
    NSArray *scaleArray;
}

@synthesize delegate;

-(id)initWithFrame:(CGRect)frame {
    self = [[[NSBundle mainBundle] loadNibNamed:@"RollingMenu" owner:self options:nil] objectAtIndex:0];
    self.frame = frame;
    cells = [[NSMutableArray alloc] init];
    
    swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(userDidSwipe:)];
    swipeRight.view.layer.zPosition = 100;
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeRight];
    
    swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(userDidSwipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeLeft];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userDidTap:)];
    tap.view.layer.zPosition = 100;
    [self addGestureRecognizer:tap];
    
    selectedIndex = 5;
    
    return self;
}

-(void) userDidSwipe:(UISwipeGestureRecognizer *)recognizer {
    switch (recognizer.direction) {
        case UISwipeGestureRecognizerDirectionRight:
            [self swipeRight];
            break;
            
        case UISwipeGestureRecognizerDirectionLeft:
            [self swipeLeft];
            break;
            
        case UISwipeGestureRecognizerDirectionDown:
            NSLog(@"Down");
            break;
            
        case UISwipeGestureRecognizerDirectionUp:
            NSLog(@"Up");
            break;
            
        default:
            break;
    }
}

-(void)swipeRight {
    if (selectedIndex > 0) {
        selectedIndex--;
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationCurveLinear
                         animations:^{
                             [self reloadData];
                             [self layoutIfNeeded];
                         }
                         completion:^(BOOL finished) {
                             
                         }];
        [delegate selectedCellChanged:selectedIndex];
        //[self reloadData];
    }
}

-(void) swipeLeft {
    if (selectedIndex < ([delegate numberOfCellsInMenu] - 1)) {
        selectedIndex++;
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationCurveLinear
                         animations:^{
                             [self reloadData];
                             [self layoutIfNeeded];
                         }
                         completion:^(BOOL finished) {
                             
                         }];
        [delegate selectedCellChanged:selectedIndex];
        //[self reloadData];
    }
}

-(void) userDidTap:(UITapGestureRecognizer *) recognizer {
    NSLog(@"Tap");
    CGPoint point = [recognizer locationInView:self];
    if (point.x > (self.frame.size.width / 2)) {
        [self swipeLeft];
    } else {
        [self swipeRight];
    }
}

-(void) reloadData {
    for (int i = 0; i < [cells count]; i++) {
        RollingMenuCell *cell = [cells objectAtIndex:i];
        cell.transform = CGAffineTransformMakeScale([self scaleForCell:i], [self scaleForCell:i]);
        double width = cell.frame.size.width;
        double selfWidth = self.frame.size.width / 2;
        double scale = [self xValueForCell:i];
        double x = selfWidth + (scale * width);
        cell.center = CGPointMake(x, self.frame.size.height / 2);
        NSInteger layer = [self layerForCell:i];
        if (layer == 50) {
            cell.alpha = 1.0f;
        } else {
            cell.alpha = 0.7f;
        }
        cell.layer.zPosition = layer;
        //cell.transform = CGAffineTransformMakeScale([self scaleForCell:i], [self scaleForCell:i]);
        [cell layoutIfNeeded];
    }
    //[self loadData];
}

-(void) loadData {
    for (int i = 0; i < [delegate numberOfCellsInMenu]; i++) {
        NSString *title = [delegate titleForCellAtIndex:i];
        RollingMenuCell *cell = [[RollingMenuCell alloc] init];
        cell.delegate = self;
        [cell setTitle:title];
        double width = cell.frame.size.width;
        double selfWidth = self.frame.size.width / 2;
        double scale = [self xValueForCell:i];
        NSLog([NSString stringWithFormat:@"%f", scale]);
        double x = selfWidth + (scale * width);
        cell.center = CGPointMake(x, self.frame.size.height / 2);
        NSInteger layer = [self layerForCell:i];
        if (layer == 50) {
            cell.alpha = 1.0f;
        } else {
            cell.alpha = 0.7f;
        }
        cell.layer.zPosition = layer;
        cell.transform = CGAffineTransformMakeScale([self scaleForCell:i], [self scaleForCell:i]);
        [self addSubview:cell];
        [cells addObject:cell];
        [cell layoutIfNeeded];
    }
}

-(void) setSelectedPosition:(NSInteger)position {
    if (position > selectedIndex) {
        for (nil; selectedIndex <= position; nil) {
            [self swipeLeft];
        }
    } else {
        for (nil; selectedIndex >= position; nil) {
            [self swipeRight];
        }
    }
    //[self reloadData];
}

-(NSInteger) layerForCell:(NSInteger)index {
    NSInteger half = [delegate numberOfCellsInMenu] / 2;
    NSInteger shift = half - selectedIndex;
    index += shift;
    index = index - half;
    if (index < 0) {
        index = 0 - index;
    }
    return 50 - index;
}

-(double) xValueForCell:(double)index {
    bool negative = false;
    NSInteger half = [delegate numberOfCellsInMenu] / 2;
    NSInteger shift = half - selectedIndex;
    index = index - half;
    index += shift;
    if (index < 0) {
        negative = true;
        index = 0 - index;
    }
    //index--;
    index = -0.075 * (index * index + 9 * index);
    if (negative) {
        if (index < 0) {
            return index;
        } else {
            index = 0 - index;
            return index;
        }
    } else {
        if (index < 0) {
            index = 0 - index;
            return index;
        } else {
            return index;
        }
    }
    //return index;
}

-(double) scaleForCell:(double)index {
    NSInteger half = [delegate numberOfCellsInMenu] / 2;
    NSInteger shift = half - selectedIndex;
    index = index - half;
    index += shift;
    return -0.04 * ((index + 5) * (index - 5));
}

-(void) userTappedCell:(NSInteger)index {
    //[self setSelectedPosition:index];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
