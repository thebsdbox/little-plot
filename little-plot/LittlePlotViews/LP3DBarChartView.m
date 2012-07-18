//
//  LP3DBarChartView.m
//  little-plot
//
//  Created by Daniel Finneran on 18/07/2012.
//
//

#import "LP3DBarChartView.h"

@interface LP3DBarChartView () {
    NSRect barRect;
    NSInteger barDepth; //Three dimensional depth
    NSArray *barColourArray; // An array of colours for the bar charts
    NSColor *barLineColour; // The colour of the bars drawn around the bar charts.
    NSInteger barLineThickness; //The thickness of the bars drawn around the bar charts.
    CGFloat barSpacing; // The spacing between the bars, that make up the chart.
    NSArray *barArray; // Array of barcharts to be drawn by drawRect
    NSArray *barchartArray; // Array of barcharts to be drawn by drawRect
    BOOL barAutoSpace; // Boolean that can be set to automatically space the bars of the chart.
}

@end

@implementation LP3DBarChartView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

// Setter Functions

- (void)setRect:(NSRect)chartRect{
    barRect = chartRect;
}

-(void)setDepth:(NSInteger)depth {
    barDepth = depth;
}

- (void)setColours:(NSArray*)colourArray{
    if ([colourArray count] > 3)
        NSLog(@"Only the first three colours are Required");
    barColourArray = colourArray;
}

- (void)setLineColour:(NSColor*)lineColour{
    barLineColour = lineColour;
    
}
- (void)setLineThickness:(NSInteger)lineThickness{
    barLineThickness = lineThickness;
}

-(void)setBarSpacing:(NSInteger)spacing {
    barSpacing = spacing;
}

- (void)setchartArray:(NSArray *)chartArray {
    barchartArray  = chartArray;
    [self generateBarCharts:barchartArray];
    [self display];
}

- (void)setAutoBarSpacing:(BOOL)autoSpacing {
    barAutoSpace = autoSpacing;
}

// Function to manage the drawing

- (void)drawRect:(NSRect)dirtyRect
{
    if (barchartArray) {
        [self generateBarCharts:barchartArray];
        for (NSArray *drawBarChart in barArray)
        {
            int counter =0;
            for (NSBezierPath *barChartBezier in drawBarChart)
            {
                [barChartBezier setLineWidth:barLineThickness];
                [[(NSColor *)[barColourArray objectAtIndex:0] colorWithAlphaComponent:(0.5/ counter)] set];
                [barChartBezier setLineWidth:barLineThickness];
                //[barChartBezier stroke];
                [barChartBezier fill];
                counter++;
            }
        }
    }
}


//Functions required to caluclate plot the three dimensions of the bar charts.


-(void)generateBarCharts:(NSArray *)array {
    //This function takes an two-dimensional NSArray of values, for the count of elements and their value
    /* Create the bounding information */
    
    // Iterate through all of the values passed in the array and find the maximum value
    NSInteger maxValue =0;
    for (NSNumber *element in array) {
        if (maxValue < [element intValue])
            maxValue = [element intValue];
    }
    
    //Create a rectangle that takes into account the addition space that is required for the three dimensional effect drawn around it (plus any extra space due to lines being drawn)
    NSRect alteredRect = NSMakeRect(self.bounds.origin.x + barLineThickness, self.bounds.origin.y + barLineThickness, self.bounds.size.width - barLineThickness, self.bounds.size.height - barLineThickness);
    
    //Calculate the units of height and width based on the maximum value in the array and the number of items
    CGFloat heightUnit = (alteredRect.size.height - barDepth) / maxValue;
    CGFloat widthUnit = (alteredRect.size.width - barDepth) / [array count];
    
    //Autospacing automatically adds half a width unit to be calculated and used as the spacing amount
    if (barAutoSpace)
        barSpacing = (widthUnit/2);
    
    //MutableArray and counter required for storing draw paths and counting elements
    NSMutableArray *mutableBarArray = [[NSMutableArray alloc] init];
    NSUInteger counter = 0;
    
    //Iterate through every element in the array
    for (NSNumber *element in array) {
        //Create the initial rect that is calculated to take into account line thickness and the height of the 3D depth to be drawn on top
        NSRect barChartRect = NSMakeRect((widthUnit * counter),barLineThickness, ( widthUnit + (widthUnit * counter) - barLineThickness), (heightUnit * [element intValue])-barDepth);
        //If barspacing was specified or Auto calculated.. modify each rect to compensate
        if (barSpacing !=0) {
            barChartRect.origin.x=barChartRect.origin.x + (barSpacing/2);
            barChartRect.size.width=barChartRect.size.width - (barSpacing/2);
        }
        //Add the calculated BezierPaths to the array
        [mutableBarArray addObject:[NSArray arrayWithObjects:
                                    [self generateChartFront:barChartRect],
                                    [self generateChartRoof:barChartRect],
                                    [self generateChartDepth:barChartRect], nil]];
        counter++;
    }
    //Return the Array (not sure this should convert)
    barArray = mutableBarArray;
}

- (NSBezierPath *)generateChartFront:(NSRect)chartRect {
    //Draw Front first, Roof and depth added afterwards.
    /*
     --------------
     |A          B|
     |            |
     |            |
     |            |
     |            |
     |D          C|
     --------------
     */
    //// Front Drawing
    NSBezierPath* frontPath = [NSBezierPath bezierPath];
    [frontPath moveToPoint: NSMakePoint(chartRect.origin.x, chartRect.origin.y)]; //Move to D
    [frontPath lineToPoint: NSMakePoint(chartRect.origin.x, chartRect.size.height)]; // Draw to A
    [frontPath lineToPoint: NSMakePoint(chartRect.size.width, chartRect.size.height)];
    [frontPath lineToPoint: NSMakePoint(chartRect.size.width, chartRect.origin.y)];
    [frontPath lineToPoint: NSMakePoint(chartRect.origin.x, chartRect.origin.y)];
    [frontPath closePath];
    return frontPath;
    
}
- (NSBezierPath *)generateChartRoof:(NSRect)chartRect {
    /*
          --------------
         /A           B/
        /             /
       /             /
      /             /
     /D           C/
     --------------
     */
    //// Roof Drawing
    NSBezierPath* roofPath = [NSBezierPath bezierPath];
    [roofPath moveToPoint: NSMakePoint(chartRect.origin.x, chartRect.size.height)];  // Move to D
    [roofPath lineToPoint: NSMakePoint(chartRect.size.width, chartRect.size.height+barDepth)]; // Draw to A
    [roofPath lineToPoint: NSMakePoint((chartRect.size.width*2)-chartRect.origin.x,chartRect.size.height+barDepth)]; // Draw from A (last point) to B
    [roofPath lineToPoint: NSMakePoint(chartRect.size.width, chartRect.size.height)]; // Draw from B (last point) to C
    [roofPath lineToPoint: NSMakePoint(chartRect.origin.x, chartRect.size.height)];   // Draw from (last point) C to D
    [roofPath closePath]; // Redundant thanks to the Line above (Draw from D to A)
    return roofPath;
}
- (NSBezierPath *)generateChartDepth:(NSRect)chartRect {
             /*
            /|
           /B|
          /  |
         /   |
        /    |
       /     |
      /A     |
     |       |
     |     C/
     |     /
     |    /
     |   /
     |  /
     |D/
     |/
     */
    //// Depth Drawing
    NSBezierPath* depthPath = [NSBezierPath bezierPath];
    [depthPath moveToPoint: NSMakePoint(chartRect.size.width, chartRect.origin.y)]; //Move to D
    [depthPath lineToPoint: NSMakePoint(chartRect.size.width, chartRect.size.height)]; //Draw to A
    [depthPath lineToPoint: NSMakePoint((chartRect.size.width*2)-chartRect.origin.x, chartRect.size.height+barDepth)];
    [depthPath lineToPoint: NSMakePoint((chartRect.size.width*2)-chartRect.origin.x, barDepth)];
    [depthPath lineToPoint: NSMakePoint(chartRect.size.width, chartRect.origin.y)];
    [depthPath closePath];
    return depthPath;
}






@end
