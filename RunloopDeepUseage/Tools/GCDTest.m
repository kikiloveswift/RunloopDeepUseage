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
    void (^myBlock)(void) = ^(){
        printf("%d block -1\n",(int)pthread_self());
    };
    dispatch_queue_t q = dispatch_queue_create("com.kong.thread", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, q, myBlock);
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}
@end
