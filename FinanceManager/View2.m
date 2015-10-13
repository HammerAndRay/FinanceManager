//
//  View2.m
//  FinanceManager
//
//  Created by Rahim Baraky on 15/05/2015.
//  Copyright (c) 2015 Rahim Baraky. All rights reserved.
//

#import "View2.h"
#import "TableCell.h"
#import "View2-2.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface View2()

@property (strong) NSMutableArray *incomeArray;

@end

@implementation View2
@synthesize tableViewForIncome;
- (void)viewDidLoad {
    self.tableViewForIncome.delegate = self;
    self.tableViewForIncome.dataSource= self;
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
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Income"];
    self.incomeArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableViewForIncome reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.incomeArray objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.incomeArray removeObjectAtIndex:indexPath.row];
        [self.tableViewForIncome deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.incomeArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
    static NSString *CellIdentifier = @"Cell";
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSManagedObject *cat2 = [self.incomeArray objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:[cat2 valueForKey:@"date"]];
    NSString *myDateString = dateString;
    
    cell.TitleLabel.text = [NSString stringWithFormat:@"%@", [cat2 valueForKey:@"category"]];

    cell.DateLabel.text = myDateString;
    if (totalBalance <0) {
        cell.AmountLabel.textColor = [UIColor redColor];
    } else {
        cell.AmountLabel.textColor = [UIColor greenColor];
    }
    cell.AmountLabel.text = [NSString stringWithFormat:@"%@", [cat2 valueForKey:@"amount"]];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"UpdateDevice"]) {
        NSManagedObject *selectedDevice = [self.incomeArray objectAtIndex:[[self.tableViewForIncome indexPathForSelectedRow] row]];
        View2_2 *destViewController = segue.destinationViewController;
        destViewController.device = selectedDevice;
    }
}

@end
