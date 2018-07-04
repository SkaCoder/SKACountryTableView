//
//  ViewController.h
//  SKACountryTableView
//
//  Created by Alok Singh on 04/07/18.
//  Copyright © 2018 Alok Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKACountryTableView.h"

@interface ViewController : UIViewController<SKACountryTableViewDelegate>
{
    SKACountryTableView *tablecoun;
    NSArray *nameArray;
    UITableView *newtable;
    IBOutlet UIButton *main_btn;
    
    IBOutlet UILabel *main_label;
    
}

@end

