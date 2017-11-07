//
//  GCDTest.h
//  RunloopDeepUseage
//
//  Created by konglee on 2017/10/30.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDTest : NSObject
+ (instancetype)shareInstance;

- (void)test;

- (void)cancelTest;


@end
