//
//  ZGDDatePickerDemo_ViewController.m
//  ZGDDatePicker-Tool
//
//  Created by 赵国栋 on 16/8/25.
//  Copyright © 2016年 赵国栋. All rights reserved.
//  https://github.com/guodongZhao/ZGDDatePicker-Tool.git

#import "ZGDDatePickerDemo_ViewController.h"
#import "ZGDDatePickerView.h"
@interface ZGDDatePickerDemo_ViewController ()<ZGDDatePickerDelegate>

@end

@implementation ZGDDatePickerDemo_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"中国结"]];
    
}

- (IBAction)Action_ShowDatePickerButton:(UIButton *)sender {
    ZGDDatePickerView *datePicker = [[ZGDDatePickerView alloc] initWithDefultDate:nil MinimumDate:nil MaximumDate:nil AndBackGroundImage:nil AndUIDatePickerMode:UIDatePickerModeDate];
    datePicker.delegate = self;
}

- (void)ZGDDatePicker:(UIDatePicker *)pickerView ChooseDate:(NSDate *)chooseDate ChooseDateStr:(NSString *)chooseDateStr
{
    NSLog(@"ChooseDate==%@,ChooseDateStr==%@", chooseDate, chooseDateStr);
}
@end
