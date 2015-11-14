//
//  LenZoom.m
//  GestureRecognizer
//
//  Created by du phung cong on 11/12/15.
//  Copyright © 2015 Cuong Trinh. All rights reserved.
//

#import "LenZoom.h"

@interface LenZoom () <UIGestureRecognizerDelegate>

@end

@implementation LenZoom
{
    UIImageView* imageView;
    UIPanGestureRecognizer* pan;
    UIPinchGestureRecognizer* pinch;
    
    CGFloat circleRadius;
    CGPoint circleCenter;
    
    CAShapeLayer* maskLayer;
    CAShapeLayer* circleLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"grass.png"];
    imageView.userInteractionEnabled = true;
    imageView.multipleTouchEnabled = true;
    [self.view addSubview:imageView];
    
    maskLayer = [CAShapeLayer layer];
    imageView.layer.mask = maskLayer;
    
    circleLayer = [CAShapeLayer layer];
    circleLayer.lineWidth = 3.0;
    circleLayer.fillColor = [[UIColor clearColor] CGColor];
    circleLayer.strokeColor = [[UIColor blackColor] CGColor];
    [imageView.layer addSublayer:circleLayer];
    
    circleCenter = CGPointMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0);
    circleRadius = self.view.bounds.size.width * 0.3;
    
    [self updateCirclePathLocation:circleCenter andRadius:circleRadius];
    
    pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panImage:)];
    pan.delegate = self;
    [imageView addGestureRecognizer:pan];
    
    pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchImage:)];
    pinch.delegate = self;
    [self.view addGestureRecognizer:pinch];
}

- (void)updateCirclePathLocation:(CGPoint)center andRadius:(CGFloat)radius {
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // draw circle
    /*[path addArcWithCenter:circleCenter
                    radius:circleRadius
                startAngle:0.0
                  endAngle:M_PI * 2.0
                 clockwise:YES];*/
    
    // draw polygon (4 points)
    [path moveToPoint:CGPointMake(circleCenter.x, circleCenter.y - circleRadius)];
    [path addLineToPoint:CGPointMake(circleCenter.x - circleRadius * 0.5, circleCenter.y)];
    [path addLineToPoint:CGPointMake(circleCenter.x, circleCenter.y + circleRadius)];
    [path addLineToPoint:CGPointMake(circleCenter.x + circleRadius * 0.5, circleCenter.y)];
    [path closePath];
    
    maskLayer.path = [path CGPath];
    circleLayer.path = [path CGPath];
    
}

- (void)panImage: (UIPanGestureRecognizer*)gestureRecognizer {
    [self adjustAnchoPointForGestureRecognizer:gestureRecognizer];
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan || gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        circleCenter = [gestureRecognizer locationInView:self.view];
        [self updateCirclePathLocation:circleCenter andRadius:circleRadius];
    }
}

- (void)pinchImage: (UIPinchGestureRecognizer*)gestureRecognizer {
    [self adjustAnchoPointForGestureRecognizer:gestureRecognizer];
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan || gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        circleRadius = circleRadius * [gestureRecognizer scale];
        [self updateCirclePathLocation:circleCenter andRadius:circleRadius];
        gestureRecognizer.scale = 1.0;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return true;
}

- (void)adjustAnchoPointForGestureRecognizer: (UIGestureRecognizer*)gestureRecognizer {
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperView = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperView;
    }
}

@end
