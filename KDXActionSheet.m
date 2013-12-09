//
//  KDXActionSheet.m
//  KDXBlockAlert
//
//  Created by Blankwonder on 11/20/12.
//

#import "KDXActionSheet.h"

@interface KDXActionSheet() <UIActionSheetDelegate>{
    NSMutableArray *_buttonTitleArray;
    NSMutableArray *_buttonActionBlockArray;
    
    NSString *_cancelButtonTitle;
    void (^_cancelAction)();
    
    NSString *_destructiveButtonTitle;
    void (^_destructiveAction)();
    
    NSString *_title;
}
@end

static NSMutableArray *ActiveInstances = nil;

@implementation KDXActionSheet

- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
                 cancelAction:(void ( ^)())cancelAction
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            destructiveAction:(void ( ^)())destructiveAction; {

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
        _destructiveButtonTitle = destructiveButtonTitle;
        _destructiveAction = [destructiveAction copy];
        _title = title;
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

- (void)showInView:(UIView *)view {
    [ActiveInstances addObject:self];
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:_title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    if (_destructiveButtonTitle) {
        as.destructiveButtonIndex = [as addButtonWithTitle:_destructiveButtonTitle];
    }
    for (NSString *title in _buttonTitleArray) {
        [as addButtonWithTitle:title];
    }
    if (_cancelButtonTitle) {
        as.cancelButtonIndex = [as addButtonWithTitle:_cancelButtonTitle];
    }
    [as showInView:view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        if (_cancelAction)
            _cancelAction();
    } else if (buttonIndex == actionSheet.destructiveButtonIndex) {
        if (_destructiveAction)
            _destructiveAction();
    } else {
        int index = buttonIndex;
        if (_destructiveButtonTitle) {
            index--;
        }
        id actionBlock = _buttonActionBlockArray[index];
        if (actionBlock && actionBlock != [NSNull null]) {
            void (^block)() = actionBlock;
            block();
        }
    }
    actionSheet.delegate = nil;
    [ActiveInstances removeObject:self];
}

@end
