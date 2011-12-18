//
//  Animation.m
//  CH05_SLQTSOR_EXERCISE
//
//  Created by Tom Jones on 18/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Animation.h"
#import "AnimationHeader.h"

@implementation Animation


-(id)initWithSpriteSheet:(SpriteSheet *)aSheet
{
    if(self = [super init]) {
        sprites = aSheet;
        frames = [[NSMutableArray alloc]init];
        frameDict = [[NSMutableDictionary alloc]init];
    }
    return self;
}

-(Image *)frameForDirection:(int)dir moving:(BOOL)moving
{
    switch (dir) {
        case DOWN:
            if(moving)
                if(nextDown == MOVING_DOWN0) {
                    nextDown = MOVING_DOWN1;
                    return [sprites spriteImageAtIndex:nextDown];
                } else {
                    nextDown = MOVING_DOWN0;
                    return [sprites spriteImageAtIndex:nextDown];
                }
            return [sprites spriteImageAtIndex:STATIONARY_DOWN];
            break;            
        case UP:
            if(moving)
                if(nextUp == MOVING_UP0) {
                    nextUp = MOVING_UP1;
                    return [sprites spriteImageAtIndex:nextUp];
                } else {
                    nextUp = MOVING_UP0;
                    return [sprites spriteImageAtIndex:nextUp];
                }
            return [sprites spriteImageAtIndex:STATIONARY_UP];
            break; 
        case LEFT:
            if(moving)
                if(nextLeft == MOVING_LEFT0) {
                    nextLeft = MOVING_LEFT1;
                    return [sprites spriteImageAtIndex:nextLeft];
                } else {
                    nextLeft = MOVING_LEFT0;
                    return [sprites spriteImageAtIndex:nextLeft];
                }
            return [sprites spriteImageAtIndex:STATIONARY_LEFT];
            break; 
        case RIGHT:
            if(moving)
                if(nextRight == MOVING_RIGHT0) {
                    nextRight = MOVING_RIGHT1;
                    return [sprites spriteImageAtIndex:nextRight];
                } else {
                    nextRight = MOVING_RIGHT0;
                    return [sprites spriteImageAtIndex:nextRight];
                }
            return [sprites spriteImageAtIndex:STATIONARY_RIGHT];
            break; 
        default:
            break;
    }
    return nil;
}

-(Image *)frameForKey:(int)index
{
    return [sprites spriteImageAtIndex:index];
}
@end
