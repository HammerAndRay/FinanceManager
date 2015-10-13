//
//  TableCell.h
//  FinanceManager
//
//  Created by Rahim Baraky on 15/05/2015.
//  Copyright (c) 2015 Rahim Baraky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *RecurringLabel;
@property (strong, nonatomic) IBOutlet UILabel *DateLabel;
@property (strong, nonatomic) IBOutlet UILabel *AmountLabel;

@end
