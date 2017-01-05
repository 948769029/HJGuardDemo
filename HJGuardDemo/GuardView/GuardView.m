//
//  GuardView.m
//  GuardDemo
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 张洪健. All rights reserved.
//

#import "GuardView.h"

static NSMutableDictionary *showingKeys;

@interface GuardView ()

@property (strong,nonatomic) UIView *onview;
@property (strong,nonatomic) UIBezierPath *path;
@property (assign,nonatomic) BOOL appendPath;
@property (strong,nonatomic) UIImage *image;
@property (strong,nonatomic) NSString *withKey;
@property (assign,nonatomic) CGPoint imageAt;
@property (copy,nonatomic) NewUserGuideTapBlock afterTapBlock;
@property (strong,nonatomic) UIView *bgView;
@property (strong,nonatomic) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) NSString *btnTitle;

@end

@implementation GuardView

#pragma mark - 自定义 图片 文字  按钮
-(void)showOn:(UIView *)onview
      forView:(UIView *)forView
 cornerRadius:(CGFloat)cornerRadius
        image:(UIImage *)image
      imageAt:(CGPoint)imageAt
     titleStr:(NSString *)titleStr
     btnTitle:(NSString *)btnTitle
      withKey:(NSString *)withKey
     afterTap:(NewUserGuideTapBlock)afterTapBlock
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:[onview convertRect:forView.frame toView:onview] cornerRadius:cornerRadius];
    [self showOn:onview path:path appendPath:YES image:image imageAt:imageAt titleStr:titleStr btnTitle:btnTitle withKey:withKey afterTap:afterTapBlock];
}

-(void)showOn:(UIView *)onview
         path:(UIBezierPath *)path
   appendPath:(BOOL)appendPath
        image:(UIImage *)image
      imageAt:(CGPoint)imageAt
     titleStr:(NSString *)titleStr
     btnTitle:(NSString *)btnTitle
      withKey:(NSString *)withKey
     afterTap:(NewUserGuideTapBlock)afterTapBlock {
    
    self.onview = onview;
    self.path = path;
    self.image = image;
    self.imageAt = imageAt;
    self.titleStr = titleStr;
    self.btnTitle = btnTitle;
    self.withKey = withKey;
    self.afterTapBlock = afterTapBlock;
    self.appendPath = appendPath;
    
    
    [self newUserGuide];
    
    if(showingKeys == nil){
        showingKeys = [NSMutableDictionary dictionary];
    }
    
    if(self.withKey){
        [showingKeys setObject:@(1) forKey:self.withKey ];
    }
}


#pragma mark 图片
-(void)showOn:(UIView *)onview forView:(UIView *)forView   cornerRadius:(CGFloat)cornerRadius image:(UIImage *)image imageAt:(CGPoint)imageAt withKey:(NSString *)withKey afterTap:(NewUserGuideTapBlock)afterTapBlock
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:[onview convertRect:forView.frame toView:onview] cornerRadius:cornerRadius];
    
    [self showOn:onview path:path appendPath:YES image:image imageAt:imageAt withKey:withKey afterTap:afterTapBlock];
    
}

///按照 path 显示 layer 层的 mask, 支持事件穿透
-(void)showOn:(UIView *)onview path:(UIBezierPath *)path appendPath:(BOOL)appendPath image:(UIImage *)image imageAt:(CGPoint)imageAt withKey:(NSString *)withKey afterTap:(NewUserGuideTapBlock)afterTapBlock {
    
    
    self.onview = onview;
    self.path = path;
    self.image = image;
    
    
    self.imageAt = imageAt;
    self.withKey = withKey;
    self.afterTapBlock = afterTapBlock;
    self.appendPath = appendPath;
    
    
    [self newUserGuide];
    
    if(showingKeys == nil){
        showingKeys = [NSMutableDictionary dictionary];
    }
    
    if(self.withKey){
        [showingKeys setObject:@(1) forKey:self.withKey ];
    }
    
    
}
+(BOOL)hadShowNewUserGuideForKey:(NSString *)key
{
    if(key){
        return  [[NSUserDefaults standardUserDefaults] boolForKey:key];
    }
    return NO;
}
+(BOOL)isShowingNewUserGuideForKey:(NSString *)key
{
    if(key){
        return  [[showingKeys objectForKey:key] boolValue ];
        
    }
    return NO;
}

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

- (void)newUserGuide

{
    NSArray *array = [self subviews];
    for (UIView *view in array ) {
        [view removeFromSuperview];
    }
    [_onview addSubview:self];
    self.frame = _onview.bounds;
    
    
    // 这里创建指引
    {
        UIView * bgView = [[UIView alloc]initWithFrame:self.bounds];
        _bgView = bgView;
        [self addSubview:bgView];
    }
    
    
    
    {
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sureTapClick:)];
//        [self addGestureRecognizer:tap];        
    }
    
    
    {
        
        //create path
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
        [path appendPath:[self.path bezierPathByReversingPath]];
        
        if( NO == _appendPath ){
            
            self.shapeLayer.path =  _path.CGPath;
            
        }else{
            
            self.shapeLayer.path =  path.CGPath;
            
        }
        self.shapeLayer.backgroundColor = [UIColor orangeColor].CGColor;
        self.shapeLayer.fillColor = [UIColor redColor].CGColor;
        self.shapeLayer.strokeColor = [UIColor greenColor].CGColor;
        self.shapeLayer.lineWidth = 2;
        [self.layer setMask:self.shapeLayer];
    }
    
    
    {
        
        UIImageView * imageView = [[UIImageView alloc]initWithImage:_image];
        imageView.frame = CGRectMake(self.imageAt.x, self.imageAt.y, imageView.frame.size.width,  imageView.frame.size.height) ;
        [self addSubview:imageView ] ;
        
        UILabel *label = [[UILabel alloc] init];
        label.text = self.titleStr;
        label.numberOfLines = 0;
        CGFloat labelW = 100;
        CGFloat labelX = CGRectGetMaxX(imageView.frame) - labelW / 2;
        CGFloat labelY = CGRectGetMaxY(imageView.frame);
        CGSize size = [label sizeThatFits:CGSizeMake(labelW, CGFLOAT_MAX)];
        label.frame = CGRectMake(labelX, labelY, 100, size.height);
        [self addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.btnTitle forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(CGRectGetMaxX(imageView.frame) + 10, (CGRectGetHeight(imageView.frame) - 40) / 2, 80, 40);
        [button addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
}

- (void)btnAction
{
    [self removeFromSuperview];
    if(self.afterTapBlock){
        self.afterTapBlock();
    }
}

-(void)afterShow{
    if(self.withKey){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:self.withKey];
        [showingKeys removeObjectForKey:self.withKey];
        
    }
}
/**
 *   新手指引确定
 */
- (void)sureTapClick:(UIGestureRecognizer *)tap
{
    
    [self removeFromSuperview];
    if(self.afterTapBlock){
        self.afterTapBlock();
    }
    
    
}
-(void)removeFromSuperview
{
    [super removeFromSuperview];
    [self afterShow];
    
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
