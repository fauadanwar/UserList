//
//  AddUserWebService.h
//  UserManager
//
//  Created by FauadAnwar on 28/03/16.
//  Copyright © 2016 Freelancer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDataModel.h"

@interface AddUserWebService : NSObject

- (void)addUser:(UserDataModel *)userModel withCompletionHandler:(void (^)(BOOL result))completion;

@end
