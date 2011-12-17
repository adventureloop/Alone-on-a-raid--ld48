//
//  SLQTSORAppDelegate.h
//  SLQTSOR
//
//  Created by Michael Daley on 25/08/2009.
//  Copyright Michael Daley 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"

@class EAGLView;

@interface SLQTSORAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    EAGLView *glView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet EAGLView *glView;

@end

