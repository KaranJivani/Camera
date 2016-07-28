//
//  KRNItems.m
//  RandomItems
//
//  Created by Karan Jivani on 7/7/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import "KRNItems.h"

@implementation KRNItems

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.itemName forKey:@"itemName"];
    [aCoder encodeObject:self.serialNumber forKey:@"serialNumber"];
    [aCoder encodeObject:self.dateCreated forKey:@"dateCreated"];
    [aCoder encodeObject:self.itemKey forKey:@"itemKey"];
    [aCoder encodeObject:self.thumbnail forKey:@"thumbnail"];
    [aCoder encodeInteger:self.valueInDollars forKey:@"valueInDollars"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _itemName = [aDecoder decodeObjectForKey:@"itemName"];
        _serialNumber = [aDecoder decodeObjectForKey:@"serialNumber"];
        _dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
        _itemKey = [aDecoder decodeObjectForKey:@"itemKey"];
        _thumbnail = [aDecoder decodeObjectForKey:@"thumbnail"];
        _valueInDollars = [aDecoder decodeIntegerForKey:@"valueInDollars"];
    }
    return self;
}

-(instancetype)initWithItemName: (NSString *)name
                 valueInDollars: (int)value
                   serialNumber: (NSString *)sNumber {
    
    //call the superclass's designated initializer
    self = [super init];
    
    //did the superclass's initializer succeed?
    if (self) {
        //give the instance variables intial value
        self.itemName = name;
        self.serialNumber = sNumber;
        self.valueInDollars = value;
    }
    
    //Create an NSUUID object and get its string presentation
    NSUUID *uuid = [[NSUUID alloc]init];
    
    NSString *key = [uuid UUIDString];
    _itemKey = key;
    
    //Return the address of the newly initialized object
    return self;
}

////Silver challange
//-(instancetype)initwithItemName:(NSString *)name serialNumber:(NSString *)serialNumber {
//    
//    return [self initWithItemName:name valueInDollars:0 serialNumber:serialNumber];
//}

-(instancetype)initWithItemName:(NSString *)name {
    
    return [self initWithItemName:name valueInDollars:0 serialNumber:@""];
}

-(instancetype)init {
    
    return[self initWithItemName:@"item"];
}


+(instancetype)randomItem {
    
    //Create an immutable array of three adjective
    NSArray *randomAdjectiveList = @[@"Fliffy",@"Rusty",@"Shiny"];
    //Create an immutable array of three nouns
    NSArray *randomNounList = @[@"Bear",@"Spork",@"Mac"];
    
    //Get the index of a random adjective/noun from the list
    /*Note : the % operator, called the modulo operator gives you the remainder. so adjectiveIndex is the random number from 0 to 2 inclusive. */
    
    NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
    
    NSInteger nounIndex = arc4random() % [randomNounList count];
    
    //Note thet NSinteger is not an object but the type defination for "long"
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",[randomAdjectiveList objectAtIndex:adjectiveIndex],[randomNounList objectAtIndex:nounIndex]];
    
    int randomValue = arc4random() % 100;
    
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0'+arc4random()%10,
                                    'A'+arc4random()%26,
                                    '0'+arc4random()%10,
                                    'A'+arc4random()%26,
                                    '0'+arc4random()%10];
    
    KRNItems *newItem = [[self alloc]initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerialNumber];
    
    return newItem;
}

-(NSString *)description {
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"%@ (Model %@): Worth $%d, recorded on %@",
     self.itemName,
     self.serialNumber,
     self.valueInDollars,
     self.dateCreated];
    
    return descriptionString;
}

-(void)dealloc {
    NSLog(@"Destroyed: %@",self);
}

-(NSDate *) dateCreated {
    NSDate *date = [[NSDate alloc]init];
    return date;
    
}

-(void)setThumbnailFromImage:(UIImage *)image {
    
    CGSize origImageSize = image.size;
    
    //The recangle of thumbnail
    CGRect newRect = CGRectMake(0, 0, 66, 66);
    
    //Figure out the scaling ratio to make sure we maintain the same aspect ratio
    float ratio = MAX(newRect.size.width/ origImageSize.width , newRect.size.height);//
    
    //Create a transparent bitmap context with a scaling factor equal to that of the screen
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    
    //Create a path taht is a rounded rectangle
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    
    //Make all subsequent drawing clip to this rounded rectangle
    [path addClip];
    
    //center the Image in the thumbnail rectange
    CGRect projectRect;
    projectRect.size.width = ratio*origImageSize.width;
    projectRect.size.height = ratio*origImageSize.height;
    projectRect.origin.x = (newRect.size.width - projectRect.size.width)/2;
    projectRect.origin.y = (newRect.size.height - projectRect.size.width)/2;
    
    //Draw the Image on it
    [image drawInRect:projectRect];
    
    //Get the image from tge image context; keep it as our thumbnail
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    self.thumbnail = smallImage;
    
    //Cleanup image context resources;
    UIGraphicsEndImageContext();
    
    
}
@end
