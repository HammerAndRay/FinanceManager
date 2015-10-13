//
//  Brain.h
//  FinanceManager
//
//  Created by Rahim Baraky on 13/05/2015.
//  Copyright (c) 2015 Rahim Baraky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Brain : NSObject {
    
    double operaterType;
    double operaterType2;
    NSString * waitingoperaterType2;
    
    
    
}

- (void) setOperaterType:(double) Opp;
- (double)doOperation:(NSString *)operation :(Boolean)CheckRad: (NSString *) LastOoperater;
- (void)doWaitingOperation;
//- (Boolean) IfRad:(Boolean)CheckRad;

@end

