//
//  LittlePlotLabelView.m
//  little-plot
//
//  Created by Daniel Finneran on 22/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LittlePlotLabelView.h"

@interface LittlePlotLabelView (){
    // Internal Variables
    BOOL _enableDebug;
    
    // A bool switch so that drawRect knows what to draw
    BOOL _drawingLineLabels;
    BOOL _reDraw;
    
    // Pie Variables
    NSMutableArray *_pieSegmentData;
    
    
    // Line Variables
    NSMutableArray *_lineLabelData;
}

@end

@implementation LittlePlotLabelView

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
    // Drawing code here.
    if (_enableDebug) {
        [[NSColor redColor] set];        // NSRectFill([self bounds]);
        NSRect viewRect = [self bounds];
        NSBezierPath *rectPath = [NSBezierPath bezierPathWithRect:viewRect];
        [rectPath stroke];
    }
       
    
    if ( _drawingLineLabels) {
        for (NSArray *labelObjects in _lineLabelData) {
            [(NSColor *)[labelObjects objectAtIndex:1] set];
            NSBezierPath *path = [labelObjects objectAtIndex:0];
            [path stroke];
            NSPoint pathPoint = [path currentPoint];
            NSRect labelRect = NSMakeRect((pathPoint.x+5), (pathPoint.y -13), [self frame].size.width, 20);



            if (_reDraw) {
                NSTextView *labelText = [[NSTextView alloc] initWithFrame:labelRect];

            [labelText setString:[labelObjects objectAtIndex:2]];
            [labelText setEditable:NO];
            [labelText setDrawsBackground:NO];
            [labelText setSelectable:NO];
            [self addSubview:labelText]; 
            
            }
            }
        _reDraw = false;

    } else {
        
    
    for (NSArray *labelObjects in _pieSegmentData) {
        [(NSColor *)[labelObjects objectAtIndex:1] set];
        NSRect labelRect = [[labelObjects objectAtIndex:0] rectValue];
        NSRectFill(labelRect);
        labelRect.origin.x = (labelRect.origin.x + labelRect.size.width)+5;
        labelRect.size.width = [self frame].size.width - labelRect.origin.x;
        
        if (_reDraw) {

        NSTextView *labelText = [[NSTextView alloc] initWithFrame:labelRect];
        [labelText setString:[labelObjects objectAtIndex:2]];
        [labelText setEditable:NO];
        [labelText setDrawsBackground:NO];
        [labelText setSelectable:NO];
        [self addSubview:labelText];
        
        }
    }
        _reDraw = false;

    }
}

- (void)debugView:(BOOL)enableDebug {
    _enableDebug = enableDebug;
}

- (void)createLineLabels:(NSArray *)lineColours lineText:(NSArray *)lineText {
    //Pair of Arrays used to create the Labels
    _drawingLineLabels = TRUE;
    
    if ([lineColours count] != [lineText count]) {
        return;
    }
    NSInteger labelSpacing = ([self frame].size.height / ([lineColours count]+1));
    _lineLabelData = [[NSMutableArray alloc] initWithCapacity:[lineColours count]];
    for (unsigned count = 0; count < [lineColours count]; count ++) {
        NSBezierPath *path = [[NSBezierPath alloc] init];
        [path moveToPoint:NSMakePoint(20, (labelSpacing * (count+1)))];
        [path lineToPoint:NSMakePoint(35, (labelSpacing * (count+1)))];                            
        [_lineLabelData addObject:[NSArray arrayWithObjects:
                                   path,
                                   [lineColours objectAtIndex:count],
                                   [lineText objectAtIndex:count],
                                   nil]];
    }
    _reDraw = true;
    [self display];
}


- (void)createPieLabels:(NSArray *)pieSegmentColours lineText:(NSArray *)pieSegmentText {
    //Pair of Arrays used to create the Labels
    _drawingLineLabels = FALSE;
    
    if ([pieSegmentColours count] != [pieSegmentText count]) {
        return;
    }
    NSInteger labelSpacing = ([self frame].size.height / ([pieSegmentColours count]+1));
    NSLog(@"%f diveded by %lu",[self frame].size.height, [pieSegmentColours count]);
    NSLog(@"%lu", labelSpacing);
    _pieSegmentData = [[NSMutableArray alloc] initWithCapacity:[pieSegmentColours count]];
    for (unsigned count = 0; count < [pieSegmentColours count]; count ++ )
    {
        [_pieSegmentData addObject:[NSArray arrayWithObjects:
                                    [NSValue valueWithRect:NSMakeRect(20, (labelSpacing * (count+1)), labelSpacing/2, labelSpacing/2)],
                                     [pieSegmentColours objectAtIndex:count],
                                     [pieSegmentText objectAtIndex:count],
                                     nil]];
    }
    _reDraw = true;
    [self display];
}

@end
