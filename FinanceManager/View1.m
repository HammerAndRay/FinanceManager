//
//  View1.m
//  FinanceManager
//
//  Created by Rahim Baraky on 13/05/2015.
//  Copyright (c) 2015 Rahim Baraky. All rights reserved.
//

#import "View1.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface View1 ()

@property (strong, nonatomic) IBOutlet UILabel *totalExpense;
@property (strong, nonatomic) IBOutlet UILabel *totalIncome;
@property (strong, nonatomic) IBOutlet UILabel *totalbal;
@end

@implementation View1

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"firstUse"]) { //if it is not present create it
        NSString *check = @"yes";
        
        [defaults setObject:check forKey:@"firstUse"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSArray *types = @[@"Travel Card", @"Car Loan", @"Medical Bills", @"Gift", @"Salary", @"Clothing", @"Fuel", @"Credit Card", @"Mortgage", @"Rent", @"NowTV", @"Water", @"TV", @"Internet", @"Fitness"];
        
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext* saveContext = appDelegate.managedObjectContext;
        
        NSError *error = nil;
        
        for (NSManagedObject *info in types)
        {
            
            NSManagedObject *newOutgoingType;
            
            
            newOutgoingType = [NSEntityDescription
                               insertNewObjectForEntityForName:@"Cat"
                               inManagedObjectContext:saveContext];
            
            [newOutgoingType setValue: info forKey:@"category"];
            
        }
        [saveContext save:&error];

    }}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    float totalOutgoingAmount = 0.0;
    float totalIncomeAmount = 0.0;
    float totalBalance;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Expense"];
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    for (NSManagedObject *info in results)
    {
        
        NSString *amount = [info valueForKey:@"amount"];
        float temp = [amount floatValue];
        totalOutgoingAmount = totalOutgoingAmount + temp;
        
    }
    NSLog(@"%.02f",totalOutgoingAmount);
    _totalExpense.text = [NSString stringWithFormat: @"%0.2f", totalOutgoingAmount];
    
    
    
    request = [[NSFetchRequest alloc]initWithEntityName:@"Income"];
    
    results = [context executeFetchRequest:request error:&error];
    
    for (NSManagedObject *info in results)
    {
        
        NSString *amount = [info valueForKey:@"amount"];
        float temp = [amount floatValue];
        totalIncomeAmount = totalIncomeAmount + temp;
        
    }
    _totalIncome.text = [NSString stringWithFormat: @"%0.2f", totalIncomeAmount];
    
    totalBalance = totalIncomeAmount - totalOutgoingAmount;
    _totalbal.text = [NSString stringWithFormat: @"%0.2f", totalBalance];
    
    if (totalBalance <0) {
        _totalbal.textColor = [UIColor redColor];
    } else {
    _totalbal.textColor = [UIColor greenColor];
    }
}
 
@end
