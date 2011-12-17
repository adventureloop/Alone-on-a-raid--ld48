//
//  TileMap.m
//  SLQTSOR
//
//  Created by Michael Daley on 05/04/2009.
//  Copyright 2009 Michael Daley. All rights reserved.

#import "TileMap.h"
#import "Transform2D.h"

#import "TileSet.h"
#import "SpriteSheet.h"
#import "GameController.h"
#import "ImageRenderManager.h"
#import "AbstractScene.h"
#import "Texture2D.h"

#pragma mark -
#pragma mark Private interface

@interface TileMap (Private)

// Parses the XML read from the tiled tmx file.
- (void)parseMapFileTBXML:(int)tbXML;

// Using the parsed tilemap data, generate a VBO that contains information on each tile
// that is present in that layer.  These VBOs are then used to render layers as requested
- (void)createLayerTileImages;

// Parse the objects that have been defined on the map
- (void)parseMapObjects:(int)aTmxXML;
@end

#pragma mark -
#pragma mark Public implementation

@implementation TileMap

@synthesize tileSets;
@synthesize layers;
@synthesize objectGroups;
@synthesize mapWidth;
@synthesize mapHeight;
@synthesize tileWidth;
@synthesize tileHeight;
@synthesize colorFilter;

- (void)dealloc {
    NSLog(@"INFO - TiledMap: Deallocating");
    [objectGroups release];
    [mapProperties release];
    if (tileSetProperties)
        [tileSetProperties release];
    [tileSets release];
    [layers release];
    [super dealloc];
}

- (id)initWithFileName:(NSString*)aTiledFile fileExtension:(NSString*)aFileExtension {
    
    self = [super init];
    if (self != nil) {
        
        // Grab a reference to the game controller
        sharedGameController = [GameController sharedGameController];
		sharedImageRenderManager = [ImageRenderManager sharedImageRenderManager];
        
        // Set up the arrays and default values for layers and tilesets
        tileSets = [[NSMutableArray alloc] init];
        layers = [[NSMutableArray alloc] init];
        mapProperties = [[NSMutableDictionary alloc] init];
        objectGroups = [[NSMutableDictionary alloc] init];
        
        
        //Parse tilemap 
    }
    
    // Create an empty TexturedColoredQuad that can be used to check for other empty TexturedColoredQuads
    // inside a layers tileImages array.
	memset(&nullTCQ, 0, sizeof(TexturedColoredQuad));
    
    // Create tile images for each layer in the tilemap.  These will then be used when we render
    // a layer.
    [self createLayerTileImages];
    
    colorFilter = Color4fOnes;
    
    return self;
}

- (void)renderLayer:(int)aLayerIndex mapx:(int)aMapx mapy:(int)aMapy width:(int)aWidth height:(int)aHeight useBlending:(BOOL)aUseBlending {
    
    // Make sure the boundaries of the tiles to be rendered are within the bounds of the layer
    if (aMapx < 0)
        aMapx = 0;
    if (aMapx > mapWidth)
        aMapx = mapWidth;
    if (aMapy < 0)
        aMapy = 0;
    if (aMapy > mapHeight)
        aMapy = mapHeight;
	
    int maxWidth = aMapx + aWidth;
    int maxHeight = aMapy + aHeight;	
    
    // Grab the layer specified
	Layer *layer = [layers objectAtIndex:aLayerIndex];
	
    // There is only ever one tileset so grab it and get the name of the texture it uses
    TileSet *tileSet = [tileSets objectAtIndex:0];
	uint textureName = [tileSet tiles].image.texture.name;
	
    // Loop through the tiles within the range specified and add their images to the render queue.
	for (int y=aMapy; y < maxHeight; y++) {
        for (int x=aMapx; x < maxWidth; x++) {
            // Grab the TexturedColoredQuad for the image at this tile location
			TexturedColoredQuad *tcq = [layer getTileImageAt:CGPointMake(x, y)];
            
			// If the TexturedColoredQuad returned is not the same as the nullTCQ then it is populated
            // and we can add it to the render quque.
			if (memcmp(tcq, &nullTCQ, sizeof(TexturedColoredQuad)) != 0)
				[sharedImageRenderManager addTexturedColoredQuadToRenderQueue:tcq texture:textureName];
		}
    }
}

- (TileSet*)tileSetWithGlobalID:(int)aGlobalID {
    // Loop through all the tile sets we have and check to see if the supplied global ID
    // is within one of those tile sets.  If the global ID is found then return the tile set
    // in which it was found
    for(TileSet *tileSet in tileSets) {
        if([tileSet containsGlobalID:aGlobalID]) {
            return tileSet;
        }
    }
    return nil;
}

- (int)layerIndexWithName:(NSString*)aLayerName {
    
    // Loop through the names of the layers and pass back the index if found
    for(Layer *layer in layers) {
        if([[layer layerName] isEqualToString:aLayerName]) {
            return [layer layerID];
        }
    }
    
    // If we reach here then no layer with a matching name was found
    return -1;
}


- (NSString*)mapPropertyForKey:(NSString*)aKey defaultValue:(NSString*)aDefaultValue {
    NSString *value = [mapProperties valueForKey:aKey];
    if(!value)
        return aDefaultValue;
    return value;
}


- (NSString*)layerPropertyForKey:(NSString*)aKey layerID:(int)aLayerID defaultValue:(NSString*)aDefaultValue {
    if(aLayerID < 0 || aLayerID > [layers count] -1) {
        NSLog(@"TILED ERROR: Request for a property on a layer which is out of range.");
        return nil;
    }
    NSString *value = [[[layers objectAtIndex:aLayerID] layerProperties] valueForKey:aKey];
    if(!value)
        return aDefaultValue;
    return value;
}


- (NSString*)tilePropertyForGlobalTileID:(int)aGlobalTileID key:(NSString*)aKey defaultValue:(NSString*)aDefaultValue {
    NSString *value = [[tileSetProperties valueForKey:[NSString stringWithFormat:@"%d", aGlobalTileID]] valueForKey:aKey];
    if(!value)
        return aDefaultValue;
    return value;
}

@end

#pragma mark -
#pragma mark Private implementation

@implementation TileMap (Private)

- (void)createLayerTileImages {
    
    int x = 0;
    int y = 0;
    
    // Grab the tileset for the tile map
    TileSet *tileSet = [tileSets objectAtIndex:0];
    
    // Loop through all the layers in the map and create a VBO for each
    for(int layerIndex=0; layerIndex < [layers count]; layerIndex++) {
        
        Layer *layer = [layers objectAtIndex:layerIndex];
        
        // Only create images for this layer is it is marked as visible
        if ([self layerPropertyForKey:@"visible" layerID:layerIndex defaultValue:@"0"]) {
            for(int mapTileY=0; mapTileY < mapHeight; mapTileY++) {
                for(int mapTileX=0; mapTileX < mapWidth; mapTileX++) {
                    
                    // Get the tileID and tilesetID for the current map location
                    int tileID = [layer tileIDAtTile:CGPointMake(mapTileX, mapTileY)];
                    
                    // We only want to generate information for this tile if the tile is being used
                    if (tileID > -1) {
                        // Get the sprite used at this tile locaiton
                        SpriteSheet *tileSprites = [tileSet tiles];
                        Image *tileImage = [tileSprites spriteImageAtCoords:CGPointMake([tileSet getTileX:tileID], [tileSet getTileY:tileID])];
                        
                        // Add the tile images ImageDetails to the layer
                        [layer addTileImageAt:CGPointMake(mapTileX, mapTileY) imageDetails:tileImage.imageDetails];
                    }
                    x += tileWidth;
                }
                // Now we have finished so move to the next row of tiles and reset x.  y has to be incremented as
                // we are rendering the rows from the bottom to the top of the screen.
                y += tileHeight;
                x = 0;
            }
            y = 0;
        }
    }
}

- (void)parseMapFileTBXML:(int)tbXML {
 }

- (void)parseMapObjects:(int)aTmxXML {
}

@end