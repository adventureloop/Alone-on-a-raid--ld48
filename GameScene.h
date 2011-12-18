//
//  GameScene.h
//  SLQTSOR
//
//  Created by Mike Daley on 29/08/2009.
//  Copyright 2009 Michael Daley. All rights reserved.
//

#import "AbstractScene.h"
#import "TileMap.h"
#import "Entity.h"
#import "PlayerEntity.h"
#import "EnemyEntity.h"


#define GAME_STATE_RUNNING 0
#define GAME_STATE_PAUSED 1
#define GAME_STATE_OVER 2
#define GAME_STATE_WON 3

@class Image;
@class ImageRenderManager;

@interface GameScene : AbstractScene {
    Image *pausedImage;
    CGPoint pausedImageCenter;
    
    Image *joypad;
    Image *pauseButton;
    CGPoint pauseButtonCenter;
    CGPoint joypadCenter;
    CGSize joypadSize;
    CGRect joypadBounds;
    
    CGPoint cameraCenter;
    CGPoint touchLocation;
    BOOL touching;
    
	ImageRenderManager *sharedImageRenderManager;
    
    TileMap *tileMap;
    
    NSArray *staticEntities;
    NSMutableArray *enemy;
    PlayerEntity *player;
    float playerHealth;
    Image *halfHeart;
    Image *heart;
    
    //Game states
    int gamestate;
}

-(void)handleTouch:(CGPoint )pos;
-(void)initGame;
@end
