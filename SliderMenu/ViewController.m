//
//  ViewController.m
//  SliderMenu
//
//  Created by admin on 14/10/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ViewController.h"
#import "YYContentViewController.h"
#import "YYSliderMenuView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"懂球帝";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _titleArray = @[@"头条",@"圈子",@"懂球号",@"集锦",@"中超",@"专题",@"深度",@"足彩",
                    @"闲情",@"视频",@"装备",@"英超",@"西甲",@"德甲",@"意甲",@"五洲"];
    
    
    YYSliderMenuView *menuView = [[YYSliderMenuView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) titles:_titleArray viewControllers:[self viewControllers]];
    [self.view addSubview:menuView];
    
}

#pragma mark - 创建控制器
- (NSArray *)viewControllers{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i=0; i<_titleArray.count; i++) {
        
        YYContentViewController *contentVC = [[YYContentViewController alloc] init];
        contentVC.content = _titleArray[i];
        
        [array addObject:contentVC];
    }
    
    NSArray *arr = [array mutableCopy];
    
    return arr;
}




@end
