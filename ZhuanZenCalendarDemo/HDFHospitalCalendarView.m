//
//  HDFHospitalCalendarView.m
//  ZhuanZenCalendarDemo
//
//  Created by huangyibiao on 16/4/11.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HDFHospitalCalendarView.h"
#import "NSDate+HDFDate.h"
#import "UIView+HDFView.h"
#import "UIControl+HDFControl.h"

#define kDuration 0.35

@interface  HDFCalendarModel : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) BOOL canBeSelected;

@end

@implementation HDFCalendarModel

@end

@interface HDFCalendarCell : UICollectionViewCell

@property (nonatomic, strong) HDFCalendarModel *model;
@property (nonatomic, strong) UILabel *dayLabel;

@end

@implementation HDFCalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.dayLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.dayLabel.backgroundColor= [UIColor whiteColor];
    self.dayLabel.textAlignment = NSTextAlignmentCenter;
    self.dayLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.dayLabel];
  }
  
  return self;
}

- (void)setModel:(HDFCalendarModel *)model {
  if (model != _model) {
    _model = model;
    
    self.dayLabel.text = [NSString stringWithFormat:@"%ld", [model.date hdf_day]];
    
    if (model.canBeSelected) {
      self.dayLabel.textColor = [UIColor blackColor];
    } else {
      self.dayLabel.textColor = [UIColor lightGrayColor];
    }
  }
}

@end

@interface HDFHospitalCalendarView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIButton *currentMonthButton;
@property (nonatomic, strong) UIButton *nextMonthButton;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionView *nextCollectionView;

@property (nonatomic, copy) HDFCalendarSelected selectedBlock;
@property (nonatomic, copy) HDCalendarCancel   cancelBlock;
@property (nonatomic, strong) NSDate *currentSelectedDate;
@property (nonatomic, strong) NSMutableArray *dataSources;

@end

@implementation HDFHospitalCalendarView

+ (instancetype)showInView:(UIView *)inView
                      size:(CGSize)size
              selectedDate:(NSDate *)selectedDate
                onSelected:(HDFCalendarSelected)onSelected
                  onCancel:(HDCalendarCancel)onCancel {
  __block HDFHospitalCalendarView *calendarView = nil;
  
  // 防止重复
  [inView.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
    if ([obj isKindOfClass:[HDFHospitalCalendarView class]]) {
      *stop = YES;
      calendarView = (HDFHospitalCalendarView *)obj;
      [calendarView dismiss];
    }
  }];
  
  if (calendarView) {
    return calendarView;
  }
  
  CGRect frame = CGRectMake(0, 0, size.width, size.height);
  
  if (calendarView == nil) {
    calendarView = [[HDFHospitalCalendarView alloc] initWithFrame:frame];
    UIView *alphaView = [[UIView alloc] initWithFrame:inView.bounds];
    alphaView.tag = 0x010101;
    [inView addSubview:alphaView];
    calendarView.center = inView.center;
    [inView addSubview:calendarView];
    calendarView.transform = CGAffineTransformMakeScale(0, 0);
    calendarView.backgroundColor = [UIColor whiteColor];
    
    [UIView animateWithDuration:kDuration animations:^{
      alphaView.backgroundColor =  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
      calendarView.transform = CGAffineTransformIdentity;
    }];
  }
  
  calendarView.selectedBlock = onSelected;
  calendarView.cancelBlock = onCancel;
  calendarView.currentSelectedDate = selectedDate;
  
  return calendarView;
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
        NSDate *today = [[NSDate date] hdf_dateAfterDay:15];
//    NSDate *today = [NSDate date];
    NSUInteger hour = [today hdf_hour];
    
    NSUInteger day = [today hdf_day];
    NSUInteger currentMonthMaxDays = [today hdf_daysInMonth];
    
    NSUInteger howManyMonths = 1;
    // 13点前的，不包含13点，范围为【X+2, X+15】
    if (hour < 13) {
      // 有下个月，则两栏显示
      if ((day + 2 > currentMonthMaxDays) || (day + 15 > currentMonthMaxDays)) {
        howManyMonths = 2;
      } else { // 只有本月
        howManyMonths = 1;
      }
    }
    // 13点后，包括13点的，范围为【X+3, X+16】
    else {
      // 有下个月，则两栏显示
      if ((day + 3 > currentMonthMaxDays) || (day + 16 > currentMonthMaxDays)) {
        howManyMonths = 2;
      } else { // 只有本月
        howManyMonths = 1;
      }
    }
    
     __weak __typeof(self) weakSelf = self;
    // 标题：哪年哪月这一栏
    NSUInteger currentMonth = [today hdf_month];
    NSUInteger currentYear = [today hdf_year];
    UIScrollView *titleView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.hdf_width, 20)];
    titleView.backgroundColor = [UIColor whiteColor];
    [self addSubview:titleView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (howManyMonths == 1) {
      button.frame = titleView.bounds;
    } else {
      button.frame = CGRectMake(0, 0, titleView.frame.size.width / 2, titleView.frame.size.height);
      
      UIButton *nextMonthButton = [UIButton buttonWithType:UIButtonTypeCustom];
      nextMonthButton.frame = CGRectMake(button.frame.size.width, 0, titleView.frame.size.width / 2, titleView.frame.size.height);
      NSUInteger nextMonth = currentMonth + 1;
      NSUInteger nextMonthYear = currentYear;
      if (nextMonth > 12) {
        nextMonth -= 12;
        nextMonthYear += 1;
      }
      
      [nextMonthButton setTitle:[NSString stringWithFormat:@"%04ld年%02ld月", nextMonthYear, nextMonth]
                       forState:UIControlStateNormal];
      [nextMonthButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
      [nextMonthButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
      [titleView addSubview:nextMonthButton];
      self.nextMonthButton = nextMonthButton;
      
     
      nextMonthButton.hdf_touchUp = ^(id sender) {
        [weakSelf onSelectedButton:sender];
      };
    }
    
    self.currentMonthButton = button;
    
    [titleView addSubview:button];
    [button setTitle:[NSString stringWithFormat:@"%04ld年%02ld月", currentYear, currentMonth]
            forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    button.selected = YES;
    
    button.hdf_touchUp = ^(id sender) {
      [weakSelf onSelectedButton:sender];
    };
    
    //
    // 星期几一栏
    UIView *weekDayView = [[UIView alloc] initWithFrame: CGRectMake(0, titleView.hdf_bottomY, self.bounds.size.width, 20)];
    [self addSubview:weekDayView];
    
    NSArray *titles = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    CGFloat x = 0;
    CGFloat w = weekDayView.bounds.size.width / titles.count;
    for (NSUInteger i = 0; i < titles.count; ++i) {
      UILabel *label = [[UILabel alloc] init];
      label.backgroundColor = [UIColor whiteColor];
      label.text = titles[i];
      label.textColor = [UIColor blackColor];
      label.frame = CGRectMake(x, 0, w, weekDayView.hdf_height);
      [weekDayView addSubview:label];
      label.textAlignment = NSTextAlignmentCenter;
      
      x += w;
    }
    
    //
    // 取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(40, self.hdf_height - 10 - 30, self.hdf_width - 40 * 2, 30);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelButton.hdf_touchUp = ^(id sender) {
      if (self.cancelBlock) {
        self.cancelBlock();
      }
      
      [self dismiss];
    };
    [self addSubview:cancelButton];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat height = self.hdf_height - weekDayView.hdf_bottomY - cancelButton.hdf_height - 10;
    layout.itemSize = CGSizeMake(self.hdf_width / 8, height /  5);
    layout.minimumLineSpacing = 2;
    layout.minimumInteritemSpacing = 2;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, weekDayView.hdf_bottomY, self.hdf_width, height)
                                             collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[HDFCalendarCell class] forCellWithReuseIdentifier:@"HDFCalendarCell"];
    
    if (howManyMonths == 1) {
      [self addSubview:self.collectionView];
    } else {
      UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, weekDayView.hdf_bottomY, self.hdf_width, height)];
      scrollView.scrollEnabled = YES;
      scrollView.backgroundColor = [UIColor whiteColor];
      self.collectionView.hdf_originY = 0;
      [scrollView addSubview:self.collectionView];
      
      UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
      layout.scrollDirection = UICollectionViewScrollDirectionVertical;
      layout.itemSize = CGSizeMake(self.hdf_width / 8, height / 5);
      layout.minimumInteritemSpacing = 2;
      layout.minimumLineSpacing = 2;
      self.nextCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.collectionView.hdf_width, 0, self.hdf_width, height)
                                                   collectionViewLayout:layout];
      self.nextCollectionView.backgroundColor = [UIColor whiteColor];
      self.nextCollectionView.dataSource = self;
      self.nextCollectionView.delegate = self;
      [self.nextCollectionView registerClass:[HDFCalendarCell class] forCellWithReuseIdentifier:@"HDFCalendarCell"];
      
      scrollView.contentSize = CGSizeMake(self.hdf_width * 2, height);
      scrollView.pagingEnabled = YES;
      
      [scrollView addSubview:self.nextCollectionView];
      [self addSubview:scrollView];
      scrollView.delegate = self;
      self.scrollView = scrollView;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
      NSMutableArray *currentMonthDataSource = [[NSMutableArray alloc] init];
      NSUInteger twoOrThree = hour < 13 ? 2 : 3;
      NSUInteger fifttenOrSixteen = hour < 13 ? 15 : 16;
      
      NSDate *firstOfCurrentMonth = [today hdf_begindayOfMonth];
      NSUInteger selectedCount = 0;
      for (NSUInteger i = 0; i < currentMonthMaxDays; ++i) {
        HDFCalendarModel *model = [[HDFCalendarModel alloc] init];
        model.date = [firstOfCurrentMonth hdf_dateAfterDay:i];

        if (i >= day + twoOrThree && i <= day + fifttenOrSixteen) {
          model.canBeSelected = YES;
          selectedCount++;
        }
        
        [currentMonthDataSource addObject:model];
      }
      
      [self.dataSources addObject:currentMonthDataSource];
      
      // 添加数据
      if (howManyMonths == 2) {// 有下个月的数据
        NSUInteger nextMonth = currentMonth + 1;
        NSUInteger nextMonthYear = currentYear;
        if (nextMonth > 12) {
          nextMonth -= 12;
          nextMonthYear += 1;
        }
        
        NSMutableArray *nextMonthModels = [[NSMutableArray alloc] init];
        NSDate *nextMonthFirstDate = [today hdf_dateAfterDay:fifttenOrSixteen];
        nextMonthFirstDate = [nextMonthFirstDate hdf_begindayOfMonth];
        NSUInteger maxDaysInNextMonth = [nextMonthFirstDate hdf_daysInMonth];
        
        for (NSUInteger i = 0; i <= maxDaysInNextMonth - 1; ++i) {
          HDFCalendarModel *model = [[HDFCalendarModel alloc] init];
          model.date = [nextMonthFirstDate hdf_dateAfterDay:i];
          if (i <= fifttenOrSixteen - twoOrThree - selectedCount) {
            model.canBeSelected = YES;
            selectedCount++;
          } else {
            model.canBeSelected = NO;
          }
          
          [nextMonthModels addObject:model];
        }
        
        [self.dataSources addObject:nextMonthModels];
      }
      
      dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
      });
    });
  }
  
  return self;
}

- (void)dismiss {
  UIView *alphaView = [self.superview viewWithTag:0x010101];
  
  [UIView animateWithDuration:kDuration animations:^{
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    alphaView.alpha = 0;
  } completion:^(BOOL finished) {
    [alphaView removeFromSuperview];
    [self removeFromSuperview];
  }];
}

#pragma mark - Getter
- (NSMutableArray *)dataSources {
  if (_dataSources == nil) {
    _dataSources = [[NSMutableArray alloc] init];
  }
  
  return _dataSources;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  NSArray *array = [self.dataSources objectAtIndex:collectionView == self.collectionView ? 0 : 1];
  
  return array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  HDFCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HDFCalendarCell"
                                                                    forIndexPath:indexPath];
  NSArray *array = [self.dataSources objectAtIndex:collectionView == self.collectionView ? 0 : 1];
  cell.model = [array objectAtIndex:indexPath.item];
  cell.dayLabel.backgroundColor = [UIColor redColor];
  return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView == self.collectionView.superview) {
    CGFloat offset = scrollView.contentOffset.x;
    NSUInteger index = offset / self.hdf_width;
    
    if (self.currentMonthButton.isSelected && index == 1) {
      self.nextMonthButton.selected = YES;
      self.currentMonthButton.selected = NO;
    } else if (self.nextMonthButton && self.nextMonthButton.isSelected && index == 0) {
      self.nextMonthButton.selected = NO;
      self.currentMonthButton.selected = YES;
    }
  }
}

- (void)onSelectedButton:(UIButton *)sender {
  if (self.currentMonthButton == sender && !self.currentMonthButton.isSelected) {
    self.nextMonthButton.selected = NO;
    self.currentMonthButton.selected = YES;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
  } else if (self.nextMonthButton && self.nextMonthButton == sender && !self.nextMonthButton.isSelected) {
    self.nextMonthButton.selected = YES;
    self.currentMonthButton.selected = NO;
    [self.scrollView setContentOffset:CGPointMake(self.hdf_width, 0) animated:YES];
  }
 
}

@end
