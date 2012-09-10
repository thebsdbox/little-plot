//
//  LPUtils.m
//  little-plot
//
//  Created by dan on 10/09/2012.
//
//

#import "LPUtils.h"

@implementation LPUtils

+ (NSColor *)randomColor
{
	float red = (arc4random()%1000)/1000.0;
	float green = (arc4random()%1000)/1000.0;
	float blue = (arc4random()%1000)/1000.0;
	return [NSColor colorWithCalibratedRed:red green:green blue:blue alpha:1];
}

+ (NSColor *)colorForIndex:(unsigned)index colourArray:(NSMutableArray *)_colourArray
{
	if( _colourArray == nil )
		_colourArray = [[NSMutableArray alloc] init];
	
	if( index >= [_colourArray count] )
	{
		NSUInteger currentNum = 0;
		for(currentNum = [_colourArray count]; currentNum  <= index; currentNum++ )
		{
			[_colourArray addObject:[LPUtils randomColor]];
		}
	}
	return [_colourArray objectAtIndex:index];
}

@end
