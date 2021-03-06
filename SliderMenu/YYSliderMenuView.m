
//
//  YYSliderMenuView.m
//  SliderMenu
//
//  Created by admin on 17/10/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "YYSliderMenuView.h"

#import "YYContentViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//顶部滚动选项栏的高度
#define TopViewHeight 30
//每一个选项的宽度
#define ItemWidth kScreenWidth/6.0

@interface YYSliderMenuView()<UIScrollViewDelegate>
{
    
    //顶部选项卡滑动view
    UIScrollView *_topScrollView;
    
    //选项卡下方横线
    UIView *_sliderView;
    
    //记录当前被选中的按钮的index
    NSInteger _currentIndex;
    
    //所有按钮的数组
    NSMutableArray *_buttonsArray;

}

/**
 *  试图滑动view
 */
@property (nonatomic,strong)UIScrollView *mainScrollView;

@end

@implementation YYSliderMenuView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray viewControllers:(NSArray *)viewControllersArray{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.titleArray = titleArray;
        
        self.viewControllersArray = viewControllersArray;
        
        [self topView];
        
        [self addSubview:self.mainScrollView];
        
        //默认加载第一个视图
        [self mainScrollViewAddSubViews:0];
        
        _mainScrollView.contentSize = CGSizeMake(kScreenWidth*_titleArray.count, self.frame.size.height-40);
        
    }
    
    
    return self;
    
}



#pragma mark - 选项卡视图
- (void)topView {
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, TopViewHeight)];
    [self addSubview:topView];
    
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, TopViewHeight)];
    //    _topScrollView.delegate = self;
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.showsVerticalScrollIndicator = NO;
    [topView addSubview:_topScrollView];
    
    
    _buttonsArray = [NSMutableArray array];
    
    //添加选项button
    for (int i=0; i<self.titleArray.count; i++) {
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i*ItemWidth, 0, ItemWidth, TopViewHeight)];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [_topScrollView addSubview:button];
        
        if (i == 0) {
            button.selected = YES;
        }
        
        [_buttonsArray addObject:button];
    }
    
    _sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, TopViewHeight-2, ItemWidth, 2)];
    _sliderView.backgroundColor = [UIColor greenColor];
    [_topScrollView addSubview:_sliderView];
    
    
    _topScrollView.contentSize = CGSizeMake(_titleArray.count*ItemWidth, 0);
}

#pragma mark - 添加内容视图到mainScrollView上
- (void)mainScrollViewAddSubViews:(NSUInteger)index{
    
    CGFloat viewHeight = self.frame.size.height-40;
    
    
    YYContentViewController *contentVC = self.viewControllersArray[index];

    UIView *contenView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth*index, 0, kScreenWidth, viewHeight)];
    [contenView addSubview:contentVC.view];

    [_mainScrollView addSubview:contenView];
    
    
}

#pragma mark - button点击事件
- (void)changeVC:(UIButton *)sender{
    
    if (sender.selected) {
        return;
    }
    sender.selected = YES;
    sender.titleLabel.font = [UIFont systemFontOfSize:16];
    
    
    //将之前选中的button还原
    [self changeCurrentItem:NO];
    
    
    //给_currentIndex赋予新的当前选中的值
    _currentIndex = sender.tag;
    
    
    //加载被点击的item对应的视图
    [self mainScrollViewAddSubViews:_currentIndex];
    
    
    //下划线滑动动画
    [self lineSlideAnimation:_currentIndex];
    
    //内容视图跟随滑动
    [_mainScrollView setContentOffset:CGPointMake(kScreenWidth*_currentIndex, 0) animated:NO];
    
}

#pragma mark - mainScrollView
- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TopViewHeight, kScreenWidth, self.frame.size.height-TopViewHeight)];
        _mainScrollView.delegate = self;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.pagingEnabled = YES;
    }
    return _mainScrollView;
}

- (void)setTitleArray:(NSArray *)titleArray{
    
    _titleArray = [NSArray array];
    _titleArray = titleArray;
    
    
}

#pragma mark - 下划线滑动动画
- (void)lineSlideAnimation:(NSInteger)index{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (index < _titleArray.count-4 && index > 0) {
            
            [_topScrollView setContentOffset:CGPointMake((index-1)*ItemWidth, 0) animated:YES];
        }
        
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 animations:^{
            
            CGRect rect = _sliderView.frame;
            rect.origin.x = index*ItemWidth;
            _sliderView.frame = rect;
            
        }];
        
    }];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == _mainScrollView) {
    
        double index = scrollView.contentOffset.x/kScreenWidth;
        
        NSLog(@"%ld",(long)index);
        
        
        [self changeCurrentItem:NO];
        
        _currentIndex = index;
        
        [self changeCurrentItem:YES];
        
        //加载被点击的item对应的视图
        [self mainScrollViewAddSubViews:_currentIndex];
        
        [self lineSlideAnimation:index];
        
        
    
    }
    
    
}

#pragma mark - 修改当前选中和之前选中button的属性
- (void)changeCurrentItem:(BOOL)isSelected{
    
    UIButton *button = _buttonsArray[_currentIndex];
    button.selected = isSelected;
    
    if (isSelected) {
        
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        
    }else{
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
    }
    
}


@end
