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
    }
    return self;
}

-(void)render
{
    [image renderCenteredAtPoint:tileLocation];//tileMapPositionToPixelPosition(tileLocation) scale:scale rotation:rotation];
}


-(void)updateWithDelta:(float)aDelta scene:(AbstractScene *)scene {}
-(void)checkForCollisionWithEntity:(AbstractScene *)entity{}

-(CGRect)collisionBounds
{
    return CGRectMake(tileLocation.x, tileLocation.y, width, height);
}
@end
