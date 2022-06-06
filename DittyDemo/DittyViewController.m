//
//  DittyViewController.m
//  DittyDemo
//
//  Created by Zero.D.Saber on 04/05/2017.
//  Copyright © 2017 Zero.D.Saber. All rights reserved.
//

#import "DittyViewController.h"
#import "MDAnimator.h"
#import "MDAnimationItem.h"
#import "MDBangAnimation.h"
#import "MDShadowMergeAnimation.h"
#import "MDAnimator+UTils.h"
#import "CommonDefine.h"
#import "ZDFunction.h"

@interface DittyViewController ()
@property (nonatomic, strong) UIView *animationView;
@property (nonatomic, strong) MDAnimator *animator;
@end

@implementation DittyViewController

- (void)dealloc
{
    [self.animator stop];
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];

    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //MARK: 开启动画
    [self setupAnimation];
}

#pragma mark -

- (void)setup {
    [self setupUI];
}

- (void)setupUI {
    self.animationView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.animationView];
}

- (void)setupAnimation
{
    self.animator = [MDAnimator new];
    NSArray <NSDictionary *> *items = [self models];
    //MARK: 设置背景和文字动画
    [items enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
        MDAnimationItem *item = [MDAnimationItem itemWithDictionary:dic];
        item.shadowCount =  arc4random() % 5 + 1;
        
        // bgView
        UIView *bgView = [self.animator animationBGViewWithItem:item];
        bgView.frame = self.animationView.bounds;
        
        // label
        UILabel *label = [self.animator labelWithText:item.word
                                                 font:[UIFont boldSystemFontOfSize:60]
                                            textColor:[UIColor whiteColor]];
        label.frame = self.animationView.bounds;
        label.center = self.animationView.center;
        
        /*
        // 添加到父视图(执行动画的时候再添加到父视图，减少内存占用)
        [self.animationView addSubview:bgView];
        [self.animationView addSubview:label];
         */
        
        // 创建并添加动画
        id <MDAnimationProtocol> ani = [self.animator animationWithView:label item:item];
        // 持有背景视图和animationView
        ani.bgAnimationView = bgView;
        ani.animationSuperView = self.animationView;
        [self.animator addAnimation:ani];
    }];
    
}

- (NSArray<NSDictionary *> *)models
{
    NSString *path = [[NSBundle bundleForClass:[self class]] resourcePath];
    NSString *configPath = [path stringByAppendingPathComponent:@"dity.geojson"];
    NSData *data = [NSData dataWithContentsOfFile:configPath];
    NSDictionary *d = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
    NSArray *items = [d objectForKey:@"data"];
    return items;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Property

- (UIView *)animationView {
    if (!_animationView) {
        CGFloat screenWidth = CGRectGetWidth(self.view.frame);
        _animationView = ({
            UIView *view = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, screenWidth, screenWidth}];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
            view.backgroundColor = [UIColor whiteColor];
            view.clipsToBounds = YES;
            //view.layer.masksToBounds = YES;
            view;
        });
    }
    return _animationView;
}

@end
