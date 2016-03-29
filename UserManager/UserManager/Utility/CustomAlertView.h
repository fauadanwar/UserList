#import <UIKit/UIKit.h>

@protocol CustomAlertViewDelegate <NSObject>

@optional

- (void)alertViewTag:(NSInteger)alertViewTag clickedButtonAtIndex:(NSInteger)buttonIndex;

@end


@interface CustomAlertView : UIAlertView

- (CustomAlertView *)initCustomAlertWithTitle:(NSString *)title
                                 message:(NSString *)message
                                delegate:(id)delegate
                       cancelButtonTitle:(NSString *)cancelButtonTitle
                       otherButtonTitles:(NSString *)otherButtonTitles;

@end
