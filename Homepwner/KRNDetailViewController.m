//
//  KRNDetailViewController.m
//  Homepwner
//
//  Created by Karan Jivani on 7/18/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import "KRNDetailViewController.h"

@interface KRNDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation KRNDetailViewController

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    KRNItems *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d",item.valueInDollars];
    
    //you will need NSDateFormatter that will turn a date in to a date string
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
        
        //Use filtered NSDate object to set dateLabel contents
        self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    //Clear first responder
    [self.view endEditing:YES];
    
    //"Save changes to the item"
    KRNItems *item = self.item;
    
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
    
}

-(void)setItem:(KRNItems *)item {
    _item = item;
    self.navigationItem.title = self.item.itemName;
}

@end
