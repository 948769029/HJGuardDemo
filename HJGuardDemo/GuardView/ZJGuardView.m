//
//  ZJGuardView.m
//  GuardDemo
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 张洪健. All rights reserved.
//

#import "ZJGuardView.h"

#define LabelW  150
#define ButtonW 80
#define ButtonH 40
#define Margin  10

@interface ZJGuardView ()

@property (nonatomic, copy)     GuideTapBlock afterTapBlock;
@property (nonatomic, assign)   ShowDirection direction;
@property (nonatomic, strong)   NSString *title;
@property (nonatomic, strong)   NSString *btnTitle;
@property (nonatomic, strong)   UIView *onView;
@property (nonatomic, strong)   UIView *forView;
@property (nonatomic, strong)   UIView *subView;
@property (nonatomic, strong)   UIBezierPath *path;
@property (nonatomic, strong)   CAShapeLayer *shapeLayer;

@end

@implementation ZJGuardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        self.shapeLayer = shapeLayer;
        
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.8];
    }
    return self;
}

- (void)showForView:(UIView *)forView
            subView:(UIView *)subView
          direction:(ShowDirection)direction
              title:(NSString *)title
           btnTitle:(NSString *)btnTitle
           afterTap:(GuideTapBlock)afterTapBlock
{
    UIView *onView = [UIApplication sharedApplication].keyWindow;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:[onView convertRect:forView.frame toView:onView] cornerRadius:0];
    
    self.path = path;
    self.onView = onView;
    self.forView = forView;
    self.subView = subView;
    self.direction = direction;
    self.title = title;
    self.btnTitle = btnTitle;
    self.afterTapBlock = afterTapBlock;
    
    [self newCreateGuard];
}

- (void)newCreateGuard
{
    NSArray *array = [self subviews];
    for (UIView *view in array ) {
        [view removeFromSuperview];
    }
    [self.onView addSubview:self];
    self.frame = self.onView.bounds;
    
    {
        // 这里创建指引
        UIView * bgView = [[UIView alloc]initWithFrame:self.bounds];
        [self addSubview:bgView];
    }
    {
        //create path
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
        [path appendPath:[self.path bezierPathByReversingPath]];
        self.shapeLayer.path = path.CGPath;
        self.shapeLayer.backgroundColor = [UIColor orangeColor].CGColor;
        self.shapeLayer.fillColor = [UIColor redColor].CGColor;
        self.shapeLayer.strokeColor = [UIColor greenColor].CGColor;
        self.shapeLayer.lineWidth = 2;
        [self.layer setMask:self.shapeLayer];
    }
    {
        // 创建显示控件
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"箭头"]];
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = self.title;
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        [self addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.btnTitle forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        // 计算位置
        CGPoint point = [self.subView convertPoint:self.forView.center toView:self.onView];
        CGFloat imageW = imageView.frame.size.width;
        CGFloat imageH = imageView.frame.size.height;
        CGSize size = [label sizeThatFits:CGSizeMake(LabelW, CGFLOAT_MAX)];
        CGFloat labelX = 0;
        CGFloat labelY = 0;
        CGFloat buttonX = 0;
        
        switch (self.direction) {
                
                case ShowDirectionRightDown: // 右下
            {
                point.x += self.forView.frame.size.width / 2;
                point.y += self.forView.frame.size.height / 2;
                
                labelX = point.x + imageW - LabelW / 2;
                labelY = point.y + imageH + Margin;
                buttonX = point.x + imageW + Margin + ButtonW / 2;
            }
                break;
                case ShowDirectionRightTop: // 右上
            {
                point.x += self.forView.frame.size.width / 2;
                point.y -= (imageH + self.forView.frame.size.height / 2);
                
                labelX = point.x + imageW - LabelW / 2;
                labelY = point.y - size.height - Margin;
                buttonX = point.x + imageW + Margin + ButtonW / 2;
            }
                break;
                case ShowDirectionLeftDown: // 左下
            {
                point.x -= (imageW + self.forView.frame.size.width / 2);
                point.y += self.forView.frame.size.height / 2;
                
                labelX = point.x - LabelW / 2;
                labelY = point.y + imageH + Margin;
                buttonX = point.x - Margin - ButtonW / 2;
            }
                break;
                case ShowDirectionLeftTop: // 左上
            {
                point.x -= (imageW + self.forView.frame.size.width / 2);
                point.y -= (imageH + self.forView.frame.size.height / 2);
                
                labelX = point.x - LabelW / 2;
                labelY = point.y - size.height - Margin;
                buttonX = point.x - Margin - ButtonW / 2;
            }
                break;
        }
        
        imageView.frame = CGRectMake(point.x, point.y, imageW,  imageH) ;
        label.frame = CGRectMake(labelX, labelY, LabelW, size.height);
        button.frame = CGRectMake(0, 0, ButtonW, ButtonH);
        button.center = CGPointMake(buttonX, imageView.center.y);
        
    }
}

#pragma mark 事件响应
- (void)btnAction
{
    [self removeFromSuperview];
    if(self.afterTapBlock){
        self.afterTapBlock();
    }
}

-(void)removeFromSuperview
{
    [super removeFromSuperview];
}

#pragma mark - UIView Overrides 拦截穿透
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    UIView *hitView = [super hitTest:point withEvent:event];
//    if ([self.path containsPoint:point]) {
//
//        [self removeFromSuperview];
//
//        return nil;
//    }
//    return hitView;
//}

@end
