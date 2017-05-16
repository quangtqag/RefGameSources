//
//  SettingsViewController.h
//  DrawPad
//
//  Created by Quang Tran on 5/16/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsViewControllerDelegate <NSObject>
- (void)closeSettings:(id)sender;
@end


@interface SettingsViewController : UIViewController

@property CGFloat brush;
@property CGFloat opacity;
@property CGFloat red;
@property CGFloat green;
@property CGFloat blue;

@property (nonatomic, weak) id<SettingsViewControllerDelegate> delegate;

@end
