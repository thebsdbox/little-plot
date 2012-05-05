//
//  LittlePlotTableView.h
//  little-plot
//
//  Created by Daniel Finneran on 02/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LittlePlotTableView : NSView

-(void)debugView:(BOOL)enableDebug;
-(void)setCellRect:(NSRect)cellRect;
-(void)setTabelArray:(NSMutableArray *)tableArray;
-(void)autoSizeCell:(BOOL)autoSize;

@end
