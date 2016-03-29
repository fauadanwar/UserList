//
//  AddUserViewController.h
//  UserManager
//
//  Created by FauadAnwar on 28/03/16.
//  Copyright © 2016 Freelancer. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 @brief Protocol to get call back when User get added.
 */
@protocol AddUserViewControllerProtocol <NSObject>

@required

- (void)newUserAdded;

@end

@interface AddUserViewController : UIViewController

@property(nonatomic, weak) id<AddUserViewControllerProtocol> protocolDelegate; /**< delegate obejct to get protocol call back. */

@end
