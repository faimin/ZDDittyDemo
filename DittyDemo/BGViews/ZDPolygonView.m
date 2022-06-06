//
//  ZDPolygonView.m
//  ZDPopDemo
//
//  Created by Zero.D.Saber on 2017/6/1.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

#import "ZDPolygonView.h"
#import <pop/POP.h>
#import "ZDFunction.h"


@interface ZDPolygonView ()
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAShapeLayer *subShapeLayer2;
@end

@implementation ZDPolygonView

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self setup];
}

#pragma mark -

- (void)setup {
    [self setupUI];
}

- (void)setupUI {
    if (CGRectEqualToRect(self.frame, CGRectZero)) return;
    if (self.layer.sublayers.count > 0) {
        [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    }
    
    CGFloat width = 100;
    
    CAShapeLayer *subShapeLayer1 = ({
        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
        __unused CGFloat dx = 20.f;
        CGFloat width1 = width * 0.8;
        CGRect frame = (CGRect){0, 0, width1, width1};
        //CGRectInset(superShapeLayer.bounds, dx, dx);
        shapeLayer.frame = frame;
        shapeLayer.position = self.center;
        shapeLayer.path = [self drawPolygonViewWithWidth:frame.size.width].CGPath;
        shapeLayer.lineCap = kCALineCapButt;
        shapeLayer.fillColor = [UIColor blueColor].CGColor;
        shapeLayer.strokeColor = [UIColor clearColor].CGColor;
        shapeLayer;
    });
    
    CAShapeLayer *subShapeLayer2 = ({
        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
        __unused CGFloat dx = 40.f;
        CGFloat width2 = width * 0.5;
        CGRect frame = (CGRect){0, 0, width2, width2};
        //CGRectInset(superShapeLayer.bounds, dx, dx);
        shapeLayer.frame = frame;
        shapeLayer.position = self.center;
        shapeLayer.path = [self drawPolygonViewWithWidth:frame.size.width].CGPath;
        shapeLayer.lineCap = kCALineCapButt;
        shapeLayer.fillColor = [UIColor yellowColor].CGColor;
        shapeLayer.strokeColor = [UIColor clearColor].CGColor;
        shapeLayer;
    });
    
    [self.layer addSublayer:self.shapeLayer];
    [self.layer addSublayer:subShapeLayer1];
    [self.layer addSublayer:subShapeLayer2];
    
    self.subShapeLayer2 = subShapeLayer2;
}

#pragma mark - Protocol

- (void)startAnimation {
    //self.shapeLayer.opacity = 1.f;
    
    POPBasicAnimation *animation = ({
        POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerSubscaleXY];
        animation.fromValue = [NSValue valueWithCGSize:(CGSize){0, 0}];
        CGFloat scale = ceil(MAX(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) / (100 * 0.5 * 0.5)) * 1.6;// 0.5是最小多边形是原图的几分之几,还有一个是内部颜色占整体的几分之几
        animation.toValue = [NSValue valueWithCGSize:(CGSize){scale, scale}];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.duration = self.duration;
        animation.removedOnCompletion = YES;
        animation;
    });
    animation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            //self.shapeLayer.opacity = 0.f;
            [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
            self.superview.backgroundColor = [UIColor colorWithCGColor:self.subShapeLayer2.fillColor];
            [self removeFromSuperview];
        };
    };
    
    [self.layer pop_addAnimation:animation forKey:@"ZDShapeScale1"];
}

#pragma mark - Getter

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        CGFloat width = 100;
        
        CAShapeLayer *superShapeLayer = ({
            CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
            //shapeLayer.backgroundColor = [UIColor cyanColor].CGColor;
            shapeLayer.frame = (CGRect){0, 0, width, width};
            shapeLayer.position = self.center;
            shapeLayer.path = [self drawPolygonViewWithWidth:width].CGPath;
            shapeLayer.lineCap = kCALineCapButt;
            shapeLayer.fillColor = [UIColor orangeColor].CGColor;
            shapeLayer.strokeColor = [UIColor clearColor].CGColor;
            shapeLayer;
        });
        
        _shapeLayer = superShapeLayer;
    }
    
    return _shapeLayer;
}

// 下面是100*100大小的多边形
- (UIBezierPath *)drawPolygonViewWithWidth:(CGFloat)width {
    CGFloat scale = width / 100.0;
    
    //! Polygon
    UIBezierPath *polygon = [UIBezierPath bezierPath];
    [polygon moveToPoint:ZD_PointScale(CGPointMake(25, 0), scale)];
    [polygon addLineToPoint:ZD_PointScale(CGPointMake(49.99, 25), scale)];
    [polygon addLineToPoint:ZD_PointScale(CGPointMake(74.54, 0), scale)];
    [polygon addLineToPoint:ZD_PointScale(CGPointMake(100, 25), scale)];
    [polygon addLineToPoint:ZD_PointScale(CGPointMake(75, 50), scale)];
    [polygon addLineToPoint:ZD_PointScale(CGPointMake(100, 75), scale)];
    [polygon addLineToPoint:ZD_PointScale(CGPointMake(75, 100), scale)];
    [polygon addLineToPoint:ZD_PointScale(CGPointMake(49.99, 75), scale)];
    [polygon addLineToPoint:ZD_PointScale(CGPointMake(25, 100), scale)];
    [polygon addLineToPoint:ZD_PointScale(CGPointMake(0, 75), scale)];
    [polygon addLineToPoint:ZD_PointScale(CGPointMake(25, 50), scale)];
    [polygon addLineToPoint:ZD_PointScale(CGPointMake(0, 25), scale)];
    [polygon addLineToPoint:ZD_PointScale(CGPointMake(25, 0), scale)];
    [polygon closePath];
    
    return polygon;
}

@end
