//
//  CommonUtility.h
//  UserManager
//
//  Created by FauadAnwar on 28/03/16.
//  Copyright © 2016 Freelancer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CustomAlertView.h"

@interface CommonUtility : NSObject

/*!Returns boolean indicating whether the string is nil or not*/
+ (BOOL) isNilOrEmptyString : (NSString *)aString;

/**
 * @brief Add the subview to parent view and add the subview controller, to it's parent view controller.
 *
 * @details This method is use to add the subview to parent view, followed by adding subview controller to it's parent view controller and  also notifies 'didMoveToParentViewController' after adding subview to parent VC.
 *
 * @return void
 */
+ (void) addSubViewNController: (UIViewController *)childViewController
                      toParent: (UIViewController *)parentViewController;


/**
 * @brief Removes subview from it's parent view and removes sub view controller, from it's parent view controller.
 *
 * @details This method is use to remove the sub view from it's parent view, followed by remove sub view controller from it's parent view controller and  also notifies 'willMoveToParentViewController' before removing from parent VC.
 *
 * @return void
 */
+ (void) removeSubViewNControllerFromParent: (UIViewController *)subviewController;

#pragma mark - Common alert view

/**
 * @brief   Method to show alert .
 *
 * @details   Show alert by setting input message text as message and input title as title to alert view
 *
 * @param NSString $aTitle
 *          aTitle is the string that appears in the receiver’s title bar.
 *
 * @param NSString $aMessage
 *          aMessage is a descriptive text that provides more details than the title.
 *
 * @return void
 *
 */
+ (void) showUIAlertViewWithTitle:(NSString*)title
                          message:(NSString*)message
                         delegate:(id)delegate
                   cancelBtnTitle:(NSString *)cancelButtonTitle
                otherButtonTitles:(NSString *)otherButtonTitles
                              tag:(int)tag
          presentInViewController:(UIViewController *)parentViewController;
@end
