//
//  Tap.m
//  GestureRecognizer
//
//  Created by Cuong Trinh on 8/25/15.
//  Copyright (c) 2015 Cuong Trinh. All rights reserved.
//

#import "Tap.h"

@implementation Tap
{
    UIImageView* grass;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    grass = [[UIImageView alloc] initWithFrame:self.view.bounds];
    grass.image = [UIImage imageNamed:@"grass.png"];
    grass.userInteractionEnabled = YES;
    grass.multipleTouchEnabled = YES;
    [self.view addSubview:grass];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(onTap:)];
    
    [grass addGestureRecognizer: tapGesture];
}

- (void) onTap: (UITapGestureRecognizer*) tap
{
    CGPoint point = [tap locationInView:self.view];
    // NSLog(@"x=%f - y=%f", point.x, point.y);
    UIImageView *ant = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ant.png"]];
    ant.center = point;
    [grass addSubview:ant];
}

@end
