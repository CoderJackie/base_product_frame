//
//  UINavigationController+Block.m
//  Navigation
//
//  Created by Ignacio on 3/22/13.
//  Copyright (c) 2013 DZEN. All rights reserved.
//

#import "UINavigationController+Block.h"

static VoidBlock _completionBlock;
static UIViewController *_viewController;

@implementation UINavigationController (Block)

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated onCompletion:(VoidBlock)completion
{
    [self setCompletionBlock:completion viewController:viewController andDelegate:self];
    [self pushViewController:_viewController animated:animated];
}

- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated onCompletion:(VoidBlock)completion
{
    [self setCompletionBlock:completion viewController:viewController andDelegate:self];
    [self popToViewController:_viewController animated:animated];
}

- (void)popViewControllerAnimated:(BOOL)animated onCompletion:(VoidBlock)completion
{
    NSUInteger index = [self.viewControllers indexOfObject:self.visibleViewController];
    
    if (index > 0) {
        
        index--;
        UIViewController *viewController = [self.viewControllers objectAtIndex:index];
        
        [self setCompletionBlock:completion viewController:viewController andDelegate:self];
        [self popToViewController:_viewController animated:animated];
    }
}

- (void)popToRootViewControllerAnimated:(BOOL)animated onCompletion:(VoidBlock)completion
{
    NSUInteger index = [self.viewControllers indexOfObject:self.visibleViewController];
    
    if (index > 0) {

        UIViewController *viewController = [self.viewControllers objectAtIndex:0];
        
        [self setCompletionBlock:completion viewController:viewController andDelegate:self];
        [self popToRootViewControllerAnimated:animated];
    }
}

- (void)setCompletionBlock:(VoidBlock)completion viewController:(UIViewController *)viewController andDelegate:(id)delegate
{
    _completionBlock  = [completion copy];
    _viewController = viewController;
    
    self.delegate = delegate;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isEqual:_viewController] && _completionBlock) {
        _completionBlock();
    }
}

@end
