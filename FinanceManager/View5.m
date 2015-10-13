//
//  View5.m
//  FinanceManager
//
//  Created by Rahim Baraky on 13/05/2015.
//  Copyright (c) 2015 Rahim Baraky. All rights reserved.
//

#import "View5.h"

@interface View5 ()

@end

@implementation View5
{
    int CounterFor3rdFunctionPort;
    int CounterFor3rdFunctionLand;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    Tape = [prefs stringForKey:@"info"];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    CounterFor3rdFunctionPort = 0;
    CounterFor3rdFunctionLand =0;
    TapeBuffer = @"";
    //    Tape = @"";
    // IsRadOn = YES;

    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:Tape forKey:@"info"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//////////////////////////////////////////////////////////////////////////////

- (Brain *)SendToBrain
{
    if (!SendToBrain){ SendToBrain = [[Brain alloc] init];};
    return SendToBrain;
}

//////////////////////////////////////////////////////////////////////////////
- (void) NumberPressed:(NSString*)number{
    
    if (InTheMiddleOfTyping) {
        
        LabelActiveCal.text = [LabelActiveCal.text stringByAppendingString:number];
    //    LabelActiveCalLand.text = [LabelActiveCalLand.text stringByAppendingString:number];
    } else
    {
        [LabelActiveCal setText:number];
     //   [LabelActiveCalLand setText:number];
        InTheMiddleOfTyping = YES;
    }
}


//////////////////////////////////////////////////////////////////////////////

- (void) AllClear{
    //   [SendToBrain release];
    SendToBrain = [[Brain alloc] init];
    [LabelActiveCal setText:@"0"];
    [LabelNonActiveCal setText:@""];
  //  [LabelActiveCalLand setText:@"0"];
  //  [LabelNonActiveCalLand  setText:@""];
    DecimalPressed = NO;
    InTheMiddleOfTyping = NO;
    TapeBuffer = @"";
}
//////////////////////////////////////////////////////////////////////////////

- (void) clear {
    
    if (InTheMiddleOfTyping) {
        
        NSString * TextInCalLabel = LabelActiveCal.text;
        NSString * UpdatedCal = [TextInCalLabel substringToIndex:[TextInCalLabel length] - 1];
        
      //  NSString * TextInCalLabel2 = LabelActiveCalLand.text;
    //    NSString * UpdatedCal2 = [TextInCalLabel2 substringToIndex:[TextInCalLabel2 length] - 1];
        
        if ([UpdatedCal length] > 0)
        {
            LabelActiveCal.text = UpdatedCal;
      //      LabelActiveCalLand.text = UpdatedCal2;
        }
        else
        {
            InTheMiddleOfTyping= NO;
            LabelActiveCal.text = @"0";
     //       LabelActiveCalLand.text = @"0";
        }
    }
}
//////////////////////////////////////////////////////////////////////////////

- (void) decimalPoint {
    
    if (DecimalPressed == NO)
    {
        if (InTheMiddleOfTyping == NO)
        {
            InTheMiddleOfTyping = YES;
            [LabelActiveCal setText:@"0."];
         //   [LabelActiveCalLand setText:@"0."];
        }
        else
        {
            [LabelActiveCal setText:[[LabelActiveCal text] stringByAppendingString:@"."]];
     //       [LabelActiveCalLand setText:[[LabelActiveCalLand text] stringByAppendingString:@"."]];
        }
        DecimalPressed = YES;
    }
    
    
}
//////////////////////////////////////////////////////////////////////////////

- (void) operater:(NSString*)operaterType{
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    {
        //    NSLog(@"This is Port");
        if ([LabelActiveCal.text isEqualToString:@"0"] &&( [operaterType isEqualToString:@"1/x"] || [operaterType isEqualToString:@"x²"]) ){
            
            [LabelNonActiveCal setText:@"Error!"];
            
            [self performSelector:@selector(AllClear) withObject:self afterDelay:1.0];
        }
        
        if (InTheMiddleOfTyping) {
            [[self SendToBrain] setOperaterType:[[LabelActiveCal text] doubleValue]];
            [LabelNonActiveCal setText:operaterType];
            InTheMiddleOfTyping = NO;
            DecimalPressed = NO;
            
            TapeBuffer = [TapeBuffer stringByAppendingString:LabelActiveCal.text];
            TapeBuffer = [TapeBuffer stringByAppendingString:operaterType];
            //    NSLog(@"This is when :%@",TapeBuffer);
            
            
            if ([operaterType isEqualToString:@"="])
            {
                InTheMiddleOfTyping = YES;
            }
            
        }
        else if ([operaterType isEqualToString:@"Sin"] || [operaterType isEqualToString:@"Cos"] || [operaterType isEqualToString:@"Tan"]|| [operaterType isEqualToString:@"ArcSin"]|| [operaterType isEqualToString:@"ArcCos"]|| [operaterType isEqualToString:@"ArcTan"]|| [operaterType isEqualToString:@"π"]) {
            [LabelNonActiveCal setText:operaterType];
        }
        double result = [[self SendToBrain] doOperation:operaterType:IsRadOn:[LabelNonActiveCal text]];
        ConvertDouble = [NSNumber numberWithDouble:result];
        [LabelActiveCal setText:[NSString stringWithFormat:@"%@", ConvertDouble]];
        
        if ([operaterType isEqualToString:@"="])
        {
            NSString * TempResult = [NSString stringWithFormat:@"%@",ConvertDouble];
            TapeBuffer = [TapeBuffer stringByAppendingString:TempResult];
            TapeBuffer = [TapeBuffer stringByAppendingString:@"\n"];
            Tape = [Tape stringByAppendingString:TapeBuffer];
            // NSLog(@"This is TapeBuffer :%@",TapeBuffer);
            // NSLog(@"This is Tape :%@",Tape);
        }
    }
//    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
//    {
//        //   NSLog(@"This is Land");
//        if ([LabelActiveCalLand.text isEqualToString:@"0"] &&( [operaterType isEqualToString:@"1/x"] || [operaterType isEqualToString:@"x²"]) ){
//            
//            [LabelNonActiveCalLand setText:@"Error!"];
//            
//            [self performSelector:@selector(AllClear) withObject:self afterDelay:1.0];
//        }
//        
//        if (InTheMiddleOfTyping) {
//            [[self SendToBrain] setOperaterType:[[LabelActiveCalLand text] doubleValue]];
//            [LabelNonActiveCalLand setText:operaterType];
//            InTheMiddleOfTyping = NO;
//            DecimalPressed = NO;
//            
//            //      Tape = [Tape stringByAppendingString:LabelActiveCal.text];
//            
//            TapeBuffer = [TapeBuffer stringByAppendingString:LabelActiveCalLand.text];
//            TapeBuffer = [TapeBuffer stringByAppendingString:operaterType];
//            //    NSLog(@"This is when :%@",TapeBuffer);
//            
//            
//            if ([operaterType isEqualToString:@"="])
//            {
//                InTheMiddleOfTyping = YES;
//            }
//            
//        }
//        else if ([operaterType isEqualToString:@"Sin"] || [operaterType isEqualToString:@"Cos"] || [operaterType isEqualToString:@"Tan"]|| [operaterType isEqualToString:@"ArcSin"]|| [operaterType isEqualToString:@"ArcCos"]|| [operaterType isEqualToString:@"ArcTan"]|| [operaterType isEqualToString:@"π"]) {
//            [LabelNonActiveCalLand setText:operaterType];
//        }
//        double result = [[self SendToBrain] doOperation:operaterType:IsRadOn:[LabelNonActiveCalLand text]];
//        ConvertDouble = [NSNumber numberWithDouble:result];
//        [LabelActiveCalLand setText:[NSString stringWithFormat:@"%@", ConvertDouble]];
//        
//        if ([operaterType isEqualToString:@"="])
//        {
//            NSString * TempResult = [NSString stringWithFormat:@"%@",ConvertDouble];
//            TapeBuffer = [TapeBuffer stringByAppendingString:TempResult];
//            Tape = [Tape stringByAppendingString:TapeBuffer];
//            //  NSLog(@"This is TapeBuffer :%@",TapeBuffer);
//            //  NSLog(@"This is Tape :%@",Tape);
//        }
//    }
}


//////////////////////////////////////////////////////////////////////////////
///////////////This section below  is for the first function buttons//////////
//////////////////////////////////////////////////////////////////////////////

- (IBAction)ButtonNumber0:(UIButton *)sender {
    [self NumberPressed:@"0"];
}
- (IBAction)ButtonNumber1:(UIButton *)sender {
    [self NumberPressed:@"1"];}

- (IBAction)ButtonNumber2:(UIButton *)sender {
    [self NumberPressed:@"2"];}

- (IBAction)ButtonNumber3:(UIButton *)sender {
    [self NumberPressed:@"3"];}

- (IBAction)ButtonNumber4:(UIButton *)sender {
    [self NumberPressed:@"4"];}

- (IBAction)ButtonNumber5:(UIButton *)sender {
    [self NumberPressed:@"5"];}

- (IBAction)ButtonNumber6:(UIButton *)sender {
    [self NumberPressed:@"6"];}

- (IBAction)ButtonNumber7:(UIButton *)sender {
    [self NumberPressed:@"7"];}

- (IBAction)ButtonNumber8:(UIButton *)sender {
    [self NumberPressed:@"8"];}

- (IBAction)ButtonNumber9:(UIButton *)sender {
    [self NumberPressed:@"9"];}


- (IBAction)ButtonFunctionPoint:(UIButton *)sender {
    [self decimalPoint];
}

- (IBAction)ButtonFunctionSignChange:(UIButton *)sender {
    [self operater:@"±"];
}

- (IBAction)ButtonFunctionClearAll:(UIButton *)sender {
    [self AllClear];
}

- (IBAction)ButtonFunctionClear:(UIButton *)sender {
    [self clear];
}

- (IBAction)ButtonFunctionPrecent:(UIButton *)sender {
    [self operater:@"%"];
}

- (IBAction)ButtonFunctionDivide:(UIButton *)sender {
    [self operater:@"÷"];
}

- (IBAction)ButtonFunctionTimes:(UIButton *)sender {
    [self operater:@"X"];
}

- (IBAction)ButtonFunctionPlus:(UIButton *)sender {
    [self operater:@"+"];
}

- (IBAction)ButtonFunctionMinus:(UIButton *)sender {
    [self operater:@"−"];
}

- (IBAction)ButtonFunctionEquals:(UIButton *)sender {
    [self operater:@"="];
}

@end
