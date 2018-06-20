//
//  UIBarButtonItem+left.m
//  01-抽屉控制器
//
//  Created by cyw on 2017/2/7.
//  Copyright © 2017年 cyw. All rights reserved.
//

#import "UIBarButtonItem+left.h"

@implementation UIBarButtonItem (left)

+(UIBarButtonItem *)initWithTarget:(id)taget action:(SEL)action image:(NSString *)image hightImage:(NSString *)hightImage{
    UIButton *button  = [[UIButton alloc] init];
    button.bounds = CGRectMake(0, 0, 30, 30);
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
    [button addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
