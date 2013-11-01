//
//  MMSBombView.m
//  DynamicsFun
//
//  Created by Michal Smialko on 11/1/13.
//  Copyright (c) 2013 Michal Smialko. All rights reserved.
//

#import "MMSBombView.h"

@implementation MMSBombView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.layer.cornerRadius = frame.size.width/2.f;
    }
    return self;
}

@end
