//
//  ViewController.m
//  image的性能优化
//
//  Created by 陈友文 on 2017/10/31.
//  Copyright © 2017年 陈友文. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Extenion.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect rect = CGRectMake(0, 0, 160, 160);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    UIImage *image =  [UIImage imageNamed:@"timg.jpg"];
    imageView.layer.cornerRadius = 80;
    imageView.clipsToBounds = YES;
    
    imageView.image = image;
    
    
    
}

/**
 对image切圆角

 @param image image
 @param rect rect
 @param bgColor 背景颜色
 @return 返回后的image
 */
//-(UIImage *)avatarImage:(UIImage *)image withRect:(CGRect)rect withBackColor:(UIColor *)bgColor{
//    
//    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0);
//    
//    [bgColor setFill];
//    UIRectFill(rect);
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
//    
//}



@end
