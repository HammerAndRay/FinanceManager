//
//  View3.m
//  FinanceManager
//
//  Created by Rahim Baraky on 15/05/2015.
//  Copyright (c) 2015 Rahim Baraky. All rights reserved.
//

#import "View3.h"
#import "TableCell.h"
#import "View3-2.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface View3()
{
    
}


@property (strong) NSMutableArray *expenseArray;

@end

@implementation View3
@synthesize tableViewForExpense;
- (void)viewDidLoad {
    self.tableViewForExpense.delegate = self;
    self.tableViewForExpense.dataSource= self;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Expense"];
    self.expenseArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableViewForExpense reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.expenseArray objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.expenseArray removeObjectAtIndex:indexPath.row];
        [self.tableViewForExpense deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.expenseArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ///////////////////////////////////////////////////////////
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
    
    
    request = [[NSFetchRequest alloc]initWithEntityName:@"Income"];
    
    results = [context executeFetchRequest:request error:&error];
    
    for (NSManagedObject *info in results)
    {
        
        NSString *amount = [info valueForKey:@"amount"];
        float temp = [amount floatValue];
        totalIncomeAmount = totalIncomeAmount + temp;
        
    }
    
    totalBalance = totalIncomeAmount - totalOutgoingAmount;
    
    
    ///////////////////////////////////////////////////////////
    static NSString *CellIdentifier = @"Cell2";
    TableCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSManagedObject *cat2 = [self.expenseArray objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:[cat2 valueForKey:@"date"]];
    NSString *myDateString = dateString;
    
    cell2.TitleLabel.text = [NSString stringWithFormat:@"%@", [cat2 valueForKey:@"category"]];
    cell2.RecurringLabel.text =[NSString stringWithFormat:@"%@", [cat2 valueForKey:@"recurring"]];
    cell2.DateLabel.text = myDateString;
    if (totalBalance <0) {
        cell2.AmountLabel.textColor = [UIColor redColor];
    } else {
        cell2.AmountLabel.textColor = [UIColor greenColor];
    }
    cell2.AmountLabel.text = [NSString stringWithFormat:@"%@", [cat2 valueForKey:@"amount"]];
    
    
    return cell2;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"UpdateDevice"]) {
        NSManagedObject *selectedDevice = [self.expenseArray objectAtIndex:[[self.tableViewForExpense indexPathForSelectedRow] row]];
        View3_2 *destViewController = segue.destinationViewController;
       destViewController.device = selectedDevice;
    }
}


@end
