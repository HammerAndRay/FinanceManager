//
//  View3.h
//  FinanceManager
//
//  Created by Rahim Baraky on 15/05/2015.
//  Copyright (c) 2015 Rahim Baraky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface View3 : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableViewForExpense;

@property (nonatomic,strong) NSArray *Title;
@property (nonatomic,strong) NSArray *Recurring;
@property (nonatomic,strong) NSArray *Date;
@property (nonatomic,strong) NSArray *Amount;

@end
