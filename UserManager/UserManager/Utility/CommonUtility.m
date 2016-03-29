//
//  CommonUtility.m
//  UserManager
//
//  Created by FauadAnwar on 28/03/16.
//  Copyright © 2016 Freelancer. All rights reserved.
//

#import "CommonUtility.h"

typedef NS_ENUM(NSUInteger, AlertButtonIndex) {
    AlertButtonIndexOk,
    AlertButtonIndexCancel
};

@implementation CommonUtility

+ (BOOL) isNilOrEmptyString : (NSString *)aString
{
    BOOL isNilOrEmpty = NO;
    
    @try
    {
        if (aString == nil ||
            [aString isMemberOfClass:[NSNull class]] == YES ||
            [aString isKindOfClass:[NSString class]] == NO)
        {
            isNilOrEmpty = YES;
        }
        else{
            
            @autoreleasepool {
                NSString *aTempString = [aString stringByTrimmingCharactersInSet:
                                         [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                
                if ([aTempString compare:@""] == NSOrderedSame)
                {
                    isNilOrEmpty = YES;
                }
                
                else if ([aTempString isEqualToString:@"(null)"]){
                    
                    isNilOrEmpty = YES;
                    
                }
            }
        }
        
    }
    @catch (NSException *e)
    {
        @throw;
    }
    
    return  isNilOrEmpty;
}

#pragma mark - Subview add/remove methods

/**
 * @brief Add the subview to parent view and add the subview controller, to it's parent view controller.
 *
 * @details This method is use to add the subview to parent view, followed by adding subview controller to it's parent view controller and  also notifies 'didMoveToParentViewController' after adding subview to parent VC.
 *
 * @return void
 */
+ (void) addSubViewNController: (UIViewController *)childViewController
                      toParent: (UIViewController *)parentViewController
{
    if(childViewController != nil)
    {
        [parentViewController addChildViewController:childViewController];
        [parentViewController.view addSubview: childViewController.view];
        [childViewController didMoveToParentViewController:parentViewController];
    }
}


/**
 * @brief Removes subview from it's parent view and removes sub view controller, from it's parent view controller.
 *
 * @details This method is use to remove the sub view from it's parent view, followed by remove sub view controller from it's parent view controller and  also notifies 'willMoveToParentViewController' before removing from parent VC.
 *
 * @return void
 */
+ (void) removeSubViewNControllerFromParent: (UIViewController *)subviewControllerToBeRemoved
{
    if(subviewControllerToBeRemoved != nil)
    {
        [subviewControllerToBeRemoved.view removeFromSuperview];
        [subviewControllerToBeRemoved willMoveToParentViewController:nil];
        [subviewControllerToBeRemoved removeFromParentViewController];
    }
}

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
          presentInViewController:(UIViewController *)parentViewController
{
    @try
    {
        if (title == nil)
        {
            title = NSLocalizedString(@"UI_ERROR_TITLE", @"Error");
        }
        
        if (message == nil)
        {
            message = NSLocalizedString(@"ERROR_DESC_NOT_FOUND", @"We're sorry, something has gone wrong. Please try again later.");
        }
        
        if (NSClassFromString(@"UIAlertController"))
        {
            //Create Alert Controller
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: title
                                                                                     message: message
                                                                              preferredStyle: UIAlertControllerStyleAlert];
            
            if(otherButtonTitles)
            {
                //Action Buttons - Ok and Cancel
                UIAlertAction *actionOk = [UIAlertAction actionWithTitle:otherButtonTitles
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction *action)
                                           {
                                               if(delegate &&
                                                  [delegate respondsToSelector:@selector(alertViewTag:clickedButtonAtIndex:)])
                                               {
                                                   [delegate alertViewTag:tag clickedButtonAtIndex:AlertButtonIndexOk];
                                               }
                                           }];
                
                //Add Action button - Other e.g. Ok
                [alertController addAction:actionOk];
            }
            
            //Add Action button Cancel, if required
            if(cancelButtonTitle)
            {
                UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                                       style:UIAlertActionStyleCancel
                                                                     handler:^(UIAlertAction *action)
                                               {
                                                   if(delegate &&
                                                      [delegate respondsToSelector:@selector(alertViewTag:clickedButtonAtIndex:)])
                                                   {
                                                       [delegate alertViewTag:tag clickedButtonAtIndex:AlertButtonIndexCancel];
                                                   }
                                               }];
                
                [alertController addAction:actionCancel];
            }
            
            // Present Alert Controller
            [parentViewController presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            CustomAlertView *anAlert = [[CustomAlertView alloc] initCustomAlertWithTitle:title
                                                                                 message:message
                                                                                delegate:delegate
                                                                       cancelButtonTitle:cancelButtonTitle
                                                                       otherButtonTitles:otherButtonTitles];
            
            
            anAlert.tag = tag;
            
            [anAlert show];
            
            anAlert = nil;
        }
    }
    @catch (NSException * e)
    {
        @throw e;
    }
}
@end
