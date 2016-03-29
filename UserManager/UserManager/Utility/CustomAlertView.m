#import "CustomAlertView.h"

@interface CustomAlertView ()<UIAlertViewDelegate>
{
    id<CustomAlertViewDelegate> alertViewdelegate;
}

@end

@implementation CustomAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CustomAlertView *)initCustomAlertWithTitle:(NSString *)title
                                       message:(NSString *)message
                                      delegate:(id)delegate
                             cancelButtonTitle:(NSString *)cancelButtonTitle
                             otherButtonTitles:(NSString *)otherButtonTitles
{
   self =  [super initWithTitle:title
                 message:message
                delegate:nil
       cancelButtonTitle:cancelButtonTitle
       otherButtonTitles:otherButtonTitles, nil];
    
    if(self)
    {
        self.delegate =  self;
        alertViewdelegate = delegate;
    }
    
    return self;
}

#pragma mark - alert view delegate handling

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex// NS_DEPRECATED_IOS(2_0, 9_0);
{
    if(alertViewdelegate &&
       [alertViewdelegate respondsToSelector:@selector(alertViewTag:clickedButtonAtIndex:)])
    {
        [alertViewdelegate alertViewTag: alertView.tag
                   clickedButtonAtIndex: buttonIndex];
    }
}

@end
