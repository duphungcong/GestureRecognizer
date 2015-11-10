//
//  RotateBall.m
//  GestureRecognizer
//
//  Created by du phung cong on 11/8/15.
//  Copyright © 2015 Cuong Trinh. All rights reserved.
//

#import "RotateBall.h"

@implementation RotateBall
{
    UIImageView* ball;
    NSTimer* timer;
    CGFloat angle;
    CGFloat velocity;
    float timeInterval;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    angle = 0.0;
    timeInterval = 0.05;
    
    ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rotateball.png"]];
    ball.center = self.view.center;
    ball.userInteractionEnabled = true;
    ball.multipleTouchEnabled = true;
    [self.view addSubview:ball];
    
    UIRotationGestureRecognizer* rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateBall:)];
    [ball addGestureRecognizer:rotate];
    
}

- (void)rotateBall: (UIRotationGestureRecognizer*)gestureRecognizer {
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan || gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        gestureRecognizer.view.transform = CGAffineTransformRotate(gestureRecognizer.view.transform, gestureRecognizer.rotation);
        gestureRecognizer.rotation = 0.0;
    }
    if(gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        velocity = gestureRecognizer.velocity;
        //NSLog(@"velocity = %2.1f", velocity);
        timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                 target:self
                                               selector:@selector(rotateBallAfterEndGesture)
                                               userInfo:nil
                                                repeats:true];
    }
}

- (void)rotateBallAfterEndGesture {
    angle = velocity * timeInterval;
    //NSLog(@"angle = %2.1f", angle);
    //NSLog(@"velocity = %2.1f", velocity);
    ball.transform = CGAffineTransformRotate(ball.transform, angle);
    velocity = velocity * 0.96;
    if([self absNumber:velocity] <= 0.1) {
        [timer invalidate];
        timer = nil;
    }
}

- (CGFloat)absNumber:(CGFloat)number {
    if(number >= 0) {
        return number;
    }
    else {
        return number * (-1);
    }
}

- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}


- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [timer invalidate];
    timer = nil;
}

@end
