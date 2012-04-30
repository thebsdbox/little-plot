//  LittlePlotLineView.m
//  little-plot


#import "LittlePlotLineView.h"

// Additional internal variables

@interface LittlePlotLineView () {
    
    NSMutableArray *_graphPlots;
    NSMutableArray *_firePointArray;
    NSBezierPath *_path;
    BOOL _fire;
    BOOL _enableDebug;
    NSColor *_plotColour;
}

@end

// Main Implementation of methods/Selectors.

@implementation LittlePlotLineView

-(BOOL)isFlipped {
    return false;
}
-(void)setPoints:(NSMutableArray *)pointsArray {
    _graphPlots = pointsArray;
}

-(void)setFire:(BOOL)fire {
    _fire = fire;
}

-(void)setPlotColour:(NSColor *)plotColour {
    _plotColour = plotColour;
}



- (void)debugView:(BOOL)enableDebug {
    _enableDebug = enableDebug;
}

-(void)drawRect:(NSRect)dirtyRect {
    
    if (_enableDebug) {
        [[NSColor redColor] set];
        NSRect viewRect = [self bounds];
        NSBezierPath *rectPath = [NSBezierPath bezierPathWithRect:viewRect];
        [rectPath stroke];
    }
    if (_plotColour) {
        [_plotColour set];
    } else {
        [[NSColor blackColor] set];
    }
    
    
    if (_firePointArray) {
        for (NSBezierPath* paths in _firePointArray) {
            [[NSColor blackColor] set];
            if ([paths currentPoint].y > 50) {
                [[NSColor orangeColor] set];
            }         
            if ([paths currentPoint].y > 75) {
                [[NSColor redColor] set];
            }
            [paths stroke];
        }
    } else {
        [_path stroke];
    }
    
}

-(float)calculateSpacing {
    // average the width of the NSView with the amount of plots to make, to work out the space between each plot.
    // _graphPlots minus one as an array of 10 items returns 11 (due to starting at 0, not 1)
    if (_graphPlots) {
        return self.bounds.size.width / ([_graphPlots count] -1);        
    }
    return 0;
    
}

-(void)drawPoints {
    if(_graphPlots) {
        if (!_fire)
            _path = [NSBezierPath bezierPath];
        else 
            _firePointArray = [[NSMutableArray alloc] init];
        [_path setLineWidth:0.5];
        //Determine if X,Y or just Y
        if ([[_graphPlots objectAtIndex:0] isKindOfClass:[NSNumber class]]) {
            for (int i = 0; i < ([_graphPlots count] -1); i++) {
                // Allocate the beginning point and it's ending point
                if (_fire) 
                    _path = [NSBezierPath bezierPath];
                [_path moveToPoint:NSMakePoint( i*[self calculateSpacing], [[_graphPlots objectAtIndex:i] intValue])];
                [_path lineToPoint:NSMakePoint((i+1) * [self calculateSpacing], [[_graphPlots objectAtIndex:i+1] intValue])];
                if (_fire)
                    [_firePointArray addObject:_path];  
            }
            return;
        }
        if ([[_graphPlots objectAtIndex:0] isKindOfClass:[NSValue class]]) {
            for (int i = 0; i < ([_graphPlots count] -1); i++) {
                // Allocate the beginning point and it's ending point
                if (_fire) 
                    _path = [NSBezierPath bezierPath];
                [_path moveToPoint:[[_graphPlots objectAtIndex:i] pointValue]];
                [_path lineToPoint:[[_graphPlots objectAtIndex:i+1] pointValue]];
                if (_fire)
                    [_firePointArray addObject:_path];  
            }
        }

    }
}


@end