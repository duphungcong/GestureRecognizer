//
//  PinchRotateDelegate.m
//  GestureRecognizer
//
//  Created by du phung cong on 11/10/15.
//  Copyright © 2015 Cuong Trinh. All rights reserved.
//

#import "PinchRotateDelegate.h"

@interface PinchRotateDelegate () <UIGestureRecognizerDelegate>

@end

@implementation PinchRotateDelegate 
{
    UIImageView* ball;
    UIPinchGestureRecognizer* pinch;
    UIRotationGestureRecognizer* rotate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rotateball.png"]];
    ball.center = self.view.center;
    ball.userInteractionEnabled = true;
    ball.multipleTouchEnabled = true;
    [self.view addSubview:ball];
    
    pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchBall:)];
    pinch.delegate = self;
    [ball addGestureRecognizer:pinch];
    
    rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateBall:)];
    rotate.delegate = self;
    [ball addGestureRecognizer:rotate];
}

- (void)pinchBall: (UIPinchGestureRecognizer*)gestureRecognizer {
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan || gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        gestureRecognizer.view.transform = CGAffineTransformScale(gestureRecognizer.view.transform, gestureRecognizer.scale, gestureRecognizer.scale);
        NSLog(@"Pinch");
        gestureRecognizer.scale = 1.0;
    }
}

- (void)rotateBall: (UIRotationGestureRecognizer*)gestureRecognizer {
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan || gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        gestureRecognizer.view.transform = CGAffineTransformRotate(gestureRecognizer.view.transform, gestureRecognizer.rotation);
        NSLog(@"Rotate");
        gestureRecognizer.rotation = 0.0;
    }
}

// Chap nhan Pinch va Rotate dong thoi
/*- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return true;
}*/

// Uu tien Rotate
// Comment neu muon uu tien Pinch
/*- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if([gestureRecognizer isMemberOfClass:[UIPinchGestureRecognizer class]] &&
       [otherGestureRecognizer isMemberOfClass:[UIRotationGestureRecognizer class]]) {
        return true;
    }
    else {
        return false;
    }
}*/

// Uu tien Pinch
// Comment neu muon uu tien Rotate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if([gestureRecognizer isMemberOfClass:[UIPinchGestureRecognizer class]] &&
       [otherGestureRecognizer isMemberOfClass:[UIRotationGestureRecognizer class]]) {
        return true;
    }
    else {
        return false;
    }
}

// scale and rotation transforms are applied relative to the layer's anchor point
// this method moves a gesture recognizer's view's anchor point between the user's fingers
- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}

@end
