//
//  RunLoopSource.h
//  RunloopDeepUseage
//
//  Created by kong on 2017/10/13.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RunLoopSource : NSObject
{
    CFRunLoopSourceRef runLoopSource;
    NSMutableArray *commands;
}

- (void)addToCurrentRunLoop;

- (void)invalidate;

//Handle Method

- (void)sourceFired;

// 注入命令和source
- (void)addCommand:(NSInteger)command WithData:(id)data;

- (void)fireCommandsOnRunLoop:(CFRunLoopRef)runLoop;

@end

//CallBackFunction
void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode);

void RunLoopSourcePerformRoutine (void *info);

void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode);

