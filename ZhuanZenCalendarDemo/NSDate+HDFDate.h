//
//  Created by 黄仪标 on 15/6/14.
//  Copyright (c)2015年 haodf. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @author Huangyibiao
 *
 *  日期相关扩展
 */
@interface NSDate (HDFDate)

/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)hdf_day;
- (NSUInteger)hdf_month;
- (NSUInteger)hdf_year;
- (NSUInteger)hdf_hour;
- (NSUInteger)hdf_minute;
- (NSUInteger)hdf_second;
+ (NSUInteger)hdf_day:(NSDate *)hdf_date;
+ (NSUInteger)hdf_month:(NSDate *)hdf_date;
+ (NSUInteger)hdf_year:(NSDate *)hdf_date;
+ (NSUInteger)hdf_hour:(NSDate *)hdf_date;
+ (NSUInteger)hdf_minute:(NSDate *)hdf_date;
+ (NSUInteger)hdf_second:(NSDate *)hdf_date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)hdf_daysInYear;
+ (NSUInteger)hdf_daysInYear:(NSDate *)hdf_date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)hdf_isLeapYear;
+ (BOOL)hdf_isLeapYear:(NSDate *)hdf_date;
+ (BOOL)hdf_isLeapYearWithYear:(int)year;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)hdf_weekOfYear;
+ (NSUInteger)hdf_weekOfYear:(NSDate *)hdf_date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)hdf_formatYMD;
+ (NSString *)hdf_formatYMD:(NSDate *)hdf_date;

/**
 * 返回当前月一共有几周(可能为4,5,6)hdf_
 */
- (NSUInteger)hdf_weeksOfMonth;
+ (NSUInteger)hdf_weeksOfMonth:(NSDate *)hdf_date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)hdf_begindayOfMonth;
+ (NSDate *)hdf_begindayOfMonth:(NSDate *)hdf_date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)hdf_lastdayOfMonth;
+ (NSDate *)hdf_lastdayOfMonth:(NSDate *)hdf_date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)hdf_
 */
- (NSDate *)hdf_dateAfterDay:(NSUInteger)hdf_day;
+ (NSDate *)hdf_dateAfterDate:(NSDate *)hdf_date day:(NSInteger)hdf_day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)hdf_
 */
- (NSDate *)hdf_dateAfterMonth:(NSUInteger)hdf_month;
+ (NSDate *)hdf_dateAfterDate:(NSDate *)hdf_date month:(NSInteger)hdf_month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)hdf_offsetYears:(int)hdf_numYears;
+ (NSDate *)hdf_offsetYears:(int)hdf_numYears fromDate:(NSDate *)hdf_fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)hdf_offsetMonths:(int)hdf_numMonths;
+ (NSDate *)hdf_offsetMonths:(int)hdf_numMonths fromDate:(NSDate *)hdf_fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)hdf_offsetDays:(int)hdf_numDays;
+ (NSDate *)hdf_offsetDays:(int)hdf_numDays fromDate:(NSDate *)hdf_fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)hdf_offsetHours:(int)hdf_hours;
+ (NSDate *)hdf_offsetHours:(int)hdf_numHours fromDate:(NSDate *)hdf_fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)hdf_daysAgo;
+ (NSUInteger)hdf_daysAgo:(NSDate *)hdf_date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)hdf_weekday;
+ (NSInteger)hdf_weekday:(NSDate *)hdf_date;

/**
 *  获取星期几(名称)hdf_
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)hdf_dayFromWeekday;
+ (NSString *)hdf_dayFromWeekday:(NSDate *)hdf_date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)hdf_isSameDay:(NSDate *)hdf_anotherDate;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)hdf_isToday;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)hdf_dateByAddingDays:(NSUInteger)hdf_days;

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)hdf_monthWithMonthNumber:(NSInteger)hdf_month;

/**
 * 根据日期返回字符串
 */
+ (NSString *)hdf_stringWithDate:(NSDate *)hdf_date format:(NSString *)hdf_format;
- (NSString *)hdf_stringWithFormat:(NSString *)hdf_format;
+ (NSDate *)hdf_dateWithString:(NSString *)hdf_string format:(NSString *)hdf_format;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)hdf_daysInMonth:(NSUInteger)hdf_month;
+ (NSUInteger)hdf_daysInMonth:(NSDate *)hdf_date month:(NSUInteger)hdf_month;
+ (NSUInteger)hdf_dayInYear:(NSUInteger)year month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)hdf_daysInMonth;
+ (NSUInteger)hdf_daysInMonth:(NSDate *)hdf_date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)hdf_timeInfo;
+ (NSString *)hdf_timeInfoWithDate:(NSDate *)hdf_date;
+ (NSString *)hdf_timeInfoWithDateString:(NSString *)hdf_dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)hdf_ymdFormat;
- (NSString *)hdf_hmsFormat;
- (NSString *)hdf_ymdHmsFormat;
+ (NSString *)hdf_ymdFormat;
+ (NSString *)hdf_hmsFormat;
+ (NSString *)hdf_ymdHmsFormat;

/**
 * @author huangyibiao
 *
 * @param  date fromDate
 *
 * @return a NSDateComponents object
 */
+ (NSDateComponents *)hdf_dateComponentsWithDate:(NSDate *)date;

/**
 * @author huangyibiao
 *
 * 将日期转换成时间戳
 */
- (NSString *)hdf_toTimeStamp;

/**
 * @author huangyibiao
 *
 * 将时间戳转换成日期
 *
 * @param timeStamp 时间戳
 */
+ (NSDate *)hdf_toDateWithTimeStamp:(NSString *)timeStamp;

/**
 * @author huangyibiao
 *
 * 将国际日期转换成本地日期（系统日期，因为我们国家地处东八区，会与国际相关8个时区）
 *
 * @param anyDate 国际日期
 *
 * @return 返回本地日期（系统日期）
 */
+ (NSDate *)hdf_localDateWithDate:(NSDate *)anyDate;

@end
