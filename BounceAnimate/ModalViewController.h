//
//  ModalVCViewController.h
//  BounceAnimate
//
//  Created by Xavier on 3/28/16.
//  Copyright © 2016 Xavier. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModalViewController;

@protocol ModalVCDismissDelegate <NSObject>
- (void)modalViewControllerClickedDismissButton:(ModalViewController *) modalVCViewController;
@end


@interface ModalViewController : UIViewController

@property(nonatomic, weak) UIPercentDrivenInteractiveTransition *interactiveTransition;
@property(nonatomic, assign) BOOL interacting; //标记当前正在进行手势操作， 当通过按扭dismiss时，能够正常显示动画。

@property(nonatomic, weak) id<ModalVCDismissDelegate> delegate;

@end
