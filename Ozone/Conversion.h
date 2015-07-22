//
//  Conversion.h
//  OzoneConversion
//
//  Created by Mac on 6/22/15.
//  Copyright (c) 2015 davidkopala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Conversion : NSObject

-(NSString *) flowRateAndPPMWater:(NSString *)GPM PPM:(NSString *)GPM;

-(NSString *) OutputOzoneGeneratorFeedgas:(NSString *)SLPM percent:(NSString *)percent;

-(NSString *) OutputOZoneGeneratorDry:(NSString *)SLMP percent:(NSString *)percent;

-(NSString *) OutputOzoneGenerator:(NSString *)SLMP density:(NSString *)density;

-(NSString *) OutputOzoneGeneratorPPM:(NSString *)CFM PPM:(NSString *)PPM;

-(NSString *) AdjustedFlow:(NSString *)PSI Measured:(NSString *)Measured;

@end
