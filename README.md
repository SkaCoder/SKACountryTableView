# SKACountryTableView

Country Tableview with Search Bar(including country flag,country code,country name)

###Installation

• import in your project the folder "SKACountryTableView"

###How to use

•  in your code import SKACountryTableView.h file.

      #import "SKACountryTableView.h"

•  implement delegate in your class

      @interface className : UIViewController<SKACountryTableViewViewDelegate>

•	add delegate methods

      -(void)didSelectItem:(NSString *)item; //to select country view cell

•	in your code add follow code when you need show the SKACountryTableView

           SKACountryTableView *objYHCPickerView = [[SKACountryTableView alloc] initWithFrame:CGRectMake(0, 467,         414,270)withNSArray:nameArray];      

           objYHCPickerView.delegate = self;

           CGRect newFrame = objYHCPickerView.frame;

           objYHCPickerView.passRect=newFrame;

           [self.view addSubview:objYHCPickerView];

            [objYHCPickerView showPicker];

####feedback?

•	mail: sachinandre06@gmail.com
