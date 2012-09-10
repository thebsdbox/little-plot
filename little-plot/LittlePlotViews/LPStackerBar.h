//
//  LPStackerBar.h
//  little-plot
//
//  Created by Daniel Finneran on 22/08/2012.
//
//

#import <Cocoa/Cocoa.h>

@interface LPStackerBar : NSView

-(void)setHorizontal:(BOOL)horizontal;
- (void)setPieSegmentColourArray:(NSMutableArray *)pieSegmentColourArray;

@end
