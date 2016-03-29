//
//  GetUserWebService.m
//  UserManager
//
//  Created by FauadAnwar on 28/03/16.
//  Copyright © 2016 Freelancer. All rights reserved.
//

#import "GetUserWebService.h"
#import <AFNetworking/AFURLSessionManager.h>

@interface GetUserWebService ()
{
    /*!Block added for handling get user completion */
    void (^_getUserCompletion)(NSArray *);
}
@end
@implementation GetUserWebService

- (void)getUsers:(void (^)(NSArray *userArray))completion
{
    _getUserCompletion = completion;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",DOMAIN_NAME,URL_GET_USERS]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
    {
        if (error)
        {
            NSLog(@"Error: %@", error);
            completion(nil);
        }
        else
        {
            NSLog(@"%@ %@", response, responseObject);
            [self parseResponse:responseObject];
        }
    }];
    [dataTask resume];
}

- (void)parseResponse:(NSDictionary *)responceDictionary
{
    NSMutableArray *modelsArray = [[NSMutableArray alloc] init];
    if ([[responceDictionary objectForKey:WS_STATUS] integerValue] == 1)
    {
        NSArray *userArray = [[responceDictionary objectForKey:WS_DATA] objectForKey:WS_USER_LIST];
       
        for (NSDictionary *userDictionary in userArray)
        {
            UserDataModel *dataModel = [[UserDataModel alloc] init];
            dataModel.userID = [userDictionary objectForKey:WS_USER_ID];
            dataModel.userName = [userDictionary objectForKey:WS_USER_NAME];
            dataModel.userAddress = [userDictionary objectForKey:WS_USER_ADDRESS];
            dataModel.userImageURL = [userDictionary objectForKey:WS_USER_IMAGE];
            [modelsArray addObject:dataModel];
        }
        _getUserCompletion(modelsArray);
    }
    else
    {
        _getUserCompletion(nil);
    }
}
@end
