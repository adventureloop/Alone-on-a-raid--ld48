//
//  GameScene.m
//  SLQTSOR
//
//  Created by Mike Daley on 29/08/2009.
//  Copyright 2009 Michael Daley. All rights reserved.
//

#import "GameScene.h"
#import "Image.h"
#import "ImageRenderManager.h"

@implementation GameScene

- (id) init
{
	self = [super init];
	if (self != nil) {
		// Grab a reference to the ImageRenderManager
		sharedImageRenderManager = [ImageRenderManager sharedImageRenderManager];
		
		// Create an image using the knight.gif image file
		myImage = [[Image alloc] initWithImageNamed:@"knight.gif" filter:GL_LINEAR];
		// Set the color of the image we have just created
		myImage.color = Color4fMake(1.0, 0.5, 0.5, 0.75);
		// Create a second image using the same image file
		myImage1 = [[Image alloc] initWithImageNamed:@"knight.gif" filter:GL_LINEAR];
		// Set the initial scale amount
		scaleAmount = 2;
		// Set the velocity of the moving image.  This will cause the image to move 50 pixels per second
		velocity = CGPointMake(50, 50);
		// Set the initial position
		point = CGPointMake(160, 240);
	}
	return self;
}

- (void)updateSceneWithDelta:(float)aDelta {

}


- (void)renderScene {
	// Render image1 in the center of the screen
	[myImage1 renderCenteredAtPoint:CGPointMake(160, 240)];
    
	// Render myImage based on the point calculated in the update method
	[myImage renderCenteredAtPoint:point];
    myImage.rotation = myImage.rotation = -90;
	// Ask the ImageRenderManager to render the images on its render queue
	[sharedImageRenderManager renderImages];
}


@end
