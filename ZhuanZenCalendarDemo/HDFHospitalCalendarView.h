//
//  HDFHospitalCalendarView.h
//  ZhuanZenCalendarDemo
//
//  Created by huangyibiao on 16/4/11.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HDFCalendarSelected)(NSDate *selectedDate);
typedef void(^HDCalendarCancel)(void);

/**
 *	@author huangyibiao
 *
 *	转诊问题池日历
 */
@interface HDFHospitalCalendarView : UIView

+ (instancetype)showInView:(UIView *)inView
                     size:(CGSize)size
               selectedDate:(NSDate *)selectedDate
                onSelected:(HDFCalendarSelected)onSelected
                  onCancel:(HDCalendarCancel)onCancel;

@end
