//
//  ANPeripheralManager.h
//  IbeaconDemo
//
//  Created by AnRu on 2017/3/7.
//  Copyright © 2017年 anru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANPeripheralManager : NSObject

+ (ANPeripheralManager *)sharedPeripheralManager;

- (void)startAdvert;

@end
