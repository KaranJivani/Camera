//
//  KRNItemCell.m
//  Homepwner
//
//  Created by Karan Jivani on 7/27/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import "KRNItemCell.h"

@implementation KRNItemCell

- (IBAction)showImage:(id)sender {

    if (self.actionBlock) {
        self.actionBlock();
    }
}

@end
