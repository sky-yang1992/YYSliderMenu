//
//  ContentViewController.m
//  SliderMenu
//
//  Created by admin on 14/10/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "YYContentViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface YYContentViewController()<UITableViewDelegate,UITableViewDataSource>

/**
 *  table
 */
@property (nonatomic,strong) UITableView *contenTableView;

@end

@implementation YYContentViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
//    UILabel *txt = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 100, 40)];
//    txt.textColor = [UIColor redColor];
//    txt.font = [UIFont systemFontOfSize:16];
//    txt.textAlignment = NSTextAlignmentCenter;
//    txt.text = self.content;
//    [self.view addSubview:txt];
    
    [self.view addSubview:self.contenTableView];
    
}

-(UITableView *)contenTableView{
    
    if (!_contenTableView) {
        _contenTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-30) style:UITableViewStylePlain];
        _contenTableView.dataSource = self;
        _contenTableView.delegate = self;
        _contenTableView.rowHeight = 60;
        _contenTableView.tableFooterView = [[UIView alloc] init];
    }
    return _contenTableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return <#arrayName#>.count;
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行---%@",(long)indexPath.row,self.content];
    
    return cell;
    
}


@end
