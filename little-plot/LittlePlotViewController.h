//
//  LittlePlotViewController.h
//  little-plot
//
//  Created by Daniel Finneran on 19/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LittlePlotViewController : NSViewController


-(void)createPie;
-(void)createLine;
-(void)setPlotArray:(NSArray *)plotArray;

-(NSArray *)plotArray;

@end
