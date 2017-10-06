//
//  STableViewCell.h
//  RunloopDeepUseage
//
//  Created by konglee on 2017/10/4.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UISwitch *controlSwitch;

@end
