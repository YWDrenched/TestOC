//
//  ViewController.m
//  01-GCD理解
//
//  Created by cyw on 16/12/24.
//  Copyright © 2016年 cyw. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self test01];
//    [self test02];
//    [self test03];
//    [self test04];
//    [self test05];
//    [self test06];
//    [self test07];
//    [self test08];
    [self test09];
    
}

// 同步 并发
//2018-06-20 09:24:05.567975+0800 01-GCD理解[15241:1650445]  任务1--- <NSThread: 0x2831befc0>{number = 1, name = main}
//2018-06-20 09:24:07.569549+0800 01-GCD理解[15241:1650445]  任务2--- <NSThread: 0x2831befc0>{number = 1, name = main}
//2018-06-20 09:24:09.571260+0800 01-GCD理解[15241:1650445]  任务3--- <NSThread: 0x2831befc0>{number = 1, name = main}
//不会开启线程，在当前线程完成,按顺序执行
-(void)test01{
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSLog(@" 任务1--- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    });
    
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSLog(@" 任务2--- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    });
    
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSLog(@" 任务3--- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    });
}

//同步 串行
//2018-06-20 09:29:47.264987+0800 01-GCD理解[15250:1651924]  任务1--- <NSThread: 0x281573440>{number = 1, name = main}
//2018-06-20 09:29:49.266107+0800 01-GCD理解[15250:1651924]  任务2--- <NSThread: 0x281573440>{number = 1, name = main}
//2018-06-20 09:29:51.267472+0800 01-GCD理解[15250:1651924]  任务3--- <NSThread: 0x281573440>{number = 1, name = main}
//不会开启线程，在当前线程完成,按顺序执行
-(void)test02{
    dispatch_queue_t t = dispatch_queue_create("串行", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(t, ^{
        NSLog(@" 任务1--- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    });
    
    dispatch_sync(t, ^{
        NSLog(@" 任务2--- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    });
    
    dispatch_sync(t, ^{
        NSLog(@" 任务3--- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    });
}


//异步 并发
//018-06-20 09:34:13.839306+0800 01-GCD理解[15255:1652981]  任务1--- <NSThread: 0x283470a00>{number = 3, name = (null)}
//2018-06-20 09:34:13.839306+0800 01-GCD理解[15255:1652980]  任务2--- <NSThread: 0x283475bc0>{number = 4, name = (null)}
//2018-06-20 09:34:13.839660+0800 01-GCD理解[15255:1652983]  任务3--- <NSThread: 0x283475fc0>{number = 5, name = (null)}
//会开启新线程，不会按顺序执行
-(void)test03{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@" 任务1--- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@" 任务2--- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@" 任务3--- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    });
}

//异步 串行
//2018-06-20 09:43:46.016412+0800 01-GCD理解[15268:1655388]  任务1--- <NSThread: 0x283240580>{number = 3, name = (null)}
//2018-06-20 09:43:48.021712+0800 01-GCD理解[15268:1655388]  任务2--- <NSThread: 0x283240580>{number = 3, name = (null)}
//2018-06-20 09:43:50.023068+0800 01-GCD理解[15268:1655388]  任务3--- <NSThread: 0x283240580>{number = 3, name = (null)}
// 会开启新线程，任务按顺序执行
-(void)test04{
    dispatch_queue_t t = dispatch_queue_create("串行", DISPATCH_QUEUE_SERIAL);
    dispatch_async(t, ^{
        NSLog(@" 任务1--- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    });
    
    dispatch_async(t, ^{
        NSLog(@" 任务2--- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    });
    
    dispatch_async(t, ^{
        NSLog(@" 任务3--- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    });
}

//主队列 同步 会锁死
// test05因为是在主队列中，并且是同步执行，会等待队列中的任务执行完毕，而又把任务1添加到了主队列中，任务1又在等待test05执行完。所以在相互等待对方完成任务，所以就锁死了
-(void)test05{
    
    NSLog(@"当前线程 --- %@",[NSThread currentThread]);
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"任务1 --- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    });
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"任务2 --- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    });
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"任务3 --- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    });
}


// 主队列 异步
// 会按顺序在主线程中执行，虽然是异步有开线程的能力，但是因为在主队列，所以就会在主线程中按顺序执行
-(void)test06{
    NSLog(@"当前线程 --- %@",[NSThread currentThread]);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"任务1 --- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"任务2 --- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"任务3 --- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    });
}

//GCD栏栅:需要将两个异步任务连接在一起，比如开启一个异步并发从获取服务器一个ID，然后拿这个ID再去获取一个list
//2018-06-20 10:42:28.734118+0800 01-GCD理解[15324:1666227] 当前线程 --- <NSThread: 0x283c0ee40>{number = 1, name = main}
//2018-06-20 10:42:28.734288+0800 01-GCD理解[15324:1666243] 任务1 --- <NSThread: 0x283c5f0c0>{number = 3, name = (null)}
//2018-06-20 10:42:28.734367+0800 01-GCD理解[15324:1666242] 任务2 --- <NSThread: 0x283c5d800>{number = 4, name = (null)}
//2018-06-20 10:42:28.734454+0800 01-GCD理解[15324:1666245] 任务3 --- <NSThread: 0x283c5f280>{number = 5, name = (null)}
//2018-06-20 10:42:28.734817+0800 01-GCD理解[15324:1666244] 任务4 --- <NSThread: 0x283c0b800>{number = 6, name = (null)}
//2018-06-20 10:42:28.734912+0800 01-GCD理解[15324:1666248] 任务5 --- <NSThread: 0x283c5f300>{number = 7, name = (null)}
// 会执行完任务1，任务2之后才会去执行任务3，4，5


-(void)test07{
    NSLog(@"当前线程 --- %@",[NSThread currentThread]);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务1 --- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务2 --- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    });
    
    dispatch_barrier_async(dispatch_get_global_queue(0, 0), ^{
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"任务3 --- %@",[NSThread currentThread]);
            [NSThread sleepForTimeInterval:2.0];
        });
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"任务4 --- %@",[NSThread currentThread]);
            [NSThread sleepForTimeInterval:2.0];
        });
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"任务5 --- %@",[NSThread currentThread]);
            [NSThread sleepForTimeInterval:2.0];
        });
    });
}

// GCD遍历  会在不同的线程去遍历 可以快速的迭代 但是end一定是最后输出的
-(void)test08{
    dispatch_apply(7, dispatch_get_global_queue(0, 0), ^(size_t index) {
        NSLog(@"%zu ----- %@",index,[NSThread currentThread]);
    });
    NSLog(@"end");
}


//GCD group 分别异步执行2个耗时任务，然后当2个耗时任务都执行完毕后再回到主线程执行任务。这时候我们可以用到 GCD 的队列组。
//          会等待任务1，任务2执行完毕之后，在执行任务4
-(void) test09{
    dispatch_group_t gruop = dispatch_group_create();
    
    dispatch_group_async(gruop, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务1 --- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
        NSLog(@"任务1完成");
        
//        NSLog(@"任务2 --- %@",[NSThread currentThread]);
//        [NSThread sleepForTimeInterval:2.0];
    });
    
    dispatch_group_async(gruop, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务3 --- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
        NSLog(@"任务3完成");
        
    });
    
    dispatch_group_notify(gruop, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务4 ---%@",[NSThread currentThread]);
    });

    
    
}


@end
