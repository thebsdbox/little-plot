//  LittlePlotLineView.m
//  little-plot


#import "LittlePlotLineView.h"

@interface LittlePlotLineView () {
    
    NSMutableArray *_graphPlots;
    NSMutableArray *_firePointArray;
    NSBezierPath *_path;
    BOOL fire;
}

@end

@implementation LittlePlotLineView

-(BOOL)setPoints:(NSMutableArray *)pointsArray {
    _graphPlots = [[NSMutableArray arrayWithCapacity:200]init];
    for (int i = 0; i < 200; i++) {
        NSPoint point = {(i+i)*2,arc4random()%100};
        [_graphPlots addObject:[NSValue valueWithPoint:point]];
    }
    return true;
}

-(BOOL)isFlipped {
    return false;
}

-(void)drawRect:(NSRect)dirtyRect {
    
    
    [_path stroke];
    for (NSBezierPath* paths in _firePointArray) {
        NSPoint point = [paths currentPoint];
        [[NSColor blackColor] set];
        if ([paths currentPoint].y > 50) {
            [[NSColor orangeColor] set];
            NSLog(@"%@", NSStringFromPoint([paths currentPoint]));
        } 
        
        if ([paths currentPoint].y > 75) {
            [[NSColor redColor] set];
        }
        [paths stroke];
    }
    
}

-(void)drawPoints {
    if(_graphPlots) {
        _path = [NSBezierPath bezierPath];
        [_path setLineWidth:2];
        for (int i = 0; i < 198; i++) {
            NSPoint point = [[_graphPlots objectAtIndex:i] pointValue];
            [_path moveToPoint:point];
            NSPoint nextPoint = [[_graphPlots objectAtIndex:i+1] pointValue];
            [_path lineToPoint:nextPoint];
            
        }
    }
}

-(void)drawFirePoints {
    if(_graphPlots) {
        _firePointArray = [[NSMutableArray alloc] init];
        //_path = [NSBezierPath bezierPath];
        for (int i = 0; i < 198; i++) {
            NSBezierPath *path = [NSBezierPath bezierPath];
            NSPoint point = [[_graphPlots objectAtIndex:i] pointValue];
            [path moveToPoint:point];
            NSPoint nextPoint = [[_graphPlots objectAtIndex:i+1] pointValue];
            [path lineToPoint:nextPoint];
            
            [path setLineWidth:2];
            [_firePointArray addObject:path];
        }
    } 
}

@end