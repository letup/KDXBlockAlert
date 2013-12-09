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
                  cancelBlock:(void ( ^)())cancelBlock;

- (void)addButtonWithTitle:(NSString *)title actionBlock:(void ( ^)())actionBlock;
- (void)show;

@end
