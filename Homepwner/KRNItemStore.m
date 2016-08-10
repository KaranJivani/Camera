//
//  KRNItemStore.m
//  Homepwner
//
//  Created by Karan Jivani on 7/16/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import "KRNItemStore.h"
#import "KRNItem.h"
#import "KRNImageStore.h"
@import CoreData;

@interface KRNItemStore()
@property(nonatomic) NSMutableArray *privateItems;

@property(nonatomic, strong) NSMutableArray *AllAssetTypes;
@property(nonatomic, strong) NSManagedObjectContext *context;
@property(nonatomic, strong) NSManagedObjectModel *model;
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
//        self.privateItems = [[NSMutableArray alloc]init];
        
        /*NSString *path = [self itemArchivePath];
        self.privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        //If the array had not been saved previously, create a new empty one
        if (!self.privateItems) {
                    self.privateItems = [[NSMutableArray alloc]init];
        }*/
        
        //Read in Homepwner.xcdatamodeld
        
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:_model];
        
        //Where does the SQLite file go?
        NSString *path = self.itemArchivePath;
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        
        NSError *error = nil;
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            @throw [NSException exceptionWithName:@"OpenFailure" reason:[error localizedDescription] userInfo:nil];
        }
        
        //Create the managed object context
        _context = [[NSManagedObjectContext alloc]init];
        _context.persistentStoreCoordinator = psc;
        [self loadAllItems];
    }
    return self;
}

-(NSArray *)allItems {
    return self.privateItems;
}

-(KRNItem *)createItem {
    
//    KRNItem *item = [[KRNItem alloc]init];
    
    double order;
    if ([self.allItems count] == 0) {
        order = 1.0;
    }
    else {
        order = [[self.privateItems lastObject]orderingValue] + 1.0;
    }
    NSLog(@"Adding after %d items, order = %.2f",[self.privateItems count],order);
    KRNItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"KRNItem" inManagedObjectContext:self.context];
    item.orderingValue = order;
    
    [self.privateItems addObject:item];
    return item;
}

-(void)removeItem: (KRNItem *)item {
    
    NSString *key = item.itemKey;
    [[KRNImageStore sharedStore]deleteImageForKey:key];
    
    [self.context deleteObject:item];
    [self.privateItems removeObjectIdenticalTo:item];
}

-(void)moveItemAtIndex: (NSUInteger)fromIndex toIndex:(NSUInteger)toIndex{
    if (fromIndex == toIndex) {
        return;
    }
    
    //Get pointer to object being moved so you can reinsert it
    KRNItem *item = [self.privateItems objectAtIndex:fromIndex];
    //Remove item from array
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    //Insert item in array at new location
    [self.privateItems insertObject:item atIndex:toIndex];
    
    //Computing a new orderValue for the object that was moved
    double lowerBound = 0.0;
    
    //Is there an object before it in the Araay?
    if (toIndex>0) {
        lowerBound = [self.privateItems[toIndex - 1] orderingValue];
    }
    else {
        lowerBound = [self.privateItems[1] orderingValue] - 2.0;
    }
    double upperBound = 0.0;
    
    //Is there any object after it in the Array?
    if (toIndex < [self.privateItems count] - 1) {
        upperBound = [self.privateItems[(toIndex + 1)] orderingValue];
    } else {
        upperBound = [self.privateItems[(toIndex - 1)] orderingValue] + 2.0;
    }
    
    double newOrderValue = (lowerBound + upperBound) / 2.0;
    
    NSLog(@"moving to order %f", newOrderValue);
    item.orderingValue = newOrderValue;

}

#pragma mark Construct file path method, Place to save data on file system

-(NSString *)itemArchivePath {
    
    //Make sure that first argument is NSDocumentDictionary and not NSDocumentation dictionary
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    //Get the one document directory from the list
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

-(BOOL)saveChanges {
    /*NSString *path = [self itemArchivePath];
    
    //Returns YES on success
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];*/
    
    NSError *error;
    BOOL successful = [self.context save:&error];
    if (!successful) {
        NSLog(@"Error saving: %@",[error localizedDescription]);
    }
    return successful;
}

-(void)loadAllItems {
    
    if (!self.privateItems) {
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        NSEntityDescription *e = [NSEntityDescription entityForName:@"KRNItem" inManagedObjectContext:self.context];
        request.entity = e;
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"orderingValue" ascending:YES];
        request.sortDescriptors = @[sd];
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetcg failed" format:@"Reason: %@",[error localizedDescription]];
        }
        self.privateItems = [[NSMutableArray alloc]initWithArray:result];
    }
}

@end
