//
//  ViewController.m
//  ReactiveCocoaBase
//
//  Created by CrabMan on 16/5/30.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "ViewController.h"
#import "GlobalHeader.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//RACMulticastConnection:用于当一个信号被多次订阅时，为了保证创建信号时，避免多次调用信号的block，造成副作用，可以用这个类来处理
    /*
     每次订阅不要都请求，只想请求一次，每次订阅只拿到数据
     RACMulticastConnection ：必须有信号
     
     */
    
    
    //底层原理本质
    RACSubject *subject = [RACSubject subject];
    //订阅
    
    [subject subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@1];
    
    
}

- (void)connection {

    
    
    //1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //didSubscribe 连接类连接的时候执行
        NSLog(@"发送网络请求");
        [subscriber sendNext:@"热门模块的数据"];
        return nil;
    }];
    
    //2.把信号转化为连接类
    //确定源信号的订阅者为RACSubject,(保存两个属性dynamicSignal和subject)
    //    RACMulticastConnection *connection = [signal publish];
    
    RACMulticastConnection *connection = [signal multicast:[RACReplaySubject subject]];
    
    //3.订阅连接类信号
    //使用RACSubject保存订阅者
    [connection.signal subscribeNext:^(id x) {
        //nextBlock：发送数据就会来
        NSLog(@"订阅者一：%@",x);
    }];
    
    [connection.signal subscribeNext:^(id x) {
        NSLog(@"订阅者二：%@",x);
    }];
    
    [connection.signal subscribeNext:^(id x) {
        NSLog(@"订阅者三：%@",x);
    }];
    
    
    //4.连接
    //底层在使用源信号订阅RACSubject信号，将源信号的订阅者设置为RACSubject，订阅执行源信号didSubscribeBlock（里面subscribe是RACSubject类型，遍历，每次发送数据）
    [connection connect];
    


}
- (void)requestBug {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送热门模块的请求");
        [subscriber sendNext:@1];
        return nil;
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"订阅者一%@",x);
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"订阅者二%@",x);
    }];
    //多次订阅，每次都会重新发送网络请求

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
