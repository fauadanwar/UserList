//
//  AddUserViewController.m
//  UserManager
//
//  Created by FauadAnwar on 28/03/16.
//  Copyright © 2016 Freelancer. All rights reserved.
//

#import "AddUserViewController.h"
#import "UserManager.h"

@interface AddUserViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate> 
{
    CGFloat _initialConstraintConstant;
    
    CGFloat _scrollOffset;
    
    __weak IBOutlet UIImageView *imageViewProfilePicture;
    __weak IBOutlet UILabel *labelName;
    __weak IBOutlet UITextField *textFieldName;
    __weak IBOutlet UILabel *labelAddress;
    __weak IBOutlet UITextField *textFieldAddress;
    __weak IBOutlet UIScrollView *scrollViewMain;
    
    UIViewController *progressViewControler;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBottomAlignment;
- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)SaveButtonClicked:(id)sender;
- (IBAction)profileImageTaped:(id)sender;
@end

@implementation AddUserViewController

@synthesize protocolDelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _initialConstraintConstant = _constraintBottomAlignment.constant;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(IBAction)actionEndEditing:(id)sender
{
    [self.view endEditing:YES];
}

-(void) keyboardDidShow:(NSNotification *)notification
{
    if (!IS_IPAD())
    {
        //Get Size of keyboard
        NSDictionary* info = [notification userInfo];
        
        CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        
        self.constraintBottomAlignment.constant = kbSize.height - _initialConstraintConstant;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [self.view layoutIfNeeded];
        }];
        
        NSLog(@"");
    }
}

-(void) keyboardWillHide:(NSNotification *)notification
{
    if (!IS_IPAD())
    {
        self.constraintBottomAlignment.constant = _initialConstraintConstant;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [self.view layoutIfNeeded];
        }];
    }
}

#pragma mark Text Field Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == textFieldName) {
        
        [textFieldAddress becomeFirstResponder];
    }
    else if (textField == textFieldAddress) {
        
        [self SaveButtonClicked:nil];
    }
    
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)profileImageTaped:(id)sender
{
    UIImagePickerController *imagePickController = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ||
        [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront])
    {
        imagePickController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        imagePickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else
    {
        [CommonUtility  showUIAlertViewWithTitle:@"Error"
                                         message:@"Picture selection not available."
                                        delegate:nil
                                  cancelBtnTitle:nil
                               otherButtonTitles:@"OK"
                                             tag:0
                         presentInViewController:self];
    }
    imagePickController.delegate = self;
    imagePickController.allowsEditing = TRUE;
    [self presentViewController:imagePickController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    imageViewProfilePicture.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)cancelButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)SaveButtonClicked:(id)sender
{

    if ([CommonUtility isNilOrEmptyString:textFieldName.text] == NO &&
        [CommonUtility isNilOrEmptyString:textFieldAddress.text] == NO &&
        imageViewProfilePicture.image != nil)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STBD_NAME_MAIN bundle:nil];
        progressViewControler = [storyboard instantiateViewControllerWithIdentifier:SB_ID_PROGRESS_INDICATOR];
        
        [CommonUtility addSubViewNController:progressViewControler toParent:self];
        
        UserDataModel *model = [[UserDataModel alloc] init];
        model.userName = textFieldName.text;
        model.userAddress = textFieldAddress.text;
        model.userImage = imageViewProfilePicture.image;
        
        UserManager *userManager = [[UserManager alloc] init];
        [userManager addUser:model withCompletionHandler:^(BOOL result)
         {
             [CommonUtility removeSubViewNControllerFromParent:progressViewControler];
             progressViewControler = nil;
             if (result)
             {
                 if (protocolDelegate && [protocolDelegate conformsToProtocol:@protocol(AddUserViewControllerProtocol)]
                     && [protocolDelegate respondsToSelector:@selector(newUserAdded)])
                 {
                     [protocolDelegate newUserAdded];
                     [self dismissViewControllerAnimated:YES completion:nil];
                 }
             }
             else
             {
                 [CommonUtility  showUIAlertViewWithTitle:@"Error"
                                                  message:@"Unable to add user."
                                                 delegate:nil
                                           cancelBtnTitle:nil
                                        otherButtonTitles:@"OK"
                                                      tag:0
                                  presentInViewController:self];
             }
             
         }];

    }
    else
    {
        [CommonUtility  showUIAlertViewWithTitle:@"Error"
                                         message:@"Details are not valid."
                                        delegate:nil
                                  cancelBtnTitle:nil
                               otherButtonTitles:@"OK"
                                             tag:0
                         presentInViewController:self];
    }
}
@end
