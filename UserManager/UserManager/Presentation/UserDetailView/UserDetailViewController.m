//
//  UserDetailViewController.m
//  UserManager
//
//  Created by FauadAnwar on 28/03/16.
//  Copyright © 2016 Freelancer. All rights reserved.
//

#import "UserDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface UserDetailViewController ()
{
    __weak IBOutlet UILabel *labelAddressText;
    __weak IBOutlet UILabel *labelNameText;
    __weak IBOutlet UILabel *labelAddress;
    __weak IBOutlet UILabel *labelName;
    __weak IBOutlet UIImageView *imageViewProfile;
}
@end

@implementation UserDetailViewController

#pragma mark - Managing the detail item

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.userDetail) {
        labelNameText.text = self.userDetail.userName;
        labelAddressText.text = self.userDetail.userAddress;
        [imageViewProfile sd_setImageWithURL:[NSURL URLWithString:self.userDetail.userImageURL] placeholderImage:[UIImage imageNamed:@"placeholder"]];

    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
