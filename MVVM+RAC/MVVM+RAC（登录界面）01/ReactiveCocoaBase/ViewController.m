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
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UIButton *logBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //将两个信号合并并聚合
  RACSignal *combineSignal = [RACSignal combineLatest:@[_accountTextField.rac_textSignal,_passWordTextField.rac_textSignal] reduce:^id(NSString *account,NSString *passWord){
       
        
        return @(account.length && passWord.length);
    }];
    
    //设置按钮能否点击
    RAC(_logBtn,enabled) = combineSignal;
    
    
    //创建登录命令
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
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
    
    
    //获取命令中的信号源
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    
    [[command.executing skip:1] subscribeNext:^(id x) {
        if ([x boolValue]) {
            //正在执行
            NSLog(@"蒙版出现");
        } else {
            //没有执行（跳过）或者执行完成
        //需要跳过没有执行，以及手动设置执行完成
            NSLog(@"蒙版消失");
        
        }
    }];
    
    
    //监听登录按钮的点击
    [[_logBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
     
        
         NSLog(@"点击登录按钮");
        //处理登录事件
        
        [command execute:nil];
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
