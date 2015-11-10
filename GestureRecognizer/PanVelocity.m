//
//  PanVelocity.m
//  GestureRecognizer
//
//  Created by Cuong Trinh on 8/25/15.
//  Copyright (c) 2015 Cuong Trinh. All rights reserved.
//

#import "PanVelocity.h"


@implementation PanVelocity
{
    UIImageView* ball;
    NSTimer* timer;
    CGVector velocity;
    CGFloat ballRadius;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"football.png"]];
    ball.userInteractionEnabled = true;
    ball.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
    [self.view addSubview:ball];
    
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(throwBall:)];
    [ball addGestureRecognizer:pan];

    ballRadius = 32;
    
    velocity = CGVectorMake(0.0, 0.0);
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                             target:self
                                           selector:@selector(loop)
                                           userInfo:nil
                                            repeats:true];
    
}

- (void) throwBall: (UIPanGestureRecognizer*) pan {
    if (pan.state == UIGestureRecognizerStateBegan || pan.state == UIGestureRecognizerStateChanged) {
        CGPoint acceleration = [pan velocityInView:self.view];
        CGSize viewSize = self.view.bounds.size;
        velocity = CGVectorMake(velocity.dx + acceleration.x * 5 / viewSize.width,
                                velocity.dy + acceleration.y * 5 / viewSize.height);
        [pan setTranslation:CGPointZero inView:self.view];
    }
}

- (void) loop {
    CGPoint newPos = CGPointMake(ball.center.x + velocity.dx, ball.center.y + velocity.dy);
    CGSize viewSize = self.view.bounds.size;
    
    if (newPos.x < ballRadius) {
        newPos.x = ballRadius;
        velocity.dx = - velocity.dx;
    }
    
    if (newPos.x > viewSize.width - ballRadius) {
        newPos.x = viewSize.width - ballRadius;
        velocity.dx = - velocity.dx;
    }
    
    if (newPos.y < ballRadius) {
        newPos.y = ballRadius;
        velocity.dy = - velocity.dy;
    }
    
    if (newPos.y > viewSize.height - ballRadius) {
        newPos.y = viewSize.height - ballRadius;
        velocity.dy = - velocity.dy;
    }
    ball.center = newPos;
    
    velocity = CGVectorMake(velocity.dx * 0.9, velocity.dy * 0.9);
}
@end
