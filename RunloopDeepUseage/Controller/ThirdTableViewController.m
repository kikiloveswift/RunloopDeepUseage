//
//  ThirdTableViewController.m
//  RunloopDeepUseage
//
//  Created by kong on 2017/11/10.
//  Copyright © 2017年 konglee. All rights reserved.
//

#import "ThirdTableViewController.h"
#import <pthread.h>

@interface ThirdTableViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    void(^Block)(void);
}

@property (nonatomic, strong) UITableView *sTableView;

@property (nonatomic, copy) NSArray *dataArr;

@property (nonatomic, assign) NSInteger selectedIndex;


@end

static  NSString *identify = @"PthreadCell";

@implementation ThirdTableViewController






- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configSetting];
    [self configUI];
    
}


- (void)configSetting
{
    self.title = @"Pthread";
    _selectedIndex = NSNotFound;
    _dataArr = @[@"Pthread简单使用",@"dispatch_asyn"];
}
- (void)configUI
{
    _sTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWidth, KHeight - 64) style:UITableViewStylePlain];
    _sTableView.delegate = self;
    _sTableView.dataSource = self;
    _sTableView.rowHeight = 50.0f;
    [self.view addSubview:_sTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = _dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectedIndex == indexPath.row)
    {
        return;
    }
    _selectedIndex = indexPath.row;
    
    switch (indexPath.row)
    {
        case 0:
        {
            [self testPthread0];
        }
            break;
        case 1:
        {
            [self testAsyn];
        }
            break;
        default:
            break;
    }
}

//Pthread 简单使用
void *PrintThreadName(void *threadID)
{
    long tid;
    tid = (long)threadID;
    printf("thread is #%ld\n",tid);
    pthread_exit(NULL);
}

//Pthread 简单使用
- (void)testPthread0
{
    pthread_t threads[5];
    int rc = 0;
    long t = 0;
    for ( t = 0; t < 5; t ++)
    {
        printf("in thread %ld\n",t);
//        pthread_attr_t type =
        rc = pthread_create(&threads[t], NULL, PrintThreadName, (void *)t);
        if (rc)
        {
            printf("ERROR THREAD CREAT %d\n",rc);
        }
    }
}

//GCD dispatch_asyn
- (void)testAsyn
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (NSInteger i = 0; i < 5; i ++)
        {
            NSLog(@"Current dispatch Thread is %@",[NSThread currentThread]);
        }
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
