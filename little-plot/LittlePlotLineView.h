//
//  LittlePlotLineView.h
//  little-plot
//
//  Created by Daniel Finneran on 19/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LittlePlotLineView : NSView {
    
}

-(BOOL)setPoints:(NSMutableArray *)pointsArray;
-(void)drawPoints;
-(void)drawFirePoints;
- (void)debugView:(BOOL)enableDebug;
-(void)setPlotColour:(NSColor *)plotColour;



@end
