//
//  ViewController.m
//  TestSVPullToRefresh
//
//  Created by hc_cyril on 16/7/25.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import "ViewController.h"
#import "SVPullToRefresh.h"
#import "SVPullToRefreshGifView.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSources;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    __weak typeof(self) weakSelf  = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        
        int64_t delayInSeconds = 3.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [weakSelf.tableView beginUpdates];
            [weakSelf.dataSources insertObject:[NSDate date] atIndex:0];
            [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
            [weakSelf.tableView endUpdates];
            [weakSelf.tableView.pullToRefreshView stopAnimating];
        });
        
    }];
    SVPullToRefreshGifView *gifView = [[SVPullToRefreshGifView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,100)];
    [self.tableView.pullToRefreshView setCustomView:gifView forState:SVPullToRefreshStateLoading];
    [self.tableView.pullToRefreshView setCustomView:gifView forState:SVPullToRefreshStateStopped];
    [self.tableView.pullToRefreshView setCustomView:gifView forState:SVPullToRefreshStateTriggered];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableViewDelegate and tableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [[self.dataSources objectAtIndex:indexPath.row] description];
    return cell;
}

#pragma mark - setter and getter
- (UITableView *)tableView {

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataSources {

    if (!_dataSources) {
        _dataSources = [NSMutableArray new];
        for (int i = 0; i < 10; i ++) {
            [_dataSources addObject:[NSDate date]];
        }
    }
    return _dataSources;
}

@end
