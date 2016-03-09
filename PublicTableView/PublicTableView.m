//
//  PublicTableView.m
//  PublicTableView
//
//  Created by shenyuan on 16/3/9.
//  Copyright © 2016年 Mitake. All rights reserved.
//

#import "PublicTableView.h"
#import <objc/objc-runtime.h>

@interface PublicTableView ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *cellClassName;
    NSString *cellInvokeMethod;
}

@end

@implementation PublicTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style cellWithClassName:(NSString *)className cellWithMethod:(NSString *)cellMethod cellWithIsUserNib:(BOOL)isUserNib {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        
        cellClassName = className;
        cellInvokeMethod = cellMethod;
        
        if (isUserNib) {
            [self registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:className];
        } else {
            [self registerClass:NSClassFromString(className) forCellReuseIdentifier:className];
        }
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellClassName forIndexPath:indexPath];
    
    if ([cell respondsToSelector:NSSelectorFromString(cellInvokeMethod)]) {
        
        id value = self.dataList[indexPath.row];
        
        [self sendMsg:cell method:NSSelectorFromString(cellInvokeMethod) value1:value value2:indexPath];
        
    }else{
        NSLog(@"%@",@"cell未实现该方法");
    }
    
    return cell;
}

- (void)sendMsg:(id)rever method:(SEL)method value1:(id)value1 value2:(id)value2{
    
    int (*action)(id, SEL, id, id) = (int (*)(id, SEL, id, id)) objc_msgSend;
    
    action(rever, method, value1, value2);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tableBlock(tableView,indexPath);
}

- (void)blockWithCellSelectRowIndexPath:(TableBlock)tableBlock
{
    self.tableBlock = tableBlock;
}


@end
