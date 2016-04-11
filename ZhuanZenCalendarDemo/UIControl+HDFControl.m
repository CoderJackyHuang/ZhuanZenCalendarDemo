//
//  UIControl+HDFControl.m
//  DEMO
//
//  Created by huangyibiao on 15/6/10.
//  Copyright (c) 2015年 huangyibiao. All rights reserved.
//

#import "UIControl+HDFControl.h"
#import <objc/runtime.h>

// TouchDown/TouchUp事件的key
static const void *s_HDFButtonTouchDownKey = "s_HDFButtonTouchDownKey";
static const void *s_HDFButtonTouchUpKey = "s_HDFButtonTouchUpKey";
static const void *s_HDFValueChangedKey = "s_HDFValueChangedKey";


@implementation UIControl (HDFControl)

- (void)setHdf_touchDown:(HDFButtonBlock)touchDown {
  objc_setAssociatedObject(self, s_HDFButtonTouchDownKey, touchDown, OBJC_ASSOCIATION_COPY);
  
  [self removeTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
  
  if (touchDown) {
    [self addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
  }
}

- (HDFButtonBlock)hdf_touchDown {
  HDFButtonBlock downBlock = objc_getAssociatedObject(self, s_HDFButtonTouchDownKey);
  return downBlock;
}

- (void)setHdf_touchUp:(HDFButtonBlock)touchUp {
  objc_setAssociatedObject(self, s_HDFButtonTouchUpKey, touchUp, OBJC_ASSOCIATION_COPY);
  
  [self removeTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchUpInside];
  
  if (touchUp) {
    [self addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchUpInside];
  }
}

- (HDFButtonBlock)hdf_touchUp {
  HDFButtonBlock upBlock = objc_getAssociatedObject(self, s_HDFButtonTouchUpKey);
  return upBlock;
}

- (void)setHdf_valueChangedBlock:(HDFValueChangedBlock)valueChangedBlock {
  objc_setAssociatedObject(self, s_HDFValueChangedKey, valueChangedBlock, OBJC_ASSOCIATION_COPY);
  
  [self removeTarget:self action:@selector(onValueChanged:) forControlEvents:UIControlEventTouchUpInside];
  
  if (valueChangedBlock) {
    [self addTarget:self action:@selector(onValueChanged:) forControlEvents:UIControlEventValueChanged];
  }
}

- (HDFValueChangedBlock)hdf_valueChangedBlock {
  HDFValueChangedBlock block = objc_getAssociatedObject(self, s_HDFValueChangedKey);
  return block;
}

- (void)onValueChanged:(id)sender {
  HDFValueChangedBlock block = [self hdf_valueChangedBlock];
  
  if (block) {
    block(sender);
  }
}

- (void)onTouchUp:(UIButton *)sender {
  HDFButtonBlock touchUp = [self hdf_touchUp];
  
  if (touchUp) {
    touchUp(sender);
  }
}

- (void)onTouchDown:(UIButton *)sender {
  HDFButtonBlock touchDown = [self hdf_touchDown];
  
  if (touchDown) {
    touchDown(sender);
  }
}

@end
