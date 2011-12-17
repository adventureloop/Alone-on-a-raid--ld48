//
//  TileSet.m
//  CH05_SLQTSOR_EXERCISE
//
//  Created by Tom Jones on 17/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TileSet.h"

@implementation TileSet

-(id)initWithImagedNamed:(NSString *)aImageFileName 
                    name:(NSString *)aName 
               tileSetID:(int)aTileSetID
                firstGID:(int)afirstGID 
                tileSize:(CGSize)aSize 
                 spacing:(int)aSpacing 
                  margin:(int)aMargin
{
    if(self = [super init]) {
        sharedTextureManager = [TextureManager sharedTextureManager];
        
        tiles = [[SpriteSheet spriteSheetForImageNamed:aImageFileName 
                                            spriteSize:aSize 
                                               spacing:aSpacing 
                                                margin:aMargin 
                                           imageFilter:GL_LINEAR] retain];
        
        tileSetID = aTileSetID;
        name = aName;
        firstGlobalID = afirstGID;
        tileHeight = aSize.height;
        tileWidth = aSize.width;
        spacing = aSpacing;
        margin = aMargin;
        
        horizontalTiles = tiles.horizSpriteCount;
        verticalTiles = tiles.vertSpriteCount;
        
        lastGlobalID = tiles.horizSpriteCount * tiles.vertSpriteCount + firstGlobalID - 1;
    }
    return self;
}




- (BOOL)containsGlobalID:(int)aGlobalID {
	// If the global ID which has been passed is within the global IDs in this
	// tileset then return YES
	return (aGlobalID >= firstGlobalID) && (aGlobalID <= lastGlobalID);
}


- (int)getTileX:(int)aTileID {
	return aTileID % horizontalTiles;
}


- (int)getTileY:(int)aTileID {
	return aTileID / horizontalTiles;
}
@end
