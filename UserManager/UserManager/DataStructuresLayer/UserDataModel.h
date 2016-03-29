//
//  UserDataModel.h
//  UserManager
//
//  Created by FauadAnwar on 28/03/16.
//  Copyright © 2016 Freelancer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataModel : NSObject
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *userAddress;
@property (strong, nonatomic) NSString *userImageURL;
@property (strong, nonatomic) UIImage *userImage;
@end
