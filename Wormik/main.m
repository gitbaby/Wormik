//
//  main.m
//  Wormik
//
//  Created by Oleksii Kozlov on 19.12.11.
//  Copyright 2011 Oleksii Kozlov. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"AppDelegate");
    [pool release];
    return retVal;
}
