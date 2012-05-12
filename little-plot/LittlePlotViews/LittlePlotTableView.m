//
//  LittlePlotTableView.m
//  little-plot
//
//  Created by Daniel Finneran on 02/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LittlePlotTableView.h"

@interface LittlePlotTableView () {
    BOOL _enableDebug;
    NSRect _cellRect;
    NSMutableArray *_tableArray;
    NSNumber *_rows;
    NSNumber *_columns;
}

@end

@implementation LittlePlotTableView

- (void)debugView:(BOOL)enableDebug {
    _enableDebug = enableDebug;
}

-(void)calculateTableDimensions {
    //work out number of rows and columns
    if (!_columns)
        _columns = [NSNumber numberWithInteger:[[_tableArray objectAtIndex:0] count]];
    if (!_rows)
        _rows = [NSNumber numberWithInteger:[_tableArray count]];
}

-(void)autoSizeCell:(BOOL)autoSize {
    if (_tableArray) {
        [self calculateTableDimensions];
        _cellRect = NSMakeRect(0, 0, ([self bounds].size.width / [_columns floatValue]), ([self bounds].size.height / [_rows floatValue]));
    }
}

-(BOOL)isFlipped {
    return true;
}

-(void)setCellRect:(NSRect)cellRect {
    _cellRect = cellRect;
}

-(void)setTabelArray:(NSMutableArray *)tableArray {
    _tableArray = tableArray;
}

-(void)drawRect:(NSRect)dirtyRect {
    if (_enableDebug) {
        [[NSColor redColor] set];
        NSRect viewRect = [self bounds];
        NSBezierPath *rectPath = [NSBezierPath bezierPathWithRect:viewRect];
        [rectPath stroke];
    }

     [self calculateTableDimensions];

    if (_tableArray) {
        [[NSColor blackColor] set];
        NSRect _drawCellRect = _cellRect;
        for (NSInteger _row = 0; _row < [_rows integerValue]; _row++) {
            for (NSInteger _column = 0; _column < [_columns integerValue]; _column++) {
                [[[_tableArray objectAtIndex:_row] objectAtIndex:_column] drawInRect:_drawCellRect withAttributes:nil];
                NSBezierPath *cellPath = [NSBezierPath bezierPathWithRect:_drawCellRect];
                [cellPath setLineWidth:0];
                NSAffineTransform *transform = [NSAffineTransform transform];
                // build the bezierPath
                [transform translateXBy: 0.5 yBy: 0.5];
                [cellPath transformUsingAffineTransform:transform];
                [cellPath stroke];
                _drawCellRect.origin.x = (_drawCellRect.size.width * (_column +1));
            }
            //Reset position
            _drawCellRect.origin.x = 0;
            //Increment Row/Cell
            _drawCellRect.origin.y = (_drawCellRect.size.height * (_row +1));
        }
        
    }
    
}

@end
