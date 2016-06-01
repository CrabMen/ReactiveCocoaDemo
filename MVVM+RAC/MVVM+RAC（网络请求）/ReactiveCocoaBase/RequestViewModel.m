//
//  RequestViewModel.m
//  ReactiveCocoaBase
//
//  Created by CrabMan on 16/6/2.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "RequestViewModel.h"

@implementation RequestViewModel

-(instancetype)init {

    if (self = [super init]) {
        
        [self setUp];
        
    }
    
    return self;

}


- (void)setUp {
    
    
    _requestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        //执行命令
        //发送请求
        
        
        //创建信号，将请求包装一下
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            
            
            //创建请求管理者
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            
            
            [manager GET:@"https://api.douban.com/v2/book/search" parameters:@{@"q":@"美女"} progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
                //请求成功的时候调用
                NSLog(@"%@",responseObject);
                
                
                //不应该将整个字典传过去
                NSArray *dicArray = [responseObject objectForKey:@"books"];
                
            NSArray *modelArray = [[dicArray.rac_sequence map:^id(id value) {
                 
                    return [[NSObject alloc]init];
                }] array];
                
                [subscriber sendNext:modelArray];
                
                
                [responseObject writeToFile:@"/Users/CrabMan/Documents/ReactiveCocoaDemo/MVVM+RAC/MVVM+RAC（网络请求）/美女.plist" atomically:YES];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
            

            
            
            return nil;
        }];;
        
        
        return signal;
    }];
}
@end
