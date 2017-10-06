//
//  NSThreadOperationPriorityDiscuss.m
//  RunloopDeepUseage
//
//  Created by konglee on 2017/10/6.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import "NSThreadOperationPriorityDiscuss.h"

@implementation NSThreadOperationPriorityDiscuss

+ (void)networkRequestThreadEntryPoint:(id)__unused object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"KONGThread1"];
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

+ (NSThread *)networkRequestThread {
    static NSThread *_networkRequestThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkRequestThreadEntryPoint:) object:nil];
        [_networkRequestThread start];
    });
    
    return _networkRequestThread;
}

+ (void)logMessageInAnotherThread
{
    NSLog(@"currentThread is %@",[NSThread currentThread]);
}


@end
