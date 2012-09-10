//
//  LPUtils.h
//  little-plot
//
//  Created by dan on 10/09/2012.
//
//

//This class is used to shrink repeated code and create a central place for utility functions.

#import <Foundation/Foundation.h>

@interface LPUtils : NSObject

+ (NSColor *)randomColor;
+ (NSColor *)colorForIndex:(unsigned)index colourArray:(NSMutableArray *)_colourArray;

@end
