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

@interface SecondViewController ()
{
    NSMutableArray *sourcesToPing;
    
}

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"secondVC");
    sourcesToPing = [NSMutableArray array];
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




@end
