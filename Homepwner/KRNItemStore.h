//
//  KRNItemStore.h
//  Homepwner
//
//  Created by Karan Jivani on 7/16/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KRNItems;

@interface KRNItemStore : NSObject

@property(nonatomic,readonly) NSArray *allItems;

+(instancetype)sharedStore;
-(KRNItems *)createItem;
-(void)removeItem: (KRNItems *)item;

@end
