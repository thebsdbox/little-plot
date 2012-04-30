//
//  LittlePlotLineView.h
//  little-plot
//
//  Created by Daniel Finneran on 19/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LittlePlotLineView : NSView 

/* Setter Methods */

// Set the Array of points to be used, this can either be an array of NSNumbers
// or an array of NSPoints (that will need wrapping with the NSValue class
-(void)setPoints:(NSMutableArray *)pointsArray;
// Set an alternative colour, if not used then +(NSColor *)blackcolor is used
-(void)setPlotColour:(NSColor *)plotColour;
// Semi-pointless feature to have values increase in "temperature" after 50% and 75%
-(void)setFire:(BOOL)fire;
-(void)setAutoHeight:(BOOL)autoHeight;
/* Main Functions */

// This will create the relevant paths that will be then drawn by drawRect
-(void)drawPoints;
// This will enable a red cube to be drawn around the [NSView frame], purely for debugging.
-(void)debugView:(BOOL)enableDebug;

@end
