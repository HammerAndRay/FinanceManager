//
//  View4.h
//  FinanceManager
//
//  Created by Rahim Baraky on 18/05/2015.
//  Copyright (c) 2015 Rahim Baraky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface View4 : UIViewController<CPTPlotDataSource> {
    IBOutlet CPTGraphHostingView *hostView;
    CPTXYGraph *graph;
    NSArray *plotData;
}
@end
