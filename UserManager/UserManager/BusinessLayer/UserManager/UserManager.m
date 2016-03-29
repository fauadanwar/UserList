//
//  UserManager.m
//  UserManager
//
//  Created by FauadAnwar on 28/03/16.
//  Copyright © 2016 Freelancer. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

- (void)getUsersList:(void (^)(NSArray *userArray))completion
{
    [[UserManagerModel getInstance] getUsersList:completion];
}

- (void)addUser:(UserDataModel *)userModel withCompletionHandler:(void (^)(BOOL result))completion
{
    [[UserManagerModel getInstance] addUser:userModel withCompletionHandler:completion];
}
@end
