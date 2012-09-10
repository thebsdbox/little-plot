//
//  LPPieChartView.m
//  little-plot
//
//  Created by Daniel Finneran on 19/07/2012.
//
//

#import "LPPieChartView.h"
#import "LPUtils.h"

@interface LPPieChartView () {
    
        NSMutableArray *_segmentPathsArray;
        NSBezierPath *inner;
        NSBezierPath *outer;
        BOOL _enableDebug;
        
    }

@end

@implementation LPPieChartView

//Padding around all the piechart
#define PADDINGAROUNDGRAPH 22.0

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)setPieSegmentArray:(NSArray *)pieSegmentArray {
    _pieSegmentArray = pieSegmentArray;
   // [self generateDrawingInformation];
    [self setNeedsDisplayInRect:[self visibleRect]];
}

- (void)setPieSegmentColourArray:(NSMutableArray *)pieSegmentColourArray {
    _colourArray = pieSegmentColourArray;
}

- (void)setDebugView:(BOOL)enableDebug {
    _enableDebug = enableDebug;
}

-(NSArray *)pieSegmentColourArray {
    return _colourArray;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    if (_pieSegmentArray)
        [self generateDrawingInformation];
    if (_enableDebug) {
        [[NSColor redColor] set];
        [[NSBezierPath bezierPathWithRect:[self bounds]] stroke];
    }
    
    if (_colourArray == nil)
        _colourArray = [[NSMutableArray alloc] init];
    
    if ([_colourArray count] < [_pieSegmentArray count]) {
        while ([_colourArray count] <= [_pieSegmentArray count]) {
            //if there are no colours or empty spaces add some random colours
            [_colourArray addObject:[LPUtils randomColor]];
        }
    }

    for( unsigned count = 0; count < [_segmentPathsArray count]; count++ )
    {
        NSBezierPath *eachPath = [_segmentPathsArray objectAtIndex:count];
        // fill the path with the drawing color for this index
        [(NSColor *)[_colourArray objectAtIndex:count] set];
        [eachPath fill];
    }
}

- (void)generateDrawingInformation
{
    //Function to generate the pie slices
    NSArray *cachedSegmentValuesArray = _pieSegmentArray;
    
    // Get rid of any existing Paths Array
	if( _segmentPathsArray )
		_segmentPathsArray = nil;
	
	// If there aren't any values to display, we can exit now
	if( [cachedSegmentValuesArray count] < 1 )
		return;
    
	// Get the sum of the amounts and exit if it is zero
	float sumOfAmounts = 0;
	for( NSNumber *eachAmountToSum in cachedSegmentValuesArray )
		sumOfAmounts += [eachAmountToSum floatValue];
    
	if( sumOfAmounts == 0 )
		return;
    
	_segmentPathsArray = [[NSMutableArray alloc] initWithCapacity:[cachedSegmentValuesArray count]];
        
	NSRect viewBounds = [self bounds];
	NSRect graphRect = NSInsetRect(viewBounds, PADDINGAROUNDGRAPH, PADDINGAROUNDGRAPH);
    
	// Make the graphRect square and centred
	if( graphRect.size.width > graphRect.size.height )
	{
		double sizeDifference = graphRect.size.width - graphRect.size.height;
		graphRect.size.width = graphRect.size.height;
		graphRect.origin.x += (sizeDifference / 2);
	}
    
	if( graphRect.size.height > graphRect.size.width )
	{
		double sizeDifference = graphRect.size.height - graphRect.size.width;
		graphRect.size.height = graphRect.size.width;
		graphRect.origin.y += (sizeDifference / 2);
	}
    
	// Calculate how big a 'unit' is
	float unitSize = (360.0 / sumOfAmounts);
    
	if( unitSize > 360 )
		unitSize = 360;
    
	float radius = graphRect.size.width / 2;
    
	NSPoint midPoint = NSMakePoint( NSMidX(graphRect), NSMidY(graphRect) );
    
	// cycle through the segmentValues and create the bezier paths
	float currentDegree = 0;
	unsigned currentIndex;
    for( currentIndex = 0; currentIndex < [cachedSegmentValuesArray count]; currentIndex++ )
	{
		NSNumber *eachValue = [cachedSegmentValuesArray objectAtIndex:currentIndex];
        
		float startDegree = currentDegree;
		currentDegree += ([eachValue floatValue] * unitSize);
		float endDegree = currentDegree;
		NSBezierPath *eachSegmentPath = [NSBezierPath bezierPath];
        
		[eachSegmentPath moveToPoint:midPoint];
        
        [eachSegmentPath appendBezierPathWithArcWithCenter:midPoint radius:radius/2 startAngle:startDegree endAngle:endDegree];
        [eachSegmentPath appendBezierPathWithArcWithCenter:midPoint radius:radius startAngle:endDegree endAngle:startDegree clockwise:YES];
        //Close for completeness (also if drawing lines around the slices.
        [eachSegmentPath closePath];
        
		[_segmentPathsArray addObject:eachSegmentPath];
	}
}


@end
