//
//  LittlePlotPieView.h
//  little-plot
//
//  Created by Daniel Finneran on 19/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LittlePlotPieView : NSView {	
    NSArray *_segmentNamesArray;
	NSArray *_segmentValuesArray;
	NSMutableArray *_segmentPathsArray;
}


- (NSArray *)segmentNamesArray;
- (void)setSegmentNamesArray:(NSArray *)newArray;

- (NSArray *)segmentValuesArray;
- (void)setSegmentValuesArray:(NSArray *)newArray;

- (NSArray *)segmentPathsArray;
- (void)generateDrawingInformation;

- (NSColor *)randomColor;
- (NSColor *)colorForIndex:(unsigned)index;

@end
