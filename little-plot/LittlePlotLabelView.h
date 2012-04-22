//
//  LittlePlotLabelView.h
//  little-plot
//
//  Created by Daniel Finneran on 22/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LittlePlotLabelView : NSView



- (void)createLineLabels:(NSArray *)lineColours lineText:(NSArray *)lineText; 
- (void)createPieLabels:(NSArray *)pieSegmentColours lineText:(NSArray *)pieSegmentText;

@end
