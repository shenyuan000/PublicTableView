//
//  PublicTableView.h
//  PublicTableView
//
//  Created by shenyuan on 16/3/9.
//  Copyright © 2016年 Mitake. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TableBlock)(UITableView *tableView,NSIndexPath *indexPath);

@interface PublicTableView : UITableView
/**
 *  定义一个公共的TableView,然后可以在使用tableview的地方使用
 *
 *  @param frame      UITableView的frame
 *  @param style       UITableViewStyle
 *  @param className  cell Class
 *  @param cellMethod cell调用的方法
 *  @param isUserNib  是否使用nib
 *
 *  @return cell
 */
-(instancetype)initWithFrame:(CGRect)frame
                       style:(UITableViewStyle)style
           cellWithClassName:(NSString *)className
              cellWithMethod:(NSString *)cellMethod
           cellWithIsUserNib:(BOOL)isUserNib;

// 数据列表
@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, copy) TableBlock tableBlock;

// 数据行选择时所触发的block
- (void)blockWithCellSelectRowIndexPath:(TableBlock)tableBlock;

@end
