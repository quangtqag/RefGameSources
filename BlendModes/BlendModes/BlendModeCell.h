//
//  BlendModeCell.h
//  BlendModes
//
//  Created by Quang Tran on 4/4/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlendModeCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

@end
