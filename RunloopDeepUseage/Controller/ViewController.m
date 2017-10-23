//
//  ViewController.m
//  RunloopDeepUseage
//
//  Created by konglee on 2017/10/4.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import "ViewController.h"
#import "STableViewCell.h"
#import "SecondViewController.h"
#import "NSThreadOperationPriorityDiscuss.h"
#import <Foundation/Foundation.h>
#define isDate11()\
({\
BOOL a = false;\
 NSDate *date = [NSDate date];\
 NSTimeZone *nowTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:8]; \
 NSInteger timeOffset = [nowTimeZone secondsFromGMTForDate:date]; \
 NSDate *newDate = [date dateByAddingTimeInterval:timeOffset]; \
 NSTimeInterval timeInterval = [newDate timeIntervalSince1970]; \
 if (timeInterval >= 1510243200 && timeInterval <= 1510588800 ) \
 {\
   a = true;\
 }else{\
   a = false;}\
 (a);\
})

@interface ViewController ()

@property (nonatomic, strong) UITableView *sTableView;

@property (nonatomic, strong) UIView *dropView;


@end

static NSString *identify_SCell = @"STableViewCell";



@implementation ViewController

void observerGetStatus(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    NSLog(@"\n**CurrentRunloopMode is %@",[[NSRunLoop currentRunLoop] currentMode]);


    printf("\n");
    switch (activity)
    {
        case kCFRunLoopEntry:
        {
            printf("1kCFRunLoopEntry 即将进入loop");
        }
            break;
        case kCFRunLoopExit:
        {
            printf("6kCFRunLoopExit 即将退出runloop");
        }
            break;
        case kCFRunLoopAfterWaiting:
        {
            printf("5kCFRunLoopAfterWaiting 刚从休眠中唤醒");
        }
            break;
        case kCFRunLoopBeforeTimers:
        {
            printf("2kCFRunLoopBeforeTimers 即将处理timer");
        }
            break;
        case kCFRunLoopBeforeSources:
        {
            printf("3kCFRunLoopBeforeSources 即将处理Source");
        }
            break;
        case kCFRunLoopBeforeWaiting:
        {
            printf("4kCFRunLoopBeforeWaiting 即将进入休眠");
        }
            break;
            
        default:
        {
            printf("kCFRunLoopAllActivities");
        }
            break;
    }
    
}


- (void)calloutRunloopStatus
{
    NSRunLoop *myRunloop = [NSRunLoop currentRunLoop];
    
    CFRunLoopObserverContext context = {0 ,(__bridge void *)(self), NULL, NULL, NULL};
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, observerGetStatus, &context);
    if (observer)
    {
        CFRunLoopRef cfloop = [myRunloop getCFRunLoop];
        CFRunLoopAddObserver(cfloop, observer, kCFRunLoopDefaultMode);
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view, typically from a nib.
//    [self calloutRunloopStatus];
    [self initUI];
    if (isDate11())
    {
        NSLog(@"sjhi ");
    }
    else
    {
        NSLog(@"BUSHI");
    }
//    [[TrackingModeObserver shareInstance] addTrackingOb];
    //1510243200  1510588800
//    int a = isDate11();
//    if (isDate1111(BOOL))
//    {
//        NSLog(@"shi ");
//    }
//    else
//    {
//        NSLog(@"bushi ");
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark -initUI
- (void)initUI
{
    _sTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight) style:UITableViewStyleGrouped];
    _sTableView.delegate = self;
    _sTableView.dataSource = self;
    _sTableView.rowHeight = 100.f;
    if (@available(iOS 11.0, *)) {
        _sTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    [_sTableView registerNib:[UINib nibWithNibName:identify_SCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identify_SCell];
    [self.view addSubview:_sTableView];
    
    [self initDropView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    [_sTableView addGestureRecognizer:pan];
}

- (void)panAction:(UIPanGestureRecognizer *)pan
{
    CGFloat y = [pan translationInView:_sTableView].y;
    NSLog(@"ypan = %.1f",y);

    if (y < 0)
    {
        return;
    }
    if (y > 130)
    {
        pan.enabled = false;
        [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            _dropView.transform = CGAffineTransformMakeTranslation(0, KHeight);
            _sTableView.transform = CGAffineTransformMakeTranslation(0, KHeight);
        } completion:^(BOOL finished) {
            pan.enabled = true;

        }];
    }
    else
    {
        _dropView.transform = CGAffineTransformMakeTranslation(0, y);
        _sTableView.transform = CGAffineTransformMakeTranslation(0, y);
    }
}

- (void)initDropView
{
    _dropView = [UIView new];
    _dropView.frame = CGRectMake(0, -KHeight, KWidth, KHeight);
    _dropView.backgroundColor = [UIColor grayColor];
    UIImageView *imgView = [UIImageView new];
    imgView.frame = CGRectMake(0, 0, KWidth, KHeight);
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.image = [UIImage imageNamed:@"zlc.jpg"];
    [_dropView addSubview:imgView];
    [self.view addSubview:_dropView];
    [self.view insertSubview:_dropView aboveSubview:_sTableView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_dropView addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:3.0 animations:^{
        _dropView.transform = CGAffineTransformIdentity;
//        _sTableView.contentOffset = CGPointMake(0, 0);
        _sTableView.transform = CGAffineTransformIdentity;
    }];
}

#pragma Mark -UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat y = scrollView.contentOffset.y;
//    NSLog(@"y = %.1f\n",y);
//    if (y < -200)
//    {
//
//        [UIView animateWithDuration:1 animations:^{
//            _dropView.transform = CGAffineTransformMakeTranslation(0, -y);
//        } completion:^(BOOL finished) {
//            _dropView.transform = CGAffineTransformMakeTranslation(0, KHeight);
//            _sTableView.transform = CGAffineTransformMakeTranslation(0, KHeight);
//        }];
//        return;
////        [UIView animateWithDuration:3 delay:1 usingSpringWithDamping:1 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
////            _dropView.frame = CGRectMake(0, -y-KHeight, KWidth, KHeight);
////        } completion:^(BOOL finished) {
////
////        }];
//
//    }
//
//    if (y < 0)
//    {
//        _dropView.transform = CGAffineTransformMakeTranslation(0, -y);
//    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    STableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify_SCell];
    if (cell == nil)
    {
        cell = (STableViewCell *)[[NSBundle mainBundle] loadNibNamed:identify_SCell owner:self options:nil][0];
    }
    cell.countLabel.text = [NSString stringWithFormat:@"%ld-%ld倒计时label",(long)indexPath.section,(long)indexPath.row];
    cell.controlSwitch.on = false;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell 点击");
    SecondViewController *secondVC = [SecondViewController new];
    //最后一个参数如果是YES，则会阻塞此线程，只有等到那个线程完事之后，这个才会执行。
    [NSThreadOperationPriorityDiscuss performSelector:@selector(logMessageInAnotherThread) onThread:[NSThreadOperationPriorityDiscuss networkRequestThread] withObject:nil waitUntilDone:NO];

    [self.navigationController pushViewController:secondVC animated:YES];
}
@end


@interface TrackingModeObserver()


@end

@implementation TrackingModeObserver

static TrackingModeObserver *_trackingObserver = nil;

+ (instancetype)shareInstance
{
    @synchronized (self)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _trackingObserver = [TrackingModeObserver new];
        });
        return _trackingObserver;
    }
}

- (void)addTrackingOb
{
    NSRunLoop *myRunloop = [NSRunLoop currentRunLoop];
    
    CFRunLoopObserverContext context = {0 ,(__bridge void *)(_trackingObserver), NULL, NULL, NULL};
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, observerGetStatus, &context);
    if (observer)
    {
        CFRunLoopRef cfloop = [myRunloop getCFRunLoop];
        CFRunLoopAddObserver(cfloop, observer, kCFRunLoopCommonModes);
    }
}



@end
