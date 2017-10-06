//
//  NSThreadOperationPriorityDiscuss.h
//  RunloopDeepUseage
//
//  Created by konglee on 2017/10/6.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSThreadOperationPriorityDiscuss : NSObject

+ (void)logMessageInAnotherThread;

+ (NSThread *)networkRequestThread;
@end
