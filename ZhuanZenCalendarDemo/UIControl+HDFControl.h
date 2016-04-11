//
//  UIControl+HDFControl.h
//  DEMO
//
//  Created by huangyibiao on 15/6/10.
//  Copyright (c) 2015年 huangyibiao. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "HDFDefine.h"

/**
 * UISwitch控件类型的值改变时的回调block声明
 *
 * @param sender 响应的UISwitch控件
 */
typedef void(^HDFSwitchValueChangedBlock)(UISwitch *sender);
typedef void(^HDFButtonBlock)(UIButton *sender);


/**
 * 能够添加值改变事件的控件的回调block声明
 *
 * @param sender 响应的控件
 */
typedef void(^HDFValueChangedBlock)(id sender);

/**
 * @author Huangyibiao
 *
 * 给UIControl添加扩展方法，追加touch down和touch up事件的block
 *
 * @since v0.1
 */
@interface UIControl (HDFControl)

/**
 * 按钮按下事件回调
 *
 * @see HDFButtonBlock
 */
@property (nonatomic, copy) HDFButtonBlock hdf_touchDown;

/**
 * 按钮松开事件回调
 *
 * @see HDFButtonBlock
 */
@property (nonatomic, copy) HDFButtonBlock hdf_touchUp;

/**
 * 值改变时的回调block
 *
 * @see HDFValueChangedBlock
 */
@property (nonatomic, copy) HDFValueChangedBlock hdf_valueChangedBlock;

@end
