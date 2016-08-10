//
//  KRNItem.m
//  Homepwner
//
//  Created by Karan Jivani on 8/10/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import "KRNItem.h"

@implementation KRNItem

-(void)awakeFromInsert {
    
    [super awakeFromInsert];
    self.dateCreated = [NSDate date];
    
    //Create an NSUUID object and get its string presentation
    NSUUID *uuid = [[NSUUID alloc]init];
    
    NSString *key = [uuid UUIDString];
    self.itemKey = key;
}

// Insert code here to add functionality to your managed object subclass
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
