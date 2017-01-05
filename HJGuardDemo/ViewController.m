//
//  ViewController.m
//  HJGuardDemo
//
//  Created by apple on 2017/1/5.
//  Copyright © 2017年 张洪健. All rights reserved.
//

#import "ViewController.h"
#import "GuardView.h"
#import "ZJGuardView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *BtnOne;
@property (weak, nonatomic) IBOutlet UIButton *BtnTwo;
@property (weak, nonatomic) IBOutlet UIButton *BtnThree;
@property (weak, nonatomic) IBOutlet UIButton *BtnFour;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadGuard];
}

- (void)loadGuard
{
    ///先注释,方便查看效果
    //    if([NewUserGuide hadShowNewUserGuideForKey:NSStringFromClass(self.class)] ||
    //       [NewUserGuide isShowingNewUserGuideForKey:NSStringFromClass(self.class)]
    //       ){
    //        return;
    //    }
    
    ZJGuardView *guardView = [[ZJGuardView alloc] init];
    [guardView showForView:self.BtnOne subView:self.view direction:ShowDirectionRightDown title:@"11111111111" btnTitle:@"下一步" afterTap:^{
        [guardView showForView:self.BtnTwo subView:self.view direction:ShowDirectionLeftDown title:@"2222222" btnTitle:@"下一步" afterTap:^{
            [guardView showForView:self.BtnThree subView:self.view direction:ShowDirectionRightTop title:@"3333333333" btnTitle:@"下一步" afterTap:^{
                [guardView showForView:self.BtnFour subView:self.view direction:ShowDirectionLeftTop title:@"4444444" btnTitle:@"完成" afterTap:^{
                    NSLog(@"完成");
                }];
            }];
        }];
    }];
    
//    UIView *onView = [UIApplication sharedApplication].keyWindow;
//
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:[self.view convertRect:self.BtnTwo.frame toView:onView] cornerRadius:5];
//    UIImage *image = [UIImage imageNamed:@"newUserGuide-1"];
//
//    CGPoint point = [self.view convertPoint:self.BtnOne.center toView:onView];
//    NSLog(@"外面的：%@",NSStringFromCGPoint(point));
//    point.y += self.BtnTwo.frame.size.height/2 + 10;
//    point.x -= image.size.width /2 ;
//
//    CGPoint point2 = [self.view convertPoint:self.BtnThree.center toView:onView];
//    point2.y += self.BtnThree.frame.size.height/2 + 10;
//    point2.x -= image.size.width /2 ;
//
//    CGPoint point3 = [self.view convertPoint:self.BtnOne.center toView:onView];
//    point3.y += self.BtnOne.frame.size.height/2 + 10;
//    point3.x -= image.size.width /2 ;

//    GuardView *view = [[GuardView alloc] init];
//    [view showOn:onView path:path appendPath:YES image:image imageAt:point withKey:NSStringFromClass(self.class) afterTap:^{
//        [view showOn:onView forView:self.BtnThree cornerRadius:10 image:nil imageAt:CGPointMake(100, 100) withKey:@"btn3" afterTap:^{
//
//            [view showOn:onView forView:self.BtnOne cornerRadius:10 image:nil imageAt:CGPointMake(100, 100) withKey:@"btn1" afterTap:^{
//                NSLog(@"完成引导");
//            }];
//        }];
//        
//    }];
}



@end
