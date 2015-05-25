//
//  MFMailComposeViewController+Block.m
//  iOS Blocks
//
//  Created by Ignacio Romero Zurbuchen on 12/11/12.
//  Copyright (c) 2013 DZEN. All rights reserved.
//

#import "MFMailComposeViewController+Block.h"

static ComposeCreatedBlock _composeCreatedBlock;
static ComposeFinishedBlock _composeFinishedBlock;

@implementation MFMailComposeViewController (Block)

+ (void)mailWithSubject:(NSString *)subject
                message:(NSString *)message
             recipients:(NSArray *)recipients
         andAttachments:(NSArray *)attachments
             onCreation:(ComposeCreatedBlock)creation
               onFinish:(ComposeFinishedBlock)finished
{
    _composeCreatedBlock = [creation copy];
    _composeFinishedBlock = [finished copy];
    
    MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
    mailComposeViewController.mailComposeDelegate = [self class];
    [mailComposeViewController setSubject:subject];
    [mailComposeViewController setMessageBody:message isHTML:YES];
    [mailComposeViewController setToRecipients:recipients];
    
    for (NSDictionary *attachment in attachments) {
        NSData *data = [attachment objectForKey:kMFAttachmentData];
        NSString *mimeType = [attachment objectForKey:kMFAttachmentMimeType];
        NSData *filename = [attachment objectForKey:kMFAttachmentFileName];
        
        [mailComposeViewController addAttachmentData:data mimeType:mimeType fileName:filename];
    }
    
    mailComposeViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    
    if (_composeCreatedBlock) {
        _composeCreatedBlock(mailComposeViewController);
    }
}

+ (void)mailWithSubject:(NSString *)subject
                message:(NSString *)message
             recipients:(NSArray *)recipients
             onCreation:(ComposeCreatedBlock)creation
               onFinish:(ComposeFinishedBlock)finished
{
    [MFMailComposeViewController mailWithSubject:subject
                                         message:message
                                      recipients:recipients
                                  andAttachments:nil
                                      onCreation:creation
                                        onFinish:finished];
}


#pragma mark - MFMailComposeViewControllerDelegate

+ (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if (_composeFinishedBlock) {
        _composeFinishedBlock(controller, error);
    }
}

@end
