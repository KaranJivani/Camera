//
//  KRNItem.h
//  Homepwner
//
//  Created by Karan Jivani on 8/10/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KRNItem : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

-(void)setThumbnailFromImage: (UIImage *)image;

@end

NS_ASSUME_NONNULL_END

#import "KRNItem+CoreDataProperties.h"
