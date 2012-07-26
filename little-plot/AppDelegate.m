//
//  AppDelegate.m
//  little-plot
//
//  Created by Daniel Finneran on 19/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "LittlePlotLabelView.h"
#import "LittlePlotTableView.h"
#import "LittlePlotBarView.h"
// Name Space correct
#import "LPPieChartView.h"
#import "LPLineChartView.h"
// 3D
#import "LP3DBarChartView.h"
#import "LP3DPieChartView.h"

@interface AppDelegate (){
    NSTimer *timer;
    LPPieChartView *timedPieChart;
    LPLineChartView *lineView;
    NSMutableArray *pointsArray;
}

@end

@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application

    
    NSView *_view = [[NSView alloc] initWithFrame:[_window frame]];
  
    
    NSRect _rect = [_view frame];
    _rect.origin.x =0;
    _rect.origin.y =0;
    
    _rect.size.height = _rect.size.height -22;
    // Split the window in half
    _rect.size.height = _rect.size.height /3;
    _rect.size.width = _rect.size.width /2;
    //create a view for the bottom half
    //move the frame to occupy the other half of the screen
    _rect.origin.y = _rect.size.height;
    //_rect.origin.x = 20;
    //create the view for the top half of the screen
      _rect.origin.y = (_rect.size.height * 2);
    LittlePlotTableView *tableView = [[LittlePlotTableView alloc] initWithFrame:_rect];
    [tableView setTabelArray:[[NSMutableArray alloc] initWithObjects:[NSArray arrayWithObjects:@"1" , @"2", @"3", @"test",nil],
                                                                    [NSArray arrayWithObjects:@"4" , @"5", @"6", @"test2",nil],
                                                                    [NSArray arrayWithObjects:@"7" , @"8", @"9", @"test3",nil],
                                                                    nil]];
    
    [_view addSubview:tableView];
    _rect.origin.x = _rect.size.width;
    LP3DBarChartView *barChartView = [[LP3DBarChartView alloc] initWithFrame:_rect];
    [barChartView setColours:[NSArray arrayWithObjects:[NSColor colorWithDeviceRed:1 green:0 blue:0 alpha:1],
                              [NSColor colorWithDeviceRed:0.6 green:0 blue:0 alpha:1],
                              [NSColor colorWithDeviceRed:0.3 green:0 blue:0 alpha:1], nil]];
    [barChartView setAutoBarSpacing:TRUE];
    [barChartView setDepth:30];
    [_view addSubview:barChartView];
    [barChartView setchartArray:[self randomGeneratedPercentages:5]];
    /*
    LittlePlotBarView *barView = [[LittlePlotBarView alloc] initWithFrame:_rect];
    [_view addSubview:barView];
    [barView debugView:YES];
     */
     [tableView debugView:YES];
    [tableView autoSizeCell:YES];
    //[tableView setCellRect:NSMakeRect(0, 0, 100, 20)];
    //Create a view for the labels in the bottom right corner
//    LittlePlotLabelView *label = [[LittlePlotLabelView alloc] initWithFrame:
     //                             NSMakeRect(([pie frame].size.width-100), 0, [pie frame].size.width, [pie frame].size.height)];
    //turn on the debug square for testing
    //[label debugView:YES];
  //  [label setAutoresizingMask:NSViewHeightSizable];
    //create 6 random numbers for the pie chart
 //   [pie setPieSegmentArray:[self randomGeneratedPercentages:6]];
    //add colours for the pie chart
   // [pie setPieSegmentColourArray:[NSMutableArray arrayWithObjects:
     //                             [NSColor redColor],
       //                           [NSColor yellowColor],
         //                         [NSColor greenColor],
           //                       [NSColor blueColor],
             //                     [NSColor orangeColor],
               //                   [NSColor purpleColor],
                 //                  [NSColor blackColor], nil]];
    //create the labels, taking the colours from the pie view
  //  [label createPieLabels:[pie pieSegmentColourArray]
    //              lineText:[NSMutableArray arrayWithObjects:
      //                                                            @"red",
        //                                                          @"yellow",
          //                                                        @"green",
            //                                                      @"blue",
              //                                                    @"orange",
                //                                                  @"purple",
                  //                                                @"black",
                    //                                                nil]];
    //add the views as subviews to out main view.
    //[_view addSubview:pie];
/*
    LP3DPieChartView *pieChart = [[LP3DPieChartView alloc] initWithFrame:[_window frame]];
    [pieChart setDebugView:YES];
    [_window setBackgroundColor:[NSColor blackColor]];
    [pieChart setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    [pieChart setPieSegmentArray:[self randomGeneratedPercentages:6]];
    [_window setContentView:pieChart];
   
    timedPieChart = [[LPPieChartView alloc] initWithFrame:[_window frame]];
    timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(drawGraph) userInfo:nil repeats:YES];
    [timedPieChart setPieSegmentColourArray:[NSMutableArray arrayWithObjects:
                                            [NSColor redColor],
                                            [NSColor yellowColor],
                                            [NSColor greenColor],
                                            [NSColor blueColor],
                                            [NSColor orangeColor],
                                            [NSColor purpleColor],
                                             nil]];
    [_window setContentView:timedPieChart];
 
*/
    pointsArray = [[NSMutableArray alloc]initWithCapacity:100];
    lineView = [[LPLineChartView alloc]initWithFrame:[_window frame]];
    [lineView debugView:YES];
    [lineView setAutoHeight:YES];
    [_window setContentView:lineView];
    [lineView setPlotColour:[NSColor blackColor]];

    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(drawGraph) userInfo:nil repeats:YES];
}



/*
 
        HELPER FUNCTIONS
 
 */


-(void)drawGraph {
    //[timedPieChart setPieSegmentArray:[self randomGeneratedPercentages:6]];
//    [pointsArray insertObject:[[NSNumber alloc] initWithInt:arc4random()%100]  atIndex:[pointsArray count]];
    [pointsArray addObject:[[NSNumber alloc] initWithInt:arc4random()%100]];
    if (!([pointsArray count] < 100)) {
        [lineView setPoints:[pointsArray subarrayWithRange:NSMakeRange([pointsArray count] - 99,99)]];
    } else
    {
        [lineView setPoints:pointsArray];
    }
    [lineView drawPoints];
    [lineView display];
}

- (NSMutableArray *)randomGeneratedPercentages:(NSInteger)numberOfEntries {
    NSMutableArray * array = [[NSMutableArray alloc]initWithCapacity:100];
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
        [array insertObject:[NSValue valueWithPoint:point] atIndex:0];
    }
    return array;
}


@end
