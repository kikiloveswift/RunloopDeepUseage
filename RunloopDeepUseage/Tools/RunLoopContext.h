//
//  RunLoopContext.h
//  RunloopDeepUseage
//
//  Created by kong on 2017/10/13.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RunLoopSource.h"

@interface RunLoopContext : NSObject
{
    CFRunLoopRef  runLoop;
    RunLoopSource *source;
}

@property (readonly) CFRunLoopRef runLoop;

@property (readonly) RunLoopSource *source;

- (instancetype)initWithSource:(RunLoopSource *)src andRunLoop:(CFRunLoopRef)loop;


@end
