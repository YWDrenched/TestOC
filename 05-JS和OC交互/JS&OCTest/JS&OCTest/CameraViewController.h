//
//  CameraViewController.h
//  JS&OCTest
//
//  Created by 陈友文 on 2018/1/29.
//  Copyright © 2018年 陈友文. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^successBlcok)(NSString* result);

@interface CameraViewController : UIViewController

@property (nonatomic,copy)successBlcok block;

@end
