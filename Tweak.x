#import <UIKit/UIKit.h>

@interface YTSlimVideoDescriptionCell : UIView
// -(id)_viewControllerForAncestor;
@property (nonatomic, strong, readwrite) UILabel *descriptionLabel;
@end

%hook YTSlimVideoDescriptionCell

// v1.1.0
- (void)didMoveToSuperview {
    %orig;

    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(self.descriptionLabel.superview.superview.frame.origin.x, self.frame.origin.y + self.descriptionLabel.superview.superview.frame.origin.y, self.descriptionLabel.frame.size.width, self.frame.size.height) textContainer:nil];
    textView.editable = NO;
    textView.selectable = YES;
    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    if (self.descriptionLabel.attributedText) {
        textView.attributedText = self.descriptionLabel.attributedText;
    } else if (self.descriptionLabel.text) {
        textView.text = self.descriptionLabel.text;
    }
    CGFloat leftRightInset = textView.textContainer.lineFragmentPadding;
    textView.textContainerInset = UIEdgeInsetsMake(0, -leftRightInset, 0, -leftRightInset);
    textView.backgroundColor = [UIColor clearColor];
    [self.superview addSubview:textView];
    [self removeFromSuperview];
}

// v1.0.0
// - (id)initWithFrame:(CGRect)frame {
//     id orig = %orig;
//     if (orig) {
//         UILongPressGestureRecognizer *copyShareGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(ytcopy_showCopyShareAlert:)];
//         copyShareGesture.minimumPressDuration = .3;
//         [self addGestureRecognizer:copyShareGesture];
//         self.userInteractionEnabled = YES;
//     }
//     return orig;
// }



// %new
// - (void)ytcopy_showCopyShareAlert:(UILongPressGestureRecognizer *)sender {
//     if (sender.state == UIGestureRecognizerStateBegan) {
//         [[[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight] impactOccurred];

//         YTSlimVideoDescriptionCell *cell = (YTSlimVideoDescriptionCell *)sender.view;
//         NSString *desc = cell.descriptionLabel.attributedText.string ?: cell.descriptionLabel.text;

//         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"YTCopy" message:@"What do you want to do with the description?" preferredStyle:UIAlertControllerStyleAlert];
//         [alert addAction:[UIAlertAction actionWithTitle:@"Copy" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//             // Copy
//             [UIPasteboard generalPasteboard].string = desc;
//         }]];
//         [alert addAction:[UIAlertAction actionWithTitle:@"Share" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//             // Share
//             UIActivityViewController *shareMenu = [[UIActivityViewController alloc] initWithActivityItems:@[desc] applicationActivities:nil];
//             shareMenu.popoverPresentationController.sourceView = cell;
//             [self._viewControllerForAncestor presentViewController:shareMenu animated:YES completion:nil];
//         }]];
//         [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];

//         [self._viewControllerForAncestor presentViewController:alert animated:YES completion:nil];
//     }
// }

%end
