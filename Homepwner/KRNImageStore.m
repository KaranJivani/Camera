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
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(clearCache:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
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
    
    //Create a full path for image
    NSString *imagePath = [self imagePathForKey:key];
    
    //Turn Image into JPEG data
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    
    //write it to full path
    [data writeToFile:imagePath atomically:YES];
}

-(UIImage *)imageForKey: (NSString *)key {
//    return [self.dictionary objectForKey:key];
    
    //If Possible, Get image from the directory
    UIImage *result = self.dictionary[key];
    if (!result) {
        NSString *imagePath = [self imagePathForKey:key];
        
        //Create UIImage object from file
        result = [UIImage imageWithContentsOfFile:imagePath];
        
        //If we found Image on file system, place it in to a cache
        if (result) {
            self.dictionary[key] = result;
        }
        else {
            NSLog(@"Error: Unable to find %@",[self imagePathForKey:key]);
        }
    }
    return result;
}

-(void)deleteImageForKey: (NSString *)key {
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
    
    //when an image is deleted from the store it also deleted from file system
    NSString *imagePath = [self imagePathForKey:key];
    [[NSFileManager defaultManager]removeItemAtPath:imagePath error:nil];
}

- (NSString *)imagePathForKey:(NSString *)key {
    
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                       NSUserDomainMask,
                                                                       YES);
    
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:key];

}

-(void)clearCache: (NSNotification*)note {
    NSLog(@"flushing %d images out of the cache",[self.dictionary count]);
    [self.dictionary removeAllObjects];
}

@end
