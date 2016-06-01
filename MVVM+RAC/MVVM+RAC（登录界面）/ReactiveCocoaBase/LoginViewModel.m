//
//  LoginViewModel.m
//  ReactiveCocoaBase
//
//  Created by CrabMan on 16/6/1.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

-(instancetype)init {

    if (self = [super init]) {
        [self setUp ];
    }
    return self;
}

- (void)setUp {

    //处理文本框逻辑登录逻辑，需要拿到textField，
    //1.处理登录点击信号
    _loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self,account),RACObserve(self,passWord)] reduce:^id(NSString *account,NSString *passWord){
        

        return @(account.length && passWord.length);
   }];
    
    //2.处理登录点击命令
    _loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
        NSLog(@"发送登录请求");
        //发送数据
        //block:事件的处理,发送登录请求
        
        
        
        
        
        //执行命令就会调用
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            //模拟网络请求延迟
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                
                [subscriber sendNext:@"请求登录的返回数据"];
                //执行完成
                [subscriber sendCompleted];
                
            });
            
            
            return nil;
        }];
        
    }];
    
    //3.处理登录请求返回的结果
    
    //获取命令中的信号源
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    //4.处理登录请求的执行过程
    [[_loginCommand.executing skip:1] subscribeNext:^(id x) {
        if ([x boolValue]) {
            //正在执行
            NSLog(@"蒙版出现");
        } else {
            //没有执行（跳过）或者执行完成
            //需要跳过没有执行，以及手动设置执行完成
            NSLog(@"蒙版消失");
            
        }
    }];



}


@end
