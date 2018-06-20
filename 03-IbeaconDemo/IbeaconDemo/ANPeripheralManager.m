//
//  ANPeripheralManager.m
//  IbeaconDemo
//
//  Created by AnRu on 2017/3/7.
//  Copyright © 2017年 anru. All rights reserved.
//

#import "ANPeripheralManager.h"
#import <CoreBluetooth/CoreBluetooth.h>

///  外设名称
static NSString * const kPeripheralName = @"ibecon";

///  服务ID
static NSString * const kServiceID = @"BECF";
///  特征ID
static NSString * const kCharacteristicID = @"ABCD";

@interface ANPeripheralManager()<CBPeripheralManagerDelegate>
{
    //一个后台任务标识符
    UIBackgroundTaskIdentifier taskID;
}

@property(nonatomic,strong)CBPeripheralManager *pmgr;
@end

@implementation ANPeripheralManager

- (instancetype)init
{
    if (self = [super init])
    {
        //一、 创建外设(Apple Watch)管理者
        self.pmgr = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    }
    return self;
}
+ (ANPeripheralManager *)sharedPeripheralManager
{
    static ANPeripheralManager *_instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

#pragma mark - CBPeripheralManagerDelegate
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {//蓝牙打开了,就表明可用
        //二、设置服务和特征
        [self setupService];
    }
}

#pragma mark  - 设置服务和特征
- (void)setupService
{
    CBUUID *serviceID = [CBUUID UUIDWithString:kServiceID];
    //1.创建服务
    /**
     如果primary设置为YES,表示是主服务,与次服务对应
     */
    CBMutableService *service = [[CBMutableService alloc] initWithType:serviceID primary:YES];
    
    //2.创建特征
    /**
     如果给 characteristic 设置了  value 参数，那么这个  value 会被缓存，并且  properties 和  permissions 会自动设置为可读。如果想要 characteristic 可写，或者在其生命周期会改变它的值，那需要将  value 设置为  nil 。这样的话，就会动态的来处理  value 。
     */
    CBMutableCharacteristic *characteristic = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:kCharacteristicID] properties:CBCharacteristicPropertyRead | CBCharacteristicPropertyWrite | CBCharacteristicPropertyWriteWithoutResponse | CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsReadable | CBAttributePermissionsWriteable];
    
    //3.给服务设置特征
    [service setCharacteristics:@[characteristic]];
    
    //4.将服务添加到外设管理者中
    [self.pmgr addService:service];
}

- (void)startAdvert
{
    //1.外设的名称,显示给要连接的中心来看的名字
    NSString *peripheralName = kPeripheralName;
    
    //2.创建服务的ID
    CBUUID *serviceId = [CBUUID UUIDWithString:kServiceID];
    
    //3.属性字典
    /**
     只有  CBAdvertisementDataLocalNameKey 和  CBAdvertisementDataServiceUUIDsKey 才是 peripheral Manager 支持的。
     */
    NSDictionary *advDict = @{CBAdvertisementDataLocalNameKey:peripheralName,
                              CBAdvertisementDataServiceUUIDsKey:@[serviceId]};
    
    [self.pmgr startAdvertising:advDict];
    
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral
                                       error:(NSError *)error {
    if (error) {
        NSLog(@"Error advertising: %@", [error localizedDescription]);
    }else{
        NSLog(@"广播成功");
    }
}


@end
