KDXBlockAlert
=============

An UIAlertView and UIActionSheet helper for block-based callback usage

## Example

### KDXAlertView

    KDXAlertView *av = [[KDXAlertView alloc]
                        initWithTitle:@"Error"
                        message:@"Something wrong!"
                        cancelButtonTitle:@"Cancel"
                        cancelAction:^{
                            [self dismissViewControllerWithAnimation];
                        }];
    [av addButtonWithTitle:@"Retey" action:^{
        [self retry];
    }];
    [av show];

    
### KDXActionSheet

    KDXActionSheet *as = [[KDXActionSheet alloc]
                          initWithTitle:@"Do something"
                          cancelButtonTitle:@"Cacnel"
                          cancelAction:nil
                          destructiveButtonTitle:@"Delete"
                          destructiveAction:^{
                              [model delete];
                          }];
    [as addButtonWithTitle:@"Share" action:^{
        [self shareItem:model];
    }];
    [as showInView:self.view];
    
## Feature

* Block-based callback, now you don't have to implement the annoying UIAlertViewDelegate or UIActionSheetDelegate protocol.
* It's just a helper. The underlying implementation is still UIAlertView or UIActionSheet. Don't worry about compatibility.
