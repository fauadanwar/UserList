//
//  UserManagerModel.m
//  UserManager
//
//  Created by FauadAnwar on 28/03/16.
//  Copyright © 2016 Freelancer. All rights reserved.
//

#import "UserManagerModel.h"

@implementation UserManagerModel

+ (UserManagerModel *) getInstance
{
    static UserManagerModel *eventModel;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        eventModel = [[UserManagerModel alloc] init];
    });
    
    return eventModel;
}

- (void)getUsersList:(void (^)(NSArray *userArray))completion
{
    GetUserWebService *getUserWS = [[GetUserWebService alloc] init];
    [getUserWS getUsers:completion];
}

- (void)addUser:(UserDataModel *)userModel withCompletionHandler:(void (^)(BOOL result))completion
{
    AddUserWebService *addUserWS = [[AddUserWebService alloc] init];
    [addUserWS addUser:userModel withCompletionHandler:completion];
}
@end
