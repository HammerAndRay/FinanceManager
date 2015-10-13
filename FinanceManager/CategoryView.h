//
//  CategoryView.h
//  FinanceManager
//
//  Created by Rahim Baraky on 16/05/2015.
//  Copyright (c) 2015 Rahim Baraky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryView : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableViewForCategory;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *ButtonGoBack;
@property (nonatomic,strong) NSArray *Title;
@property (nonatomic,strong) NSArray *Description;
- (IBAction)ButtonBack:(UIBarButtonItem *)sender;
@end
