//
//  KRNItemStore.m
//  Homepwner
//
//  Created by Karan Jivani on 7/16/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import "KRNItemStore.h"
#import "KRNItems.h"

@interface KRNItemStore()
@property(nonatomic) NSMutableArray *privateItems;
@end

@implementation KRNItemStore

+(instancetype)sharedStore {
    
    static KRNItemStore *sharedStore = nil;
    
    //Do I need to create a  shared store?
    if (!sharedStore) {
        sharedStore = [[self alloc]initPrivate];
    }
    return sharedStore;
}

//If programmer calls [[KRNItemStore alloc]init], let him know the error
-(instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[KRNItemStore sharedStore]" userInfo:nil];
    
    return  nil;
}

//Here is the real initializer
-(instancetype)initPrivate {
    self = [super init];
    if (self) {
        self.privateItems = [[NSMutableArray alloc]init];
    }
    return self;
}

-(NSArray *)allItems {
    return self.privateItems;
}

-(KRNItems *)createItem {
    
    KRNItems *item = [KRNItems randomItem];
    [self.privateItems addObject:item];
    return item;
}

-(void)removeItem: (KRNItems *)item {
    
    [self.privateItems removeObjectIdenticalTo:item];
}
@end
