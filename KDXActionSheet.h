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
                 cancelAction:(void ( ^)())cancelAction
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            destructiveAction:(void ( ^)())destructiveAction;

- (void)addButtonWithTitle:(NSString *)title action:(void ( ^)())action;

- (void)showInView:(UIView *)view;

@end
