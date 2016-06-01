//
//  ViewController.m
//  ReactiveCocoaBase
//
//  Created by CrabMan on 16/5/30.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "ViewController.h"
#import "GlobalHeader.h"
#import "RACReturnSignal.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //flattenMap ：用于信号中的信号
    
    RACSubject *signalOfSignals = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    
    //订阅信号
//    [signalOfSignals subscribeNext:^(id x) {
//       [x subscribeNext:^(id x) {
//           NSLog(@"%@",x);
//       }];
//    }];
    
//   [ signalOfSignals flattenMap:^RACStream *(id value) {
//       //返回的是源信号发送的内容即信号
//       return value;
//   }];
    
    [[signalOfSignals flattenMap:^RACStream *(id value) {
        return value;
    }] subscribeNext:^(id x) {
    
        NSLog(@"%@",x);
    }];
    
    [signalOfSignals sendNext:signal];
    [signal sendNext:@123];
}

- (void)map {

    
    RACSubject *subject = [RACSubject subject];
    
    RACSignal *bindSignal = [subject map:^id(id value) {
        
        
        //返回值得类型就是你需要映射的值
        return [NSString stringWithFormat:@"加了字符串前缀的%@",value];
    }];
    
    [bindSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"1234"];
    


}
- (void)flattenMap {

    RACSubject *subject = [RACSubject subject];
    
    //绑定信号
    RACSignal *bindSignal = [subject flattenMap:^RACStream *(id value) {
        //返回信号，就是要包装的值
        value = [NSString stringWithFormat:@"被包装后的:%@",value];
        return [RACReturnSignal return:value];
    }];
    
    
    [bindSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    //发送数据
    [subject sendNext:@1234];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
