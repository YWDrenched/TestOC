//
//  UIButton+NormalBtn.h
//  SensorCharging
//
//  Created by cyw on 2017/5/18.
//  Copyright © 2017年 cyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (NormalBtn)

/**
 创建Btn

 @param name 名字
 @param image 图片
 @param selectImage 选中图片
 @param target target
 @param action 方法
 @param controlEvents 事件
 @return 按钮
 */
+(UIButton *)initWithNormalBtnName:(NSString *)name withBtnImage:(NSString *)image withBtnSelectImage:(NSString *)selectImage withTarget:(id)target withAction:(SEL)action withControlEvents:(UIControlEvents)controlEvents;



/**
  创建有背景图片的按钮

 @param name 名字
 @param image 图片
 @param selectImage 选中图片
 @param backImage 背景图片
 @param selectedBackImage 选中背景图
 @param target target
 @param action 方法
 @param controlEvents 事件
 @return 按钮
 @return btn
 */
+(UIButton *)cyw_normalBtnName:(NSString *)name withBtnImage:(NSString *)image withBtnSelectImage:(NSString *)selectImage wihtBackImage:(NSString *)backImage withSelectBackImage:(NSString *)selectedBackImage withTarget:(id)target withAction:(SEL)action withControlEvents:(UIControlEvents)controlEvents;

/**
 创建有背景颜色的按钮
 
 @param name 名字
 @param image 图片
 @param selectImage 选中图片
 @param bgColor 背景颜色
 @param target target
 @param action 方法
 @param controlEvents 事件
 @return 按钮
 */
+(UIButton *)cyw_normalBtnName:(NSString *)name withBtnImage:(NSString *)image withBtnSelectImage:(NSString *)selectImage wihtBackColor:(UIColor *)bgColor withTarget:(id)target withAction:(SEL)action withControlEvents:(UIControlEvents)controlEvents;


@end
