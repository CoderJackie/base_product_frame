//
//  UIAlertView+Block.h
//  iOS Blocks
//
//  Created by Ignacio Romero Zurbuchen on 12/11/12.
//  Copyright (c) 2013 DZEN. All rights reserved.
//

#import "UIAlertView+Block.h"

static DismissBlock _dismissBlock;
static VoidBlock _cancelBlock;

@implementation UIAlertView (Block)

+ (UIAlertView *)alertViewWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:(NSArray *)otherButtons
                 onDismiss:(DismissBlock)dismissed
                  onCancel:(VoidBlock)cancelled
{
    _dismissBlock  = [dismissed copy];
    _cancelBlock  = [cancelled copy];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[self class]
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];
    
    for (NSString *buttonTitle in otherButtons) {
        [alert addButtonWithTitle:buttonTitle];
    }
    
    [alert show];

    return alert;
}

+ (UIAlertView *)alertViewWithTitle:(NSString *)title
                            message:(NSString *)message
{
    return [UIAlertView alertViewWithTitle:title
                            message:message
                  cancelButtonTitle:NSLocalizedString(@"OK", @"OK")];
}

+ (UIAlertView *)alertViewWithTitle:(NSString *)title
                            message:(NSString *)message
                  cancelButtonTitle:(NSString *)cancelButtonTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];
    [alert show];

    return alert;
}


+ (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == [alertView cancelButtonIndex]) {
		if (_cancelBlock) {
            _cancelBlock();
        }
	}
    else {
        if (_dismissBlock) {
            _dismissBlock(buttonIndex,[alertView buttonTitleAtIndex:buttonIndex]);
        }
    }
}

@end