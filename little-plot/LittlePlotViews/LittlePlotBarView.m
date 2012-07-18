//
//  LittlePlotBarView.m
//  little-plot
//
//  Created by Daniel Finneran on 17/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LittlePlotBarView.h"

@interface LittlePlotBarView () {
    bool _enableDebug;
}

@end

@implementation LittlePlotBarView

- (BOOL) isFlipped {
    return true;
}

- (void)debugView:(BOOL)enableDebug {
    _enableDebug = enableDebug;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    if (_enableDebug) {
        [[NSColor redColor] set];
        [[NSBezierPath bezierPathWithRect:[self bounds]] stroke];
    }
    NSInteger rotateFactor = 9;
    NSRect rect3 = NSMakeRect(10, 0, 100, 100);
    NSRect rect4 = NSMakeRect(10, 50, 100, 100);

    NSRect rect1 = NSMakeRect(100, 0, 100, 100);
    NSRect rect2 = NSMakeRect(100, 100, 100, 100);
    
    [[NSColor redColor]set];
    [[self rectToBezierPathDiamondRotated:rect1 factorToRotate:rotateFactor]  fill];
    [[NSColor blueColor]set];
    [[self rectToBezierPathCuboid:rect2 withHeight:100 factorToRotate:rotateFactor] fill];
    [[NSColor greenColor]set];
    [[self rectToBezierPathCuboidPart2:rect2 withHeight:100 factorToRotate:rotateFactor] fill];
    [[NSColor blueColor]set];

    [[NSColor redColor]set];
    [[self rectToBezierPathDiamondRotated:rect3 factorToRotate:rotateFactor]  fill];
    [[NSColor blueColor]set];
    [[self rectToBezierPathCuboid:rect4 withHeight:50 factorToRotate:rotateFactor] fill];
    [[NSColor greenColor]set];
    [[self rectToBezierPathCuboidPart2:rect4 withHeight:50 factorToRotate:rotateFactor] fill];
    [[NSColor blueColor]set];
}

- (NSBezierPath *)rectToBezierPathDiamondRotated:(NSRect)rect factorToRotate:(NSInteger)rotation{
    //This will take the four coord that make up the rect and rotate them into a diamond
    
    NSBezierPath *convertedPath =[NSBezierPath bezierPath];
    //D
    [convertedPath moveToPoint:NSMakePoint(rect.origin.x, (rect.size.height /rotation+ rect.origin.y))];
    //A
    [convertedPath lineToPoint:NSMakePoint((rect.size.width/rotation + rect.origin.x), (rect.size.height + rect.origin.y))];
    //B
    [convertedPath lineToPoint:NSMakePoint((rect.size.width + rect.origin.x) , (rect.size.height - (rect.size.height /rotation) + rect.origin.y))];
    //C
    [convertedPath lineToPoint:NSMakePoint((rect.size.width - (rect.size.width/rotation) + rect.origin.x), rect.origin.y)];
    // D  
    [convertedPath lineToPoint:NSMakePoint(rect.origin.x, (rect.size.height /rotation+ rect.origin.y))];
    return convertedPath;
    
} 
- (NSBezierPath *)rectToBezierPathDiamond:(NSRect)rect {
    //This will take the four coord that make up the rect and rotate them into a diamond

    NSBezierPath *convertedPath =[NSBezierPath bezierPath];
    //D
    [convertedPath moveToPoint:NSMakePoint(rect.origin.x, (rect.size.height /2+ rect.origin.y))];
    //A
    [convertedPath lineToPoint:NSMakePoint((rect.size.width/2 + rect.origin.x), (rect.size.height + rect.origin.y))];
    //B
    [convertedPath lineToPoint:NSMakePoint((rect.size.width + rect.origin.x) , (rect.size.height /2+ rect.origin.y))];
    //C
    [convertedPath lineToPoint:NSMakePoint((rect.size.width/2 + rect.origin.x), rect.origin.y)];
    // D  
    [convertedPath lineToPoint:NSMakePoint(rect.origin.x, (rect.size.height /2+ rect.origin.y))];


    return convertedPath;

}

- (NSBezierPath *)rectToBezierPathCuboid:(NSRect)rect withHeight:(NSInteger)height {
    NSBezierPath *convertedPath =[NSBezierPath bezierPath];
    //D
    [convertedPath moveToPoint:NSMakePoint(rect.origin.x, (rect.size.height /2+ rect.origin.y))];
    //A
    [convertedPath lineToPoint:NSMakePoint((rect.size.width/2 + rect.origin.x), (rect.size.height + rect.origin.y))];    
    //B
    [convertedPath lineToPoint:NSMakePoint((rect.size.width/2 + rect.origin.x),(rect.size.height + rect.origin.y) - height)];
    //C
    [convertedPath lineToPoint:NSMakePoint(rect.origin.x, (rect.size.height /2 + rect.origin.y) - height)];
    //D
    [convertedPath lineToPoint:NSMakePoint(rect.origin.x, (rect.size.height /2+ rect.origin.y))];
    
    return convertedPath;
    
}

- (NSBezierPath *)rectToBezierPathCuboid:(NSRect)rect withHeight:(NSInteger)height factorToRotate:(NSInteger)rotation{
    NSBezierPath *convertedPath =[NSBezierPath bezierPath];
    //D
    [convertedPath moveToPoint:NSMakePoint(rect.origin.x, (rect.size.height /rotation + rect.origin.y))];
    //A
    [convertedPath lineToPoint:NSMakePoint((rect.size.width/rotation + rect.origin.x), (rect.size.height + rect.origin.y))];
    //B
    [convertedPath lineToPoint:NSMakePoint((rect.size.width/rotation + rect.origin.x),(rect.size.height + rect.origin.y) - height)];
    //C
    [convertedPath lineToPoint:NSMakePoint(rect.origin.x, (rect.size.height /rotation + rect.origin.y) - height)];
    //D
    [convertedPath lineToPoint:NSMakePoint(rect.origin.x, (rect.size.height /rotation + rect.origin.y))];
    return convertedPath;
    
}

- (NSBezierPath *)rectToBezierPathCuboidPart2:(NSRect)rect withHeight:(NSInteger)height factorToRotate:(NSInteger)rotation{
    NSBezierPath *convertedPath =[NSBezierPath bezierPath];
    /*
    //D
    [convertedPath moveToPoint:NSMakePoint(rect.origin.x, (rect.size.height /rotation + rect.origin.y))];
    //A
    [convertedPath lineToPoint:NSMakePoint((rect.size.width/rotation + rect.origin.x), (rect.size.height + rect.origin.y))];
    //B
    [convertedPath lineToPoint:NSMakePoint((rect.size.width/rotation + rect.origin.x),(rect.size.height + rect.origin.y) - height)];
    //C
    [convertedPath lineToPoint:NSMakePoint(rect.origin.x, (rect.size.height /rotation + rect.origin.y) - height)];
    //D
    [convertedPath lineToPoint:NSMakePoint(rect.origin.x, (rect.size.height /rotation+ rect.origin.y))];
     */
    [convertedPath moveToPoint:NSMakePoint((rect.size.width/rotation + rect.origin.x), (rect.size.height + rect.origin.y))];

    [convertedPath lineToPoint:NSMakePoint((rect.size.width + rect.origin.x), (rect.size.height - (rect.size.height /rotation) + rect.origin.y))];
    
    //[convertedPath lineToPoint:NSMakePoint((rect.size.width + rect.origin.x),(rect.size.height + rect.origin.y) - height)];
    [convertedPath lineToPoint:NSMakePoint((rect.size.width + rect.origin.x),(rect.size.height - (rect.size.height /rotation) + rect.origin.y)-height)];
    [convertedPath lineToPoint:NSMakePoint((rect.size.width/rotation + rect.origin.x), (rect.size.height + rect.origin.y) - height)];
    [convertedPath lineToPoint:NSMakePoint((rect.size.width/rotation + rect.origin.x), (rect.size.height + rect.origin.y))];

    //[convertedPath lineToPoint:NSMakePoint((rect.size.width + rect.origin.x) , (rect.size.height - (rect.size.height /rotation) + rect.origin.y))];
    //C
   // [convertedPath lineToPoint:NSMakePoint((rect.size.width - (rect.size.width/rotation) + rect.origin.x), rect.origin.y)];
    // D  
  //  [convertedPath lineToPoint:NSMakePoint(rect.origin.x, (rect.size.height /rotation+ rect.origin.y))];

    return convertedPath;
    
}

@end
