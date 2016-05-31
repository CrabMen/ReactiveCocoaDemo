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
// rac_liftSeletor:withSignalsFromArray:Singals ;当传入的signa（或者是信号数组），每个signal都至少sendNext过一次，就会去出发第一个selector参数的方法
    //使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据
    //使用场景：当一个界面有多次请求（热销模块和最新模块）的时候，需要保证全部都请求完成，才搭建界面
   
    RACSignal *hotSaleSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       //AFN请求数据
        NSLog(@"热销模块请求数据");
        [subscriber sendNext:@"热销模块的数据"];
        return nil;
    }];
    
    
    RACSignal *newSaleSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //AFN请求数据
        NSLog(@"新款模块请求数据");
        [subscriber sendNext:@"新款模块的数据"];
        return nil;
    }];
    
    //方法的参数必须跟数组的信号一一对应
    [self rac_liftSelector:@selector(updateUIWithHotData:andNewData:) withSignalsFromArray:@[hotSaleSignal,newSaleSignal]];
}
- (void)updateUIWithHotData:(NSString *)hotData andNewData:(NSString *)newData{
//分别拿到请求的数据（一一对应） 更新界面
    NSLog(@"更新UI:%@,%@",hotData,newData);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
