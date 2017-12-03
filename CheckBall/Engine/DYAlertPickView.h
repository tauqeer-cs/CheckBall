//
//  DYAlerPickView.h
//  DYAlertPickerViewDemo
//
//  Created by danny on 2015/7/7.
//  Copyright (c) 2015年 danny. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DYAlertPickView;

@protocol DYAlertPickViewDataSource <NSObject>
@required

//
- (NSAttributedString *)pickerview:(DYAlertPickView *)pickerView
                            titleForRow:(NSInteger)row;

- (NSInteger)numberOfRowsInPickerview:(DYAlertPickView *)pickerView;

@end

@protocol DYAlertPickViewDelegate <NSObject>
@optional


- (void)pickerview:(DYAlertPickView *)pickerView
          didConfirmWithItemAtRow:(NSInteger)row;
- (void)pickerviewDidClickCancelButton:(DYAlertPickView *)pickerView;
- (void)pickerviewDidClickSwitchButton:(UISwitch *)switchButton __attribute((deprecated("use DYAlertPickerViewDidClickSwitchButton:switchButton:")));
- (void)pickerviewDidClickSwitchButton:(DYAlertPickView *)pickerView switchButton:(UISwitch *)switchButton;
- (BOOL)pickerviewStateOfSwitchButton;

@end

@interface DYAlertPickView : UIView<UITableViewDataSource, UITableViewDelegate>

@property BOOL tapBackgroundToDismiss;

@property BOOL tapPickerViewItemToConfirm;

/*
 
 @param headerTitle
 @param cancelButtonTitle
 @param confirmButtonTitle
 @param switchButtonTitle

 */
- (id)initWithHeaderTitle:(NSString *)headerTitle
        cancelButtonTitle:(NSString *)cancelButtonTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle switchButtonTitle:(NSString *)switchButtonTitle;

@property id<DYAlertPickViewDelegate> delegate;
@property id<DYAlertPickViewDataSource> dataSource;


@property (nonatomic, strong) UIColor *headerBackgroundColor;

@property (nonatomic, strong) UIColor *headerTitleColor;

@property (nonatomic, strong) UIColor *cancelButtonBackgroundColor;

@property (nonatomic, strong) UIColor *cancelButtonNormalColor;

@property (nonatomic, strong) UIColor *cancelButtonHighlightedColor;

@property (nonatomic, strong) UIColor *confirmButtonBackgroundColor;

@property (nonatomic, strong) UIColor *confirmButtonNormalColor;

@property (nonatomic, strong) UIColor *confirmButtonHighlightedColor;

@property (nonatomic, strong) NSString *switchButtonTitle;

- (void)show;
- (void)showAndSelectedIndex:(NSInteger)index;

@end
