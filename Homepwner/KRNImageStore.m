//
//  KRNImageStore.m
//  Homepwner
//
//  Created by Karan Jivani on 7/19/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import "KRNImageStore.h"

@interface KRNImageStore ()

@property(nonatomic,strong)NSMutableDictionary *dictionary;

@end

@implementation KRNImageStore

#pragma mark Sinleton methods
+(instancetype)sharedStore {
    
    static KRNImageStore *sharedStore = nil;

//    if (!sharedStore) {
//        sharedStore = [[self alloc]initPrivate];
//    }
    
    //Thread safe singleton using function dispatch_once to ensure that code is run exactly once
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc]initPrivate];
                    });
    
    return sharedStore;
}

-(instancetype)initPrivate {
    self = [super init];
    if (self) {
        self.dictionary = [[NSMutableDictionary alloc]init];
    }
    return self;
}

-(instancetype)init {
    
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRImageStore sharedStore]" userInfo:nil];
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setImage: (UIImage *)image forKey:(NSString *)key {
    [self.dictionary setObject:image forKey:key];
}
-(UIImage *)imageForKey: (NSString *)key {
    return [self.dictionary objectForKey:key];
    
}
-(void)deleteImageForKey: (NSString *)key {
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
}


@end
