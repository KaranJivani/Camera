//
//  KRNDetailViewController.h
//  Homepwner
//
//  Created by Karan Jivani on 7/18/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KRNItem.h"
#import "KRNImageStore.h"
@interface KRNDetailViewController : UIViewController

-(instancetype)initForNewItem: (BOOL)isNew;

@property(strong,nonatomic) KRNItem *item;

//Completion Block for reloading table view when dismiss the view controller and pass this block to dissmiss view controller method in completion Argument
@property(nonatomic,copy) void(^dismissBlock)(void);


@end
