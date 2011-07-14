//
//  PlantKeyAppDelegate.h
//  PlantKey
//
//  Created by David J Gagnon on 8/9/10.
//  Copyright University of Wisconsin 2010. All rights reserved.
//
//  Licensed under the MIT license: 
//  http://www.opensource.org/licenses/mit-license.php



#import <UIKit/UIKit.h>

@interface PlantKeyAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

