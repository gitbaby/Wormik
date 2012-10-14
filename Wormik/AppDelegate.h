//
//  AppDelegate.h
//  Wormik
//
//  Created by Oleksii Kozlov on 19.12.11.
//  Copyright 2012 Oleksii Kozlov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
