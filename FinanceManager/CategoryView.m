//
//  CategoryView.m
//  FinanceManager
//
//  Created by Rahim Baraky on 16/05/2015.
//  Copyright (c) 2015 Rahim Baraky. All rights reserved.
//

#import "CategoryView.h"
#import "TableCell.h"
#import <CoreData/CoreData.h>

@interface CategoryView ()

@property (strong) NSMutableArray *categories;

@end

@implementation CategoryView
@synthesize tableViewForCategory;
- (void)viewDidLoad {
    
    
    
    
    
    
    self.tableViewForCategory.delegate = self;
    self.tableViewForCategory.dataSource= self;
    [super viewDidLoad];
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
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Cat"];
    self.categories = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableViewForCategory reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.categories objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.categories removeObjectAtIndex:indexPath.row];
        [self.tableViewForCategory deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categories.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell3";
    TableCell *cell3 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    
    NSManagedObject *cat2 = [self.categories objectAtIndex:indexPath.row];
    [cell3.textLabel setText:[NSString stringWithFormat:@"%@", [cat2 valueForKey:@"category"]]];
//    int row = [indexPath row];
//    cell3.TitleLabel.text = _Title[row];
//    cell3.DescriptionLabel.text = _Description[row];
    
    
    return cell3;
}
- (IBAction)ButtonBack:(UIButton *)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
