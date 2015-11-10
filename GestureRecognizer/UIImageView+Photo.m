//
//  UIImageView+Photo.m
//  RandomPhoto
//
//  Created by cuong minh on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIImageView+Photo.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIImageView (Photo)

UIRotationGestureRecognizer *rotateRecognizer;
UIPinchGestureRecognizer *pinchRecognizer;

- (void) makeItCool
{
    [self.layer setMasksToBounds:NO];
    
    // put a white border around the image view to make the image stand out from the background
    [self.layer setBorderWidth:5.0f];
    [self.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    // add a shadow behind the image view to make it stand out even more
    [self.layer setShadowRadius:5.0f];
    [self.layer setShadowOpacity:.85f];
    [self.layer setShadowOffset:CGSizeMake(1.0f, 2.0f)];
    [self.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.layer setShouldRasterize:YES];
    [self.layer setMasksToBounds:NO];
    

    CGAffineTransform transform = CGAffineTransformMakeRotation(((float)rand()/RAND_MAX - 0.5)*0.4);
    self.transform = transform;    
}

- (void) addGestureRecognizer
{
    self.userInteractionEnabled = YES;  //Don't forget this line
    self.multipleTouchEnabled = YES;  //Don't forget this line
    rotateRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateMe:)];
    [self addGestureRecognizer: rotateRecognizer];
    
    
    pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchMe:)];
    [self addGestureRecognizer: pinchRecognizer];

}
- (void) rotateMe: (UIRotationGestureRecognizer *)gestureRecognizer
{
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan || gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        gestureRecognizer.view.transform = CGAffineTransformRotate(gestureRecognizer.view.transform, gestureRecognizer.rotation);
        gestureRecognizer.rotation = 0.0;
    }
}

- (void) pinchMe: (UIPinchGestureRecognizer *)gestureRecognizer
{
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan || gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        gestureRecognizer.view.transform = CGAffineTransformScale(gestureRecognizer.view.transform, gestureRecognizer.scale, gestureRecognizer.scale);
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
