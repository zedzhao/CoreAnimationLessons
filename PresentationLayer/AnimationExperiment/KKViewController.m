//
//  KKViewController.m
//  AnimationExperiment
//
//  Created by Kun on 14-5-6.
//  Copyright (c) 2014年 Kun. All rights reserved.
//

@import QuartzCore;

#import "KKViewController.h"


@interface KKViewController ()

@property (nonatomic,strong) CALayer *movingLayer;
@end


static CGFloat layerSize = 50;
static CGFloat const layerCenterInset = 100;

@implementation KKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CALayer *movingLayer = [CALayer layer];
    [movingLayer setBounds:CGRectMake(0, 0, layerSize, layerSize)];
    [movingLayer setBackgroundColor:[UIColor orangeColor].CGColor];
    [movingLayer setPosition:CGPointMake(layerCenterInset, layerCenterInset)];
    [self.view.layer addSublayer:movingLayer];
    [self setMovingLayer:movingLayer];
 	
    
    CAKeyframeAnimation *moveLayerAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];

    [moveLayerAnimation setValues:@[[NSValue valueWithCGPoint:CGPointMake(100, 100)], [NSValue valueWithCGPoint:CGPointMake(200, 250)]]];
     
    moveLayerAnimation.repeatCount = HUGE_VALF;
    moveLayerAnimation.duration = 2.0;
    [moveLayerAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    moveLayerAnimation.calculationMode = kCAAnimationCubic;
    [self.movingLayer addAnimation:moveLayerAnimation forKey:@"move"];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressedLayer:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (IBAction)pressedLayer:(UIGestureRecognizer*)gestureRecognizer{
    CGPoint touchPoint =[gestureRecognizer locationInView:self.view];
    
    if ([self.movingLayer.presentationLayer hitTest:touchPoint]) {
        [self blinkLayerWithColor:[UIColor yellowColor]];
    }else if ([self.movingLayer hitTest:touchPoint]){
        [self blinkLayerWithColor:[UIColor redColor]];
    }
}

- (void)blinkLayerWithColor:(UIColor *)color{
    CABasicAnimation *blinkAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    [blinkAnimation setDuration:0.1];
    [blinkAnimation setAutoreverses:YES];
    [blinkAnimation setFromValue:(id)self.movingLayer.backgroundColor];
    [blinkAnimation setToValue:(id)color.CGColor];
    
    [self.movingLayer addAnimation:blinkAnimation forKey:@"blink"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
