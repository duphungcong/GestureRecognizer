//
//  Pan.m
//  GestureRecognizer
//
//  Created by Cuong Trinh on 8/25/15.
//  Copyright (c) 2015 Cuong Trinh. All rights reserved.
//

#import "Pan.h"

@interface Pan ()

@end

@implementation Pan
{
    UIImageView* target;
    UIImageView* bullEye;
    UILabel* label;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //Explain about this app
    label = [UILabel new];
    label.numberOfLines = 3;
    label.text = @"Khi 2 vòng tròn đồng tâm hay rung lắc bia";
    
    CGSize labelSize = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
    
    label.frame = CGRectMake(8, 80, self.view.bounds.size.width - 16, labelSize.height);
    [self.view addSubview:label];

    
    target = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Target.png"]];
    bullEye = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BullEye.png"]];
    target.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
    
    [self.view addSubview:target];
    
    bullEye.center = CGPointMake(100, 200);
    bullEye.multipleTouchEnabled = true;
    bullEye.userInteractionEnabled = true;
    [self.view addSubview:bullEye];
    
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panBullEye:)];
    
    [bullEye addGestureRecognizer:pan];
}

- (void) panBullEye: (UIPanGestureRecognizer*) pan {
    if (pan.state == UIGestureRecognizerStateBegan || pan.state == UIGestureRecognizerStateChanged) {
        bullEye.center = [pan locationInView:self.view];
        [self bullEyeInTarget:bullEye.center];
    }
}

- (BOOL) bullEyeInTarget: (CGPoint) bullEyeCenter {
    CGFloat distanceDoubleSquare = powf(bullEyeCenter.x - target.center.x, 2) + powf(bullEyeCenter.y - target.center.y, 2);
    if (distanceDoubleSquare < 20) {
        NSLog(@"Match");
        label.text = @"Match";
        return true;
    } else {
        label.text = @"";
        return false;
    }
}

@end
