//
//  MMSBallView.m
//  DynamicsFun
//
//  Created by Michal Smialko on 11/1/13.
//  Copyright (c) 2013 Michal Smialko. All rights reserved.
//

#import "MMSBallView.h"

@interface MMSBallView ()
@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@end

@implementation MMSBallView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.layer.cornerRadius = frame.size.width/2.f;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [self addSubview:self.titleLabel];
    }
    return self;
}

@end
