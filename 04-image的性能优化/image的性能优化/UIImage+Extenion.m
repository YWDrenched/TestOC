//
//  UIImage+Extenion.m
//  image的性能优化
//
//  Created by 陈友文 on 2017/10/31.
//  Copyright © 2017年 陈友文. All rights reserved.
//

#import "UIImage+Extenion.h"

@implementation UIImage (Extenion)

+(UIImage *)cyw_avatarImage:(UIImage *)image withRect:(CGRect)rect withBackColor:(UIColor *)bgColor{
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0);
    
    
    //背景填充颜色
    [bgColor setFill];
    UIRectFill(rect);
    //圆角
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [path addClip];
    
 
    //绘制
    [image drawInRect:rect];
    //获取图形上下文
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return resultImage;
    
//    
//    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0);
//    
//    [bgColor setFill];
//    UIRectFill(rect);
//    
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
//    [path addClip];
//    
//    
//    
//    [image drawInRect:rect];
//    
//    UIImage *result =  UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return result;
}

@end
