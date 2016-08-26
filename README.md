# ZGDDatePicker-Tool
====================
# 自定义风格的iOS时间选择器，美化页面使你的app更加高端大气上档次！ 
----------------------
## Show
![](https://github.com/guodongZhao/ZGDDatePicker-Tool/raw/master/testShow.gif)
## `Use`
### 使用的正确姿势-- :
  导入头文件 `ZGDDatePickerView.h`
  初始化`ZGDDatePickerView`  例如: （注意：除DatePickerMode风格外 其他可传空）
  ```objc
  ZGDDatePickerView *datePicker = [[ZGDDatePickerView alloc] initWithDefultDate:nil MinimumDate:nil MaximumDate:nil AndBackGroundImage:nil AndUIDatePickerMode:UIDatePickerModeDate];
  datePicker.delegate = self;  // 遵循代理
  ```


### `Method`
  `初始化`
```objc
/**
 *  ZGDDatePickerView  初始化
 *
 *  @param defultDate  默认时间
 *  @param minimumDate 最小时间
 *  @param maximumDate 最大时间
 *  @param backGroundImage 背景图片
 *
 *  @return nil
 */
- (instancetype)initWithDefultDate:(NSDate *)defultDate MinimumDate:(NSDate *)minimumDate MaximumDate:(NSDate *)maximumDate AndBackGroundImage:(UIImage *)backGroundImage AndUIDatePickerMode:(UIDatePickerMode)datePickerMode;
```
#### `Delegate`
 `代理回调`
```objc
/**
 *  代理回调
 *
 *  @param pickerView    UIDatePicker
 *  @param chooseDate    选中的时间NSDate格式
 *  @param chooseDateStr 选中的时间字符串格式
 */
- (void)ZGDDatePicker:(UIDatePicker *)pickerView ChooseDate:(NSDate *)chooseDate ChooseDateStr:(NSString *)chooseDateStr;
```
