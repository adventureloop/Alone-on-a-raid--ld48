//
//  EnemyEntity.m
//  CH05_SLQTSOR_EXERCISE
//
//  Created by Tom Jones on 17/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EnemyEntity.h"


@implementation EnemyEntity
@synthesize health;

-(id)initWithTileLocation:(CGPoint)tileLoc spriteSheet:(SpriteSheet *)sheet
{
    if(self = [super initWithTileLocation:tileLoc spriteSheet:sheet]) {
        health = 1.0;
        playerSpeed = 2.0;
    }
    return self;
}

-(void)updateWithDelta:(float)aDelta player:(Entity *)player
{
    
    oldLocation.x = tileLocation.x;
    oldLocation.y = tileLocation.y;
 
    [self attackPlayer:player];
    
    int speed = aDelta * playerSpeed + playerSpeed;
    if(moving)
        switch (direction) {
            case UP:
                tileLocation.x += speed;
                break;
            case DOWN:
                tileLocation.x -= speed;
                break;
                
            case LEFT:
                tileLocation.y += speed;
                break;
                
            case RIGHT:
                tileLocation.y -= speed;
                break;
            default:
                break;
        }
}

-(void)attackPlayer:(Entity *)player
{
    int enX = [player collisionBounds].origin.x;
    int enY = [player collisionBounds].origin.y;
    
    int xdif = tileLocation.x - enX;
    int ydif = tileLocation.y - enY;
    
    if(abs(ydif) > abs(xdif))
        if(ydif > 0)
            direction = RIGHT;
        else
            direction = LEFT;
    else
        if(xdif > 0)
            direction = UP;
        else
            direction = DOWN;
    
    moving = YES;
}
@end
