//
//  Created by 黄仪标 on 15/6/14.
//  Copyright (c) 2015年 haodf. All rights reserved.
//

#import "NSDate+HDFDate.h"

@implementation NSDate (HDFDate)

- (NSUInteger)hdf_day {
  return [NSDate hdf_day:self];
}

- (NSUInteger)hdf_month {
  return [NSDate hdf_month:self];
}

- (NSUInteger)hdf_year {
  return [NSDate hdf_year:self];
}

- (NSUInteger)hdf_hour {
  return [NSDate hdf_hour:self];
}

- (NSUInteger)hdf_minute {
  return [NSDate hdf_minute:self];
}

- (NSUInteger)hdf_second {
  return [NSDate hdf_second:self];
}

+ (NSUInteger)hdf_day:(NSDate *)hdf_date {
  return [[self hdf_dateComponentsWithDate:hdf_date] day];
}

+ (NSUInteger)hdf_month:(NSDate *)hdf_date {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
  // NSDayCalendarUnit
  NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth)fromDate:hdf_date];
#else
  NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit)fromDate:hdf_date];
#endif
  
  return [dayComponents month];
}

+ (NSUInteger)hdf_year:(NSDate *)hdf_date {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
  // NSDayCalendarUnit
  NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear)fromDate:hdf_date];
#else
  NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit)fromDate:hdf_date];
#endif
  
  return [dayComponents year];
}

+ (NSUInteger)hdf_hour:(NSDate *)hdf_date {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
  // NSDayCalendarUnit
  NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour)fromDate:hdf_date];
#else
  NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit)fromDate:hdf_date];
#endif
  
  return [dayComponents hour];
}

+ (NSUInteger)hdf_minute:(NSDate *)hdf_date {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
  // NSDayCalendarUnit
  NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute)fromDate:hdf_date];
#else
  NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit)fromDate:hdf_date];
#endif
  
  return [dayComponents minute];
}

+ (NSUInteger)hdf_second:(NSDate *)hdf_date {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
  // NSDayCalendarUnit
  NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond)fromDate:hdf_date];
#else
  NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit)fromDate:hdf_date];
#endif
  
  return [dayComponents second];
}

- (NSUInteger)hdf_daysInYear {
  return [NSDate hdf_daysInYear:self];
}

+ (NSUInteger)hdf_daysInYear:(NSDate *)hdf_date {
  return [self hdf_isLeapYear:hdf_date] ? 366 : 365;
}

- (BOOL)hdf_isLeapYear {
  return [NSDate hdf_isLeapYear:self];
}

+ (BOOL)hdf_isLeapYear:(NSDate *)hdf_date {
  int year = (int)[hdf_date hdf_year];
  return [self hdf_isLeapYearWithYear:year];
}

+ (BOOL)hdf_isLeapYearWithYear:(int)year {
  if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
    return YES;
  }
  
  return NO;
}

- (NSString *)hdf_formatYMD {
  return [NSDate hdf_formatYMD:self];
}

+ (NSString *)hdf_formatYMD:(NSDate *)hdf_date {
  return [NSString stringWithFormat:@"%ld-%02ld-%02ld",
          (long)[hdf_date hdf_year],
          (long)[hdf_date hdf_month],
          (long)[hdf_date hdf_day]];
}

- (NSUInteger)hdf_weeksOfMonth {
  return [NSDate hdf_weeksOfMonth:self];
}

+ (NSUInteger)hdf_weeksOfMonth:(NSDate *)hdf_date {
  return [[hdf_date hdf_lastdayOfMonth] hdf_weekOfYear] - [[hdf_date hdf_begindayOfMonth] hdf_weekOfYear] + 1;
}

- (NSUInteger)hdf_weekOfYear {
  return [NSDate hdf_weekOfYear:self];
}

+ (NSUInteger)hdf_weekOfYear:(NSDate *)hdf_date {
  NSUInteger i;
  NSUInteger year = [hdf_date hdf_year];
  
  NSDate *lastdate = [hdf_date hdf_lastdayOfMonth];
  
  for (i = 1;[[lastdate hdf_dateAfterDay:-7 * i] hdf_year] == year; i++) {
    
  }
  
  return i;
}

- (NSDate *)hdf_dateAfterDay:(NSUInteger)hdf_day {
  return [NSDate hdf_dateAfterDate:self day:hdf_day];
}

+ (NSDate *)hdf_dateAfterDate:(NSDate *)hdf_date day:(NSInteger)hdf_day {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
  [componentsToAdd setDay:hdf_day];
  
  NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:hdf_date options:0];
  
  return dateAfterDay;
}

- (NSDate *)hdf_dateAfterMonth:(NSUInteger)hdf_month {
  return [NSDate hdf_dateAfterDate:self month:hdf_month];
}

+ (NSDate *)hdf_dateAfterDate:(NSDate *)hdf_date month:(NSInteger)hdf_month {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
  [componentsToAdd setMonth:hdf_month];
  NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:hdf_date options:0];
  
  return dateAfterMonth;
}

- (NSDate *)hdf_begindayOfMonth {
  return [NSDate hdf_begindayOfMonth:self];
}

+ (NSDate *)hdf_begindayOfMonth:(NSDate *)hdf_date {
  return [self hdf_dateAfterDate:hdf_date day:-[hdf_date hdf_day] + 1];
}

- (NSDate *)hdf_lastdayOfMonth {
  return [NSDate hdf_lastdayOfMonth:self];
}

+ (NSDate *)hdf_lastdayOfMonth:(NSDate *)hdf_date {
  NSDate *lastDate = [self hdf_begindayOfMonth:hdf_date];
  return [[lastDate hdf_dateAfterMonth:1] hdf_dateAfterDay:-1];
}

- (NSUInteger)hdf_daysAgo {
  return [NSDate hdf_daysAgo:self];
}

+ (NSUInteger)hdf_daysAgo:(NSDate *)hdf_date {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
  NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                             fromDate:hdf_date
                                               toDate:[NSDate date]
                                              options:0];
#else
  NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                             fromDate:hdf_date
                                               toDate:[NSDate date]
                                              options:0];
#endif
  
  return [components day];
}

- (NSInteger)hdf_weekday {
  return [NSDate hdf_weekday:self];
}

+ (NSInteger)hdf_weekday:(NSDate *)hdf_date {
  NSCalendar *gregorian = [[NSCalendar alloc]
                           initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:hdf_date];
  NSInteger weekday = [comps weekday];
  
  return weekday;
}

- (NSString *)hdf_dayFromWeekday {
  return [NSDate hdf_dayFromWeekday:self];
}

+ (NSString *)hdf_dayFromWeekday:(NSDate *)hdf_date {
  switch([hdf_date hdf_weekday]) {
    case 1:
      return @"星期天";
      break;
    case 2:
      return @"星期一";
      break;
    case 3:
      return @"星期二";
      break;
    case 4:
      return @"星期三";
      break;
    case 5:
      return @"星期四";
      break;
    case 6:
      return @"星期五";
      break;
    case 7:
      return @"星期六";
      break;
    default:
      break;
  }
  return @"";
}

- (BOOL)hdf_isSameDay:(NSDate *)hdf_anotherDate {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                        | NSCalendarUnitMonth
                                                        | NSCalendarUnitDay)
                                              fromDate:self];
  NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                        | NSCalendarUnitMonth
                                                        | NSCalendarUnitDay)
                                              fromDate:hdf_anotherDate];
  return ([components1 year] == [components2 year]
          && [components1 month] == [components2 month]
          && [components1 day] == [components2 day]);
}

- (BOOL)hdf_isToday {
  return [self hdf_isSameDay:[NSDate date]];
}

- (NSDate *)hdf_dateByAddingDays:(NSUInteger)hdf_days {
  NSDateComponents *c = [[NSDateComponents alloc] init];
  c.day = hdf_days;
  return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

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
+ (NSString *)hdf_monthWithMonthNumber:(NSInteger)hdf_month {
  switch(hdf_month) {
    case 1:
      return @"January";
      break;
    case 2:
      return @"February";
      break;
    case 3:
      return @"March";
      break;
    case 4:
      return @"April";
      break;
    case 5:
      return @"May";
      break;
    case 6:
      return @"June";
      break;
    case 7:
      return @"July";
      break;
    case 8:
      return @"August";
      break;
    case 9:
      return @"September";
      break;
    case 10:
      return @"October";
      break;
    case 11:
      return @"November";
      break;
    case 12:
      return @"December";
      break;
    default:
      break;
  }
  return @"";
}

+ (NSString *)hdf_stringWithDate:(NSDate *)hdf_date format:(NSString *)hdf_format {
  return [hdf_date hdf_stringWithFormat:hdf_format];
}

- (NSString *)hdf_stringWithFormat:(NSString *)hdf_format {
  NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
  [outputFormatter setDateFormat:hdf_format];
  [outputFormatter setTimeZone:[NSTimeZone systemTimeZone]];
  NSString *retStr = [outputFormatter stringFromDate:self];
  
  return retStr;
}

+ (NSDate *)hdf_dateWithString:(NSString *)hdf_string format:(NSString *)hdf_format {
  NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
  [inputFormatter setDateFormat:hdf_format];
  [inputFormatter setTimeZone:[NSTimeZone systemTimeZone]];
  NSDate *date = [inputFormatter dateFromString:hdf_string];
  
  return date;
}

- (NSUInteger)hdf_daysInMonth:(NSUInteger)hdf_month {
  return [NSDate hdf_daysInMonth:self month:hdf_month];
}

+ (NSUInteger)hdf_dayInYear:(NSUInteger)year month:(NSUInteger)month {
  switch (month) {
    case 1: case 3: case 5: case 7: case 8: case 10: case 12:
      return 31;
    case 2:
      return [self hdf_isLeapYearWithYear:year] ? 29 : 28;
  }
  
  return 30;
}

+ (NSUInteger)hdf_daysInMonth:(NSDate *)hdf_date month:(NSUInteger)hdf_month {
  switch (hdf_month) {
    case 1: case 3: case 5: case 7: case 8: case 10: case 12:
      return 31;
    case 2:
      return [hdf_date hdf_isLeapYear] ? 29 : 28;
  }
  return 30;
}

- (NSUInteger)hdf_daysInMonth {
  return [NSDate hdf_daysInMonth:self];
}

+ (NSUInteger)hdf_daysInMonth:(NSDate *)hdf_date {
  return [self hdf_daysInMonth:hdf_date month:[hdf_date hdf_month]];
}

- (NSString *)hdf_timeInfo {
  return [NSDate hdf_timeInfoWithDate:self];
}

+ (NSString *)hdf_timeInfoWithDate:(NSDate *)hdf_date {
  return [self hdf_timeInfoWithDateString:[self hdf_stringWithDate:hdf_date format:[self hdf_ymdHmsFormat]]];
}

+ (NSString *)hdf_timeInfoWithDateString:(NSString *)hdf_dateString {
  NSDate *date = [self hdf_dateWithString:hdf_dateString format:[self hdf_ymdHmsFormat]];
  
  NSDate *curDate = [NSDate date];
  NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
  
  int month = (int)([curDate hdf_month] - [date hdf_month]);
  int year = (int)([curDate hdf_year] - [date hdf_year]);
  int day = (int)([curDate hdf_day] - [date hdf_day]);
  
  NSTimeInterval retTime = 1.0;
  if (time < 3600) { // 小于一小时
    retTime = time / 60;
    retTime = retTime <= 0.0 ? 1.0 : retTime;
    return [NSString stringWithFormat:@"%.0f分钟前", retTime];
  } else if (time < 3600 * 24) { // 小于一天，也就是今天
    retTime = time / 3600;
    retTime = retTime <= 0.0 ? 1.0 : retTime;
    return [NSString stringWithFormat:@"%.0f小时前", retTime];
  } else if (time < 3600 * 24 * 2) {
    return @"昨天";
  }
  // 第一个条件是同年，且相隔时间在一个月内
  // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
  else if ((abs(year) == 0 && abs(month) <= 1)
           || (abs(year) == 1 && [curDate hdf_month] == 1 && [date hdf_month] == 12)) {
    int retDay = 0;
    if (year == 0) { // 同年
      if (month == 0) { // 同月
        retDay = day;
      }
    }
    
    if (retDay <= 0) {
      // 获取发布日期中，该月有多少天
      int totalDays = (int)[self hdf_daysInMonth:date month:[date hdf_month]];
      
      // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
      retDay = (int)[curDate hdf_day] + (totalDays - (int)[date hdf_day]);
    }
    
    return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
  } else  {
    if (abs(year) <= 1) {
      if (year == 0) { // 同年
        return [NSString stringWithFormat:@"%d个月前", abs(month)];
      }
      
      // 隔年
      int month = (int)[curDate hdf_month];
      int preMonth = (int)[date hdf_month];
      if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
        return @"1年前";
      }
      return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
    }
    
    return [NSString stringWithFormat:@"%d年前", abs(year)];
  }
  
  return @"1小时前";
}

- (NSString *)hdf_ymdFormat {
  return [NSDate hdf_ymdFormat];
}

- (NSString *)hdf_hmsFormat {
  return [NSDate hdf_hmsFormat];
}

- (NSString *)hdf_ymdHmsFormat {
  return [NSDate hdf_ymdHmsFormat];
}

+ (NSString *)hdf_ymdFormat {
  return @"yyyy-MM-dd";
}

+ (NSString *)hdf_hmsFormat {
  return @"HH:mm:ss";
}

+ (NSString *)hdf_ymdHmsFormat {
  return [NSString stringWithFormat:@"%@ %@", [self hdf_ymdFormat], [self hdf_hmsFormat]];
}

- (NSDate *)hdf_offsetYears:(int)hdf_numYears {
  return [NSDate hdf_offsetYears:hdf_numYears fromDate:self];
}

+ (NSDate *)hdf_offsetYears:(int)hdf_numYears fromDate:(NSDate *)hdf_fromDate {
  if (hdf_fromDate == nil) {
    return nil;
  }
  
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
  // NSDayCalendarUnit
  NSCalendar *gregorian = [[NSCalendar alloc]
                           initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
  NSCalendar *gregorian = [[NSCalendar alloc]
                           initWithCalendarIdentifier:NSGregorianCalendar];
#endif
  
  
  NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
  [offsetComponents setYear:hdf_numYears];
  
  return [gregorian dateByAddingComponents:offsetComponents
                                    toDate:hdf_fromDate
                                   options:0];
}

- (NSDate *)hdf_offsetMonths:(int)hdf_numMonths {
  return [NSDate hdf_offsetMonths:hdf_numMonths fromDate:self];
}

+ (NSDate *)hdf_offsetMonths:(int)hdf_numMonths fromDate:(NSDate *)hdf_fromDate {
  if (hdf_fromDate == nil) {
    return nil;
  }
  
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
  // NSDayCalendarUnit
  NSCalendar *gregorian = [[NSCalendar alloc]
                           initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
  NSCalendar *gregorian = [[NSCalendar alloc]
                           initWithCalendarIdentifier:NSGregorianCalendar];
#endif
  
  NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
  [offsetComponents setMonth:hdf_numMonths];
  
  return [gregorian dateByAddingComponents:offsetComponents
                                    toDate:hdf_fromDate
                                   options:0];
}

- (NSDate *)hdf_offsetDays:(int)hdf_numDays {
  return [NSDate hdf_offsetDays:hdf_numDays fromDate:self];
}

+ (NSDate *)hdf_offsetDays:(int)hdf_numDays fromDate:(NSDate *)hdf_fromDate {
  if (hdf_fromDate == nil) {
    return nil;
  }
  
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
  // NSDayCalendarUnit
  NSCalendar *gregorian = [[NSCalendar alloc]
                           initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
  NSCalendar *gregorian = [[NSCalendar alloc]
                           initWithCalendarIdentifier:NSGregorianCalendar];
#endif
  
  
  NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
  [offsetComponents setDay:hdf_numDays];
  
  return [gregorian dateByAddingComponents:offsetComponents
                                    toDate:hdf_fromDate
                                   options:0];
}

- (NSDate *)hdf_offsetHours:(int)hdf_hours {
  return [NSDate hdf_offsetHours:hdf_hours fromDate:self];
}

+ (NSDate *)hdf_offsetHours:(int)hdf_numHours fromDate:(NSDate *)hdf_fromDate {
  if (hdf_fromDate == nil) {
    return nil;
  }
  
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
  // NSDayCalendarUnit
  NSCalendar *gregorian = [[NSCalendar alloc]
                           initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
  NSCalendar *gregorian = [[NSCalendar alloc]
                           initWithCalendarIdentifier:NSGregorianCalendar];
#endif
  
  
  NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
  [offsetComponents setHour:hdf_numHours];
  
  return [gregorian dateByAddingComponents:offsetComponents
                                    toDate:hdf_fromDate
                                   options:0];
}

+ (NSDateComponents *)hdf_dateComponentsWithDate:(NSDate *)date {
  NSCalendar *calendar = nil;
  NSUInteger flags = 0;
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
  calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
  flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour
  | NSCalendarUnitMinute | NSCalendarUnitSecond;
#else
  calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit
  | NSMinuteCalendarUnit | NSSecondCalendarUnit;
#endif
  [calendar setTimeZone:[NSTimeZone systemTimeZone]];
  
  return [calendar components:flags fromDate:date];
}

- (NSString *)hdf_toTimeStamp {
  return [NSString stringWithFormat:@"%lf", [self timeIntervalSince1970]];
}

+ (NSDate *)hdf_toDateWithTimeStamp:(NSString *)timeStamp {
  NSString *arg = timeStamp;
  if (![timeStamp isKindOfClass:[NSString class]]) {
    arg = [NSString stringWithFormat:@"%@", timeStamp];
  }
  NSTimeInterval time = [timeStamp doubleValue];
  return [NSDate dateWithTimeIntervalSince1970:time];
}


+ (NSDate *)hdf_localDateWithDate:(NSDate *)anyDate {
  //设置源日期时区
  NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
  //设置转换后的目标日期时区
  NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
  //得到源日期与世界标准时间的偏移量
  NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
  //目标日期与本地时区的偏移量
  NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
  //得到时间偏移量的差值
  NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
  //转为现在时间
  NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
  return destinationDateNow;
}

@end
