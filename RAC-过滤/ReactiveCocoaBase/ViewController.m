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
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //skip:跳跃几个值订阅，服务器返回前几个数据没有用
   //1.创建信号
    RACSubject *subject = [RACSubject subject];
    
    [[subject skip:1]subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    
    [subject sendNext:@"1"];
    [subject sendNext:@"12"];
    [subject sendNext:@"123"];
    
}
- (void)distinctUntilChanged {

    //distinctUnitChanged：r如果当前的值跟上一个值相同，相同的值只会订阅一次
    //创建信号
    RACSubject *subject = [RACSubject subject];
    
    [[subject distinctUntilChanged]subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"1"];
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    
}
- (void)takeAndTakeLast{

    
    //take:从开始一共取N次的信号,去前面的几个值
    //takeLast:去后面多少个值,必须发送完成才能有效果
    //takeUntil：只要传入的信号发送完成，就不会接受源信号内容
    
    RACSubject *subject = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    
//    [[subject take:1]subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
    
    
//    [[subject takeLast:1]subscribeNext:^(id x) {
//        NSLog(@"从最后的取：%@",x);
//    }];
    [[subject takeUntil:signal]subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@1];
    
    
    [signal sendNext:@"signal"];
    
    [subject sendNext:@12];
    
    [subject sendCompleted];
    
    
    [subject sendNext:@123];

    
}
- (void)ignore {

    //ignore:忽略问某些信息的信号
    //    [[_textField.rac_textSignal ignore:@"1"]subscribeNext:^(id x) {
    //
    //        NSLog(@"%@",x);
    //    }];
    RACSubject *subject = [RACSubject subject];
    
    [[subject ignore:@1]subscribeNext:^(id x) {
        NSLog(@"%@",x);
        
    }];
    
    [subject sendNext:@1];
    [subject sendNext:@12];
}

- (void)filter {

    //filter:过滤信号，使用给他可以满足条件的信号
    
    //只有文本框内容大于5时，猜想要获取文本框的内容
    
    [[_textField.rac_textSignal filter:^BOOL(id value) {
        return [value length] > 5;
    }]subscribeNext:^(id x) {
        NSLog(@"输入框内容:%@",x);
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
