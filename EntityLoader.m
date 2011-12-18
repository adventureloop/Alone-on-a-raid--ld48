//
//  EntityLoader.m
//  CH05_SLQTSOR_EXERCISE
//
//  Created by Tom Jones on 18/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EntityLoader.h"

@implementation EntityLoader
-(id)initWithSpriteSheet:(NSString *)spriteSheet
                 mapFile:(NSString *)mapFile
            mapHeight:(int)aMapHeight 
             mapWidth:(int)aMapWidth 
           tileHeight:(int)aTileHeight 
            tileWidth:(int)aTileWidth
{
    if(self = [super init]) {
        entities = [[NSMutableArray alloc]init];
        
        mapHeight = aMapHeight;
        mapWidth = aMapWidth;
        tileHeight = aTileHeight;
        tileWidth = aTileWidth;
        
        sprites = [[SpriteSheet alloc]initWithImageNamed:spriteSheet
                                              spriteSize:CGSizeMake(aTileWidth, aTileHeight) 
                                                 spacing:0
                                                margin:0 
                                             imageFilter:GL_LINEAR];
        
        pixelWidth = tileWidth * mapHeight;
        pixelHeight = tileHeight * mapHeight;
        
        [self parseMapFile:mapFile];
    }
    
    return self;
}

-(NSArray *)entities
{
    return entities;
}

#pragma mark -Parsing Map File
-(void)parseMapFile:(NSString *)fileName
{
    //Get the correct path
    NSString *filename = [fileName stringByDeletingPathExtension];
	NSString *filetype = [fileName pathExtension];
	NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:filetype];
    
    
    // First get the image into your data buffer
    CGImageRef image = [[UIImage imageWithContentsOfFile:path ]  CGImage];
    NSUInteger width = CGImageGetWidth(image);
    NSUInteger height = CGImageGetHeight(image);
    
    //tileHeight = height;
    //tileWidth = width;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = malloc(height * width * 4);
    
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    
    CGContextRef context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height),image);
    CGContextRelease(context);
    
    //layerName = @"Main Layer";
    //layerWidth = width;
    //layerHeight = height;
    
    
    //mapWidth = 16;
   // mapHeight = 16;
    
    int x = 0;
    int y = 0;
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    int byteIndex = 0;
    
    byteIndex = (bytesPerRow * y) + x * bytesPerPixel;
    for(y = 0;y < height;y++) {
        for(x = 0;x < width;x++) {
            byteIndex = (bytesPerRow * y) + x * bytesPerPixel;
            
            if(rawData[byteIndex] > 0 && rawData[byteIndex] < 16) {
                NSLog(@"Entity at (%d,%d)",x,y);
                [entities addObject:[[Entity alloc] initWithTileLocation:CGPointMake((float)x * 100, (float)y * 100) 
                                                                   image:[[sprites  spriteImageAtIndex:rawData[byteIndex]] retain]                                    
                                                                    type:rawData[byteIndex]
                                                                   scale:Scale2fMake(2.0, 2.0) 
                                                                    rotation:0.0] ];
                
            }
            
        }
    }
}
@end
