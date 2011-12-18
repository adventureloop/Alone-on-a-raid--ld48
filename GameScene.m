//
//  GameScene.m
//  SLQTSOR
//
//  Created by Mike Daley on 29/08/2009.
//  Copyright 2009 Michael Daley. All rights reserved.
//

#import "Global.h"
#import "GameScene.h"
#import "Image.h"
#import "ImageRenderManager.h"
#import "SpriteSheet.h"
#import "EntityLoader.h"

@implementation GameScene

- (id) init
{
	self = [super init];
	if (self != nil) {
		// Grab a reference to the ImageRenderManager
		sharedImageRenderManager = [ImageRenderManager sharedImageRenderManager];
		
        
        SpriteSheet *spriteSheet = [[SpriteSheet alloc]initWithImageNamed:@"StaticSprites.png" 
                                                               spriteSize:CGSizeMake(32.0, 32.0)
                                                                  spacing:0
                                                                   margin:0 
                                                              imageFilter:GL_LINEAR];
        
        building = [spriteSheet spriteImageAtCoords:CGPointMake(0, 0)];
        
        
       EntityLoader *load = [[EntityLoader alloc]initWithSpriteSheet:@"StaticSprites.png" 
                                                              mapFile:@"SpriteMap.png"
                                                            mapHeight:16 
                                                             mapWidth:16 
                                                           tileHeight:32 
                                                            tileWidth:32];
        
        staticEntities = [load entities];
        
        
        player = [[Entity alloc]initWithTileLocation:CGPointMake(100.0, 100.0) 
                                                       image:[spriteSheet spriteImageAtIndex:13] 
                                                        type:1
                                                       scale:Scale2fMake(2.0, 2.0)
                                                    rotation:0.0];
        
		// Create an image using the knight.gif image file
		myImage = [[Image alloc] initWithImageNamed:@"TileMap.png" filter:GL_LINEAR];
		// Set the color of the image we have just created
		myImage.color = Color4fMake(1.0, 0.5, 0.5, 0.75);
        myImage.scale = Scale2fMake(20.0, 20.0);
        
		// Set the initial scale amount
		scaleAmount = 40;
		// Set the velocity of the moving image.  This will cause the image to move 50 pixels per second
		velocity = CGPointMake(50, 50);
		// Set the initial position
		point = CGPointMake(220, 220);
        dest = CGPointMake(220, 220);
        
        tileMap = [[TileMap alloc] initWithFileName:@"TileMap.png"];
        
        myImage.rotation = myImage.rotation = -90;
        
        cameraCenter = CGPointMake(100,100);
        
        joypad = [[Image alloc] initWithImageNamed:@"JoyPad.png" filter:GL_LINEAR];
        
        joypadCenter = CGPointMake(64,415);
        joypadSize = CGSizeMake(40, 40);
        
		joypadBounds = CGRectMake(joypadCenter.x - joypadSize.width, 
								  joypadCenter.y - joypadSize.height, 
								  joypadSize.width * 2, 
								  joypadSize.height * 2);
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
    
    glClear(GL_COLOR_BUFFER_BIT);
    glPushMatrix();
    glTranslatef(100 - cameraCenter.x,250 - cameraCenter.y, 0);
    
	// Ask the ImageRenderManager to render the images on its render queue
    [tileMap renderLayer:0 mapx:0 mapy:0 width:15 height:15 useBlending:NO];
    
    [sharedImageRenderManager renderImages];
    
    for(Entity *e in staticEntities)
        [e render];
    
	// Render myImage based on the point calculated in the update method
	//[myImage renderCenteredAtPoint:tileMapPositionToPixelPosition(point)];
    

    [building renderCenteredAtPoint:point scale:Scale2fMake(2.0, 2.0) rotation:0.0];

        [player render];
    [sharedImageRenderManager renderImages];
    glPopMatrix();
    
    [joypad renderCenteredAtPoint:joypadCenter];
	[sharedImageRenderManager renderImages];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView
{
    for(UITouch *touch in touches) {
        NSLog(@"Touched at %@",touch);
        
        CGPoint pos = [touch locationInView:aView];
        
        if(pos.x < 60) {
            NSLog(@"Down");
            cameraCenter.x -= 20;
        }
        
        if(pos.x > 110 && pos.x < 160) {
            NSLog(@"Up");
            cameraCenter.x += 20;
        }
        
        if(pos.y < 50) {
            NSLog(@"Left");
            cameraCenter.y += 20;
        }
        
        if(pos.y > 80 && pos.y < 130) {
            NSLog(@"Right");
            cameraCenter.y -= 20;
        }
    }

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView
{
    
    for(UITouch *touch in touches) {
        NSLog(@"Touched at %@",touch);
        
        CGPoint pos = [touch locationInView:aView];
        
        if(pos.x < 60) {
            NSLog(@"Down");
            cameraCenter.x -= 20;
        }
        
        if(pos.x > 110 && pos.x < 160) {
            NSLog(@"Up");
            cameraCenter.x += 20;
        }
        
        if(pos.y < 50) {
            NSLog(@"Left");
            cameraCenter.y += 20;
        }
        
        if(pos.y > 80 && pos.y < 130) {
            NSLog(@"Right");
            cameraCenter.y -= 20;
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView
{
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView
{
}

@end
