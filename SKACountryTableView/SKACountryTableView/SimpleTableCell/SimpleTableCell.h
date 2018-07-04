//
//  SimpleTableCell.h
//  SKATableViewExample
//
//  Created by Alok Singh on 04/07/18.
//  Copyright © 2018 Alok Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *counrtyLabel;
@property (nonatomic, weak) IBOutlet UILabel *codeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *flgImageView;

@end
