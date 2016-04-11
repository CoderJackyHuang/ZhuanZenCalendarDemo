//
//  Created by 黄仪标 on 15/6/14.
//  Copyright (c) 2015年 haodf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGestureRecognizer+HDFGesture.h"

/**
 *  @author Huangyibiao
 *
 *  UIView所有扩展API
 */
@interface UIView (HDFView)

#pragma mark - 常用frame相关API
/**
 * view.frame.origin.x
 */
@property (nonatomic, assign) CGFloat hdf_originX;

/**
 * view.frame.origin.y
 */
@property (nonatomic, assign) CGFloat hdf_originY;

/**
 * view.frame.origin
 */
@property (nonatomic, assign) CGPoint hdf_origin;

/**
 * view.center.x
 */
@property (nonatomic, assign) CGFloat hdf_centerX;

/**
 * view.center.y
 */
@property (nonatomic, assign) CGFloat hdf_centerY;

/**
 * view.center
 */
@property (nonatomic, assign) CGPoint hdf_center;

/**
 * view.frame.size.width
 */
@property (nonatomic, assign) CGFloat hdf_width;

/**
 * view.frame.size.height
 */
@property (nonatomic, assign) CGFloat hdf_height;

/**
 * view.frame.size
 */
@property (nonatomic, assign) CGSize  hdf_size;

/**
 * view.frame.size.height + view.frame.origin.y
 */
@property (nonatomic, assign) CGFloat hdf_bottomY;

/**
 * view.frame.size.width + view.frame.origin.x
 */
@property (nonatomic, assign) CGFloat hdf_rightX;

#pragma mark - 手势相关
/**
 * @author huangyibiao
 *
 * 通过-hdf_addTapGestureWithCompletion:方法添加的手势，可通过此属性获取
 */
@property (nonatomic, strong, readonly) UITapGestureRecognizer *hdf_tapGetsure;

/**
 * @author huangyibiao
 *
 * 通过-hdf_addLongPressGestureWithCompletion:方法添加的手势，可通过此属性获取
 */
@property (nonatomic, strong, readonly) UILongPressGestureRecognizer *hdf_longPressGesture;
 
#pragma mark - 视图操作
/**
 *  @author Huangyibiao
 *
 *  移除所有子视图
 */
- (void)hdf_removeAllSubviews;

#pragma mark - 截图
/**
 *  @author Huangyibiao
 *
 *  对当前视图截图
 */
- (UIImage *)hdf_captureScreenshot;

#pragma mark - 淡入淡出效果
/**
 *  @author Huangyibiao
 *
 *  添加淡入淡出效果
 *
 *  @param duration 动画时长
 */
- (void)hdf_fadeWithDuration:(NSTimeInterval)duration;

/**
 *  @author Huangyibiao
 *
 *  给指定的视图添加淡入淡出的效果
 *
 *  @param fadeView 视图
 *  @param duration 动画时长
 */
+ (void)hdf_fadeInWithView:(UIView *)fadeView duration:(NSTimeInterval)duration;

#pragma mark - Gesture
/**
 *  @author Huangyibiao
 *
 *  给UIView添加Tap手势
 *
 *  @param completion 触发手势时的回调
 */
- (UITapGestureRecognizer *)hdf_addTapGestureWithCompletion:(HDFGestureBlock)completion;

/**
 * @author huangyibiao
 *
 * 移除调用-hdf_addTapGestureWithCompletion: API添加的手势
 */
- (void)hdf_removeTapGesture;

/**
 *  @author guoyouzeng, 15-07-12
 *
 *  @brief  给UIView添加LongPress手势
 *
 *  @param completion 触发长按手势时的回调
 */
- (void)hdf_addLongPressGestureWithCompletion:(HDFGestureBlock)completion;

/**
 * @author huangyibiao
 *
 * 移除调用-hdf_addLongPressGestureWithCompletion: API添加的手势
 */
- (void)hdf_removeLongPressGesture;


#pragma mark - UIView  Method
/*!
 *  @author jerry, 15-08-18
 *
 *  @brief  设置默认圆角为 4
 */
- (void)adjustRadiusByDefault;
/*!
 *  @author jerry, 15-08-18
 *
 *  @brief  设置圆角
 *
 *  @param radius  圆角值
 */
- (void)adjustRadius:(CGFloat) radius;

/*!
 *  @author jerry, 15-08-18
 *
 *  @brief  设置圆角 和 边框的颜色
 *
 *  @param radius  圆角值
 *  @param color   颜色值
 */
- (void)adjustBorder:(CGFloat) radius color:(UIColor *) color;

@end
