//
//  ZJGuardView.h
//  GuardDemo
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 张洪健. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GuideTapBlock)(void);

typedef enum : NSUInteger {
    ShowDirectionRightTop,
    ShowDirectionRightDown,
    ShowDirectionLeftTop,
    ShowDirectionLeftDown,
} ShowDirection;

@interface ZJGuardView : UIView

- (void)showForView:(UIView *)forView
            subView:(UIView *)subView
          direction:(ShowDirection)direction
              title:(NSString *)title
           btnTitle:(NSString *)btnTitle
           afterTap:(GuideTapBlock)afterTapBlock;

@end
