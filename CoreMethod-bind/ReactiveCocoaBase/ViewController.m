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
}

//截获发送的数据并处理
-(void)bind {

    //1.创建信号
    RACSubject *subject = [RACSubject subject];
    
    
    
    //2.绑定信号返回一个绑定的信号
    RACSignal *bindSignal = [subject bind:^RACStreamBindBlock{
        return ^RACSignal *(id value, BOOL *stop) {
            
            //value：接受到信号的内容
            NSLog(@"接受到信号的内容:%@",value);
            
            //返回信号，不能传nil
            //return [[RACSignal alloc]init];
            // return [RACSignal empty];
            //专门的返回信号
            value = [NSString stringWithFormat:@"被处理后的:%@",value];
            return [RACReturnSignal return:value];
        };
        
    }];
    
    //3.订阅绑定信号
    [bindSignal subscribeNext:^(id x) {
        NSLog(@"接受到绑定信号处理完的信号%@",x);
    }];
    
    //4。发送数据
    [subject sendNext:@"111"];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
