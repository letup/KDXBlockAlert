//
//  KDXActionSheet.h
//  KDXBlockAlert
//
//  Created by Blankwonder on 11/20/12.
//

#import <UIKit/UIKit.h>

@interface KDXActionSheet : NSObject

- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
            cancelActionBlock:(void ( ^)())cancelActionBlock
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
       destructiveActionBlock:(void ( ^)())destructiveActionBlock;

- (void)addButtonWithTitle:(NSString *)title actionBlock:(void ( ^)())actionBlock;

- (void)showInView:(UIView *)view;

@end
