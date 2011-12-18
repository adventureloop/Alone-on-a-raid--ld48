//
//  PlayerEntity.m
//  CH05_SLQTSOR_EXERCISE
//
//  Created by Tom Jones on 17/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayerEntity.h"
#import "AnimationHeader.h"

@implementation PlayerEntity

-(id)initWithTileLocation:(CGPoint)tileLoc spriteSheet:(SpriteSheet *)sheet
{
    if(self = [super init]) {
        tileLocation = tileLoc;
        animation = [[Animation alloc]initWithSpriteSheet:sheet];
        
        moving = NO;
        direction = DOWN;
    }
    return self;
}

-(void)render
{
    [[animation frameForDirection:direction moving:moving] renderAtPoint:tileLocation scale:Scale2fMake(1.0, 1.0) rotation:-90.0];
    moving = NO;
}

-(void)moveUp
{
    oldLocation.x = tileLocation.x;
    
    tileLocation.x += 5;
    direction = UP;
    moving = YES;
}

-(void)moveDown
{
    oldLocation.x = tileLocation.x;
    
    tileLocation.x -= 5;
    direction = DOWN;
    moving = YES;
}

-(void)moveRight
{
    oldLocation.y = tileLocation.y;
    
    tileLocation.y -= 5;
    direction = RIGHT;
    moving = YES;
}

-(void)moveLeft
{
    oldLocation.y = tileLocation.y;
    
    tileLocation.y += 5;
    direction = LEFT;
    moving = YES;
}
@end
