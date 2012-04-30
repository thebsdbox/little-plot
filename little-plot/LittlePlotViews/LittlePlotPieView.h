//
//  LittlePlotPieView.h
//  little-plot
//
//  Created by Daniel Finneran on 19/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LittlePlotPieView : NSView {	
	NSArray *_pieSegmentArray;
    NSMutableArray *_colourArray;
}


- (void)setPieSegmentArray:(NSArray *)pieSegmentArray;
- (void)setPieSegmentColourArray:(NSArray *)pieSegmentColourArray;

-(NSArray *)pieSegmentColourArray;

//- (NSArray *)segmentPathsArray;
- (void)generateDrawingInformation;
- (void)debugView:(BOOL)enableDebug;

- (NSColor *)randomColor;
- (NSColor *)colorForIndex:(unsigned)index;

@end
