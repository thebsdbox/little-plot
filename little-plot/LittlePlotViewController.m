//
//  LittlePlotViewController.m
//  little-plot

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
    _pieView = [[LittlePlotPieView alloc] init];
    self.view = _pieView;
}

-(void)createLine {
    _lineView = [[LittlePlotLineView alloc] init];
    self.view = _lineView;
}



-(void)setPlotArray:(NSArray *)plotArray{
    _plotArray = plotArray;
}

-(NSArray *)plotArray {
    return _plotArray;
}



@end
