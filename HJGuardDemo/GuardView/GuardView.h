//
//  GuardView.h
//  GuardDemo
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 张洪健. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NewUserGuideTapBlock)(void);

@interface GuardView : UIView

-(void)showOn:(UIView *)onview path:(UIBezierPath *)path appendPath:(BOOL)appendPath image:(UIImage *)image imageAt:(CGPoint)imageAt withKey:(NSString *)withKey afterTap:(NewUserGuideTapBlock)afterTapBlock ;

-(void)showOn:(UIView *)onview forView:(UIView *)forView   cornerRadius:(CGFloat)cornerRadius image:(UIImage *)image imageAt:(CGPoint)imageAt withKey:(NSString *)withKey afterTap:(NewUserGuideTapBlock)afterTapBlock ;

+(BOOL)hadShowNewUserGuideForKey:(NSString *)key;
+(BOOL)isShowingNewUserGuideForKey:(NSString *)key;

#pragma mark 图片 文字 按钮
- (void)showOn:(UIView *)onview
      forView:(UIView *)forView
 cornerRadius:(CGFloat)cornerRadius
        image:(UIImage *)image
      imageAt:(CGPoint)imageAt
     titleStr:(NSString *)titleStr
     btnTitle:(NSString *)btnTitle
      withKey:(NSString *)withKey
     afterTap:(NewUserGuideTapBlock)afterTapBlock;

- (void)showOn:(UIView *)onview
         path:(UIBezierPath *)path
   appendPath:(BOOL)appendPath
        image:(UIImage *)image
      imageAt:(CGPoint)imageAt
     titleStr:(NSString *)titleStr
     btnTitle:(NSString *)btnTitle
      withKey:(NSString *)withKey
     afterTap:(NewUserGuideTapBlock)afterTapBlock;

@end
