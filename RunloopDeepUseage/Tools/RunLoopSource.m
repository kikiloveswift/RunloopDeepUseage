//
//  RunLoopSource.m
//  RunloopDeepUseage
//
//  Created by kong on 2017/10/13.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import "RunLoopSource.h"

@implementation RunLoopSource

- (instancetype)init
{
    CFRunLoopSourceContext context = {0, (__bridge void *)(self), NULL, NULL, NULL, NULL, NULL, &RunLoopSourceScheduleRoutine, &RunLoopSourceCancelRoutine, &RunLoopSourcePerformRoutine};
    runLoopSource = CFRunLoopSourceCreate(NULL, 0, &context);
    commands = [NSMutableArray array];
    return self;
}

- (void)addToCurrentRunLoop
{
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFRunLoopAddSource(runLoop, runLoopSource, kCFRunLoopDefaultMode);
}

- (void)fireCommandsOnRunLoop:(CFRunLoopRef)runLoop
{
    CFRunLoopSourceSignal(runLoopSource);
    CFRunLoopWakeUp(runLoop);
}

void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    
}

void RunLoopSourcePerformRoutine (void *info)
{
    
}

void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    
}
@end
