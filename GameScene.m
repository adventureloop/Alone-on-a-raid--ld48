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
	// Calculte a new scale for x and y axis
	float xScale = myImage.scale.x + scaleAmount * aDelta;
	float yScale = myImage.scale.y + scaleAmount * aDelta;
	// Set the image scale to the one just calculated
	myImage.scale = Scale2fMake(xScale, yScale);
	// Set the rotation point to be the middle of the image based on the scale
	myImage.rotationPoint = CGPointMake(45 * myImage.scale.x, 15 * myImage.scale.y);
	// We want to rotate the image 360 degrees per second
	myImage.rotation = myImage.rotation -= 360 * aDelta;
	// If we get above 5x or below 1x then reverse the scale direction
	if (myImage.scale.x >= 2 || myImage.scale.x <= 1) {
		scaleAmount *= -1;
	}
	// Calculate a new position based on the velocity
	point.x += velocity.x * aDelta;
	point.y += velocity.y * aDelta;
	// Reverse the velocity if we go beyond the bounds of the screen
	if (point.x > 320 || point.x < 0) {
		velocity.x = -velocity.x;
	}
	
	if (point.y > 480 || point.y < 0) {
		velocity.y = -velocity.y;
	}
}


- (void)renderScene {
	// Render image1 in the center of the screen
	[myImage1 renderCenteredAtPoint:CGPointMake(160, 240)];
	// Render myImage based on the point calculated in the update method
	[myImage renderCenteredAtPoint:point];
	// Ask the ImageRenderManager to render the images on its render queue
	[sharedImageRenderManager renderImages];
}


@end
