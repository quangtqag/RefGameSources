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

#import "CardNode.h"
#import "Factories.h"
#import "RainforestCardInfo.h"
#import "GradientNode.h"

#import "UIImage+ImageEffects.h"
#import "ASImageNode+Placeholder.h"

@interface CardNode ()
@property (strong, nonatomic) RainforestCardInfo *animalInfo;
@property (strong, nonatomic) ASImageNode *backgroundImageNode;
@property (strong, nonatomic) ASNetworkImageNode *animalImageNode;
@property (strong, nonatomic) ASTextNode *animalNameTextNode;
@property (strong, nonatomic) ASTextNode *animalDescriptionTextNode;
@property (strong, nonatomic) GradientNode *gradientNode;
@end

@interface CardNode (ASNetworkImageNodeDelegate)<ASNetworkImageNodeDelegate>
@end


@implementation CardNode

#pragma mark - Lifecycle

- (instancetype)initWithAnimal:(RainforestCardInfo *)animalInfo {
    if (!(self = [super init])) { return nil; }
    
    _animalInfo = animalInfo;
    
    self.backgroundColor = [UIColor lightGrayColor];
    self.clipsToBounds = YES;
    
    _backgroundImageNode = [[ASImageNode alloc] init];
    _animalImageNode = [[ASNetworkImageNode alloc] init];
    _animalNameTextNode = [[ASTextNode alloc] init];
    _animalDescriptionTextNode = [[ASTextNode alloc] init];
    _gradientNode = [[GradientNode alloc] init];
    
    //Animal Image
    _animalImageNode.URL = self.animalInfo.imageURL;
    _animalImageNode.clipsToBounds = YES;
    _animalImageNode.delegate = self;
    _animalImageNode.placeholderFadeDuration = 0.15;
    _animalImageNode.contentMode = UIViewContentModeScaleAspectFill;
    
    //Animal Name
    _animalNameTextNode.attributedText = [NSAttributedString attributedStringForTitleText:self.animalInfo.name];
    _animalNameTextNode.placeholderEnabled = YES;
    _animalNameTextNode.placeholderFadeDuration = 0.15;
    _animalNameTextNode.placeholderColor = [UIColor colorWithWhite:0.777 alpha:1.0];
    
    //Animal Description
    _animalDescriptionTextNode.attributedText = [NSAttributedString attributedStringForDescription:self.animalInfo.animalDescription];
    _animalDescriptionTextNode.truncationAttributedText = [NSAttributedString attributedStringForDescription:@"…"];
    _animalDescriptionTextNode.backgroundColor = [UIColor clearColor];
    _animalDescriptionTextNode.placeholderEnabled = YES;
    _animalDescriptionTextNode.placeholderFadeDuration = 0.15;
    _animalDescriptionTextNode.placeholderColor = [UIColor colorWithWhite:0.777 alpha:1.0];
    
    //Background Image
    _backgroundImageNode.placeholderFadeDuration = 0.15;
    _backgroundImageNode.imageModificationBlock = ^(UIImage *image) {
        UIColor *tintColor = [UIColor colorWithWhite:0.5 alpha:0.3];
        UIImage *newImage = [[UIImage resizeImage:image newSize:CGSizeMake(100, 300)] applyBlurWithRadius:10.0 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
        return newImage;
    };
    _backgroundImageNode.placeholderEnabled = YES;
    _backgroundImageNode.placeholderFadeDuration = 0.15;
    
    //Gradient Node
    _gradientNode.layerBacked = YES;
    _gradientNode.opaque = NO;
    
    [self addSubnode:self.backgroundImageNode];
    [self addSubnode:self.animalImageNode];
    [self addSubnode:self.gradientNode];
    
    [self addSubnode:self.animalNameTextNode];
    [self addSubnode:self.animalDescriptionTextNode];
    
    return self;
}

#pragma mark - Node Layout

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    CGFloat ratio = (constrainedSize.min.height)/constrainedSize.max.width;
    
    ASRatioLayoutSpec *imageRatioSpec = [ASRatioLayoutSpec
                                         ratioLayoutSpecWithRatio:ratio
                                         child:self.animalImageNode];
    
    ASOverlayLayoutSpec *gradientOverlaySpec = [ASOverlayLayoutSpec
                                                overlayLayoutSpecWithChild:imageRatioSpec
                                                overlay:self.gradientNode];
    
    ASRelativeLayoutSpec *relativeSpec = [ASRelativeLayoutSpec
                                          relativePositionLayoutSpecWithHorizontalPosition:ASRelativeLayoutSpecPositionStart
                                          verticalPosition:ASRelativeLayoutSpecPositionEnd
                                          sizingOption:ASRelativeLayoutSpecSizingOptionDefault
                                          child:self.animalNameTextNode];
    
    ASInsetLayoutSpec *nameInsetSpec = [ASInsetLayoutSpec
                                        insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 16.0, 8.0, 0.0) child:relativeSpec];
    
    ASOverlayLayoutSpec *nameOverlaySpec = [ASOverlayLayoutSpec
                                            overlayLayoutSpecWithChild:gradientOverlaySpec overlay:nameInsetSpec];
    
    ASInsetLayoutSpec *descriptionTextInsetSpec = [ASInsetLayoutSpec
                                                   insetLayoutSpecWithInsets:UIEdgeInsetsMake(16.0, 28.0, 12.0, 28.0)
                                                   child:self.animalDescriptionTextNode];
    
    ASStackLayoutSpec *verticalStackSpec = [[ASStackLayoutSpec alloc] init];
    verticalStackSpec.direction = ASStackLayoutDirectionVertical;
    verticalStackSpec.children = @[nameOverlaySpec, descriptionTextInsetSpec];
    
    ASBackgroundLayoutSpec *backgroundLayoutSpec = [ASBackgroundLayoutSpec
                                                    backgroundLayoutSpecWithChild:verticalStackSpec
                                                    background:self.backgroundImageNode];
    
    return backgroundLayoutSpec;
}

@end

#pragma mark - ASNetworkImageNodeDelegate

@implementation CardNode (ASNetworkImageNodeDelegate)

- (void)imageNode:(ASNetworkImageNode *)imageNode didFailWithError:(NSError *)error {
    NSLog(@"Image failed to load with error: \n%@", error);
}

- (void)imageNode:(ASNetworkImageNode *)imageNode didLoadImage:(UIImage *)image {
    self.backgroundImageNode.image = image;
}

@end

