//
//  UserListViewController.m
//  UserManager
//
//  Created by FauadAnwar on 28/03/16.
//  Copyright © 2016 Freelancer. All rights reserved.
//

#import "UserListViewController.h"
#import "UserDetailViewController.h"
#import "AddUserViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UserManager.h"

@interface UserListViewController ()<AddUserViewControllerProtocol>
{
    UIViewController *progressViewControler;
    UserDetailViewController *detailViewController;
}
@property NSMutableArray *objects;
@end

@implementation UserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    detailViewController = (UserDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    _objects = [[NSMutableArray alloc] init];
    [self getUsersList];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getUsersList
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STBD_NAME_MAIN bundle:nil];
    progressViewControler = [storyboard instantiateViewControllerWithIdentifier:SB_ID_PROGRESS_INDICATOR];
    
    [CommonUtility addSubViewNController:progressViewControler toParent:self];
    
    UserManager *userManager = [[UserManager alloc] init];
    
    [userManager getUsersList:^(NSArray *userArray)
     {
         if (userArray) {
             [_objects removeAllObjects];
             [_objects addObjectsFromArray:userArray];
             [CommonUtility removeSubViewNControllerFromParent:progressViewControler];
             progressViewControler = nil;
             [self.tableView reloadData];
         }
         else
         {
             [CommonUtility  showUIAlertViewWithTitle:@"Error"
                                              message:@"Unable to get users list."
                                             delegate:nil
                                       cancelBtnTitle:nil
                                    otherButtonTitles:@"OK"
                                                  tag:0
                              presentInViewController:self];
         }

     }];
}

- (void)newUserAdded
{
    [self getUsersList];
}

- (void)switchDetailView
{
    UINavigationController *navController = [[UINavigationController alloc] init];
    
    [navController pushViewController:detailViewController animated:YES];
    
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],navController,nil];
    
    self.splitViewController.viewControllers = viewControllers;
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:STBD_ID_SEGUE_SHOW_USER_DETIALS_VIEW])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        UserDataModel *object = self.objects[indexPath.row];
        UserDetailViewController *controller = (UserDetailViewController *)[[segue destinationViewController] topViewController];
        [controller setUserDetail:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
    if ([[segue identifier] isEqualToString:STBD_ID_SEGUE_ADD_USER_VIEW])
    {
        AddUserViewController *controller = (AddUserViewController *)[[segue destinationViewController] topViewController];
        controller.protocolDelegate = self;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:STBD_ID_REUSABLE_CELL forIndexPath:indexPath];

    UserDataModel *object = self.objects[indexPath.row];
    cell.textLabel.text = object.userName;
    cell.detailTextLabel.text = object.userAddress;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:object.userImageURL] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    return cell;
}
//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}

@end
