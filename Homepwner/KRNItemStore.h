//
//  KRNItemStore.h
//  Homepwner
//
//  Created by Karan Jivani on 7/16/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KRNItem;

@interface KRNItemStore : NSObject

@property(nonatomic,readonly) NSArray *allItems;

+(instancetype)sharedStore;
-(KRNItem *)createItem;
-(void)removeItem: (KRNItem *)item;
-(void)moveItemAtIndex: (NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
-(BOOL)saveChanges;

@end
