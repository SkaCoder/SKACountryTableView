# SKACountryTableView

Country Tableview with Search Bar(including country flag,country code,country name)

###Installation

•  import in your project the folder "SKACountryTableView"

###How to use

•  in your code import SKACountryTableView.h file.

      #import "SKACountryTableView.h"

•  implement delegate in your class

      @interface className : UIViewController<SKACountryTableViewViewDelegate>

•  add delegate methods

      -(void)didSelectItem:(NSString *)item; //to select country view cell

•  in your code add follow code when you need show the SKACountryTableView

      tablecoun = [[SKACountryTableView alloc] initWithFrame:CGRectMake(50, 210, 320, 350)];
    
      tablecoun.delegate = self;
    
      CGRect newFrame = tablecoun.frame;
    
      ablecoun.passRect=newFrame;
    
      [tablecoun showTableView];
    
      [self.view addSubview:tablecoun];
      
•  in your app AppDelegate add country table Create code      
      
       NSString *createMark_Info=@"CREATE TABLE Table_Countries (_id numeric, coun_name nvarchar(500), coun_code nvarchar(50), flag_Name nvarchar(500), active_flag bit)";
       
       (Detail code show in Example)

####feedback?

•	mail: sachinandre06@gmail.com
