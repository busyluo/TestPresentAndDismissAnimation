//
//  ViewController.m
//  BounceAnimate
//
//  Created by Xavier on 3/28/16.
//  Copyright © 2016 Xavier. All rights reserved.
//

#import "RootViewController.h"
#import "BouncePresentAnimation.h"
#import "NormalDismissAnimation.h"

@interface RootViewController () <ModalVCDismissDelegate, UIViewControllerTransitioningDelegate>

@property(nonatomic, strong) ModalViewController * modalVC;

@property(nonatomic, strong) BouncePresentAnimation *presentAnimation;
@property(nonatomic, strong) NormalDismissAnimation *dismissAnimation;
@property(nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;

@end

@implementation RootViewController

-(void)awakeFromNib{
    _presentAnimation = [BouncePresentAnimation new];
    _dismissAnimation = [NormalDismissAnimation new];
    _interactiveTransition = [UIPercentDrivenInteractiveTransition new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [button setTitle:@"Present" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void) buttonClicked:(id)sender{
    self.modalVC = [[ModalViewController alloc] init];
    self.modalVC.delegate = self;
    self.modalVC.interactiveTransition = self.interactiveTransition;
    self.modalVC.transitioningDelegate = self;
    
    [self presentViewController:self.modalVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Transition delegate
- (void)modalViewControllerClickedDismissButton:(ModalViewController *)modalVCViewController{
    [self.modalVC dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.presentAnimation;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self.dismissAnimation;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.modalVC.interacting ? self.interactiveTransition : nil;
}

@end
