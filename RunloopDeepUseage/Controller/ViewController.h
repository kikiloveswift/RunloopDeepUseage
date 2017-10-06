//
//  ViewController.h
//  RunloopDeepUseage
//
//  Created by konglee on 2017/10/4.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@end

@interface TrackingModeObserver : NSObject

+ (instancetype)shareInstance;

- (void)addTrackingOb;

@end
