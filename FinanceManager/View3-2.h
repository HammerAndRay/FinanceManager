//
//  View3-2.h
//  FinanceManager
//
//  Created by Rahim Baraky on 15/05/2015.
//  Copyright (c) 2015 Rahim Baraky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface View3_2 : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
{
    UIDatePicker *datepick;
}

@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *ButtonGoBack;

- (IBAction)ButtonBack:(UIBarButtonItem *)sender;


@property (strong) NSManagedObject *device;

@end
