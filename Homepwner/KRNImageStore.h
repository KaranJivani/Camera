//
//  KRNImageStore.h
//  Homepwner
//
//  Created by Karan Jivani on 7/19/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KRNImageStore : UIViewController

+(instancetype)sharedStore ;

-(void)setImage: (UIImage *)image forKey:(NSString *)key;
-(UIImage *)imageForKey: (NSString *)key;
-(void)deleteImageForKey: (NSString *)key;

@end
