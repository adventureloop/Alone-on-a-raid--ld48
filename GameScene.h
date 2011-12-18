//
//  GameScene.h
//  SLQTSOR
//
//  Created by Mike Daley on 29/08/2009.
//  Copyright 2009 Michael Daley. All rights reserved.
//

#import "AbstractScene.h"
#import "TileMap.h"

@class Image;
@class ImageRenderManager;

@interface GameScene : AbstractScene {
	float transY;
	Image *myImage;
    Image *building;
    
	ImageRenderManager *sharedImageRenderManager;
	float scaleAmount;
	CGPoint velocity;
	CGPoint point;
    CGPoint dest;
    
    TileMap *tileMap;
}

@end
