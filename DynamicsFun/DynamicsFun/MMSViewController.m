//
//  MMSViewController.m
//  DynamicsFun
//
//  Created by Michal Smialko on 11/1/13.
//  Copyright (c) 2013 Michal Smialko. All rights reserved.
//

#import "MMSViewController.h"
#import "MMSBallView.h"
#import "MMSBombView.h"

NSInteger const ballsCount = 30;

@interface MMSViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) NSMutableArray *balls;
@end

@implementation MMSViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    // Create balls views
    CGRect ballRect = CGRectMake(0, 0, 50, 50);
    CGPoint randomPosition;
    self.balls = [[NSMutableArray alloc] initWithCapacity:ballsCount];
    for (NSInteger i=0; i<ballsCount; i++) {
        MMSBallView *ball = [[MMSBallView alloc] initWithFrame:ballRect];
        ball.titleLabel.text = [NSString stringWithFormat:@"%i", i];
        [self.view addSubview:ball];
        
        randomPosition.x = rand() % (NSInteger)self.view.frame.size.width;
        randomPosition.y = rand() % (NSInteger)self.view.frame.size.height;
        
        ball.center = randomPosition;
        
        [self.balls addObject:ball];
    }
    
    // Collision with boundaries
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:self.balls];
    [collision setTranslatesReferenceBoundsIntoBoundary:YES];
    [self.animator addBehavior:collision];
    
    // Applying gravity to balls
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:self.balls];
    [self.animator addBehavior:gravity];
    
    // Add 'Tap gesture recognizer'
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(plantBomb:)];
    [self.view addGestureRecognizer:tapGesture];
    
}

#pragma mark - MMSViewController

- (void)plantBomb:(UITapGestureRecognizer *)tapGesture
{
    // User tapped somewhere.
    // Plant the bomb which will explode after a while and push balls.
    CGPoint touchedPosition = [tapGesture locationInView:self.view];
    
    CGFloat bombSize = 60;
    CGRect bombRect = CGRectMake(touchedPosition.x - bombSize/2.f,
                                 touchedPosition.y - bombSize/2.f,
                                 bombSize,
                                 bombSize);
    MMSBombView *bombView = [[MMSBombView alloc] initWithFrame:bombRect];
    [self.view addSubview:bombView];
    
    // Animate explosion
    [UIView animateWithDuration:0.6
                     animations:^{
                         bombView.transform = CGAffineTransformScale(bombView.transform, 0, 0);
                     }
                     completion:^(BOOL finished) {
                         for (UIView *ball in self.balls) {
                             UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[ball]
                                                                                     mode:UIPushBehaviorModeInstantaneous];
                             CGFloat x = ball.center.x - bombView.center.x;
                             CGFloat y = ball.center.y - bombView.center.y;
                             push.pushDirection = CGVectorMake(x / 100, y / 100);
                             [self.animator addBehavior:push];
                         }
                         
                         [bombView removeFromSuperview];
                     }];
}

@end
