//
//  View5.h
//  FinanceManager
//
//  Created by Rahim Baraky on 13/05/2015.
//  Copyright (c) 2015 Rahim Baraky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Brain.h"
NSString * Tape;
NSString * TapeBuffer;

@interface View5 : UIViewController{

    IBOutlet UILabel *LabelActiveCal;
    IBOutlet UILabel *LabelNonActiveCal;
    Brain * SendToBrain;
    Boolean InTheMiddleOfTyping;
    Boolean DecimalPressed;
    Boolean IsRadOn;
    Boolean OppPressed;
    Boolean numberpressed;
    NSNumber * ConvertDouble;}
@end
