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
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //用来包装元组
  RACTuple *tuple = RACTuplePack(@1,@2);
    NSLog(@"%@",tuple[0]);
    }
-(void)RAC {

    
    //监听文本框内容常规做法
    [_textField.rac_textSignal subscribeNext:^(id x) {
        _label.text = x;
    }];
    //宏:用来给某个对象的某个属性绑定信号，只要产生信号，信号内容就会给属性赋值
    RAC(_label,text) = _textField.rac_textSignal;
    



}

- (void)KVOMarco {

    
    //监听属性的改变KVO
    [RACObserve(self.view, frame) subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    //常规做法
    [[self.view rac_valuesForKeyPath:@"frame" observer:nil] subscribeNext:^(id x) {
        
    }];
    


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
