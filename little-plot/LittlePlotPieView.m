//
//  LittlePlotPieView.m
//  little-plot
//
//  Created by Daniel Finneran on 19/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LittlePlotPieView.h"

@implementation LittlePlotPieView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    {
        //[[NSColor whiteColor] set]; // white background
        //NSRectFill([self bounds]);
        
       // NSArray *pathsArray = [self segmentPathsArray];
        NSArray *pathsArray = _segmentPathsArray;
        
        // count;
        for( unsigned count = 0; count < [pathsArray count]; count++ )
        {
            NSBezierPath *eachPath = [pathsArray objectAtIndex:count];
            
            // fill the path with the drawing color for this index
            [[self colorForIndex:count] set];
            [eachPath fill];
            
            // draw a black border around it
            [[NSColor blackColor] set];
            [eachPath setLineWidth:0.1f];
            [eachPath stroke];
        }
    }
}

- (BOOL)isFlipped
{
    // Ensures that 0,0 is top left corner !
	return YES;
}

- (NSColor *)randomColor
{
	float red = (arc4random()%1000)/1000.0;
	float green = (arc4random()%1000)/1000.0;
	float blue = (arc4random()%1000)/1000.0;
	float alpha = (arc4random()%1000)/1000.0;
    //NSLog(@"Random Values %f, %f, %f, %f", red, green, blue, alpha);
	return [NSColor colorWithCalibratedRed:red green:green blue:blue alpha:alpha];
}

- (NSColor *)colorForIndex:(unsigned)index
{
	//static 
    NSMutableArray *colorsArray = nil;
    
	if( colorsArray == nil )
	{
		colorsArray = [[NSMutableArray alloc] init];
	}
    
	if( index >= [colorsArray count] )
	{
		NSUInteger currentNum = 0;
		for(currentNum = [colorsArray count]; currentNum  <= index; currentNum++ )
		{
			[colorsArray addObject:[self randomColor]];
		}
	}
    
	return [colorsArray objectAtIndex:index];
}

- (void)setSegmentValuesArray:(NSArray *)newArray
{
	_pieSegmentArray = [newArray copy];    
	[self generateDrawingInformation];
	[self setNeedsDisplayInRect:[self visibleRect]];
}

- (void)setPieSegmentArray:(NSArray *)pieSegmentArray {
    _pieSegmentArray = pieSegmentArray;
    [self generateDrawingInformation];
    [self setNeedsDisplayInRect:[self visibleRect]];
}


- (void)generateDrawingInformation
{
	// Keep a pointer to the segmentValuesArray
	
    //NSArray *cachedSegmentValuesArray = [self segmentValuesArray];
	
    NSArray *cachedSegmentValuesArray = _pieSegmentArray;
    
    // Get rid of any existing Paths Array
	if( _segmentPathsArray )
	{
		_segmentPathsArray = nil;
	}
    
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
    
#define PADDINGAROUNDGRAPH 20.0
    
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
        
		[eachSegmentPath appendBezierPathWithArcWithCenter:midPoint radius:radius startAngle:startDegree endAngle:endDegree];
        //[eachSegmentPath appendBezierPathWithArcFromPoint:startDegree toPoint:endDegree radius:radius];
		//[eachSegmentPath closePath]; // close path also handles the lines from the midPoint to the start and end of the arc
		[eachSegmentPath setLineWidth:2.0];
        
		[_segmentPathsArray addObject:eachSegmentPath];
	}
}


@end




// old Getter methods


/*
 
 - (NSArray *)segmentPathsArray
 {
 return _segmentPathsArray;
 }
 
 - (NSArray *)segmentValuesArray
 {
 return _segmentValuesArray;
 }
 
 - (NSArray *)segmentNamesArray {
 return _segmentNamesArray;
 }
 
 // Old Setter method
 
 - (void)setSegmentNamesArray:(NSArray *)newArray
 {
 [self willChangeValueForKey:@"segmentNamesArray"];
 _pieSegmentArray = newArray;
 [self didChangeValueForKey:@"segmentNamesArray"];
 
 [self generateDrawingInformation];
 [self setNeedsDisplayInRect:[self visibleRect]];
 }
 
 - (void)setSegmentValuesArray:(NSArray *)newArray
 {
 [self willChangeValueForKey:@"segmentValuesArray"];
 _pieSegmentArray = [newArray copy];
 [self didChangeValueForKey:@"segmentValuesArray"];
 
 [self generateDrawingInformation];
 [self setNeedsDisplayInRect:[self visibleRect]];
 }
 
 */


