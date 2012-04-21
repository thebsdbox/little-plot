//  LittlePlotLineView.m
//  little-plot


#import "LittlePlotLineView.h"

@interface LittlePlotLineView () {
    
    NSMutableArray *_graphPlots;
    NSMutableArray *_firePointArray;
    NSBezierPath *_path;
    BOOL fire;
    BOOL _enableDebug;
}

@end

@implementation LittlePlotLineView

-(BOOL)setPoints:(NSMutableArray *)pointsArray {
    _graphPlots = pointsArray;
    return true;
}

-(BOOL)isFlipped {
    return false;
}

- (void)debugView:(BOOL)enableDebug {
    _enableDebug = enableDebug;
}

-(void)drawRect:(NSRect)dirtyRect {
    
    if (_enableDebug) {
        [[NSColor redColor] set];        // NSRectFill([self bounds]);
        NSRect viewRect = [self bounds];
        NSBezierPath *rectPath = [NSBezierPath bezierPathWithRect:viewRect];
        [rectPath stroke];
    }
    [[NSColor blackColor] set];
    [_path stroke];
    for (NSBezierPath* paths in _firePointArray) {
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

-(float)calculateSpacing {
    if (_graphPlots) {
        //float a = [self bounds].size.width / [_graphPlots count];
       //return [_graphPlots count] / self.bounds.size.width;
        return self.bounds.size.width / [_graphPlots count];
       // return [NSNumber numberWithFloat:[self.bounds.size.width / [_graphPlots count]]];
        
    }
    return 0;
    
}

-(void)drawPoints {
    if(_graphPlots) {
        if ([[_graphPlots objectAtIndex:0] isKindOfClass:[NSValue class]]) {
           
            NSLog(@"%f", [self calculateSpacing]);
            _path = [NSBezierPath bezierPath];
            [_path setLineWidth:0.5];
            for (int i = 1; i < ([_graphPlots count] -1); i++) {
                NSPoint point = [[_graphPlots objectAtIndex:i] pointValue];
                //point.x = [self calculateSpacing]+i;
                NSLog(@"%@", NSStringFromPoint(point));
                [_path moveToPoint:point];
                NSPoint nextPoint = [[_graphPlots objectAtIndex:i+1] pointValue];
                [_path lineToPoint:nextPoint];
            }
        }
        if ([[_graphPlots objectAtIndex:0] isKindOfClass:[NSNumber class]]) {
            _path = [NSBezierPath bezierPath];
            [_path setLineWidth:0.5];
            for (int i = 1; i < ([_graphPlots count] -1); i++) {
                NSPoint point = NSMakePoint( i*[self calculateSpacing], [[_graphPlots objectAtIndex:i] intValue]);
                [_path moveToPoint:point];
                //NSPoint nextPoint = [[_graphPlots objectAtIndex:i+1] pointValue];
                NSPoint nextPoint = NSMakePoint((i+1) * [self calculateSpacing], [[_graphPlots objectAtIndex:i+1] intValue]);
                NSLog(@"%@ to %@", NSStringFromPoint(point),NSStringFromPoint(nextPoint) );

                [_path lineToPoint:nextPoint];
        
            }
        }
    }
}

-(void)drawFirePoints {
    if(_graphPlots) {
        _firePointArray = [[NSMutableArray alloc] init];
        //_path = [NSBezierPath bezierPath];
        for (int i = 0; i < ([_graphPlots count] -1); i++) {
            NSBezierPath *path = [NSBezierPath bezierPath];
            NSPoint point = [[_graphPlots objectAtIndex:i] pointValue];
            [path moveToPoint:point];
            NSPoint nextPoint = [[_graphPlots objectAtIndex:i+1] pointValue];
            [path lineToPoint:nextPoint];
            
            [path setLineWidth:0.5];
            [_firePointArray addObject:path];
        }
    } 
}

@end