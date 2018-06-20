//
//  UIImage+Extenion.h
//  image的性能优化
//
//  Created by 陈友文 on 2017/10/31.
//  Copyright © 2017年 陈友文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extenion)
/**
 image切圆角

 @param image image
 @param rect rect
 @param bgColor 背景颜色
 @return 返回的Image
 */
+(UIImage *)cyw_avatarImage:(UIImage *)image withRect:(CGRect)rect withBackColor:(UIColor *)bgColor;

@end
