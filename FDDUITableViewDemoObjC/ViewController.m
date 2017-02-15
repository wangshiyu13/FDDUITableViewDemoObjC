//
//  ViewController.m
//  FDDUITableViewDemoObjC
//
//  Created by denglibing on 2017/2/14.
//  Copyright © 2017年 denglibing. All rights reserved.
//

#import "ViewController.h"

#import "FDDTableViewConverter.h"

#import "HDTableViewCell.h"

#import "FDDBaseCellModel.h"

@interface ViewController ()

@property (nonatomic, strong) FDDTableViewConverter *tableViewConverter;

@end

@implementation ViewController

- (void)dealloc{
    NSLog(@"%@ dealloc", NSStringFromClass(self.class));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"FDDUITableViewDemoObjC";
    
    NSArray *randomSources = @[@"Swift is now open source!",
                               @"We are excited by this new chapter in the story of Swift. After Apple unveiled the Swift programming language, it quickly became one of the fastest growing languages in history. Swift makes it easy to write software that is incredibly fast and safe by design. Now that Swift is open source, you can help make the best general purpose programming language available everywhere",
                               @"For students, learning Swift has been a great introduction to modern programming concepts and best practices. And because it is now open, their Swift skills will be able to be applied to an even broader range of platforms, from mobile devices to the desktop to the cloud.",
                               @"Welcome to the Swift community. Together we are working to build a better programming language for everyone.",
                               @"– The Swift Team"];
    for (int i=0; i<30; i++) {
        NSInteger randomIndex = arc4random() % 5;
        FDDBaseCellModel *cellModel = [FDDBaseCellModel modelFromCellClass:HDTableViewCell.class cellHeight:[HDTableViewCell cellHeightWithCellData:randomSources[randomIndex]] cellData:randomSources[randomIndex]];
        [self.dataArr addObject:cellModel];
    }
    
    [self disposeTableViewConverter];
}

- (void)disposeTableViewConverter{
    _tableViewConverter = [[FDDTableViewConverter alloc] initWithTableViewController:self];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = _tableViewConverter;
    tableView.dataSource = _tableViewConverter;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    __weak typeof(self) weakSelf = self;
    [_tableViewConverter registerTableViewMethod:@selector(tableView:didSelectRowAtIndexPath:) handleResult:^id(NSArray *results) {
        [weakSelf.navigationController pushViewController:[ViewController new] animated:YES];
        return nil;
    }];
    
    [_tableViewConverter registerTableViewMethod:@selector(tableView:heightForRowAtIndexPath:) handleResult:^id(NSArray *results) {
        NSIndexPath *indexPath = results[1];
        FDDBaseCellModel *cellModel = weakSelf.dataArr[indexPath.row];
        return @(cellModel.cellHeight);
    }];
    
    [_tableViewConverter registerTableViewMethod:@selector(tableView:titleForHeaderInSection:) handleResult:^id(NSArray *results) {
        return @"";
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
