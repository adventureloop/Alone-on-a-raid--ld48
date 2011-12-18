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


@class Image;
@class ImageRenderManager;

@interface GameScene : AbstractScene {
	float transY;
	Image *myImage;
    Image *building;
    
    Image *joypad;
    CGPoint joypadCenter;
    CGSize joypadSize;
    CGRect joypadBounds;
    
    CGPoint cameraCenter;
    CGPoint touchLocation;
    BOOL touching;
    
	ImageRenderManager *sharedImageRenderManager;
	float scaleAmount;
	CGPoint velocity;
	CGPoint point;
    CGPoint dest;
    
    TileMap *tileMap;
    
    NSArray *staticEntities;
    NSMutableArray *enemy;
    PlayerEntity *player;
    float playerHealth;
    Image *halfHeart;
    Image *heart;
}

-(void)handleTouch:(CGPoint )pos;
@end
