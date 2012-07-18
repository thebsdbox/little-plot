//
//  LP3DBarChartView.h
//  little-plot
//
//  Created by Daniel Finneran on 18/07/2012.
//
//

#import <Cocoa/Cocoa.h>

@interface LP3DBarChartView : NSView
- (void)setRect:(NSRect)chartRect;
- (void)setDepth:(NSInteger)depth;
- (void)setColours:(NSArray*)colourArray;
- (void)setLineColour:(NSColor*)lineColour;
- (void)setLineThickness:(NSInteger)lineThickness;
- (void)setchartArray:(NSArray *)chartArray;
- (void)generateBarCharts:(NSArray *)array;
- (void)setBarSpacing:(NSInteger)spacing;
- (void)setAutoBarSpacing:(BOOL)autoSpacing;

@end
