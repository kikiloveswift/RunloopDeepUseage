//
//  RunLoopContext.m
//  RunloopDeepUseage
//
//  Created by kong on 2017/10/13.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import "RunLoopContext.h"



@implementation RunLoopContext
@synthesize source;
@synthesize runLoop;

- (instancetype)initWithSource:(RunLoopSource *)src andRunLoop:(CFRunLoopRef)loop
{
    if (self = [super init])
    {
        source = src;
        runLoop = loop;
    }
    return self;
}

@end
