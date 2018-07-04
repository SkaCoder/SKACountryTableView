//
//  SATableView.h
//
//  Created by Sachin Andre on 10/03/18.
//  Copyright © 2018 Sachin Andre. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@protocol SKACountryTableViewDelegate <NSObject>

-(void)didSelectItem:(NSString *)item;

@end

@interface SKACountryTableView : UIView <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchBarDelegate>
{
    UIView *tableviewlyer;
    UITableView *tbleView;
    UISearchBar *searchBar_new;
  //  NSArray *arrRecords;
    id <SKACountryTableViewDelegate> delegate;
    BOOL searchEnabled;
    sqlite3 *database,*newDatabase,*skip_database,*database_profile,*country_db;
    NSString *db_name_String;
    
    NSMutableArray *country_id,*coountry_name,*country_flag;

    NSMutableDictionary *dict,*dict1;

}

@property (nonatomic, retain) NSArray *arrRecords;
@property (nonatomic, retain) id <SKACountryTableViewDelegate> delegate;
//@property (nonatomic,strong) UIView *tblSuperView;
@property (nonatomic, strong) NSMutableArray *searchResult,*searchResult1,*searchResult2;

-(id)initWithFrame:(CGRect)frame;

-(void)showTableView;
@property (nonatomic,strong) NSString *headingText;
@property (nonatomic,strong) UILabel *lblHeader;

@property (nonatomic, assign) CGRect passRect;


@end
