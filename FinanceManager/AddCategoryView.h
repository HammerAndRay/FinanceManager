//
//  AddCategoryView.h
//  FinanceManager
//
//  Created by Rahim Baraky on 16/05/2015.
//  Copyright (c) 2015 Rahim Baraky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCategoryView : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *ButtonGoBack;
- (IBAction)ButtonBack:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UITextField *AddCustomType;

- (IBAction)save:(id)sender;
@end
