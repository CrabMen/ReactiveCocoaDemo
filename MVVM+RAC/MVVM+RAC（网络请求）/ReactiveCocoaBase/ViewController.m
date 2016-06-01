//
//  ViewController.m
//  ReactiveCocoaBase
//
//  Created by CrabMan on 16/5/30.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "ViewController.h"
#import "GlobalHeader.h"
#import "RequestViewModel.h"
@interface ViewController ()

/** 请求视图模型 */
@property (nonatomic,strong) RequestViewModel *requestVM;


@end

@implementation ViewController

-(RequestViewModel *)requestVM {

    if (!_requestVM) {
        _requestVM = [[RequestViewModel alloc]init];
    }
    
    return _requestVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //url: https://api.douban.com/v2/book/search?q="美女"
    //MVVM + RAC
    
    
    //发送请求
    
  RACSignal *signal = [self.requestVM.requestCommand execute:nil];
    
    //订阅信号
    [signal subscribeNext:^(id x) {
        //x是模型数组
        NSLog(@"%@",x);
    }];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
