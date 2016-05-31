//
//  ViewController.m
//  ReactiveCocoaBase
//
//  Created by CrabMan on 16/5/30.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "ViewController.h"
#import "GlobalHeader.h"
#import "RedView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet RedView *redView;
@property (weak, nonatomic) IBOutlet UIButton *VCBtn;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //5.监听文本框
   [[_textField rac_textSignal] subscribeNext:^(id x) {
       NSLog(@"文本框内容改变%@",x );
   }];

}

- (void)delegate {
    //1.代替代理 ：RACSubject 2.rac_signalForSelecto(无法传值，只能监听方法是否点击)
    
    //RAC：
    //rac_signalForSelector
    [[self rac_signalForSelector:@selector(didReceiveMemoryWarning)] subscribeNext:^(id x) {
        NSLog(@"控制器调用内存警告方法");
        //可以用模拟器模拟内存警告
    }];
    
    [[self.redView rac_signalForSelector:@selector(clickBtn:)] subscribeNext:^(id x) {
        NSLog(@"控制器知道按钮被点击");
    }];
    
}
- (void)KVO {

    
    //2.代替KVO
    //该方法需要导入头文件
    [_redView rac_observeKeyPath:@"frame" options:NSKeyValueObservingOptionNew observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        NSLog(@"frame改变一");
    }];
    
    [[_redView rac_valuesForKeyPath:@"frame" observer:nil] subscribeNext:^(id x) {
        NSLog(@"frame被改变为：%@",x );
    }];
}
- (void)uicontrolEvent {

    //3.监听事件
    [[_VCBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"主界面按钮被点击");
    }];

}
- (void)notification {
    //4.代替通知
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:UIKeyboardDidShowNotification object:nil] subscribeNext:^(id x) {
        NSLog(@"键盘弹出%@",x);
        //x代表userinfo
    }];
    




}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    _redView.frame  = CGRectMake(100, 100, 200, 200);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
