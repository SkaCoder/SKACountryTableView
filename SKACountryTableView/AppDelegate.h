//
//  AppDelegate.h
//  SKACountryTableView
//
//  Created by Alok Singh on 04/07/18.
//  Copyright © 2018 Alok Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sys/xattr.h>
#include "sqlite3.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

{
    sqlite3_stmt *createStmt,*skip_statement;
    sqlite3 *database,*newDatabase,*skip_database,*database_profile;
    
    sqlite3_stmt *stmt;
}

@property (strong, nonatomic) UIWindow *window;


@end

