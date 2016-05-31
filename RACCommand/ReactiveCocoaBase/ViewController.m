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
    
    //switchToLatest属性讲解
    RACSubject *signalOfSignal = [RACSubject subject];
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    
//    [signalOfSignal subscribeNext:^(id x) {
//        [x subscribeNext:^(id x) {
//            NSLog(@"信号中的信号的内容%@",x);
//        }];
//        NSLog(@"信号：%@",x);
//    }];
    
    //switchToLatest获取信号中的信号发送的最新的信号
//    [signalOfSignal.switchToLatest subscribeNext:^(id x) {
//        NSLog(@"信号中的信号的内容");
//    }];
//    
//    [signalOfSignal sendNext:signalA];
//    [signalA sendNext:@"A"];
//    [signalB sendNext:@"B"];
    
    
    
    [self executionSignal];
 
}


-(void)executionSignal {

    
    //注意：当前命令发送数据完成，一定要主动发送完成
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        //input：执行命令传入参数
        //block调用：执行命令的时候就会调用
        
        NSLog(@"可以理解为发送网络请求的参数：%@",input);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            //在这个地方将参数做处理，比如发送网络请求
            [subscriber sendNext:@"执行命令后返回的数据"];
            
            //发送命令完成
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    
    //订阅信号
    //订阅信号方式二：信号源，信号中的信号，必须是在执行命令之前订阅，发送的数据就是信号
    //    [command.executionSignals subscribeNext:^(id x) {
    //
    //        [x subscribeNext:^(id x) {
    //            NSLog(@"%@",x);
    //        }];
    //
    //        NSLog(@"%@",x);
    //    }];
    //
    
    //
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    
    //监听事件是否完成
    [command.executing subscribeNext:^(id x) {
        if ([x boolValue]) {
            NSLog(@"当前命令正在执行");
        } else {
        
            NSLog(@"执行完成或者是没有执行");
        
        }
    }];
    
    //2.执行命令
    [command execute:@1];


}

- (void)command {
    //RACCommand：处理事件;不能返回空信号
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        //input：执行命令传入参数
        //block调用：执行命令的时候就会调用
        
        NSLog(@"%@",input);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"执行命令产生的数据"];
            
            return nil;
        }];
    }];
    
    
    
    
    //2.执行命令
    RACSignal *signal = [command execute:@1];
    
    //如何拿到执行命令中产生的数据 ，即订阅命令中的信号
    //1.方式一:直接订阅执行命令返回的信号
    [signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
