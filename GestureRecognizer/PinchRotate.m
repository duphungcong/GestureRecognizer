//
//  Pinch.m
//  GestureRecognizer
//
//  Created by Cuong Trinh on 8/25/15.
//  Copyright (c) 2015 Cuong Trinh. All rights reserved.
//

#import "PinchRotate.h"
#import "UIImageView+Photo.h"

@implementation PinchRotate
{
    UIImageView* girl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    girl = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"playboy.jpg"]];
    //girl = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rotateball.png"]];
    girl.frame = CGRectMake(40, 50, 300, 425);
    girl.contentMode = UIViewContentModeScaleAspectFit;
    [girl makeItCool];
    [girl addGestureRecognizer];
    
    [self.view addSubview:girl];
}

@end
