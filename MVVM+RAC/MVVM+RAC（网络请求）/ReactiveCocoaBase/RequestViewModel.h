//
//  RequestViewModel.h
//  ReactiveCocoaBase
//
//  Created by CrabMan on 16/6/2.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalHeader.h"
@interface RequestViewModel : NSObject

/** 请求命令 */
@property (nonatomic,strong,readonly) RACCommand *requestCommand;


@end
