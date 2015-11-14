//
//  BootLogic.m
//  TechmasterApp
//
//  Created by techmaster on 9/7/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

#import "BootLogic.h"
#import "MainScreen.h"


@implementation BootLogic
+ (void) boot: (UIWindow*) window
{
    MainScreen* mainScreen = [[MainScreen alloc] initWithStyle:UITableViewStyleGrouped];
    //--------- From this line, please customize your menu data -----------
    NSDictionary* basic = @{SECTION: @"Basic", MENU: @[
                                    @{TITLE: @"Tap", CLASS: @"Tap"},
                                     @{TITLE: @"TapUI", CLASS: @"TapUI"},
                                    @{TITLE: @"Pan", CLASS: @"Pan"},
                                    @{TITLE: @"Pinch to scale", CLASS: @"Pinch"},
                                    @{TITLE: @"Pinch Rotate", CLASS: @"PinchRotate"},
                                    @{TITLE: @"Pan Velocity", CLASS: @"PanVelocity"},
                                    @{TITLE: @"Random Bird", CLASS: @"RandomBird"}
                          ]};
    NSDictionary* intermediate = @{SECTION: @"UIGestureRecognizerDelegate", MENU: @[
                                    @{TITLE: @"Simultanous Recognizer", CLASS: @"SimulRecognizer"},
                                  ]};
    NSDictionary* hw = @{SECTION: @"HW", MENU: @[
                                    @{TITLE: @"Rotate Ball", CLASS: @"RotateBall"},
                                    @{TITLE: @"Pinch Rotate Delegate", CLASS: @"PinchRotateDelegate"},
                                    @{TITLE: @"Len Zoom", CLASS: @"LenZoom"}
                                  ]};

    
    mainScreen.menu = @[basic, intermediate, hw];
    mainScreen.title = @"Gesture Recognizer";
    mainScreen.about = @"Written by cuong@techmaster.vn";
    //--------- End of customization -----------
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController: mainScreen];
    
    window.rootViewController = nav;
}
@end
