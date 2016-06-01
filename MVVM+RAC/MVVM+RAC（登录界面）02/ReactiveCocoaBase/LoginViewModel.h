//
//  LoginViewModel.h
//  ReactiveCocoaBase
//
//  Created by CrabMan on 16/6/1.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalHeader.h"
@interface LoginViewModel : NSObject
//保存最好不要直接赋值，最好是绑定


/**
 保存登录账号
 */
@property (nonatomic,strong) NSString *account;

/**
 保存登录密码
 */
@property (nonatomic,strong) NSString *passWord;


/**处理登录按钮是否允许点击信号*/
@property (nonatomic,strong) RACSignal *loginEnableSignal;

/** 登录按钮命令 */
@property (nonatomic,strong) RACCommand *loginCommand;


@end
