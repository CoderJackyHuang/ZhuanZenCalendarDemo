//
//  ViewController.m
//  ZhuanZenCalendarDemo
//
//  Created by huangyibiao on 16/4/11.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "ViewController.h"
#import "HDFHospitalCalendarView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Do" style:UIBarButtonItemStylePlain target:self action:@selector(onOpen)];
}

- (void)onOpen {
  [HDFHospitalCalendarView showInView:self.view size:CGSizeMake(280,260) selectedDate:nil onSelected:^(NSDate *selectedDate) {
    
  } onCancel:^{
    
  }];
}

@end
