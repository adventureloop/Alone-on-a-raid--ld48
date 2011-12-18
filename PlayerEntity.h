//
//  PlayerEntity.h
//  CH05_SLQTSOR_EXERCISE
//
//  Created by Tom Jones on 17/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
#import "Animation.h"

@interface PlayerEntity : Entity
{
    
    Animation *animation;
    
    int direction;
    BOOL moving;
}


-(id)initWithTileLocation:(CGPoint)tileLoc spriteSheet:(SpriteSheet *)sheet;

-(void)moveUp;
-(void)moveDown;
-(void)moveRight;
-(void)moveLeft;
@end
