//
//  ModalVCViewController.m
//  BounceAnimate
//
//  Created by Xavier on 3/28/16.
//  Copyright © 2016 Xavier. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController () <UIViewControllerTransitioningDelegate>

@property(nonatomic, assign) BOOL shouldComplete;   //当拖动操作结束时，跟据这个判断是取消还是执行。

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(50, 120, 60, 20);
    [button setTitle:@"Dismiss" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //设置手势操作
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
}

- (void) buttonClicked:(id)sender{
    [self.delegate modalViewControllerClickedDismissButton:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleGesture:(UIPanGestureRecognizer *)panGestureRecognizer{
    NSLog(@"handleGesture_enter");
    
    CGPoint transition = [panGestureRecognizer translationInView:self.view];
    
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.interacting = YES;
            //[self.delegate modalViewControllerClickedDismissButton:self];
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged:{
            CGFloat fraction = transition.y / 400;
            fraction = fminf(fmaxf(0, fraction), 1);
            self.shouldComplete = (fraction > 0.5);
            
            [self.interactiveTransition updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            self.interacting = NO;
            if(!self.shouldComplete || panGestureRecognizer.state == UIGestureRecognizerStateCancelled){
                [self.interactiveTransition cancelInteractiveTransition];
            }else{
                [self.interactiveTransition finishInteractiveTransition];
            }
            break;
        default:
            break;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
