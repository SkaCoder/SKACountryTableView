//
//  SATableView.m
//
//  Created by Sachin Andre on 10/03/18.
//  Copyright © 2018 Sachin Andre. All rights reserved.
//

#import "SKACountryTableView.h"
#import "SimpleTableCell.h"

@implementation SKACountryTableView


@synthesize delegate;


- (NSString*)filePath{
    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    return [[paths objectAtIndex:0]stringByAppendingPathComponent:@"Country.sqlite"];
}
- (void)openDB{
    if(sqlite3_open([[self filePath] UTF8String], &database) !=SQLITE_OK){
        sqlite3_close(database);
        NSAssert(0, @"Databese failed to open");
    }else{
        NSLog(@"database opened");
    }
}

- (void)Select_country_name
{
    [self openDB];
    
    coountry_name=[[NSMutableArray alloc]init];
    country_id=[[NSMutableArray alloc]init];
    country_flag=[[NSMutableArray alloc]init];
    
    [coountry_name removeAllObjects];
    [country_id removeAllObjects];
    [country_flag removeAllObjects];
    NSString *sql1 = @"select coun_code,coun_name,flag_Name from Table_Countries";
    
    const char *sql = [sql1 cStringUsingEncoding:NSUTF8StringEncoding];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            [country_id addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]];
            
            [coountry_name addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)]];
            
            [country_flag addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)]];
        }
    }
    
    sqlite3_finalize(statement);
    
    dict = [NSMutableDictionary dictionaryWithObjects: country_flag forKeys: coountry_name];
    
    dict1 = [NSMutableDictionary dictionaryWithObjects: country_id forKeys: coountry_name];
 }


-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)showTableView{
    
    [self Select_country_name];
    
    tbleView = [[UITableView alloc] initWithFrame:CGRectMake(_passRect.origin.x-_passRect.origin.x, _passRect.origin.y-_passRect.origin.y, _passRect.size.width, _passRect.size.height)];
    
    //_passRect.origin.x,
    
    tbleView.delegate = self;
    tbleView.dataSource = self;
    tbleView.layer.cornerRadius=8.0;
    tbleView.clipsToBounds=YES;
    tbleView.layer.borderWidth = 1.0;
    tbleView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self addSubview:tbleView];
    
    searchBar_new = [[UISearchBar alloc] initWithFrame:CGRectMake(tbleView.frame.origin.x, tbleView.frame.origin.y, tbleView.frame.size.width, 75)];
    
    searchBar_new.delegate=self;
    
    searchBar_new.barTintColor=[UIColor colorWithRed:233.0f/255.0f green:233.0f/255.0f blue:233.0f/255.0f alpha:1.0];
    
    tbleView.tableHeaderView = searchBar_new;
    
 }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (searchEnabled) {
        return [self.searchResult count];
    }
    else{
        return [coountry_name count];
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    if (searchEnabled){
        
        cell.counrtyLabel.text = [self.searchResult objectAtIndex:indexPath.row];
        cell.flgImageView.image = [UIImage imageNamed:[dict objectForKey:[self.searchResult objectAtIndex:indexPath.row]]];
        cell.codeLabel.text = [dict1 objectForKey:[self.searchResult objectAtIndex:indexPath.row]];
    }
    else
    {
        cell.counrtyLabel.text = [coountry_name objectAtIndex:indexPath.row];
        cell.flgImageView.image = [UIImage imageNamed:[dict objectForKey:[coountry_name objectAtIndex:indexPath.row]]];
        cell.codeLabel.text = [dict1 objectForKey:[coountry_name objectAtIndex:indexPath.row]];
    }
    
    return cell;
 }
    
- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (searchEnabled){
        
        [self.delegate didSelectItem:self.searchResult[indexPath.row]];
    }
    else
    {
        [self.delegate didSelectItem:coountry_name[indexPath.row]];
    }
    
    tbleView.hidden=YES;
}

#pragma mark - Search delegate methods

- (void)filterContentForSearchText:(NSString*)searchText
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF CONTAINS[cd] %@",
                                    searchText];
    
    _searchResult = [coountry_name filteredArrayUsingPredicate:resultPredicate];
    
    [tbleView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchBar.text.length == 0) {
        searchEnabled = NO;
        [tbleView reloadData];
    }
    else {
        searchEnabled = YES;
        [self filterContentForSearchText:searchBar.text];
        
        if (_searchResult.count==0) {
            _lblHeader=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, tbleView.bounds.size.width, tbleView.bounds.size.height)];
            _lblHeader.text = @"No Result Found";
            _lblHeader.textColor = [UIColor blackColor];
            _lblHeader.textAlignment = NSTextAlignmentCenter;
            tbleView.backgroundView = _lblHeader;
            tbleView.separatorStyle = UITableViewCellSeparatorStyleNone;
            //[tbleView reloadData];
            _lblHeader.hidden=NO;
        }else{
            _lblHeader.hidden=YES;
        }
    }
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    searchEnabled = YES;
    [self filterContentForSearchText:searchBar.text];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [searchBar setText:@""];
    searchEnabled = NO;
    [tbleView reloadData];
}

@end
