//
//  View3-2.m
//  FinanceManager
//
//  Created by Rahim Baraky on 15/05/2015.
//  Copyright (c) 2015 Rahim Baraky. All rights reserved.
//

#import "View3-2.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface View3_2()
{
    NSMutableArray *_pickerData;
    NSString *selectedcat;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *recurring;
@property (strong, nonatomic) IBOutlet UITextField *amountText;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

 @end

@implementation View3_2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    _pickerData = [NSMutableArray array];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Cat"];
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    for (NSManagedObject *info in results)
    {
        
        NSString *temp = [info valueForKey:@"category"];
        [_pickerData addObject:temp];
    }
    
    if (self.device) {
        [self.amountText setText:[self.device valueForKey:@"amount"]];
        [self.datePicker setDate:[self.device valueForKey:@"date"]];
    }
}

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_pickerData objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    selectedcat  = [NSString stringWithFormat:@"%@", [_pickerData objectAtIndex:row]];
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)save:(UIBarButtonItem *)sender {
    NSString *amount;
    NSString *cat;
    NSString *recurring;
    NSDate *date;
    cat =  selectedcat;
    NSString *strMatchstring=@"\\b([0-9%_.+\\-]+)\\b";
    NSPredicate *textpredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@", strMatchstring];
    NSLog(@"i pressed save");
    if ([_amountText.text  isEqual: @""]) {
        NSLog(@"It's blank");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Must Complete All Fields"                                                        message:@"Enter amount"                                                       delegate:nil                                              cancelButtonTitle:@"OK"                                              otherButtonTitles:nil];
        [alert show];
    }
    else if(![textpredicate evaluateWithObject:_amountText.text])
    {
        UIAlertView *objAlert = [[UIAlertView alloc] initWithTitle:@"Must Complete All Fields" message:@"please enter number only." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close",nil];
        [objAlert show];
    }else if (self.recurring.selectedSegmentIndex == -1) {
        UIAlertView *objAlert = [[UIAlertView alloc] initWithTitle:@"Must Complete All Fields" message:@"please select recurring type." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close",nil];
        [objAlert show];
        
    }else if (cat == nil) {
        UIAlertView *objAlert = [[UIAlertView alloc] initWithTitle:@"Must Complete All Fields" message:@"please select category." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close",nil];
        [objAlert show];
    } else{
        
        if (self.recurring.selectedSegmentIndex == 0) {
            recurring = @"daily";
        }
        if (self.recurring.selectedSegmentIndex == 1) {
            recurring = @"weekly";
        }
        if (self.recurring.selectedSegmentIndex == 2) {
            recurring = @"monthly";
        }
        if (self.recurring.selectedSegmentIndex == 3) {
            recurring = @"yearly";
        }
        if (self.recurring.selectedSegmentIndex == 4) {
            recurring = @"none";
        }
        
        
        amount = [_amountText text];
        
        
        
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        
        date = _datePicker.date;
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSString *dateString = [dateFormat stringFromDate:date];
        NSString *myDateString = dateString;
        NSDate *myDate = [dateFormat dateFromString: myDateString];
        date = myDate;
        // [newOutgoing setValue:myDate forKey:@"startDate"];
        
        
        NSLog(@"%ld", (long)amount);
        NSLog(@"%@", cat);
        NSLog(@"%@", date);
        NSLog(@"%@", recurring);
        
        NSManagedObjectContext *context = [self managedObjectContext];
        
        if (self.device) {
            // Update existing device
            [self.device setValue:amount forKey:@"amount"];
            [self.device setValue:cat forKey:@"category"];
            [self.device setValue:date forKey:@"date"];
            [self.device setValue:recurring forKey:@"recurring"];
            
        } else {
            NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Expense" inManagedObjectContext:context];
            [newDevice setValue:amount forKey:@"amount"];
            [newDevice setValue:cat forKey:@"category"];
            [newDevice setValue:date forKey:@"date"];
            [newDevice setValue:recurring forKey:@"recurring"];}
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
        
        [self dismissViewControllerAnimated:YES completion:nil];}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UIView * txt in self.view.subviews){
        if ([txt isKindOfClass:[UITextField class]] && [txt isFirstResponder]) {
            [txt resignFirstResponder];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ButtonBack:(UIButton *)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
