//
//  Entity.m
//  CH05_SLQTSOR_EXERCISE
//
//  Created by Tom Jones on 17/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Entity.h"

@implementation Entity


-(id)initWithTileLocation:(CGPoint)tileLoc type:(int)aType
{
    if(self = [super init]) {
        type = aType;
        tileLocation = tileLoc;
    }
    return self;
}

-(void)render{}
-(void)updateWithDelta:(float)aDelta scene:(AbstractScene *)scene {}
-(void)checkForCollisionWithEntity:(AbstractScene *)entity{}

-(CGRect)collisionBounds
{
    return CGRectMake(tileLocation.x, tileLocation.y, width, height);
}
@end
