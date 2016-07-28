//
//  KRNItemCell.h
//  Homepwner
//
//  Created by Karan Jivani on 7/27/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KRNItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbNailView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end
