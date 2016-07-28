//
//  KRNImageViewController.m
//  Homepwner
//
//  Created by Karan Jivani on 7/28/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import "KRNImageViewController.h"

@interface KRNImageViewController ()<UIPopoverControllerDelegate>

@end

@implementation KRNImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadView {
    
    [super loadView];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.view = imageView;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //We must cast the view to imageview so that compiler knows that it is ok to sned it setImage:
    UIImageView *imageView = (UIImageView *)self.view;
    imageView.image = self.image;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
