//
//  iOSBlocksProtocol.h
//  iOS Blocks
//
//  Created by Ignacio Romero Zurbuchen on 2/12/13.
//  Copyright (c) 2011 DZen Interaktiv.
//  Licence: MIT-Licence
//

#import <Foundation/Foundation.h>

/*
 * Generic block constants for free usage over different classes.
 */
@protocol iOSBlocksProtocol <NSObject>

typedef void (^VoidBlock)();
typedef void (^CompletionBlock)(BOOL completed);

typedef void (^DismissBlock)(int buttonIndex, NSString *buttonTitle);
typedef void (^PhotoPickedBlock)(UIImage *chosenImage);

typedef void (^ComposeCreatedBlock)(UIViewController *controller);
typedef void (^ComposeFinishedBlock)(UIViewController *controller, NSError *error);

typedef void (^ProgressBlock)(NSInteger connectionProgress);
typedef void (^DataBlock)(NSData *data);
typedef void (^SuccessBlock)(NSHTTPURLResponse *HTTPResponse);
typedef void (^FailureBlock)(NSError *error);

typedef void (^RowPickedBlock)(NSString *title);

typedef void (^ListBlock)(NSArray *list);

typedef void (^StatusBlock)(unsigned int status);

@end