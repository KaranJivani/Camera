//
//  KRNImageTransformer.m
//  Homepwner
//
//  Created by Karan Jivani on 8/7/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import "KRNImageTransformer.h"

@implementation KRNImageTransformer

+ (Class)transformedValueClass
{
    return [NSData class];
}

- (id)transformedValue:(id)value
{
    if (!value) {
        return nil;
    }
    
    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }
    
    return UIImagePNGRepresentation(value);
}

- (id)reverseTransformedValue:(id)value
{
    return [UIImage imageWithData:value];
}

@end
