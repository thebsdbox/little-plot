//  LittlePlotLineView.m
//  little-plot


#import "LittlePlotLineView.h"

@interface LittlePlotLineView () {
    NSMutableArray *_graphPlots;
}

@end


@implementation LittlePlotLineView 

-(BOOL)setPoints:(NSMutableArray *)pointsArray {
    _graphPlots = [[NSMutableArray arrayWithCapacity:100]init];
    for (int i = 0; i < 200; i++) {
        NSPoint point = {i+i,rand()%150};
        [_graphPlots addObject:[NSValue valueWithPoint:point]];
    }
    return true;
}

-(BOOL)isFlipped {
    return true;
}

-(void)drawRect:(NSRect)dirtyRect {
    
    if(_graphPlots) {
        NSBezierPath *path = [NSBezierPath bezierPath];
        [path setLineWidth:0.5];
        for (int i = 0; i < 198; i++) {
            NSPoint point = [[_graphPlots objectAtIndex:i] pointValue];
            [path moveToPoint:point];
            NSPoint nextPoint = [[_graphPlots objectAtIndex:i+1] pointValue];
            [path lineToPoint:nextPoint];
            
        }
        [path stroke];
    }
}


@end
