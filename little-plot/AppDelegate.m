//
//  AppDelegate.m
//  little-plot
//
//  Created by Daniel Finneran on 19/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "LittlePlotPieView.h"
#import "LittlePlotLineView.h"
#import "LittlePlotLabelView.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application

    
    NSView *_view = [[NSView alloc] initWithFrame:[_window frame]];
  
    NSRect _rect = [_view frame];
    _rect.origin.x =0;
    _rect.origin.y =0;
    // Split the window in half
    _rect.size.height = _rect.size.height /2;
    //create a view for the bottom half
    LittlePlotPieView *pie = [[LittlePlotPieView alloc] initWithFrame:_rect];
    //move the frame to occupy the other half of the screen
    _rect.origin.y = _rect.size.height;
    //create the view for the top half of the screen
    LittlePlotLineView *line = [[LittlePlotLineView alloc] initWithFrame:_rect];
    LittlePlotLineView *line2 = [[LittlePlotLineView alloc] initWithFrame:_rect];

    //Create a view for the labels in the bottom right corner
    LittlePlotLabelView *label = [[LittlePlotLabelView alloc] initWithFrame:
                                  NSMakeRect(([pie frame].size.width-100), 0, [pie frame].size.width, [pie frame].size.height)];
    //turn on the debug square for testing
    [label debugView:YES];
    //create 6 random numbers for the pie chart
    [pie setPieSegmentArray:[self randomGeneratedPercentages:6]];
    //add colours for the pie chart
    [pie setPieSegmentColourArray:[NSMutableArray arrayWithObjects:
                                  [NSColor redColor],
                                  [NSColor yellowColor],
                                  [NSColor greenColor],
                                  [NSColor blueColor],
                                  [NSColor orangeColor],
                                  [NSColor purpleColor], nil]];
    //create the labels, taking the colours from the pie view
    [label createPieLabels:[pie pieSegmentColourArray] 
                  lineText:[NSMutableArray arrayWithObjects:
                                                                  @"red",
                                                                  @"yellow",
                                                                  @"green",
                                                                  @"blue",
                                                                  @"orange",
                                                                  @"purple", nil]];
    //add the views as subviews to out main view.
    [_view addSubview:pie];
    [_view addSubview:line];
    [_view addSubview:label];
    [_view addSubview:line2];
    //set random points and colour for line graph
    [line setPoints:[self randomGeneratedPlots:100 highestValue:100]];
    [line setPlotColour:[NSColor redColor]];
    //[line setPoints:[self randomGeneratedPercentages:5]];
    [line setAutoHeight:YES];
    [line2 setPlotColour:[NSColor greenColor]];
    [line2 setPoints:[self randomGeneratedPercentages:100]];
    [line2 setAutoHeight:YES];
    //draw the graph
    //[line setFire:YES];
    [line drawPoints];
    [line2 drawPoints];
    [line debugView:YES];

    //set the windows view, to ours with it's subviews.
    [_window setContentView:_view];
    
    

}


/*
 
        HELPER FUNCTIONS
 
 */


- (NSMutableArray *)randomGeneratedPercentages:(NSInteger)numberOfEntries {
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (int i = 0; i < numberOfEntries; i++) {
        NSNumber *percent = [[NSNumber alloc] initWithInt:arc4random()%100];
        [array addObject:percent];
    }
    return array;

}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return true;
}

- (NSMutableArray *)randomGeneratedPlots:(NSInteger)numberOfEntries highestValue:(NSInteger)highestValue {
    NSMutableArray * array= [[NSMutableArray alloc]init];
    for (int i = 0; i < numberOfEntries; i++) {
        NSPoint point = {(i+i)*2,arc4random()%highestValue};
       // NSPoint point = {i,arc4random()%highestValue};
        [array addObject:[NSValue valueWithPoint:point]];
    }
    return array;
}


@end
