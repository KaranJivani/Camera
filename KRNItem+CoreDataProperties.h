//
//  KRNItem+CoreDataProperties.h
//  Homepwner
//
//  Created by Karan Jivani on 8/10/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "KRNItem.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KRNItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *dateCreated;
@property (nullable, nonatomic, retain) NSString *itemKey;
@property (nullable, nonatomic, retain) NSString *itemName;
@property (nonatomic) double orderingValue;
@property (nullable, nonatomic, retain) NSString *serialNumber;
@property (nullable, nonatomic, retain) UIImage *thumbnail;
@property (nonatomic) int valueInDollars;
@property (nullable, nonatomic, retain) NSManagedObject *assetType;

@end

NS_ASSUME_NONNULL_END
