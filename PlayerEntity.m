//
//  PlayerEntity.m
//  CH05_SLQTSOR_EXERCISE
//
//  Created by Tom Jones on 17/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayerEntity.h"


@implementation PlayerEntity
@synthesize health;

-(id)initWithTileLocation:(CGPoint)tileLoc spriteSheet:(SpriteSheet *)sheet
{
    if(self = [super init]) {
        tileLocation = tileLoc;
        animation = [[Animation alloc]initWithSpriteSheet:sheet];
        
        moving = NO;
        direction = DOWN;
        
        playerSpeed = 2.0;
        width = 10.0;
        height = 10.0;
        size = CGSizeMake(10.0, 10.0);
        
        health = 5.0;
    }
    return self;
}


-(CGRect)collisionBounds
{
    return CGRectMake(tileLocation.x, tileLocation.y - 20, width, height);
}

-(void)render
{
   // NSLog(@"Player at %f %f",tileLocation.x,tileLocation.y);
    //drawRect(CGRectMake(tileLocation.x, tileLocation.y - 20, size.width, size.width));
    drawRect([self collisionBounds]);
    [[animation frameForDirection:direction moving:moving] renderAtPoint:tileLocation scale:Scale2fMake(1.0, 1.0) rotation:-90.0];
    moving = NO;
}

-(void)updateWithDelta:(float)aDelta
{
    oldLocation.x = tileLocation.x;
    oldLocation.y = tileLocation.y;
    
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

-(void)moveUp
{
    direction = UP;
    moving = YES;
}

-(void)moveDown
{
    direction = DOWN;
    moving = YES;
}

-(void)moveRight
{
    direction = RIGHT;
    moving = YES;
}

-(void)moveLeft
{
    direction = LEFT;
    moving = YES;
}

-(void)takeHit
{
    health -= 0.5;
}

-(BOOL)alive
{
    if(health > 0)
        return YES;
    return NO;
}
@end
