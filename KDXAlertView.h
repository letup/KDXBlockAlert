//
//  KDXAlertView.h
//  KDXBlockAlert
//
//  Created by Blankwonder on 11/20/12.
//

#import <Foundation/Foundation.h>

@interface KDXAlertView : NSObject

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
                  cancelAction:(void ( ^)())cancelAction;

- (void)addButtonWithTitle:(NSString *)title action:(void ( ^)())action;
- (void)show;

@end
