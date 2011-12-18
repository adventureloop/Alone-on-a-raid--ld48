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

#include <stdlib.h>

@implementation GameScene

- (id) init
{
	self = [super init];
	if (self != nil) {
		// Grab a reference to the ImageRenderManager
		sharedImageRenderManager = [ImageRenderManager sharedImageRenderManager];
        
        
       EntityLoader *load = [[EntityLoader alloc]initWithSpriteSheet:@"StaticSprites.png" 
                                                              mapFile:@"SpriteMap.png"
                                                            mapHeight:16 
                                                             mapWidth:16 
                                                           tileHeight:32 
                                                            tileWidth:32];
        
        staticEntities = [load entities];
       
        tileMap = [[TileMap alloc] initWithFileName:@"TileMap.png"];
        
        cameraCenter = CGPointMake(100,100);
        
        joypad = [[Image alloc] initWithImageNamed:@"JoyPad.png" filter:GL_LINEAR];
        
        joypadCenter = CGPointMake(64,415);
        joypadSize = CGSizeMake(40, 40);
        
		joypadBounds = CGRectMake(joypadCenter.x - joypadSize.width, 
								  joypadCenter.y - joypadSize.height, 
								  joypadSize.width * 2, 
								  joypadSize.height * 2);
        touching = NO;
        
        pauseButton = [[Image alloc] initWithImageNamed:@"PauseButton.png" filter:GL_LINEAR];
        
        pauseButtonCenter = CGPointMake(10, 30);
        
        pausedImage = [[Image alloc] initWithImageNamed:@"Paused.png" filter:GL_LINEAR];
        
        pausedImageCenter = CGPointMake(100, 500);
        
        SpriteSheet *spriteSheet = [[SpriteSheet alloc]initWithImageNamed:@"Hearts.png" 
                                                               spriteSize:CGSizeMake(64.0, 64.0)
                                                                  spacing:0
                                                                   margin:0 
                                                              imageFilter:GL_LINEAR];
        
        playerHealth = 5.0;
        
        halfHeart = [spriteSheet spriteImageAtIndex:1];
        heart = [spriteSheet spriteImageAtIndex:0];
        
        gamestate = GAME_STATE_PAUSED;
	}
	return self;
}

-(void)initGame
{
    if(enemy == nil)
        enemy = [[NSMutableArray alloc]init];
    else if([enemy count] > 0)
        [enemy removeAllObjects];
    [enemy addObject:[[EnemyEntity alloc]initWithTileLocation:CGPointMake(250, 250) spriteSheet:
                      [[SpriteSheet alloc] initWithImageNamed:@"EnemySprite.png"
                                                   spriteSize:CGSizeMake(32.0, 32.0) 
                                                      spacing:0 
                                                       margin:0 
                                                  imageFilter:GL_LINEAR]] ];
    if(player != nil)
        [player release];
    player = [[PlayerEntity alloc]initWithTileLocation:CGPointMake(350, 350) spriteSheet:
              [[SpriteSheet alloc] initWithImageNamed:@"PlayerSprite.png"
                                           spriteSize:CGSizeMake(32.0, 32.0) 
                                              spacing:0 
                                               margin:0 
                                          imageFilter:GL_LINEAR]];
    
    gamestate = GAME_STATE_RUNNING;
}
- (void)updateSceneWithDelta:(float)aDelta 
{
    if(touching)
        [self handleTouch:touchLocation];
    
    if(![player alive])
        gamestate = GAME_STATE_OVER;
    
    if(gamestate == GAME_STATE_PAUSED) 
        return;    
    
    [player updateWithDelta:aDelta];
    
    if(![player alive])
        gamestate = GAME_STATE_OVER;
    
    if([enemy count] == 0)
        gamestate = GAME_STATE_WON;
    
    for(Entity *e in staticEntities)
        if([player checkForCollisionWithEntity:e])
            [player undoMove];
    
    for(EnemyEntity *e in enemy) {
        [e updateWithDelta:aDelta player:player];
        if([e alive]){
             if([player checkForCollisionWithEntity:e]){
                [player undoMove];            
                [e takeHit];
                if(arc4random() % 100 > 66)
                    [player takeHit];
            }
        }
    }
}


- (void)renderScene 
{
    glClear(GL_COLOR_BUFFER_BIT);
    glPushMatrix();
    
    cameraCenter = [player tileLocation];
    
    glTranslatef(100 - cameraCenter.x,250 - cameraCenter.y, 0);
    
	// Ask the ImageRenderManager to render the images on its render queue
    [tileMap renderLayer:0 mapx:0 mapy:0 width:15 height:15 useBlending:NO];
    
    [sharedImageRenderManager renderImages];
    
    for(Entity *e in staticEntities)
        [e render];
    
    for(EnemyEntity *e in enemy)
        if([e alive])
            [e render];
    
    
    [player render];
    
    [sharedImageRenderManager renderImages];
    glPopMatrix();
    
    //Draw the paused UI if needed
    
   /* if(gamestate == GAME_STATE_PAUSED) {        
        
        return;
    }*/
    
    switch (gamestate) {
        case GAME_STATE_PAUSED:
            [pausedImage renderAtPoint:pausedImageCenter scale:Scale2fMake(4.0, 4.0) rotation:-90.0];
            [sharedImageRenderManager renderImages];
            break;
            
        case GAME_STATE_OVER:
            break;
        case GAME_STATE_WON:
            break;

        case GAME_STATE_RUNNING:
            [joypad renderCenteredAtPoint:joypadCenter];
            [pauseButton renderAtPoint:pauseButtonCenter scale:Scale2fMake(0.4, 0.4) rotation:-90.0];
            
            //Draw the players healt
            float tmpHealth = [player health];
            int ypos = 350;
            while(tmpHealth-- >= 1) {
                [heart renderCenteredAtPoint:CGPointMake(64, ypos) scale:Scale2fMake(0.5, 0.5) rotation:-90.0];
                ypos -= 30;
            }
            break;
        default:
            break;
    }
    
    
	[sharedImageRenderManager renderImages];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView
{
    for(UITouch *touch in touches) {
        touchLocation = [touch locationInView:aView];
        touching = YES;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView
{
    
    for(UITouch *touch in touches) {
        touchLocation = [touch locationInView:aView];
        touching = YES;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView
{
    touching = NO;
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView
{
    touching = NO;
}

-(void)handleTouch:(CGPoint)pos
{
    if(gamestate == GAME_STATE_PAUSED)
        gamestate = GAME_STATE_RUNNING;
    
    NSLog(@"Touched at (%f,%f)",pos.x,pos.y);
    if(pos.y > 400 && pos.x < 50) {
        NSLog(@"Pausing game");
        gamestate = GAME_STATE_PAUSED;
        return;
    }
        
    

    if(pos.x < 60) 
        [player moveDown];
    
    
    if(pos.x > 110 && pos.x < 160)
        [player moveUp];
    
    
    if(pos.y < 50)
        [player moveLeft];
    
    
    if(pos.y > 80 && pos.y < 130) 
        [player moveRight];
    
}
@end
