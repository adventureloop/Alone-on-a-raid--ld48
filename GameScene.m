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
		myImage = [[Image alloc] initWithImageNamed:@"TileMap.png" filter:GL_LINEAR];
		// Set the color of the image we have just created
		myImage.color = Color4fMake(1.0, 0.5, 0.5, 0.75);
        
		// Set the initial scale amount
		scaleAmount = 40;
		// Set the velocity of the moving image.  This will cause the image to move 50 pixels per second
		velocity = CGPointMake(50, 50);
		// Set the initial position
		point = CGPointMake(160, 240);
        dest = CGPointMake(160, 240);
	}
	return self;
}

- (void)updateSceneWithDelta:(float)aDelta 
{
    if(point.x != dest.x)
        point.x += (point.x > dest.x) ? -2.0 : 2.0;
    else
        point.x = dest.x;
        
    if(point.y != dest.y)
        point.y += (point.y > dest.y) ? -2.0 : 2.0;
    else
        point.y = dest.y;
}


- (void)renderScene {
    
	// Render myImage based on the point calculated in the update method
	[myImage renderCenteredAtPoint:point];
    myImage.rotation = myImage.rotation = -90;
	// Ask the ImageRenderManager to render the images on its render queue
	[sharedImageRenderManager renderImages];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView
{
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView
{
    for(UITouch *touch in touches) {
        dest = [touch locationInView:aView];
        
        dest.y = 480 - dest.y;
    }
        
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView
{
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView
{
}

@end
