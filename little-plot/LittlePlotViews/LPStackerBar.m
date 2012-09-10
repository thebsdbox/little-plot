//
//  LPStackerBar.m
//  little-plot
//
//  Created by Daniel Finneran on 22/08/2012.
//
//

#import "LPStackerBar.h"

@interface LPStackerBar() {
    BOOL isHorizonal;
    NSArray *_barArray;
    NSArray *_colourArray;
}

@end

@implementation LPStackerBar

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)setDataSource:(NSArray *)dataArray {
    _barArray = dataArray;
}

- (void)setPieSegmentColourArray:(NSMutableArray *)pieSegmentColourArray {
    _colourArray = pieSegmentColourArray;
}

-(void)setHorizontal:(BOOL)horizontal {
    isHorizonal = horizontal;
}



-(void)calculateStacks {
    
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.

    
}

@end
