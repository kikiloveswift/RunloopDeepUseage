//
//  DispatchDepth.m
//  RunloopDeepUseage
//
//  Created by kong on 2017/10/30.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import "DispatchDepth.h"
#include <pthread.h>


@implementation DispatchDepth

static DispatchDepth *dispatchDep = nil;

+ (instancetype)shareDispatch
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatchDep = [DispatchDepth new];
    });
    return dispatchDep;
}

- (void)discussDispatch_S
{
    void (^myblck)(void) = ^(){
//      pthread_self
       
    };
}
@end
