//
//  ViewController.m
//  PublicTableView
//
//  Created by shenyuan on 16/3/9.
//  Copyright © 2016年 Mitake. All rights reserved.
//

#import "ViewController.h"
#import "PublicTableView.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *dataList;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataList = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i++) {
        [self.dataList addObject:[NSNumber numberWithInt:i]];
    };
    
    PublicTableView *tableView = [[PublicTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain cellWithClassName:@"MyCell" cellWithMethod:@"cellConfig" cellWithIsUserNib:YES];
    [self.view addSubview:tableView];
    tableView.dataList = self.dataList;
    [tableView blockWithCellSelectRowIndexPath:^(UITableView *tableView, NSIndexPath *indexPath) {
        NSLog(@"点击了");
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
