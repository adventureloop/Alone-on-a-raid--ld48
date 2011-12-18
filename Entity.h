//
//  Entity.h
//  CH05_SLQTSOR_EXERCISE
//
//  Created by Tom Jones on 17/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractScene.h"
#import "Image.h"

@interface Entity : NSObject
{
    Image *image;
    
    CGPoint tileLocation;
    CGPoint pixelLocation;
    int type;
    
    int height;
    int width;
}

-(id)initWithTileLocation:(CGPoint )tileLoc image:(Image *)aImage type:(int)aType;
-(void)updateWithDelta:(float)aDelta scene:(AbstractScene *)scene;
-(void)render;
-(void)checkForCollisionWithEntity:(AbstractScene *)entity;
-(CGRect)collisionBounds;
@end
