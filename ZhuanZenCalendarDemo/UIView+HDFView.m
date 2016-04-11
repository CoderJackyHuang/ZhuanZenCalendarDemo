//
//  Created by 黄仪标 on 15/6/14.
//  Copyright (c) 2015年 haodf. All rights reserved.
//

#import "UIView+HDFView.h"
#import <objc/runtime.h>

static const void *s_HDFViewTapGestureKey = "s_HDFViewTapGestureKey";
static const void *s_HDFViewLongTapGestureKey = "s_HDFViewLongTapGestureKey";

@interface UIView ()

@property (nonatomic, strong) UITapGestureRecognizer *hdf_tap;
@property (nonatomic, strong) UILongPressGestureRecognizer *hdf_longPress;

@end

@implementation UIView (HDFView)

#pragma mark - 常用frame相关API
- (void)setHdf_origin:(CGPoint)hdf_origin {
  CGRect frame = self.frame;
  frame.origin = hdf_origin;
  self.frame = frame;
}

- (CGPoint)hdf_origin {
  return self.frame.origin;
}

- (void)setHdf_originX:(CGFloat)hdf_originX {
  [self setHdf_origin:CGPointMake(hdf_originX, self.hdf_originY)];
}

- (CGFloat)hdf_originX {
  return self.hdf_origin.x;
}

- (void)setHdf_originY:(CGFloat)hdf_originY {
  [self setHdf_origin:CGPointMake(self.hdf_originX, hdf_originY)];
}

- (CGFloat)hdf_originY {
  return self.hdf_origin.y;
}

- (void)setHdf_center:(CGPoint)hdf_center {
  self.center = hdf_center;
}

- (CGPoint)hdf_center {
  return self.center;
}

- (void)setHdf_centerX:(CGFloat)hdf_centerX {
  [self setHdf_center:CGPointMake(hdf_centerX, self.hdf_centerY)];
}

- (CGFloat)hdf_centerX {
  return self.hdf_center.x;
}

- (void)setHdf_centerY:(CGFloat)hdf_centerY {
  [self setHdf_center:CGPointMake(self.hdf_centerX, hdf_centerY)];
}

- (CGFloat)hdf_centerY {
  return self.hdf_center.y;
}

- (void)setHdf_size:(CGSize)hdf_size {
  CGRect frame = self.frame;
  frame.size = hdf_size;
  self.frame = frame;
}

- (CGSize)hdf_size {
  return self.frame.size;
}

- (void)setHdf_width:(CGFloat)hdf_width {
  self.hdf_size = CGSizeMake(hdf_width, self.hdf_height);
}

- (CGFloat)hdf_width {
  return self.hdf_size.width;
}

- (void)setHdf_height:(CGFloat)hdf_height {
  self.hdf_size = CGSizeMake(self.hdf_width, hdf_height);
}

- (CGFloat)hdf_height {
  return self.hdf_size.height;
}

- (CGFloat)hdf_bottomY {
  return self.hdf_originY + self.hdf_height;
}

- (void)setHdf_bottomY:(CGFloat)hdf_bottomY {
  self.hdf_originY = hdf_bottomY - self.hdf_height;
}

- (CGFloat)hdf_rightX {
  return self.hdf_originX + self.hdf_width;
}

- (void)setHdf_rightX:(CGFloat)hdf_rightX {
  self.hdf_originX = hdf_rightX - self.hdf_width;
}

- (void)hdf_removeAllSubviews {
  for (UIView *view in self.subviews) {
    [view removeFromSuperview];
  }
}

- (UIImage *)hdf_captureScreenshot {
  UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
  
  // after ios 7
  if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
                                [self methodSignatureForSelector:
                                 @selector(drawViewHierarchyInRect:afterScreenUpdates:)]];
    [invocation setTarget:self];
    [invocation setSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)];
    CGRect arg2 = self.bounds;
    BOOL arg3 = YES;
    [invocation setArgument:&arg2 atIndex:2];
    [invocation setArgument:&arg3 atIndex:3];
    [invocation invoke];
  } else { // before ios 7
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
  }
  
  UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return screenshot;
}

- (void)hdf_fadeWithDuration:(NSTimeInterval)duration {
  [UIView hdf_fadeInWithView:self duration:duration];
}

+ (void)hdf_fadeInWithView:(UIView *)fadeView duration:(NSTimeInterval)duration {
  CATransition *animation = [CATransition animation];
  [animation setDuration:duration];
  [animation setType:kCATransitionFade];
  animation.removedOnCompletion = YES;
  [fadeView.layer addAnimation:animation forKey:@"transition"];
}

- (UITapGestureRecognizer *)hdf_addTapGestureWithCompletion:(HDFGestureBlock)completion {
  self.userInteractionEnabled = YES;
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
  tap.hdf_gestureBlock = completion;
  [self addGestureRecognizer:tap];
  self.hdf_tap = tap;
  
  return tap;
}

- (void)hdf_removeTapGesture {
  self.hdf_tap = nil;
}

- (void)setHdf_tap:(UITapGestureRecognizer *)hdf_tap {
  if (hdf_tap == nil) {
    self.hdf_tap.hdf_gestureBlock = nil;
    
    if (self.hdf_tap) {
      [self removeGestureRecognizer:self.hdf_tap];
    }
  }
  
  objc_setAssociatedObject(self, s_HDFViewTapGestureKey,
                           hdf_tap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITapGestureRecognizer *)hdf_tapGetsure {
  return objc_getAssociatedObject(self, s_HDFViewTapGestureKey);
}

- (UITapGestureRecognizer *)hdf_tap {
  return self.hdf_tapGetsure;
}

- (void)hdf_addLongPressGestureWithCompletion:(HDFGestureBlock)completion {
  self.userInteractionEnabled = YES;
  
  if (self.hdf_longPress) {
    self.hdf_longPress.hdf_longGestureBlock = completion;
  } else {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] init];
    longPress.hdf_longGestureBlock = completion;
    [self addGestureRecognizer:longPress];
    self.hdf_longPress = longPress;
  }
}

- (UILongPressGestureRecognizer *)hdf_longPress {
  return objc_getAssociatedObject(self, s_HDFViewLongTapGestureKey);
}

- (UILongPressGestureRecognizer *)hdf_longPressGesture {
  return self.hdf_longPress;
}

- (void)setHdf_longPress:(UILongPressGestureRecognizer *)hdf_longPress {
  if (hdf_longPress == nil) {
    self.hdf_longPress.hdf_longGestureBlock = nil;
    
    if (self.hdf_longPress) {
      [self removeGestureRecognizer:self.hdf_longPress];
    }
  }
  
  objc_setAssociatedObject(self, s_HDFViewLongTapGestureKey, hdf_longPress, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)hdf_removeLongPressGesture {
  self.hdf_longPress = nil;
}


- (void)adjustRadiusByDefault {
    [self adjustRadius:4.0];
}

- (void)adjustRadius:(CGFloat) radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}


- (void)adjustBorder:(CGFloat) radius color:(UIColor *) color {
    self.layer.borderWidth = radius;
    self.layer.borderColor = color.CGColor;
}

@end
