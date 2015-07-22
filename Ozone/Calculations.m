//
//  Calculations.m
//  Ozone
//
//  Created by Mac on 7/1/15.
//  Copyright (c) 2015 davidkopala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calculations.h"

@implementation Calculations {
    double p;
    double t;
    double moleFraction;
    
    
    NSArray *pUnits;
    NSArray *pUnitsFactor;
    NSArray *units;
    NSArray *unitsFactor;
    
    NSArray *tUnits;
    NSArray *tUnitsFactor;
    
    NSArray *ppbEquations;
    NSArray *pphmEquations;
    NSArray *ppmEquations;
    NSArray *volcEquations;
    NSArray *gplEquations;
    NSArray *microgpmlEquations;
    NSArray *microgpm3Equations;
    NSArray *mgperm3Equations;
    NSArray *gpm3Equations;
    NSArray *gpnm3Equations;
    NSArray *wtpcairEquations;
    NSArray *wtpco2Equations;
    
    NSArray *equations;
}

@synthesize tUnit;
@synthesize pUnit;
@synthesize unit;
@synthesize concen;
@synthesize pInput;
@synthesize tInput;

-(id) init {
    
    moleFraction = 1e-8;
    
    pUnits = @[@"atm",
              @"torr",
              @"psia",
              @"bar",
              @"mbar",
              @"pascal",
              @"kilopascal",
              @"inwater"];
    
    pUnitsFactor = @[@1,
                     @760,
                     @14.6959,
                     @1.013250,
                     @1013.25,
                     @101.32501,
                     @406.78250461];
    
    units = @[@"ppb",
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
    
    tUnits = @[@"°C",
               @"°F",
               @"K"];
    
    tUnitsFactor = @[@(tInput + 273.15),
                     @(273.15 + (tInput - 32)*(0.5555555555)),
                     @(tInput)];
    
    return self;
}

-(void) updateArrays {
    
    unitsFactor = @[@(concen/1e9),
                    @(concen/1e8),
                    @(concen/1e6),
                    @(concen/1e2),
                    @(concen/2.1414*t/273.15/p),
                    @(concen/2.1414*1e-3*t/273.15/p),
                    @(concen/2.1414*1e-6*t/273.15/p),
                    @(concen/2.1414*1e-9*t/273.15/p),
                    @(concen/2.1414*1e-3*t/273.15/p),
                    @(concen/2.1414*1e-3),
                    @(concen/100*31.9988/(47.9982-15.9994*concen/100)),
                    @((concen/47.9982)/(100/28.9653-(0.5*concen/47.9982)))];
    
    tUnitsFactor = @[@(tInput + 273.15),
                     @(273.15 + ((tInput - 32) * 0.55555555)),
                     @(tInput)];
    
    ppbEquations = @[  @(concen),
                    @(moleFraction*pow(10, 8)),
                    @(moleFraction*pow(10, 6)),
                    @(moleFraction*100),
                    @(moleFraction*2.1414*p*273.15/t),
                    @(moleFraction*1e3*2.1414*p*273.15/t),
                    @(moleFraction*1e9*2.1414*p*273.15/t),
                    @(moleFraction*1e6*2.1414*p*273.15/t),
                    @(moleFraction*1e3*2.1414*p*273.15/t),
                    @(moleFraction*1e3*2.1414),
                    @(moleFraction*47.9982/(28.9653+0.5*moleFraction*28.9653)*100),
                    @(moleFraction*47.9982/(47.9982*moleFraction + 31.9988*(1-moleFraction))*100)];
    
    pphmEquations = @[@(moleFraction*1e9),
                      @(concen),
                      @(moleFraction*1e6),
                      @(moleFraction*100),
                      @(moleFraction*2.1414*p*273.15/t),
                      @(moleFraction*1e3*2.1414*p*273.15/t),
                      @(moleFraction*1e9*2.1414*p*273.15/t),
                      @(moleFraction*1e6*2.1414*p*273.15/t),
                      @(moleFraction*1e3*2.1414*p*273.15/t),
                      @(moleFraction*1e3*2.1414),
                      @(moleFraction*47.9982/(28.9653+0.5*moleFraction*28.9653)*100),
                      @(moleFraction*47.9982/(47.9982*moleFraction + 31.9988*(1-moleFraction))*100)];
    
    ppmEquations = @[@(moleFraction*1e9),
                     @(moleFraction*1e8),
                     @(concen),
                     @(moleFraction*100),
                     @(moleFraction*2.1414*p*273.15/t),
                     @(moleFraction*1e3*2.1414*p*273.15/t),
                     @(moleFraction*1e9*2.1414*p*273.15/t),
                     @(moleFraction*1e6*2.1414*p*273.15/t),
                     @(moleFraction*1e3*2.1414*p*273.15/t),
                     @(moleFraction*1e3*2.1414),
                     @(moleFraction*47.9982/(28.9653+0.5*moleFraction*28.9653)*100),
                     @(moleFraction*47.9982/(47.9982*moleFraction + 31.9988*(1-moleFraction))*100)];
    
    volcEquations = @[@(moleFraction*1e9),
                      @(moleFraction*1e8),
                      @(moleFraction*1e6),
                      @(concen),
                      @(moleFraction*2.1414*p*273.15/t),
                      @(moleFraction*1e3*2.1414*p*273.15/t),
                      @(moleFraction*1e9*2.1414*p*273.15/t),
                      @(moleFraction*1e6*2.1414*p*273.15/t),
                      @(moleFraction*1e3*2.1414*p*273.15/t),
                      @(moleFraction*1e3*2.1414),
                      @(moleFraction*47.9982/(28.9653+0.5*moleFraction*28.9653)*100),
                      @(moleFraction*47.9982/(47.9982*moleFraction + 31.9988*(1-moleFraction))*100)];
    
    gplEquations = @[@(moleFraction*1e9),
                     @(moleFraction*1e8),
                     @(moleFraction*1e6),
                     @(moleFraction*100),
                     @(concen),
                     @(moleFraction*1e3*2.1414*p*273.15/t),
                     @(moleFraction*1e9*2.1414*p*273.15/t),
                     @(moleFraction*1e6*2.1414*p*273.15/t),
                     @(moleFraction*1e3*2.1414*p*273.15/t),
                     @(moleFraction*1e3*2.1414),
                     @(moleFraction*47.9982/(28.9653+0.5*moleFraction*28.9653)*100),
                     @(moleFraction*47.9982/(47.9982*moleFraction + 31.9988*(1-moleFraction))*100)];
    
    microgpmlEquations = @[@(moleFraction*1e9),
                           @(moleFraction*1e8),
                           @(moleFraction*1e6),
                           @(moleFraction*100),
                           @(moleFraction*2.1414*p*273.15/t),
                           @(concen),
                           @(moleFraction*1e9*2.1414*p*273.15/t),
                           @(moleFraction*1e6*2.1414*p*273.15/t),
                           @(moleFraction*1e3*2.1414*p*273.15/t),
                           @(moleFraction*1e3*2.1414),
                           @(moleFraction*47.9982/(28.9653+0.5*moleFraction*28.9653)*100),
                           @(moleFraction*47.9982/(47.9982*moleFraction + 31.9988*(1-moleFraction))*100)];
    
    microgpm3Equations = @[@(moleFraction*1e9),
                           @(moleFraction*1e8),
                           @(moleFraction*1e6),
                           @(moleFraction*100),
                           @(moleFraction*2.1414*p*273.15/t),
                           @(moleFraction*1e3*2.1414*p*273.15/t),
                           @(moleFraction*1e6*2.1414*p*273.15/t),
                           @(concen),
                           @(moleFraction*1e3*2.1414*p*273.15/t),
                           @(moleFraction*1e3*2.1414),
                           @(moleFraction*47.9982/(28.9653+0.5*moleFraction*28.9653)*100),
                           @(moleFraction*47.9982/(47.9982*moleFraction + 31.9988*(1-moleFraction))*100)];
    
    mgperm3Equations = @[@(moleFraction*1e9),
                         @(moleFraction*1e8),
                         @(moleFraction*1e6),
                         @(moleFraction*100),
                         @(moleFraction*2.1414*p*273.15/t),
                         @(moleFraction*1e3*2.1414*p*273.15/t),
                         @(moleFraction*1e9*2.1414*p*273.15/t),
                         @(concen),
                         @(moleFraction*1e3*2.1414*p*273.15/t),
                         @(moleFraction*1e3*2.1414),
                         @(moleFraction*47.9982/(28.9653+0.5*moleFraction*28.9653)*100),
                         @(moleFraction*47.9982/(47.9982*moleFraction + 31.9988*(1-moleFraction))*100)];
    
    gpm3Equations = @[@(moleFraction*1e9),
                      @(moleFraction*1e8),
                      @(moleFraction*1e6),
                      @(moleFraction*100),
                      @(moleFraction*2.1414*p*273.15/t),
                      @(moleFraction*1e3*2.1414*p*273.15/t),
                      @(moleFraction*1e9*2.1414*p*273.15/t),
                      @(moleFraction*1e6*2.1414*p*273.15/t),
                      @(concen),
                      @(moleFraction*1e3*2.1414),
                      @(moleFraction*47.9982/(28.9653+0.5*moleFraction*28.9653)*100),
                      @(moleFraction*47.9982/(47.9982*moleFraction + 31.9988*(1-moleFraction))*100)];
    
    gpnm3Equations = @[@(moleFraction*1e9),
                       @(moleFraction*1e8),
                       @(moleFraction*1e6),
                       @(moleFraction*100),
                       @(moleFraction*2.1414*p*273.15/t),
                       @(moleFraction*1e3*2.1414*p*273.15/t),
                       @(moleFraction*1e9*2.1414*p*273.15/t),
                       @(moleFraction*1e6*2.1414*p*273.15/t),
                       @(moleFraction*1e3*2.1414),
                       @(concen),
                       @(moleFraction*47.9982/(28.9653+0.5*moleFraction*28.9653)*100),
                       @(moleFraction*47.9982/(47.9982*moleFraction + 31.9988*(1-moleFraction))*100)];
    
    wtpcairEquations = @[@(moleFraction*1e9),
                         @(moleFraction*1e8),
                         @(moleFraction*1e6),
                         @(moleFraction*100),
                         @(moleFraction*2.1414*p*273.15/t),
                         @(moleFraction*1e3*2.1414*p*273.15/t),
                         @(moleFraction*1e9*2.1414*p*273.15/t),
                         @(moleFraction*1e6*2.1414*p*273.15/t),
                         @(moleFraction*1e3*2.1414*p*273.15/t),
                         @(moleFraction*1e3*2.1414),
                         @(concen),
                         @(moleFraction*47.9982/(47.9982*moleFraction + 31.9988*(1-moleFraction))*100)];
    
    wtpco2Equations = @[@(moleFraction*1e9),
                        @(moleFraction*1e8),
                        @(moleFraction*1e6),
                        @(moleFraction*100),
                        @(moleFraction*2.1414*p*273.15/t),
                        @(moleFraction*1e3*2.1414*p*273.15/t),
                        @(moleFraction*1e9*2.1414*p*273.15/t),
                        @(moleFraction*1e6*2.1414*p*273.15/t),
                        @(moleFraction*1e3*2.1414*p*273.15/t),
                        @(moleFraction*1e3*2.1414),
                        @(moleFraction*47.9982/(28.9653+0.5*moleFraction*28.9653)*100),
                        @(concen)];
    
    
    
    equations = @[@[ppbEquations],
                  @[pphmEquations],
                  @[ppmEquations],
                  @[volcEquations],
                  @[gplEquations],
                  @[microgpmlEquations],
                  @[mgperm3Equations],
                  @[microgpm3Equations],
                  @[gpm3Equations],
                  @[gpnm3Equations],
                  @[wtpcairEquations],
                  @[wtpco2Equations]];
}

-(NSArray *)start {
    [self updateArrays];
    //NSLog(@"%f", concen/2.1414);//@(concen/2.1414*1e-3*t/273.15/p),
    NSInteger tIndex = [tUnits indexOfObject:tUnit];
    t = [[tUnitsFactor objectAtIndex:tIndex] integerValue];
    NSInteger pIndex = [pUnits indexOfObject:pUnit];
    p = pInput / [[pUnitsFactor objectAtIndex:pIndex] integerValue];
    [self updateArrays];
    NSInteger moleIndex = [units indexOfObject:unit];
    double temp = [[unitsFactor objectAtIndex:moleIndex] doubleValue];
    moleFraction = temp;
    NSLog([NSString stringWithFormat:@"%E", moleFraction]);
    [self updateArrays];
    return [equations objectAtIndex:moleIndex];
}

@end
