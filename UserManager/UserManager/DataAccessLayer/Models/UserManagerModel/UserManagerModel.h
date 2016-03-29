//
//  UserManagerModel.h
//  UserManager
//
//  Created by FauadAnwar on 28/03/16.
//  Copyright © 2016 Freelancer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddUserWebService.h"
#import "GetUserWebService.h"

@interface UserManagerModel : NSObject

/**
 *  Initializes the shared (singleton) instance of UserManagerModel class.
 *
 *  @return Singleton instance of UserManagerModel class.
 */
+ (UserManagerModel *) getInstance;

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
