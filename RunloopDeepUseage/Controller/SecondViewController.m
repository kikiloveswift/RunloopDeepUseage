//
//  SecondViewController.m
//  RunloopDeepUseage
//
//  Created by konglee on 2017/10/6.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import "SecondViewController.h"
#import "RunLoopSource.h"
#import "RunLoopContext.h"
#import "GCDTest.h"

@interface SecondViewController ()
{
    NSMutableArray *sourcesToPing;
    
}

@end

struct __CFRunLoop {
    pthread_mutex_t _lock;            /* locked for accessing mode list */
    Boolean _unused;
    pthread_t _pthread;
    uint32_t _winthread;
    CFMutableSetRef _commonModes;
    CFMutableSetRef _commonModeItems;
    CFMutableSetRef _modes;
    struct _block_item *_blocks_head;
    struct _block_item *_blocks_tail;
    CFAbsoluteTime _runTime;
    CFAbsoluteTime _sleepTime;
    CFTypeRef _counterpart;
};



@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"secondVC");
    sourcesToPing = [NSMutableArray array];
    [self threadTest];
}

- (void)registerSource:(RunLoopContext*)sourceInfo;
{
    [sourcesToPing addObject:sourceInfo];
}

- (void)removeSource:(RunLoopContext*)sourceInfo
{
    id    objToRemove = nil;
    
    for (RunLoopContext* context in sourcesToPing)
    {
        if ([context isEqual:sourceInfo])
        {
            objToRemove = context;
            break;
        }
    }
    
    if (objToRemove)
        [sourcesToPing removeObject:objToRemove];
}

- (IBAction)startAction:(id)sender
{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(runThreadAction) object:nil];
    [thread setName:@"kong1"];
    [thread start];
}
- (IBAction)stop:(id)sender
{
    CFRunLoopRef currenRunloop = CFRunLoopGetCurrent();
    CFRunLoopStop(currenRunloop);
}


- (void)runThreadAction
{
//    @autoreleasepool
//    {
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        
        NSDate *date = [NSDate date];
        NSDate *fotureDate = [date dateByAddingTimeInterval:20];
        [runloop runUntilDate:fotureDate];
//    }
}

- (void)timerAction
{
    NSLog(@"timer Fire");
    NSLog(@"thread is %@,runloop is ",[NSThread currentThread]);
    CFRunLoopRef runloop_current = [[NSRunLoop currentRunLoop] getCFRunLoop];
//    NSLog(@"%@",runloop_current -> _commonModes);
}

- (void)threadTest
{
    [[GCDTest shareInstance] test];
}


@end
