//
//  UserManager.h
//  UserManager
//
//  Created by FauadAnwar on 28/03/16.
//  Copyright © 2016 Freelancer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserManagerModel.h"

@interface UserManager : NSObject
/**
 * @brief Method to fetch all users.
 *
 * @param completion void (^)(NSArray *userArray) Completion block which is to be executed after all user list get obtained.
 *
 * @return void
 */
- (void)getUsersList:(void (^)(NSArray *userArray))completion;

/**
 * @brief Method to add user.
 *
 * @param completion void (^)(BOOL result) Completion block which is to be executed after user get added. OR when WS return failed response.
 *
 * @return void
 */
- (void)addUser:(UserDataModel *)userModel withCompletionHandler:(void (^)(BOOL result))completion;

@end
