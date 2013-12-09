//
//  KDXAlertView.m
//  KDXBlockAlert
//
//  Created by Blankwonder on 11/20/12.
//

#import "KDXAlertView.h"
@interface KDXAlertView(){
    NSMutableArray *_buttonTitleArray;
    NSMutableArray *_buttonActionBlockArray;
    
    NSString *_cancelButtonTitle;
    void (^_cancelAction)();
    
    NSString *_title, *_message;
}
@end

static NSMutableArray *ActiveInstances = nil;

@implementation KDXAlertView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
                 cancelAction:(void ( ^)())cancelAction {

    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        ActiveInstances = [NSMutableArray array];
    });

    self = [self init];
    if (self) {
        _buttonTitleArray = [NSMutableArray array];
        _buttonActionBlockArray = [NSMutableArray array];
        _cancelButtonTitle = cancelButtonTitle;
        _cancelAction = [cancelAction copy];

        _title = title;
        _message = message;
    }
    return self;
}

- (void)addButtonWithTitle:(NSString *)title action:(void ( ^)())action {
    NSAssert(title, @"Title cannot be nil.");
    [_buttonTitleArray addObject:title];
    if (action) {
        [_buttonActionBlockArray addObject:[action copy]];
    } else {
        [_buttonActionBlockArray addObject:[NSNull null]];
    }
}

- (void)show {
    [ActiveInstances addObject:self];
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:_title message:_message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    for (NSString *title in _buttonTitleArray) {
        [av addButtonWithTitle:title];
    }
    if (_cancelButtonTitle) {
        av.cancelButtonIndex = [av addButtonWithTitle:_cancelButtonTitle];
    }
    [av show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex) {
        if (_cancelAction)
            _cancelAction();
    } else {
        id actionBlock = _buttonActionBlockArray[buttonIndex];
        if (actionBlock && actionBlock != [NSNull null]) {
            void (^block)() = actionBlock;
            block();
        }
    }
    alertView.delegate = nil;
    [ActiveInstances removeObject:self];
}

@end
