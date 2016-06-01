//
//  ViewController.m
//  ReactiveCocoaBase
//
//  Created by CrabMan on 16/5/30.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "ViewController.h"
#import "GlobalHeader.h"

#import "LoginViewModel.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UIButton *logBtn;


@property (nonatomic,strong) LoginViewModel *loginVM;

@end

@implementation ViewController

-(LoginViewModel *)loginVM {

    if (!_loginVM) {
        _loginVM = [[LoginViewModel alloc]init];
    }
    
    return _loginVM;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    /*
     MVVM:
     VM:视图模型，处理界面上所有的业务逻辑，最好不要包括视图，赋值给对应的VM视图，使用绑定
     */
    
    [self bindViewMode];
    
    [self loginEvent];
    
}

/** 绑定ViewModel */
- (void)bindViewMode {

    
    //1.给视图模型的账号和密码绑定信号
    RAC(self.loginVM,account) =  _accountTextField.rac_textSignal;
    RAC(self.loginVM,passWord) = _passWordTextField.rac_textSignal;
    


}
/** 登录事件 */
- (void)loginEvent {

    //设置按钮能否点击
    RAC(_logBtn,enabled) = self.loginVM.loginEnableSignal;


    //监听登录按钮的点击
    [[_logBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        
        NSLog(@"点击登录按钮");
        //处理登录事件
        [self.loginVM.loginCommand execute:nil];
        
    }];
    

    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
