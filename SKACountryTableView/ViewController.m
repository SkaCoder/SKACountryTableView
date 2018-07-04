//
//  ViewController.m
//  SKACountryTableView
//
//  Created by Alok Singh on 04/07/18.
//  Copyright © 2018 Alok Singh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btnShowPickerClick:(id)sender {
    
    tablecoun = [[SKACountryTableView alloc] initWithFrame:CGRectMake(50, 210, 320, 350)];
    
    tablecoun.delegate = self;
    
    CGRect newFrame = tablecoun.frame;
    
    tablecoun.passRect=newFrame;
    
    [tablecoun showTableView];
    
    [self.view addSubview:tablecoun];
    
}

-(void)didSelectItem:(NSString *)item{
    main_label.text=item;
    NSLog(@"%@",item);
    [tablecoun removeFromSuperview];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    tablecoun.hidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
