//
//  MMSViewController.m
//  DynamicsFun
//
//  Created by Michal Smialko on 11/1/13.
//  Copyright (c) 2013 Michal Smialko. All rights reserved.
//

#import "MMSViewController.h"
#import "MMSBallView.h"

NSInteger const ballsCount = 30;

@interface MMSViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@end

@implementation MMSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    // Create balls views
    CGRect ballRect = CGRectMake(0, 0, 50, 50);
    CGPoint randomPosition;
    NSMutableArray *balls = [[NSMutableArray alloc] initWithCapacity:ballsCount];
    for (NSInteger i=0; i<ballsCount; i++) {
        MMSBallView *ball = [[MMSBallView alloc] initWithFrame:ballRect];
        ball.titleLabel.text = [NSString stringWithFormat:@"%i", i];
        [self.view addSubview:ball];
        
        randomPosition.x = rand() % (NSInteger)self.view.frame.size.width;
        randomPosition.y = rand() % (NSInteger)self.view.frame.size.height;
        
        ball.center = randomPosition;
        
        [balls addObject:ball];
    }
    
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:balls];
    [collision setTranslatesReferenceBoundsIntoBoundary:YES];
    [self.animator addBehavior:collision];
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:balls];
    [self.animator addBehavior:gravity];
    
}

@end
