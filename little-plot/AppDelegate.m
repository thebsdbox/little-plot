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


@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application

    
    NSView *_view = [[NSView alloc] initWithFrame:[_window frame]];
  
    NSRect _rect = [_view frame];
    _rect.origin.x =0;
    _rect.origin.y =0;
    _rect.size.height = _rect.size.height /2 ;
    LittlePlotPieView *pie = [[LittlePlotPieView alloc] initWithFrame:_rect];
    _rect.origin.y = _rect.size.height;
    LittlePlotLineView *line = [[LittlePlotLineView alloc] initWithFrame:_rect];
    [pie setPieSegmentArray:[self randomGeneratedPercentages:6]];
   [pie setPieSegmentColourArray:[NSMutableArray arrayWithObjects:
                                  [NSColor redColor],
                                  [NSColor yellowColor],
                                  [NSColor greenColor],
                                  [NSColor blueColor],
                                  [NSColor orangeColor],
                                  [NSColor purpleColor], nil]];
    [_view addSubview:pie];
    [_view addSubview:line];
    //[line setPoints:[self randomGeneratedPlots:200 highestValue:200]];
    [line setPoints:[self randomGeneratedPercentages:100]];
   // [line drawFirePoints];
    [line drawPoints];
   // [line display];
    [line debugView:TRUE];
    [pie debugView:TRUE];
    [line setAutoresizingMask:2];
    [_window setContentView:_view];

}

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
