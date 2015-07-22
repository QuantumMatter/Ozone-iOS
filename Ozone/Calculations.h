//
//  Calculations.h
//  Ozone
//
//  Created by Mac on 7/1/15.
//  Copyright (c) 2015 davidkopala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculations : NSObject

@property NSString *tUnit;
@property NSString *pUnit;
@property NSString *unit;
@property double concen;
@property double pInput;
@property double tInput;

-(void)updateArrays;

-(NSArray *)start;

@end
