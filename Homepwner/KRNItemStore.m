//
//  KRNItemStore.m
//  Homepwner
//
//  Created by Karan Jivani on 7/16/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import "KRNItemStore.h"
#import "KRNItems.h"
#import "KRNImageStore.h"

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
    
    NSString *key = item.itemKey;
    [[KRNImageStore sharedStore]deleteImageForKey:key];
    
    [self.privateItems removeObjectIdenticalTo:item];
}

-(void)moveItemAtIndex: (NSUInteger)fromIndex toIndex:(NSUInteger)toIndex{
    if (fromIndex == toIndex) {
        return;
    }
    
    //Get pointer to object being moved so you can reinsert it
    KRNItems *item = [self.privateItems objectAtIndex:fromIndex];
    //Remove item from array
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    //Insert item in array at new location
    [self.privateItems insertObject:item atIndex:toIndex];
}

#pragma mark Construct file path method, Place to save data on file system

-(NSString *)itemArchivePath {
    
    //Make sure that first argument is NSDocumentDictionary and not NSDocumentation dictionary
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    //Get the one document directory from the list
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"item.archive"];
}

-(BOOL)saveChanges {
    NSString *path = [self itemArchivePath];
    
    //Returns YES on success
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}
@end
