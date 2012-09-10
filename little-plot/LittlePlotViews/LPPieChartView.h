//
//  LPPieChartView.h
//  little-plot
//
//  Created by Daniel Finneran on 19/07/2012.
//
//

#import <Cocoa/Cocoa.h>

@interface LPPieChartView : NSView {
    NSArray *_pieSegmentArray;
    NSMutableArray *_colourArray;
}

//Setters
- (void)setPieSegmentArray:(NSArray *)pieSegmentArray;
- (void)setPieSegmentColourArray:(NSArray *)pieSegmentColourArray;
- (void)setDebugView:(BOOL)enableDebug;
//Getters
- (NSArray *)pieSegmentColourArray;
//Other Methods
- (void)generateDrawingInformation;


@end
