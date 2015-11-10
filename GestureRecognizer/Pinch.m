//
//  Pinch.m
//  GestureRecognizer
//
//  Created by Cuong Trinh on 8/25/15.
//  Copyright (c) 2015 Cuong Trinh. All rights reserved.
//

#import "Pinch.h"

@implementation Pinch
{
    UIImageView* girl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    girl = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"playboy.jpg"]];
    girl.frame = CGRectMake(40, 80, 300, 425);
    girl.contentMode = UIViewContentModeScaleAspectFit;
    girl.userInteractionEnabled = true;
    girl.multipleTouchEnabled = true;
    [self.view addSubview:girl];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(pinchPhoto:)];
    
    [girl addGestureRecognizer:pinch];

}

- (void) pinchPhoto: (UIPinchGestureRecognizer*) gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan || gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        //Try commend [self adjustAnchorPointForGestureRecognizer:gestureRecognizer]; to see different
        [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
        //CGAffineTransformScale(gestureRecognizer.view.transform, gestureRecognizer.scale, gestureRecognizer.scale
        girl.transform = CGAffineTransformScale(girl.transform, gestureRecognizer.scale, gestureRecognizer.scale);
        //CGAffineTransformMakeScale(gestureRecognizer.scale, gestureRecognizer.scale);
        gestureRecognizer.scale = 1.0;
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
