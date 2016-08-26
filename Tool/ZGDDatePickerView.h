//
//  ZGDDatePickerView.h
//  ZGDDatePicker-Tool
//
//  Created by 赵国栋 on 16/8/24.
//  Copyright © 2016年 赵国栋. All rights reserved.
//  https://github.com/guodongZhao/ZGDDatePicker-Tool.git

#import <UIKit/UIKit.h>

@protocol ZGDDatePickerDelegate <NSObject>

@required
- (void)ZGDDatePicker:(UIDatePicker *)pickerView ChooseDate:(NSDate *)chooseDate ChooseDateStr:(NSString *)chooseDateStr;

@end

@interface ZGDDatePickerView : UIView

@property (nonatomic, weak) id<ZGDDatePickerDelegate> delegate;

/**
 *  ZGDDatePickerView
 *
 *  @param defultDate  默认时间
 *  @param minimumDate 最小时间
 *  @param maximumDate 最大时间
 *  @param backGroundImage 背景图片
 *
 *  @return nil
 */
- (instancetype)initWithDefultDate:(NSDate *)defultDate MinimumDate:(NSDate *)minimumDate MaximumDate:(NSDate *)maximumDate AndBackGroundImage:(UIImage *)backGroundImage AndUIDatePickerMode:(UIDatePickerMode)datePickerMode;
@end
