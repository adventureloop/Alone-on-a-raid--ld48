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
        playerSpeed = 1.0;
    }
    return self;
}

-(void)updateWithDelta:(float)aDelta player:(Entity *)player
{
    
    oldLocation.x = tileLocation.x;
    oldLocation.y = tileLocation.y;
 
    [self attackPlayer:player];
    
    int speed = ((aDelta * playerSpeed) + playerSpeed);
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
    int enX = [player collisionBounds].origin.x + 5;
    int enY = [player collisionBounds].origin.y + 12;
    
    int xdif = tileLocation.x - enX;
    int ydif = tileLocation.y - enY;
    
    
    //if(xdif < 10 && ydif < 10)
      //  return;
    
    if(xdif > 100 && ydif > 100)
        return;
    
    moving = NO;
    
    if(abs(ydif) > abs(xdif)) {
        if(ydif > 0)
            direction = RIGHT;
        else
            direction = LEFT;
        moving = YES;
    } else {
        if(xdif > 0)
            direction = DOWN;
        else
            direction = UP;
        moving = YES;
    }
}
@end
