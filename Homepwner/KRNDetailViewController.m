//
//  KRNDetailViewController.m
//  Homepwner
//
//  Created by Karan Jivani on 7/18/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import "KRNDetailViewController.h"

@interface KRNDetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation KRNDetailViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    [self addImageToView];
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    KRNItems *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d",item.valueInDollars];
    
    //you will need NSDateFormatter that will turn a date in to a date string
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    //Use filtered NSDate object to set dateLabel contents
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
    NSString *imageKey = self.item.itemKey;
    
    //Get the Image for its image key from the image store
    UIImage *imageToDisplay = [[KRNImageStore sharedStore]imageForKey:imageKey];
    
    //Use that Image to put on the screen in image view
    self.imageView.image = imageToDisplay;
    
    if (!self.imageView.image) {
        self.imageView.hidden = TRUE;
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    //Clear first responder
    [self.view endEditing:YES];
    
    //"Save changes to the item"
    KRNItems *item = self.item;
    
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
    
}

-(void)setItem:(KRNItems *)item {
    _item = item;
    self.navigationItem.title = self.item.itemName;
}
- (IBAction)takePicture:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    
    //If a device has a camera, take a picture otherwise just pick from photo library
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    
    //Place Image Picker on the screen
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    //Get picked image from info dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //Store the image in the KRNImageStore for this key
    [[KRNImageStore sharedStore]setImage:image forKey:self.item.itemKey];
    
    //Put that image in to the screen in our image view
    self.imageView.image = image;
    
    //Take Image picker off the screen - you must call this dismiss method
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.imageView.hidden = false;

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

//programatically adding image view and Constraint using Visual Format Language

-(void)addImageToView {
    
    UIImageView *iv = [[UIImageView alloc]initWithImage:nil];
    
    //The Content mode of the ImageView in the XIB was Aspect fit:
    iv.contentMode = UIViewContentModeScaleAspectFit;
    
    //Do not produce the translated constraint for this view
    iv.translatesAutoresizingMaskIntoConstraints = NO;
    
    //The Image view was a subview of a view
    [self.view addSubview:iv];
    
    //The Imageview was pointed to by the imageView Property
    self.imageView = iv;
    
    NSDictionary *nameMap = @{@"imageView" : self.imageView, @"dateLabel" : self.dateLabel, @"toolbar" : self.toolbar};
    
    //imageView is 0 pts from superview at left and right edges
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:nameMap];
    
    //imageView is 10 pts from date Label at its top edge and 10 points from toolbar at its bottom edge
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[dateLabel]-10-[imageView]-10-[toolbar]"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:nameMap];
    
    [self.view addConstraints:horizontalConstraints];
    [self.view addConstraints:verticalConstraints];

}

@end
