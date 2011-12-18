//
//  Entity.m
//  CH05_SLQTSOR_EXERCISE
//
//  Created by Tom Jones on 17/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Entity.h"

@implementation Entity

-(id)initWithTileLocation:(CGPoint)tileLoc image:(Image *)aImage type:(int)aType
{
    if(self = [super init]) {
        image = aImage;
        type = aType;
        tileLocation = tileLoc;
        scale = Scale2fMake(1.0, 1.0);
        rotation = 0.0;
        
        oldLocation = CGPointMake(tileLocation.x, tileLocation.y);
        
        width = 40.0;
        height = 40.0;
        
        size = CGSizeMake(40.0, 40.0);
    }
    return self;
}

-(id)initWithTileLocation:(CGPoint)tileLoc image:(Image *)aImage type:(int)aType scale:(Scale2f)aScale rotation:(float)aRotation
{
    
    if(self = [super init]) {
        image = aImage;
        type = aType;
        tileLocation = tileLoc;
        scale = aScale;
        rotation = rotation;
        
        width = 40.0;
        height = 40.0;
        
        size = CGSizeMake(40.0, 40.0);
    }
    return self;
}

-(void)render
{
    drawRect([self collisionBounds]);
    [image renderCenteredAtPoint:tileLocation scale:scale rotation:rotation];
}

-(void)undoMove
{
    tileLocation.x = oldLocation.x;
    tileLocation.y = oldLocation.y;
}

-(void)updateWithDelta:(float)aDelta scene:(AbstractScene *)scene {}
-(BOOL)checkForCollisionWithEntity:(Entity *)entity
{
    CGPoint rectPoint = [entity tileLocation];
    CGSize rectSize = [entity size];
    
    return CGRectIntersectsRect([self collisionBounds],[entity collisionBounds]);
}
-(CGPoint)tileLocation
{
    return tileLocation;
}

-(CGSize)size
{
    return size;
}

-(CGRect)collisionBounds
{
    return CGRectMake(tileLocation.x - 20, tileLocation.y - 20, width, height);
}
@end
