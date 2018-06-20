//
//  ScanningViewController.m
//  CXScanning
//
//  Created by artifeng on 16/1/7.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "ScanningViewController.h"
#import "Masonry.h"
#import "ControlDeviceViewController.h"
#import "NetWorkManager.h"
#import "SVProgressHUD.h"
#import <CoreLocation/CoreLocation.h>
#import "UIAlertView+BaseAlert.h"

#define Height [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width
#define XCenter self.view.center.x
#define YCenter self.view.center.y

#define SHeight 20

#define SWidth (XCenter+80)


@interface ScanningViewController ()<CLLocationManagerDelegate>
{
    UIImageView * imageView;
    UIView *bottomView;
    BOOL isWrite;//用来判断手是否点击过手动输入

    //    用户ID
    NSString *_userID;
    //    密码
    NSString *_password;
    //    _authToken
    NSString *_authToken;
    
    NSString *_userName;
    
}
@property (nonatomic,strong)CLLocationManager *locationManager;
//   维度
@property (nonatomic,strong) NSString *latitude;
//    经度
@property (nonatomic,strong) NSString *longitude;

//@property ()


@end

@implementation ScanningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    [self getUserInfo];
    
    self.title = @"扫码充电";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(51, 51, 51)}];
    
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake((Width-SWidth)/2,(Height-SWidth)/2,SWidth,SWidth)];
    imageView.image = [UIImage imageNamed:@"scanscanBg.png"];
    [self.view addSubview:imageView];
    [self creatBottomView];
    
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self getLocation];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(imageView.frame)+5, CGRectGetMinY(imageView.frame)+5, SWidth-10,1)];
    _line.image = [UIImage imageNamed:@"线@3x"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
   
}

-(void)creatBottomView{
    
    
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn setImage:[UIImage imageNamed:@"Path"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 25, 25);
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.8;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(kScreenWidth);
    }];
    
//    UIButton *writeBtn = [[UIButton alloc ]init];
//    [writeBtn addTarget:self action:@selector(writeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [writeBtn setImage:[UIImage imageNamed:@"手指上"] forState:UIControlStateNormal];
//    [bottomView addSubview:writeBtn];
//    [writeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(bottomView).offset(10);
//        make.left.mas_equalTo(bottomView).offset(80);
//        make.size.mas_equalTo(CGSizeMake(60, 60));
//    }];
    
//    UILabel *writeLabel = [[UILabel alloc] init];
//    writeLabel.text = @"手动输入设备名称";
//    writeLabel.textColor = [UIColor whiteColor];
//    writeLabel.font = [UIFont systemFontOfSize:15];
//    [bottomView addSubview:writeLabel];
//    [writeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(writeBtn.mas_bottom).offset(0);
//        make.centerX.mas_equalTo(writeBtn);
//    }];
    
    UIButton *lightBtn = [[UIButton alloc ]init];
    [lightBtn setImage:[UIImage imageNamed:@"手电关@3x"] forState:UIControlStateNormal];
    [lightBtn setImage:[UIImage imageNamed:@"手电开@3x"] forState:UIControlStateSelected];
    [bottomView addSubview:lightBtn];
    [lightBtn addTarget:self action:@selector(lightBtnClick:) forControlEvents:UIControlEventTouchDown];
    [lightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(-55);
//        make.right.mas_equalTo(self.view).offset(-181);
//        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerX.mas_equalTo(self.view);
    }];
    
//    UILabel *lightLabel = [[UILabel alloc] init];
//    lightLabel.text = @"手电筒";
//    lightLabel.textColor = [UIColor whiteColor];
//    lightLabel.font = [UIFont systemFontOfSize:15];
//    [bottomView addSubview:lightLabel];
//    [lightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(lightBtn.mas_bottom).offset(0);
//        make.centerX.mas_equalTo(lightBtn);
//    }];
    
    
}

-(void)getLocation{
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    }
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"允许\"定位\"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ok =[UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        /*打开定位设置*/
        NSURL * settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication]openURL:settingsURL];
    }];
    UIAlertAction * cacel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:ok];
    [alert addAction:cacel];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation * currentLocation = [locations lastObject];
//    CLGeocoder * geoCoder = [[CLGeocoder alloc]init];
    /*打印当前经纬度*/
    self.longitude = [NSString stringWithFormat:@"%lf",currentLocation.coordinate.longitude];
    self.latitude = [NSString stringWithFormat:@"%lf",currentLocation.coordinate.latitude];
    NSLog(@"%@ ---  %@",self.latitude,self.longitude);
    if (self.longitude != nil && self.latitude != nil) {
        [self.locationManager stopUpdatingLocation];
    }
    
    
}


-(void)lightBtnClick:(UIButton *)sender{
    AVCaptureDevice *captureD = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    
    if (!sender.selected) {
        sender.selected = YES;
        if ([captureD hasTorch]) {
                [captureD lockForConfiguration:nil];
                [captureD setTorchMode:AVCaptureTorchModeOn];
                [captureD unlockForConfiguration];
        }
    }else{
        sender.selected = NO;
        if ([captureD hasTorch]) {
            [captureD lockForConfiguration:nil];
            [captureD setTorchMode:AVCaptureTorchModeOff];
            [captureD unlockForConfiguration];
        }
    }
    
}

-(void) backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)writeBtnClick:(UIButton *)sender{
//
//    WriteDeviceViewController *writeDeviceVC = [[WriteDeviceViewController alloc] init];
//
//    [self.navigationController pushViewController:writeDeviceVC animated:YES];
    isWrite = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    if (!isWrite) {
        
        
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
            //无权限 做一个友好的提示
//            self.view.backgroundColor = RGBA(0, 0, 0, 0.6);
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置中打开相机权限" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * ok =[UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                /*打开定位设置*/
                NSURL * settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication]openURL:settingsURL];
            }];
            UIAlertAction * cacel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:ok];
            [alert addAction:cacel];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            //调用相机的代码写在这里
            [self setupCamera];
        }
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.session stopRunning];
    [self.preview removeFromSuperlayer];
//    [self.viewTop removeFromSuperview];
//    [self.viewBottom removeFromSuperview];
//    [self.viewRight removeFromSuperview];
//    [self.viewLeft removeFromSuperview];
    if (timer != nil) {
        [timer invalidate];
        timer = nil;
        
    }
    [SVProgressHUD dismiss];
}
-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(CGRectGetMinX(imageView.frame)+5, CGRectGetMinY(imageView.frame)+5+2*num, SWidth-10,1);
       
        if (num ==(int)(( SWidth-10)/2)) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame =CGRectMake(CGRectGetMinX(imageView.frame)+5, CGRectGetMinY(imageView.frame)+5+2*num, SWidth-10,1);
        
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}


- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    _output.rectOfInterest =[self rectOfInterestByScanViewRect:imageView.frame];//CGRectMake(0.1, 0, 0.9, 1);//
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode];
    

    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResize;
    _preview.frame =self.view.bounds;
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    [self.view bringSubviewToFront:imageView];

    [self setOverView];
    
    // Start
    [_session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        /**
         *  获取扫描结果
         */
        stringValue = metadataObject.stringValue;
    }
    //通知传值
    NSString *infor = stringValue;
    NSLog(@"二维码信息 ==== %@",infor);
    NSRange range = [stringValue rangeOfString:@"?"];
    NSLog(@"%zd",range.location);
    __weak typeof(self)weakSelf = self;
    if (range.location == 25) {
        NSString *codeInfor = [stringValue substringFromIndex:range.location + 1];
        NSLog(@"截取 === %@",codeInfor);
        //    http://test01.sensor668.com:9080 / DeviceService /Device/findDevice
        //   设备查询接口
        if(codeInfor.length == 26 && codeInfor != nil){
            NSString *macAddress = [codeInfor substringWithRange:NSMakeRange(0, 17)];
            NSString *deviceNum = [codeInfor substringWithRange:NSMakeRange(18, 8)];
            NSLog(@"macAddress ==== %@ deviceNum ===== %@",macAddress,deviceNum);
            if (deviceNum != nil && macAddress != nil && (macAddress.length == 17 || deviceNum.length == 8)) {
                [_session stopRunning];
                //            发送地理位置信息
                NSString *locationUrl = [NSString stringWithFormat:@"%@DeviceService/Device/collectionAddress",urlString3];
                NSLog(@"%@ ---  %@",_userID,macAddress);
                if (self.longitude != nil && self.latitude != nil) {
                    
                    NSDictionary *locationDict = @{@"userId":_userID,
                                                   @"macAddress":[macAddress stringByReplacingOccurrencesOfString:@":" withString:@""],
                                                   @"longitude":self.longitude,
                                                   @"latitude":self.latitude,
                                                   @"collectionType":@"ios"};
                    
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        
                        [[NetWorkManager sharedManager] postMethodWithUrl:locationUrl Parameter:locationDict SuccessBlock:^(id resultBlock) {
                            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                                NSLog(@"地址接口%@",resultBlock);
                            });
                        } FailBlock:^(NSString *error) {
                            NSLog(@"%@",error);
                        }];
                    });
                }
                NSString *url = [NSString stringWithFormat:@"%@DeviceService/Device/findDevice",urlString3];
                NSDictionary *dict = @{@"macAddress":[self rangeOfMacAddress:macAddress]};
                NSLog(@"%@",dict);
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                    [SVProgressHUD show];
                    [[NetWorkManager sharedManager] postMethodWithUrl:url Parameter:dict SuccessBlock:^(id resultBlock) {
                        NSLog(@"%@",resultBlock);
                        [SVProgressHUD dismiss];
                        if ([resultBlock[@"returnCode"] isEqualToString:@"0000"]) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                NSDictionary *successDict = [resultBlock[@"retnrnJson"] firstObject];
                                ControlDeviceViewController *conVC = [[ControlDeviceViewController alloc] init];
                                conVC.codeString = codeInfor;
                                conVC.status = successDict[@"status"];
                                conVC.deviceNum = deviceNum;
                                conVC.deviceID = successDict[@"id"];
                                conVC.primaryAddress = successDict[@"primaryAddress"];
                                conVC.rate = successDict[@"rate"];
                                conVC.deviceType = successDict[@"deviceName"];
                                if ([deviceNum isEqualToString: successDict[@"deviceName"]]) {
                                    [weakSelf.navigationController pushViewController:conVC animated:YES];
                                }else{
                                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"该设备未入库，请联系客服" preferredStyle:UIAlertControllerStyleAlert];
                                    UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                        [weakSelf.navigationController popViewControllerAnimated:YES];
                                    }];
                                    [alertVC addAction:ac1];
                                    [weakSelf presentViewController:alertVC animated:YES completion:nil];
                                }
                            }); 
                        }else{
                            [SVProgressHUD showErrorWithStatus:resultBlock[@"returnMsg"]];
                        }
                    } FailBlock:^(NSString *error) {
                        [SVProgressHUD showErrorWithStatus:@"网络连接不可用"];
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                });
            }else{
                [SVProgressHUD showErrorWithStatus:@"二维码有误"];
                [SVProgressHUD dismissWithDelay:1.5];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"二维码有误"];
            [SVProgressHUD dismissWithDelay:1.5];
        }
    }else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"扫码失败，请重试" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        [alertVC addAction:ac1];
        [weakSelf presentViewController:alertVC animated:YES completion:nil];
    }
    [_session stopRunning];
}
-(NSString *)rangeOfMacAddress:(NSString *)macString{
    NSString * mac1 = [macString substringWithRange:NSMakeRange(0, 2)];
    
    NSString * mac2 = [macString substringWithRange:NSMakeRange(3, 2)];
    
    NSString * mac3 = [macString substringWithRange:NSMakeRange(6, 2)];
    
    NSString * mac4 = [macString substringWithRange:NSMakeRange(9, 2)];
    
    NSString * mac5 = [macString substringWithRange:NSMakeRange(12, 2)];
    
    NSString * mac6 = [macString substringWithRange:NSMakeRange(15, 2)];
    
    return [NSString stringWithFormat:@"%@%@%@%@%@%@",mac1,mac2,mac3,mac4,mac5,mac6];
}

- (CGRect)rectOfInterestByScanViewRect:(CGRect)rect {
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    CGFloat x = (height - CGRectGetHeight(rect)) / 2 / height;
    CGFloat y = (width - CGRectGetWidth(rect)) / 2 / width;
    
    CGFloat w = CGRectGetHeight(rect) / height;
    CGFloat h = CGRectGetWidth(rect) / width;
   
    return CGRectMake(x, y, w, h);
}

#pragma mark - 添加模糊效果
- (void)setOverView {
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    CGFloat x = CGRectGetMinX(imageView.frame);
    CGFloat y = CGRectGetMinY(imageView.frame);
    CGFloat w = CGRectGetWidth(imageView.frame);
    CGFloat h = CGRectGetHeight(imageView.frame);
    
    [self creatView:CGRectMake(0, 0, width, y)];
    [self creatView:CGRectMake(0, y, x, h)];
    [self creatView:CGRectMake(0, y + h, width, height - y - h)];
    [self creatView:CGRectMake(x + w, y, width - x - w, h)];
}

- (void)creatView:(CGRect)rect {
    CGFloat alpha = 0.6;
    UIColor *backColor = [UIColor blackColor];
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = backColor;
    view.alpha = alpha;
    [self.view addSubview:view];
    [self.view sendSubviewToBack:view];
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-290)/2,100, 290, 50)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"将条码二维码放入框中就能自动扫描";
    [self.view insertSubview:view belowSubview:bottomView];
}



- (void)_delayPop {

    [self.navigationController popViewControllerAnimated:YES];
}
-(void) getUserInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    _authToken = [userDefaults valueForKey:@"authToken"];
    
    _userID = [userDefaults valueForKey:@"userID"];
    
    _password = [userDefaults valueForKey:@"password"];
    
    _userName = [userDefaults valueForKey:@"userName"];
    
 
}

-(void)dealloc{
    NSLog(@"二维码 死了");
}

@end
