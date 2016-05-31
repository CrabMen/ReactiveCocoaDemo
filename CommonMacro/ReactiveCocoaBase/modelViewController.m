//
//  modelViewController.m
//  ReactiveCocoaBase
//
//  Created by CrabMan on 16/5/31.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "modelViewController.h"
#import "GlobalHeader.h"

@interface modelViewController ()

@property (nonatomic,strong) RACSignal *signal;

@end

@implementation modelViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    //将self变为若指针
   @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //强引用弱指针，保证弱指针不在代码块里面销毁
        @strongify(self);
        
        NSLog(@"%@",self);
        return nil;
    }];
    //强引用signal，循环引用
    _signal = signal;

}
- (IBAction)dismissVC:(id)sender {
    //dismiss会销毁控制器，自动调用dealloc方法
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)dealloc {

    NSLog(@"%s",__func__);
    
}
@end
