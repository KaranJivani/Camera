//
//  KRNItemsViewController.m
//  Homepwner
//
//  Created by Karan Jivani on 7/16/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import "KRNItemsViewController.h"
#import "KRNItemStore.h"
#import "KRNItems.h"
#import "KRNDetailViewController.h"
#import "KRNItemCell.h"

@interface KRNItemsViewController ()

@property (nonatomic,strong) IBOutlet UIView *headerView;

@end
@implementation KRNItemsViewController



#pragma mark Controller Life Cycle
-(instancetype)init {
    
    self = [self initWithStyle:UITableViewStylePlain];
    return self;
}
-(instancetype)initWithStyle:(UITableViewStyle)style {
    
    //Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        //Create a bar button item that will send addNewItem: to KRNItemsViewController
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItems:)];
        
        //set this bar button item as the right item in the navigation item
        navItem.rightBarButtonItem = bbi;
        
        navItem.leftBarButtonItem = self.editButtonItem;

           }
    
    return self;
}

#pragma mark View Life Cycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    //Uncomment following code for headerview implemetation which edit and add exactly works similar to UINavigationItems add and edit
    //    UIView *header = self.headerView;
    //    [self.tableView setTableHeaderView:header];
    
    //Load the NIB file
    UINib *nib = [UINib nibWithNibName:@"KRNItemCell" bundle:nil];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    
    //Resister this NIB which contains the cell
    [self.tableView registerNib:nib forCellReuseIdentifier:@"KRNItemCell"];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(IBAction)addNewItems:(id)sender{
    
    //Create a KRNItem and add it to the store
    KRNItems *newItem = [[KRNItemStore sharedStore]createItem];
    KRNDetailViewController *detailViewController = [[KRNDetailViewController alloc]initForNewItem:YES];
    detailViewController.item = newItem;
    
    //Completion block : Reload table so when Item added to table reloading table will show it
    detailViewController.dismissBlock = ^{
        [self.tableView reloadData];
    };
    
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:detailViewController];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:navController animated:YES completion:nil];
    
    
    /*//Figure out where that item is in the array
     NSInteger lastRow = [[[KRNItemStore sharedStore]allItems] indexOfObject:newItem];
     
     //Make a new Indexpath for 0th section, last row
     //    NSInteger lastRow = [self.tableView numberOfRowsInSection:0];
     NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
     //Insert this row in the table
     
     [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];*/
    
}

#pragma mark Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[[KRNItemStore sharedStore]allItems]count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    //Create and instance of the UITableViewCell with default appearance
//    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    
    //Get a new or recycled cell
    KRNItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KRNItemCell" forIndexPath:indexPath];
    
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
    
    //set the text on the cell with the description of the item that is at nth index of item
    NSArray *items = [[KRNItemStore sharedStore]allItems];
    KRNItems *item = [items objectAtIndex:indexPath.row];
    
    //Configure the cell with the KRNItem
    cell.nameLabel.text = item.itemName;
    cell.serialNumberLabel.text = item.serialNumber;
    
    cell.valueLabel.text = [NSString stringWithFormat:@"%d",item.valueInDollars];
    cell.thumbNailView.image = item.thumbnail;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //If the tableview is asking to commit a delete command
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[KRNItemStore sharedStore]allItems];
        KRNItems *item = [items objectAtIndex:indexPath.row];
        [[KRNItemStore sharedStore]removeItem:item];
        
        //Also remove that row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        [tableView reloadData];
    }
    
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [[KRNItemStore sharedStore]moveItemAtIndex:destinationIndexPath.row toIndex:sourceIndexPath.row];
}

#pragma mark Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    KRNDetailViewController *detaiViewController = [[KRNDetailViewController alloc]initForNewItem:NO];
    //Put it onto the top of the navigation controller's stack
    [self.navigationController pushViewController:detaiViewController animated:YES];
    
    NSArray *items = [[KRNItemStore sharedStore]allItems];
    KRNItems *selectedItem = [items objectAtIndex:indexPath.row];
    
    //Give detail view controller a pointer to the item object in row
    detaiViewController.item = selectedItem;
    
}

#pragma mark Tableview Header methods

-(IBAction)toggleEditingMode:(id)sender{
    if (self.isEditing) {
        //Change text of button to inform user of state
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        
        //Turn of editing mode
        [self setEditing:NO animated:YES ];
    }
    else{
        //Change text of button to inform user of state
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        
        //Enter Editing mode
        [self setEditing:YES animated:YES];
    }
    
}

-(UIView *)headerView {
    //if you have not loaded the header view yet..
    if (!_headerView) {
        //load HeaderView.xib
        [[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:self options:nil];
    }
    return _headerView;
}
@end
