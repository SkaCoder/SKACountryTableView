//
//  AppDelegate.m
//  SKACountryTableView
//
//  Created by Alok Singh on 04/07/18.
//  Copyright © 2018 Alok Singh. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL{
    if(NSURLIsExcludedFromBackupKey){
        assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
        NSError *error = nil;
        BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                      forKey: NSURLIsExcludedFromBackupKey error: &error];
        if(!success){
            NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
        }
        return success;
    }
    else{
        assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
        const char* filePath = [[URL path] fileSystemRepresentation];
        const char* attrName = "com.apple.MobileBackup";
        u_int8_t attrValue = 1;
        int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
        return result==0;
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    NSLog(@"app dir: %@",[[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject]);
    
    NSArray *newrray=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *newfile=[newrray objectAtIndex:0];
    newfile=[newfile stringByAppendingPathComponent:@"Country.sqlite"];
    
    NSFileManager *newmanager=[NSFileManager defaultManager];
    BOOL newsuccess=NO;
    
    if([newmanager fileExistsAtPath:newfile]){
        newsuccess=YES;
        //----------For Backing up--------------------------------
        // NSURL *pathURL_Army= [NSURL fileURLWithPath:newfile];
        // [self addSkipBackupAttributeToItemAtURL:pathURL_Army];
    }
    if(!newsuccess){
        NSString *path333=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Country.sqlite"];
        newsuccess =[newmanager copyItemAtPath:path333 toPath:newfile error:nil];
        //----------For Backing up--------------------------------
        //NSURL *pathURL_Army= [NSURL fileURLWithPath:path333];
        //[self addSkipBackupAttributeToItemAtURL:pathURL_Army];
    }
    
    createStmt = nil;
    
    
    if(sqlite3_open([newfile UTF8String], &database)==SQLITE_OK){
        if(createStmt==nil){
            
            //@"create table markInfo(Name text,Surname text,marks numeric);";
            NSString *createMark_Info=@"CREATE TABLE Table_Countries (_id numeric, coun_name nvarchar(500), coun_code nvarchar(50), flag_Name nvarchar(500), active_flag bit)";
            
            
            
            if(sqlite3_prepare_v2(database, [createMark_Info UTF8String], -1, &createStmt, NULL) != SQLITE_OK){
            }
            sqlite3_exec(database, [createMark_Info UTF8String],  NULL,NULL,NULL);
        }
        sqlite3_finalize(createStmt);
        
        
        sqlite3_close(database);
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.rootViewController = [[ViewController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
 }


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
