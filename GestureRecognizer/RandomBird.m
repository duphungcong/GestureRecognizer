//
//  RandomBird.m
//  GestureRecognizer
//
//  Created by Cuong Trinh on 8/25/15.
//  Copyright (c) 2015 Cuong Trinh. All rights reserved.
//

#import "RandomBird.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImageView+Photo.h"

@interface RandomBird()
//@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;
@property (strong, nonatomic) NSArray *photos;
@property (strong, nonatomic) UIButton *trashButton;

@property (strong, nonatomic) AVAudioPlayer* audioPlayer;
@end
@implementation RandomBird


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //Explain about this app
    UILabel* label = [UILabel new];
    label.numberOfLines = 3;
    label.text = @"1- Tap to add a new bird\n2- Hold Alt key to simulate rotate\n3- Hold Shift key to move two fingers";
    
    CGSize labelSize = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
    
    label.frame = CGRectMake(8, 80, self.view.bounds.size.width - 16, labelSize.height);
    [self.view addSubview:label];
    
    
    //Prepare array of photos to add to screen
    self.photos = @[
                   [UIImage imageNamed:@"01.jpg"],
                   [UIImage imageNamed:@"02.jpg"],
                   [UIImage imageNamed:@"03.jpg"],
                   [UIImage imageNamed:@"04.jpg"],
                   [UIImage imageNamed:@"05.jpg"],
                   [UIImage imageNamed:@"06.jpg"],
                   [UIImage imageNamed:@"07.jpg"],
                   [UIImage imageNamed:@"08.jpg"]];
    
    //Create Tap recognizer
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleTap:)];
    [self.view addGestureRecognizer: tapRecognizer];
    
    
    //Create trash button in bottom right corner
    self.trashButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 70, self.view.bounds.size.height - 70, 64, 64)];
    [self.trashButton setImage:[UIImage imageNamed:@"EmptyTrash.png"]
                      forState:UIControlStateNormal];
    [self.trashButton addTarget:self
                         action:@selector(clickOnTrash:)
               forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.trashButton];
    
    
    //Create audio player
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"empty trash" ofType:@"aif"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error: &error];
    //Truyền địa chỉ của con trỏ chứ không truyền địa chỉ vùng nhớ heap. Nếu có lỗi, con trỏ error mới được khởi tạo
    
    if (error) {
        NSLog(@"Error %@", error.description);
        return;
        
    }
    [self.audioPlayer prepareToPlay];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    int index = rand() % 8;
    UIImageView *aPhoto = [[UIImageView alloc] initWithImage: self.photos[index]];
    aPhoto.center = [tap locationInView:self.view];
    [aPhoto makeItCool];
    [aPhoto addGestureRecognizer];
    [self.view addSubview:aPhoto];
    
    [self.view bringSubviewToFront:self.trashButton];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ((touch.view == self.trashButton)) {
        return NO;
    }
    return YES;
}
- (void)clickOnTrash:(id)sender {
    for (UIView *view in self.view.subviews) {
        //if(view.tag != trashButton.tag) cach nay khong hay
        if ([view isMemberOfClass:[UIImageView class]])
        {
            [self.audioPlayer play];
            
            [UIView animateWithDuration:1.0f
                             animations:^(void)
             {
                 view.center = self.trashButton.center;
                 CGAffineTransform transform = CGAffineTransformMakeScale(0.1f, 0.1f);
                 view.transform = transform;
                 view.alpha = 0.1f;
                 
             } completion:^(BOOL finished)
             {
                 [view removeFromSuperview];
                 
             }];
        }    
    }
}


@end
