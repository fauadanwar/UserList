//
//  GetUserWebService.h
//  UserManager
//
//  Created by FauadAnwar on 28/03/16.
//  Copyright © 2016 Freelancer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDataModel.h"

@interface GetUserWebService : NSObject

- (void)getUsers:(void (^)(NSArray *userArray))completion;

@end
