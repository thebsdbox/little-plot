//
//  LittlePlotViewController.m
//  little-plot
//
//  Created by Daniel Finneran on 19/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LittlePlotViewController.h"

// Includes for LittlePlot<X>View
// PieView
#import "LittlePlotPieView.h"
// LineView
#import "LittlePlotLineView.h"

@interface LittlePlotViewController () {
    LittlePlotLineView *_lineView;
    LittlePlotPieView *_pieView;
    NSArray *_plotArray;
}
@end

@implementation LittlePlotViewController


-(void)createPie {
}
-(void)createLine {
}
-(void)setPlotArray:(NSArray *)plotArray{
    _plotArray = plotArray;
}

-(NSArray *)plotArray {
    return _plotArray;
}


@end
