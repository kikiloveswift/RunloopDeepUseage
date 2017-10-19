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

@interface ViewController ()

@property (nonatomic, strong) UITableView *sTableView;


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
    // Do any additional setup after loading the view, typically from a nib.
    [self calloutRunloopStatus];
    [self initUI];
    [[TrackingModeObserver shareInstance] addTrackingOb];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark -initUI
- (void)initUI
{
    _sTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWidth, KHeight - 64) style:UITableViewStyleGrouped];
    _sTableView.delegate = self;
    _sTableView.dataSource = self;
    _sTableView.rowHeight = 100.f;
    [_sTableView registerNib:[UINib nibWithNibName:identify_SCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identify_SCell];
    [self.view addSubview:_sTableView];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

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
