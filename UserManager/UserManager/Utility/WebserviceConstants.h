//
//  WebserviceConstants.h
//  UserManager
//
//  Created by FauadAnwar on 28/03/16.
//  Copyright © 2016 Freelancer. All rights reserved.
//

#ifndef WebserviceConstants_h
#define WebserviceConstants_h

#if DEBUG == 1
#define DOMAIN_NAME (@"http://52.91.144.12/techassignment/index.php/user/")
#elif DEBUG == 2
#define DOMAIN_NAME (@"http://52.91.144.12/techassignment/index.php/user/")
#else
#define DOMAIN_NAME (@"http://52.91.144.12/techassignment/index.php/user/")
#endif


//POST Request
#define URL_ADD_USER (@"addUser/")

//GET Request
#define URL_GET_USERS (@"listUser/")

//Web service response constants
#define WS_STATUS (@"status")
#define WS_DATA (@"data")
#define WS_USER_LIST (@"userlist")
#define WS_USER_ADDRESS (@"address")
#define WS_USER_ID (@"id")
#define WS_USER_IMAGE (@"image")
#define WS_USER_NAME (@"name")


//Web service request constants
#define WS_ADD_USER_NAME (@"name")
#define WS_ADD_USER_ADDRESS (@"address")
#define WS_ADD_USER_IMAGE_FILE (@"imgfile")

#endif /* WebserviceConstants_h */
