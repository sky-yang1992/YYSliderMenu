//
//  YYSliderMenuView.h
//  SliderMenu
//
//  Created by admin on 17/10/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYSliderMenuView : UIView

/**
 *  选项卡名称数组
 */
@property (nonatomic,strong) NSArray *titleArray;
/**
 *  子控制器数组
 */
@property (nonatomic,strong) NSArray *viewControllersArray;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray viewControllers:(NSArray *)viewControllersArray;

@end
