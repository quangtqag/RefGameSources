/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "CardCell.h"
#import "Factories.h"
#import "RainforestCardInfo.h"

#import "UIImage+ImageEffects.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

@interface CardCell ()
@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) UIImageView *animalImageView;
@property (strong, nonatomic) UILabel *animalNameLabel;
@property (strong, nonatomic) UITextView *animalDescriptionTextView;
@end

@implementation CardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
    return nil;
  }
  
  _backgroundImageView = [[UIImageView alloc] init];
  _animalImageView = [[UIImageView alloc] init];
  _animalNameLabel = [[UILabel alloc] init];
  _animalDescriptionTextView = [[UITextView alloc] init];
  
  [self addSubview:self.backgroundImageView];
  [self addSubview:self.animalImageView];
  [self addSubview:self.animalNameLabel];
  [self addSubview:self.animalDescriptionTextView];
  
  _animalImageView.contentMode = UIViewContentModeScaleAspectFill;
  
  _animalDescriptionTextView.scrollEnabled = NO;
  _animalDescriptionTextView.backgroundColor = [UIColor clearColor];
  
  self.clipsToBounds = YES;
  
  return self;
}

- (void)prepareForReuse {
  [super prepareForReuse];
  self.animalImageView.image = nil;
  self.backgroundImageView.image = nil;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  CGSize size = self.bounds.size;
  
  self.animalImageView.frame = CGRectMake(0, 0, size.width, size.height * (2.0/3.0));
  self.animalImageView.clipsToBounds = YES;
  
  __weak CardCell *weakSelf = self;
  [self.animalImageView
   setImageWithURLRequest:[NSURLRequest requestWithURL:self.animalInfo.imageURL]
   placeholderImage:nil
   success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
     weakSelf.animalImageView.image = image;
     weakSelf.backgroundImageView.image = [image applyBlurWithRadius:30 tintColor:[UIColor colorWithWhite:0.5 alpha:0.3] saturationDeltaFactor:1.8 maskImage:nil];
   } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
     
   }];
  
  self.animalNameLabel.attributedText = [NSAttributedString attributedStringForTitleText:self.animalInfo.name];
  self.animalDescriptionTextView.attributedText = [NSAttributedString attributedStringForDescription:self.animalInfo.animalDescription];
  
  [self.animalNameLabel sizeToFit];
  CGSize nameLabelSize = self.animalNameLabel.bounds.size;
  self.animalNameLabel.center = CGPointMake(16 + nameLabelSize.width/2.0, size.height * (2.0/3.0) - nameLabelSize.height/2.0 - 8);
  
  self.animalDescriptionTextView.frame = CGRectMake(8, size.height * (2.0/3.0) + 8, size.width - 16, size.height * (1.0/3.0) - 16);
  self.backgroundImageView.frame = self.bounds;
}

@end
