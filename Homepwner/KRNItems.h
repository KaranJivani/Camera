//
//  KRNItems.h
//  RandomItems
//
//  Created by Karan Jivani on 7/7/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KRNItems : NSObject

@property(nonatomic,copy) NSString *itemName;
@property(nonatomic,copy) NSString *serialNumber;
@property(nonatomic) int valueInDollars;
@property(nonatomic,readonly,strong) NSDate *dateCreated;
    

+(instancetype) randomItem;

-(instancetype)initWithItemName : (NSString*)name
                  valueInDollars:(int)value
                    serialNumber:(NSString*)sNumber;

-(instancetype)initWithItemName : (NSString*)name;

//-(instancetype)initwithItemName : (NSString*)name
//                   serialNumber : (NSString*)serialNumber;

-(NSDate *) dateCreated;

@end
