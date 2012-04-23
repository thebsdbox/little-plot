//  LittlePlotLineView.m
//  little-plot


#import "LittlePlotLineView.h"

@interface LittlePlotLineView () {
    
    NSMutableArray *_graphPlots;
    NSMutableArray *_firePointArray;
    NSBezierPath *_path;
    BOOL fire;
    BOOL _enableDebug;
    NSColor *_plotColour;
}

@end

@implementation LittlePlotLineView

-(BOOL)setPoints:(NSMutableArray *)pointsArray {
    _graphPlots = pointsArray;
    return true;
}

-(void)setPlotColour:(NSColor *)plotColour {
    _plotColour = plotColour;
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
    if (_plotColour) {
        [_plotColour set];
    } else {
        [[NSColor blackColor] set];
    }
    NSLog(@"%@", _path);
    [_path stroke];
    
    if (_firePointArray) {
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
    
}

-(float)calculateSpacing {
    // average the width of the NSView with the amount of plots to make, to work out the space between each plot.
    if (_graphPlots) {
        return self.bounds.size.width / [_graphPlots count];        
    }
    return 0;
    
}

-(void)drawPoints {
    if(_graphPlots) {
        _path = [NSBezierPath bezierPath];
        [_path setLineWidth:0.5];
        NSLog(@"%@",[_graphPlots objectAtIndex:0]);
        //Determine if X,Y or just Y
        if ([[_graphPlots objectAtIndex:0] isKindOfClass:[NSNumber class]]) {
            for (int i = 1; i < ([_graphPlots count] -1); i++) {
                NSPoint point = NSMakePoint( i*[self calculateSpacing], [[_graphPlots objectAtIndex:i] intValue]);
                [_path moveToPoint:point];
                NSPoint nextPoint = NSMakePoint((i+1) * [self calculateSpacing], [[_graphPlots objectAtIndex:i+1] intValue]);
                [_path lineToPoint:nextPoint];
                
            }
            return;
        }
        if ([[_graphPlots objectAtIndex:0] isKindOfClass:[NSValue class]]) {
            for (int i = 1; i < ([_graphPlots count] -1); i++) {
                NSPoint point = [[_graphPlots objectAtIndex:i] pointValue];
                [_path moveToPoint:point];
                NSPoint nextPoint = [[_graphPlots objectAtIndex:i+1] pointValue];
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