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

@implementation KRNItemsViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
}
-(instancetype)init {
    
    self = [self initWithStyle:UITableViewStylePlain];
    return self;
}
-(instancetype)initWithStyle:(UITableViewStyle)style {
    
    //Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        for (int i=0; i<5; i++) {
            [[KRNItemStore sharedStore]createItem];
        }
    }
    
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[[KRNItemStore sharedStore]allItems]count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    //Create and instance of the UITableViewCell with default appearance
//    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    
    //Get a new or recycled cell
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //set the text on the cell with the description of the item that is at nth index of item
    NSArray *items = [[KRNItemStore sharedStore]allItems];
    KRNItems *item = [items objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.description;
    return cell;
}
@end
