//
//  SLQTSORAppDelegate.m
//  SLQTSOR
//
//  Created by Michael Daley on 25/08/2009.
//  Copyright Michael Daley 2009. All rights reserved.
//

#import "SLQTSORAppDelegate.h"
#import "EAGLView.h"

@implementation SLQTSORAppDelegate

@synthesize window;
@synthesize glView;

- (void) applicationDidFinishLaunching:(UIApplication *)application
{
	[glView startAnimation];
}

- (void) applicationWillResignActive:(UIApplication *)application
{
	[glView stopAnimation];
}

- (void) applicationDidBecomeActive:(UIApplication *)application
{
	[glView startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	[glView stopAnimation];
}

- (void) dealloc
{
	[window release];
	[glView release];
	
	[super dealloc];
}

@end
