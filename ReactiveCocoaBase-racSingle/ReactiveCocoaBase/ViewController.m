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

    
    /*RACSignal：有数据产生的时候就使用，使用步骤
    1.创建信号     2.订阅信号     3.发送信号
     
     */
    
    //1.创建信号（冷信号）
   RACSignal *singal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       //didSubscribe调用：只要一个信号被订阅就会调用
       //didSubscribe作用：发送数据 
       //3.发送数据
       [subscriber sendNext:@(10)];
       return nil;
   }];
    
    //2.订阅信号（热信号）
    [singal subscribeNext:^(id x) {
        //nextBlock调用：只要订阅者发送数据就会调用
        //nextBlock作用：处理数据 ，展示到UI上面 
        
        
       //x:信号发送内容
        NSLog(@"%@",x);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
