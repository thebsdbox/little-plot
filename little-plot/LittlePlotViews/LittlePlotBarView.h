//
//  LittlePlotBarView.h
//  little-plot
//
//  Created by Daniel Finneran on 17/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LittlePlotBarView : NSView

-(void)debugView:(BOOL)enableDebug;
- (NSBezierPath *)rectToBezierPathDiamond:(NSRect)rect;
@end
