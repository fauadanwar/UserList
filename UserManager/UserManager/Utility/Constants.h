//
//  Constants.h
//  UserManager
//
//  Created by FauadAnwar on 28/03/16.
//  Copyright © 2016 Freelancer. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#ifdef DEBUG
#undef DEBUG
#define DEBUG 2
#endif

#define IS_IPAD() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#endif /* Constants_h */
