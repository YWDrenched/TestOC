//
//  UIButton+NormalBtn.m
//  SensorCharging
//
//  Created by cyw on 2017/5/18.
//  Copyright © 2017年 cyw. All rights reserved.
//

#import "UIButton+NormalBtn.h"

@implementation UIButton (NormalBtn)

+(UIButton *)initWithNormalBtnName:(NSString *)name withBtnImage:(NSString *)image withBtnSelectImage:(NSString *)selectImage withTarget:(id)target withAction:(SEL)action withControlEvents:(UIControlEvents)controlEvents{
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    return btn;
}

+(UIButton *)cyw_normalBtnName:(NSString *)name withBtnImage:(NSString *)image withBtnSelectImage:(NSString *)selectImage wihtBackColor:(UIColor *)bgColor withTarget:(id)target withAction:(SEL)action withControlEvents:(UIControlEvents)controlEvents{
    UIButton *btn = [UIButton initWithNormalBtnName:name
                                       withBtnImage:image
                                 withBtnSelectImage:selectImage
                                         withTarget:target
                                         withAction:action
                                  withControlEvents:controlEvents];
    btn.backgroundColor = bgColor;
    return btn;
}


+(UIButton *)cyw_normalBtnName:(NSString *)name withBtnImage:(NSString *)image withBtnSelectImage:(NSString *)selectImage wihtBackImage:(NSString *)backImage withSelectBackImage:(NSString *)selectedBackImage withTarget:(id)target withAction:(SEL)action withControlEvents:(UIControlEvents)controlEvents{
    UIButton *btn = [UIButton initWithNormalBtnName:name
                                       withBtnImage:image
                                 withBtnSelectImage:selectImage
                                         withTarget:target
                                         withAction:action
                                  withControlEvents:controlEvents];
    [btn setBackgroundImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectedBackImage] forState:UIControlStateSelected];
    return btn;
}

@end
