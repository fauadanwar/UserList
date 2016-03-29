//
//  AddUserWebService.m
//  UserManager
//
//  Created by FauadAnwar on 28/03/16.
//  Copyright © 2016 Freelancer. All rights reserved.
//

#import "AddUserWebService.h"
#import "UserDataModel.h"
#import <AFNetworking/AFHTTPSessionManager.h>

@interface AddUserWebService ()
{
    /*!Block added for handling add user */
    void (^_addUserCompletion)(BOOL);
}

@end

@implementation AddUserWebService

- (void)addUser:(UserDataModel *)userModel withCompletionHandler:(void (^)(BOOL result))completion
{
    _addUserCompletion = completion;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];

    [manager POST:[NSString stringWithFormat:@"%@%@",DOMAIN_NAME,URL_ADD_USER]
       parameters:nil
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(userModel.userImage, 0.5) name:WS_ADD_USER_IMAGE_FILE fileName:@"F3.jpg" mimeType:@"image/jpeg"];
        
        [formData appendPartWithFormData:[userModel.userName dataUsingEncoding:NSUTF8StringEncoding]
                                    name:WS_ADD_USER_NAME];
        
        [formData appendPartWithFormData:[userModel.userAddress dataUsingEncoding:NSUTF8StringEncoding]
                                    name:WS_ADD_USER_ADDRESS];
        
        // etc.
    }
    progress:nil success:^(NSURLSessionDataTask *task, id responseObject)
    {
        NSLog(@"%@", responseObject);
        [self parseResponse:responseObject];
    }
    failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"Error: %@", error);
        completion(NO);
    }];
}

- (void)parseResponse:(NSDictionary *)responceDictionary
{
    if ([[responceDictionary objectForKey:WS_STATUS] integerValue] == 1)
    {
        _addUserCompletion(YES);
    }
    else
    {
        _addUserCompletion(NO);
    }
}

@end
