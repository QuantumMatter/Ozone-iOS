//
//  Conversion.m
//  OzoneConversion
//
//  Created by Mac on 6/22/15.
//  Copyright (c) 2015 davidkopala. All rights reserved.
//

#import "Conversion.h"

@implementation Conversion

-(NSString *) flowRateAndPPMWater:(NSString *)GPM PPM:(NSString *)PPM {
    double numResult = (3.78 * 60 * [GPM integerValue] * [PPM integerValue]) / 1000;
    return [NSString stringWithFormat:@"%f", numResult];
}

-(NSString *) OutputOzoneGeneratorFeedgas:(NSString *)SLPM percent:(NSString *)percent {
    double result = [SLPM integerValue] * 0.001 * 60 * 14.3 * [percent integerValue];
    return [NSString stringWithFormat:@"%f", result];
}

-(NSString *) OutputOZoneGeneratorDry:(NSString *)SLMP percent:(NSString *)percent {
    double result = [SLMP integerValue] * 0.001 * 60 * 12.8 * [percent integerValue];
    return [NSString stringWithFormat:@"%f", result];
}

-(NSString *) OutputOzoneGenerator:(NSString *)SLMP density:(NSString *)density {
    double result = [SLMP integerValue] * 60 * 0.001 * [density integerValue];
    return [NSString stringWithFormat:@"%f", result];
}

-(NSString *) OutputOzoneGeneratorPPM:(NSString *)CFM PPM:(NSString *)PPM {
    double result = [CFM integerValue] / 35.33569 * 60 * [PPM integerValue] * 2.14;
    return [NSString stringWithFormat:@"%f", result];
}

-(NSString *) AdjustedFlow:(NSString *)PSI Measured:(NSString *)Measured {
    double result = [Measured integerValue] * sqrt(([PSI integerValue] + 14.7) / 14.7);
    return [NSString stringWithFormat:@"%f", result];
}

@end
