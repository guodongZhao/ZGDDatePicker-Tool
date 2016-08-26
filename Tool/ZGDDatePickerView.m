//
//  ZGDDatePickerVIew.m
//  ZGDDatePicker-Tool
//
//  Created by 赵国栋 on 16/8/24.
//  Copyright © 2016年 赵国栋. All rights reserved.
//  https://github.com/guodongZhao/ZGDDatePicker-Tool.git


#import "ZGDDatePickerView.h"
#define Width  [ UIScreen mainScreen ].bounds.size.width
#define Height  [ UIScreen mainScreen ].bounds.size.height

@interface ZGDDatePickerView ()
{
    NSDate *chooseDate;
    NSString *chooseDateStr;
}
// 底部蒙版View
@property (nonatomic, strong) UIView *ZGD_BackGroundView;
// 底部蒙版上的背景图View
@property (nonatomic, strong) UIImageView *ZGD_BackGroundImageView;

// 时间选择器
@property (nonatomic, strong) UIDatePicker *ZGD_DataPickerView;
// 显示时间的view
@property (nonatomic, strong) UIView *ZGD_ShowTimeLabelView;
// 显示时间的label
@property (nonatomic, strong) UILabel *ZGD_ShowTimeLabel;
// 按钮底部蒙版view
@property (nonatomic, strong) UIView *ZGD_ButtonBackGroundView;
// 取消按钮
@property (nonatomic, strong) UIButton *ZGD_CancelButton;
// 确定按钮
@property (nonatomic, strong) UIButton *ZGD_CreateButton;

@end

@implementation ZGDDatePickerView

- (instancetype)initWithDefultDate:(NSDate *)defultDate MinimumDate:(NSDate *)minimumDate MaximumDate:(NSDate *)maximumDate AndBackGroundImage:(UIImage *)backGroundImage AndUIDatePickerMode:(UIDatePickerMode)datePickerMode
{
    if (self = [super init]) {
        //初始化背景半透明模板
        self.frame=CGRectMake(0, 0, Width, Height);
        self.backgroundColor=[UIColor grayColor];
        self.alpha=0.5;
        [[[UIApplication sharedApplication].delegate window] addSubview:self];
        
        //初始化控件父视图.背景色为白色,不透明
        _ZGD_BackGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, Height/3, Width, (Height/3)*2 )];
        _ZGD_BackGroundView.backgroundColor=[UIColor whiteColor];
        [[[UIApplication sharedApplication].delegate window] addSubview:_ZGD_BackGroundView];

        // 初始化背景图片
        _ZGD_BackGroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, _ZGD_BackGroundView.bounds.size.height - 50)];
        _ZGD_BackGroundImageView.userInteractionEnabled = YES;
        _ZGD_BackGroundImageView.alpha = 0.3f;
        if (backGroundImage == nil) {
            _ZGD_BackGroundImageView.image = [UIImage imageNamed:@"风景荷花"];
        }else{
            _ZGD_BackGroundImageView.image = backGroundImage;
        }
        [_ZGD_BackGroundView addSubview:_ZGD_BackGroundImageView];
        
        
        // 初始化时间选择器
        _ZGD_DataPickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, Width, Height/3)];
        NSDate *now = [NSDate date];
        // 控件属性设置
        if (!datePickerMode) {
            // 默认年月日
            _ZGD_DataPickerView.datePickerMode = UIDatePickerModeDate;
        }else{
            _ZGD_DataPickerView.datePickerMode = datePickerMode;
        }
        // 设置时间选择器颜色
        [_ZGD_DataPickerView setValue:[UIColor colorWithRed:0/255.0 green:200/255.0 blue:225/255.0 alpha:1] forKey:@"textColor"];
        
        // 设置日期选择控件的地区
        _ZGD_DataPickerView.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
        // 设置默认显示时间
        if (defultDate == nil) {
            [_ZGD_DataPickerView setDate:now animated:YES];
        }else{
            [_ZGD_DataPickerView setDate:defultDate animated:YES];
        }
          //        // 设置日期范围（用户只能在时间范围之内选择）
        if (minimumDate == nil) {
            _ZGD_DataPickerView.minimumDate = now;
        }else{
            _ZGD_DataPickerView.minimumDate = minimumDate;
        }
        if (maximumDate == nil) {
            _ZGD_DataPickerView.maximumDate = [NSDate dateWithTimeIntervalSince1970:0];
        }else{
            _ZGD_DataPickerView.maximumDate = maximumDate;
        }
        // 添加事件响应
        [_ZGD_DataPickerView addTarget:self action:@selector(datePickerAction:) forControlEvents:UIControlEventValueChanged];
        
        [_ZGD_BackGroundView addSubview:_ZGD_DataPickerView];
        
        CGFloat LabelHeight = _ZGD_DataPickerView.bounds.size.height;
        // 初始化时间显示框
        _ZGD_ShowTimeLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, LabelHeight + (LabelHeight/2)/2, Width, LabelHeight / 2)];
        _ZGD_ShowTimeLabelView.backgroundColor = [UIColor clearColor];
        [_ZGD_BackGroundView addSubview:_ZGD_ShowTimeLabelView];
        // 初始化时间显示框
        _ZGD_ShowTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, (LabelHeight /2)/2 - 50, Width - 60, 50)];
        _ZGD_ShowTimeLabel.layer.borderWidth = 2.f;
        _ZGD_ShowTimeLabel.layer.borderColor = [UIColor colorWithRed:36/255.0 green:223/255.0 blue:225/255.0 alpha:1].CGColor;
        _ZGD_ShowTimeLabel.layer.cornerRadius = 10.f;
        _ZGD_ShowTimeLabel.layer.masksToBounds = YES;
        
        NSDate *date = _ZGD_DataPickerView.date;
        chooseDate = date;
        // NSDate转化为Nsstring
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSString *timer = [formatter stringFromDate:date];
        chooseDateStr = timer;
        _ZGD_ShowTimeLabel.text = [NSString stringWithFormat:@"选择的时间为：%@", timer];
        _ZGD_ShowTimeLabel.font = [UIFont systemFontOfSize:16];
        _ZGD_ShowTimeLabel.textAlignment = NSTextAlignmentCenter;
        _ZGD_ShowTimeLabel.textColor = [UIColor colorWithRed:0/255.0 green:235/255.0 blue:225/255.0 alpha:1];
        [_ZGD_ShowTimeLabelView addSubview:_ZGD_ShowTimeLabel];
        
        // 初始化按钮底部蒙版view
        _ZGD_ButtonBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, _ZGD_BackGroundView.frame.size.height - 50  , Width, 50)];
        [_ZGD_BackGroundView addSubview:_ZGD_ButtonBackGroundView];
        
        
        // 初始化底部按钮View
        // 左侧取消按钮
        _ZGD_CancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _ZGD_CancelButton.frame = CGRectMake(0, 0, Width /2, 50);
        [_ZGD_CancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_ZGD_CancelButton setTitleColor:[UIColor colorWithRed:0/255.0 green:200/255.0 blue:225/255.0 alpha:1] forState:UIControlStateNormal];
        [_ZGD_CancelButton setBackgroundColor:[UIColor clearColor]];
        _ZGD_CancelButton.layer.borderColor = [UIColor colorWithRed:36/255.0 green:223/255.0 blue:225/255.0 alpha:1].CGColor;
        _ZGD_CancelButton.layer.borderWidth = 2;
        _ZGD_CancelButton.layer.cornerRadius = 10.f;
        _ZGD_CancelButton.layer.masksToBounds = YES;
        [_ZGD_CancelButton addTarget:self action:@selector(Action_CancelButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
        // 右侧确定按钮
        _ZGD_CreateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _ZGD_CreateButton.frame = CGRectMake(Width / 2,  0, Width / 2, 50);
        [_ZGD_CreateButton setTitle:@"确定" forState:UIControlStateNormal];
        [_ZGD_CreateButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_ZGD_CreateButton setBackgroundColor:[UIColor clearColor]];
        _ZGD_CreateButton.layer.borderColor = [UIColor redColor].CGColor;
        _ZGD_CreateButton.layer.borderWidth = 2;
        _ZGD_CreateButton.layer.cornerRadius = 10.f;
        _ZGD_CreateButton.layer.masksToBounds = YES;
        [_ZGD_CreateButton addTarget:self action:@selector(Action_CreateButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [_ZGD_ButtonBackGroundView addSubview:_ZGD_CancelButton];
        [_ZGD_ButtonBackGroundView addSubview:_ZGD_CreateButton];
        
    }
    return self;
}
#pragma mark -
#pragma mark datePickerAction
- (void)datePickerAction:(UIDatePicker *)dataPicker
{
    NSDate *date = dataPicker.date;
    // NSDate转化为Nsstring
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *timer = [formatter stringFromDate:date];
    _ZGD_ShowTimeLabel.text = [NSString stringWithFormat:@"用车时间为：%@", timer];
    chooseDate = date;
    chooseDateStr = timer;

}

#pragma mark -
#pragma mark action
// 取消
- (void)Action_CancelButton:(UIButton *)CancelButton
{
    
    [self removeFromSuperview];
    [_ZGD_BackGroundView removeFromSuperview];
    
}
// 确定
- (void)Action_CreateButton:(UIButton *)CreateButton
{
    if ([self.delegate respondsToSelector:@selector(ZGDDatePicker:ChooseDate:ChooseDateStr:)]) {
        [self.delegate ZGDDatePicker:_ZGD_DataPickerView ChooseDate:chooseDate ChooseDateStr:chooseDateStr];
    }
    [self removeFromSuperview];
    [_ZGD_BackGroundView removeFromSuperview];
    

}

@end
