//
//  Brain.m
//  FinanceManager
//
//  Created by Rahim Baraky on 13/05/2015.
//  Copyright (c) 2015 Rahim Baraky. All rights reserved.
//

#import "Brain.h"
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

@implementation Brain

- (void)setOperaterType:(double)Opp
{
    operaterType = Opp;
}

- (double) doOperation:(NSString *)operation :(Boolean)CheckRad :(NSString *) LastOoperater
{
    
    if ([operation isEqualToString:@"1/x"] && operaterType != 0)
    {
        operaterType = 1.0 / operaterType;
    }
    else if ([operation isEqualToString:@"%"])
    {
        operaterType = operaterType / 100;
    }
    else if ([operation isEqualToString:@"π"])
    {
        operaterType =  3.14159265;
    }
    else if ([operation isEqualToString:@"x²"])
    {
        operaterType = operaterType * operaterType;
    }
    else if ([operation isEqualToString:@"ln"])
    {
        operaterType = log(operaterType);
    }
    else if ([operation isEqualToString:@"Log10"])
    {
        operaterType = log10(operaterType);
    }
    
    else if ([operation isEqualToString:@"±"] && operaterType != 0)
    {
        operaterType = -1 * operaterType;
    }
    //////////////////////////////////////////////////////////////////////////////
    //////////////This section below  is for Sin Cos and Tan//////////////////////
    //////////////////////////////////////////////////////////////////////////////
    else if ([operation isEqualToString:@"Sin"])
    {
        
        if (CheckRad) {
            operaterType =  sin(operaterType);
        } else {
            operaterType = M_PI/180 * operaterType;
            operaterType =  sin(operaterType);
        }
        //   NSLog(@"in check :%f", operaterType);
        
    }
    else if ([operation isEqualToString:@"Cos"])
    {
        if (CheckRad) {
            operaterType =  cos(operaterType);
        } else {
            operaterType = M_PI/180 * operaterType;
            operaterType =  cos(operaterType);
        }
        //   NSLog(@"in check :%f", operaterType);
    }
    else if ([operation isEqualToString:@"Tan"])
    {
        if (CheckRad) {
            operaterType =  tan(operaterType);
        } else {
            operaterType = M_PI/180 * operaterType;
            operaterType =  tan(operaterType);
        }
        //   NSLog(@"in check :%f", operaterType);
    }
    //////////////////////////////////////////////////////////////////////////////
    //////////////This section below  is for ArcSin ArcCos and ArcTan/////////////
    //////////////////////////////////////////////////////////////////////////////
    else if ([operation isEqualToString:@"ArcSin"])
    {
        if (CheckRad) {
            operaterType =  asin(operaterType);
        } else {
            operaterType =  RADIANS_TO_DEGREES(asin(operaterType));
        }
        //     NSLog(@"in check ArcSin:%f", operaterType);
    }else if ([operation isEqualToString:@"ArcCos"])
    {
        if (CheckRad) {
            operaterType =  acos(operaterType);
        } else {
            operaterType =  RADIANS_TO_DEGREES(acos(operaterType));
        }
        //     NSLog(@"in check ArcCos:%f", operaterType);
    }
    else if ([operation isEqualToString:@"ArcTan"])
    {
        if (CheckRad) {
            operaterType =  atan(operaterType);
        } else {
            operaterType =  RADIANS_TO_DEGREES(atan(operaterType));
        }
        //     NSLog(@"in check ArcTan :%f", operaterType);
    }
    
    else
    {
        [self doWaitingOperation];
        waitingoperaterType2 = operation;
        operaterType2 = operaterType;
    }
    
    return operaterType;
    
}

-(void)doWaitingOperation
{
    
    if ([@"+" isEqual:waitingoperaterType2])
    {
        operaterType = operaterType2 + operaterType;
    }
    else if ([@"X" isEqual:waitingoperaterType2])
    {
        operaterType = operaterType2 * operaterType;
    }
    else if ([@"−" isEqual:waitingoperaterType2])
    {
        operaterType = operaterType2 - operaterType;
    }
    else if ([@"÷" isEqual:waitingoperaterType2])
    {
        if (operaterType) {
            operaterType = operaterType2 / operaterType;
        }
    }
    
    
}

@end
