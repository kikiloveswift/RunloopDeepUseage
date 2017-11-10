//
//  GCDTest.m
//  RunloopDeepUseage
//
//  Created by konglee on 2017/10/30.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import "GCDTest.h"
#include <pthread.h>

@implementation GCDTest


static GCDTest *_gcdTest = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _gcdTest = [GCDTest new];
    });
    return _gcdTest;
}



/**
 测试线程
 */
- (void)test
{
//    @autoreleasepool
//    {
        void (^myBlock)(void) = ^(){
            printf("%d block\n",(int)pthread_self());
        };
        dispatch_queue_t q = dispatch_queue_create("com.kong.thread", DISPATCH_QUEUE_CONCURRENT);
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_async(group, q, myBlock);
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    }
}

- (void)cancelTest
{
    NSLog(@"break");
    [self reqestAPI];
}

- (void)reqestAPI
{
    NSString *urlStr1 = @"http://m.ctrip.com/restapi/soa2/10290/abtest.json";
    NSDictionary *params1 = @{
                              @"head": @{
                                  @"ctok": @"",
                                  @"cid": @"12001017710037836450",
                                  @"lang": @"01",
                                  @"syscode": @"12",
                                  @"sauth": @"",
                                  @"extension": @"",
                                  @"sid": @"8890",
                                  @"auth": @"",
                                  @"cver": @"702.000"
                              },
                              @"ClientID": @"12001017710037836450",
                              @"ExpCodes": @""
                              };
    
    dispatch_group_t group = dispatch_group_create();
    
    //开启10个子线程请求
    for (int i = 1; i <= 10; i ++)
    {
        dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
            dispatch_group_enter(group);
            [AFNetReqCls requestURL:urlStr1 Method:MethodPOST Params:params1 HeaderParams:nil Successs:^(id obj) {
                NSLog(@"第%d done",i);
                dispatch_group_leave(group);
            } Failure:^(id obj) {
                dispatch_group_leave(group);
            }];
        });
    }
    
    //开启单独一个
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        dispatch_group_enter(group);
        [AFNetReqCls requestURL:urlStr1 Method:MethodPOST Params:params1 HeaderParams:nil Successs:^(id obj) {
            NSLog(@"another done");
            dispatch_group_leave(group);
        } Failure:^(id obj) {
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"All done");
    });
}


@end
