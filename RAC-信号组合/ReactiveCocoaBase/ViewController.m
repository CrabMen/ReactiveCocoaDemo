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
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *logButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  //组合聚合
    [_userTextField.rac_textSignal subscribeNext:^(id x) {
        
    }];
    
    [_passCodeTextField.rac_textSignal subscribeNext:^(id x) {
        
    }];
    //组合,可以多个
    //reduceBock参数：根据组合的信号有关，一一对应
 RACSignal *combineSignal = [ RACSignal combineLatest:@[_userTextField.rac_textSignal,_passCodeTextField.rac_textSignal] reduce:^id(NSString *user,NSString *passCode){
       //block：只要源信号发送内容就会调用，组合成一个新的值
     //聚合的值就是组合信号的内容
     NSLog(@"%@,%@",user,passCode);
     
     
      // return @"12323";
     return @(user.length && passCode.length);
    }];
    
//    [combineSignal subscribeNext:^(id x) {
//        
//        _logButton.enabled = [x boolValue];
//        NSLog(@"%@",x);
//    }];
//    
    RAC(_logButton,enabled) = combineSignal;
    
}
- (IBAction)clickBtn:(id)sender {
}

-(void)zip {

    //zipWith:把两个信号压缩成一个信号，只有当两个信号同事发送信号内容时，并且把两个信号内容合并成一个元组，才会触发压缩六的next事件
    
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    
    //压缩成一个信号,当一个界面多个请求的时候，需要等所有请求完成才能更新UI
    RACSignal *zipSignal = [signalA zipWith:signalB];
    
    [signalB sendNext:@2];
    [signalA sendNext:@1];
    
}
- (void)merge {
//merage:任意一个信号请求完成都会订阅到
    
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    
    
    //组合信号
    RACSignal *mergeSignal = [signalA merge:signalB];
    
    //订阅
    [mergeSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [signalB sendNext:@"上部分"];
    [signalA sendNext:@"下部分"];

}
- (void)then {

    //then:底层就是用cancat实现，用于连接两个，当第一个信号完成才会连接then返回的信号,但是会忽略第一个信号,只会订阅到第二个信号
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送上部分请求");
        [subscriber sendNext:@"上部分数据"];
        //设置发送完成才会自动进入下部分数据请求
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送下部分请求");
        [subscriber sendNext:@"下部分数据"];
        
        return nil;
    }];
    
    //创建组合信号,then会忽略到第一个信号的值
    RACSignal *thenSiganal = [signalA then:^RACSignal *{
        return signalB;
    }];
    
    //订阅信号
    [thenSiganal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
}
- (void)concat {

    //concat:将信号用另外一个信号包装，先执行外层然后执行内层信号，多个信号都会被订阅到
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送上部分请求");
        [subscriber sendNext:@"上部分数据"];
        //设置发送完成才会自动进入下部分数据请求
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送下部分请求");
        [subscriber sendNext:@"下部分数据"];
        
        return nil;
    }];
    
    
    //concat:按顺序请求
    RACSignal *concat = [signalA concat:signalB];
    
    [concat subscribeNext:^(id x) {
        //先拿到Ade值，再拿到B的值
        NSLog(@"%@",x);
    }];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
