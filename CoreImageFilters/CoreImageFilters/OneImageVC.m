//
//  OneImageVC.m
//  CoreImageFilters
//
//  Created by Quang Tran on 3/19/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "OneImageVC.h"
#import "SliderCell.h"
#import "DocVC.h"

@interface OneImageVC ()<UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIButton *showHideMenuBtn;
@property (weak, nonatomic) IBOutlet UISwitch *affectImmediatelySwitch;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuViewTopConstraint;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@property (nonatomic, strong) NSArray *inputKeys;
@property(nonatomic, strong) NSMutableArray *mutableAttrs;
@property(nonatomic, strong) UIPopoverPresentationController *presentationController;
@property(nonatomic, strong) UIImagePickerController *imgPC;


@end

@implementation OneImageVC {
  CIContext *context;
  CIFilter *filter;
  CIImage *beginImage;
  UIImageOrientation orientation;
}

NSString *const kAffectImmediately = @"FirstConstant";


-(BOOL)prefersStatusBarHidden {
  return YES;
}

- (IBAction)closeButtonDidTap:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showMenuButtonDidTap:(id)sender {
  // Show menu view
  if (self.menuViewTopConstraint.constant < 0) {
    self.menuViewTopConstraint.constant = self.imageView.frame.origin.y;
    self.showHideMenuBtn.selected = NO;
    [UIView animateWithDuration:0.5 animations:^{
      self.menuView.alpha = 1;
      [self.view layoutIfNeeded];
    }];
  }
  // Hide menu view
  else {
    self.menuViewTopConstraint.constant = -self.menuView.bounds.size.height;
    self.showHideMenuBtn.selected = YES;
    [UIView animateWithDuration:0.5 animations:^{
      self.menuView.alpha = 0;
      [self.view layoutIfNeeded];
    }];
  }
}

- (IBAction)changeImageButtonDidTap:(id)sender {
  [self presentViewController:self.imgPC animated:YES completion:nil];
}

- (IBAction)saveToPhotoLibraryButtonDidTap:(id)sender {
  UIImageWriteToSavedPhotosAlbum(self.imageView.image, nil, nil, nil);
}

- (IBAction)affectImmediatelyDidChangeValue:(UISwitch*)sender {
  
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  [ud setBool:sender.isOn forKey:kAffectImmediately];
  
  NSArray<SliderCell*> *visibleCells = self.tableView.visibleCells;
  for (SliderCell *cell in visibleCells) {
    cell.affectImmediately = sender.isOn;
  }
}

- (IBAction)showDocumentButtonDidTap:(id)sender {
  DocVC *docVC = [DocVC new];
  NSURL *docURL = filter.attributes[kCIAttributeReferenceDocumentation];
  docVC.docURL = docURL;
  UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:docVC];
  [self presentViewController:navi animated:YES completion:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Config affect immediately switch
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  [self.affectImmediatelySwitch setOn:[ud boolForKey:kAffectImmediately]];
  
  // Config Image Picker Controller
  self.imgPC = [[UIImagePickerController alloc] init];
  self.imgPC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  self.imgPC.delegate = self;
  self.imgPC.editing = YES;
  
  // Config menu view
  self.menuView.alpha = 0;
  self.menuViewTopConstraint.constant = -self.menuView.bounds.size.height;
  self.showHideMenuBtn.selected = YES;
  
  if (!UIAccessibilityIsReduceTransparencyEnabled()) {
    self.menuView.backgroundColor = [UIColor clearColor];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.menuView.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.menuView insertSubview:blurEffectView atIndex:0];
  } else {
    self.menuView.backgroundColor = [UIColor blackColor];
  }
  
  // Config table view
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  [self.tableView registerNib:[UINib nibWithNibName:@"SliderCell" bundle:nil] forCellReuseIdentifier:@"cell"];
  self.tableView.tableFooterView = [UIView new];
  self.tableView.allowsSelection = NO;
  self.tableView.bounces = NO;
  
  context = [CIContext contextWithOptions:nil];
  
  filter = [CIFilter filterWithName:self.filterName];
  NSMutableArray<NSString *> *mutableInputKeys = [[NSMutableArray alloc] initWithArray:filter.inputKeys];
  
  if ([mutableInputKeys containsObject:kCIInputImageKey] == YES) {
    NSString *imgName = @"twobird";
    if ([self.filterName isEqualToString:@"CIShadedMaterial"]) {
      imgName = @"height_text_img";
    }
    else if ([self.filterName isEqualToString:@"CIHeightFieldFromMask"]) {
      imgName = @"text_img";
    }
    else if ([self.filterName isEqualToString:@"CIGaussianBlur"]
             || [self.filterName isEqualToString:@"CIMotionBlur"]
             || [self.filterName isEqualToString:@"CIZoomBlur"]) {
      imgName = @"text_white_bg_black";
    }
    else if ([self.filterName isEqualToString:@"CIMaskedVariableBlur"]) {
      imgName = @"mountain";
    }
    else if ([self.filterName isEqualToString:@"CIMedianFilter"]
             || [self.filterName isEqualToString:@"CINoiseReduction"]) {
      imgName = @"libertyface";
    }
    else if ([self.filterName isEqualToString:@"CIColorClamp"]) {
      imgName = @"twogirls";
    }
    else if ([self.filterName isEqualToString:@"CIColorControls"]
             || [self.filterName isEqualToString:@"CIColorMatrix"]
             || [self.filterName isEqualToString:@"CIExposureAdjust"]
             || [self.filterName isEqualToString:@"CIGammaAdjust"]
             || [self.filterName isEqualToString:@"CIHueAdjust"]
             || [self.filterName isEqualToString:@"CIWhitePointAdjust"]
             || [self.filterName isEqualToString:@"CIColorInvert"]
             || [self.filterName isEqualToString:@"CIColorMap"]
             || [self.filterName isEqualToString:@"CIColorMonochrome"]
             || [self.filterName isEqualToString:@"CIColorPosterize"]
             || [self.filterName isEqualToString:@"CIFalseColor"]
             || [self.filterName isEqualToString:@"CISepiaTone"]
             ) {
      imgName = @"liberty";
    }
    else if ([self.filterName isEqualToString:@"CIColorPolynomial"]
             || [self.filterName isEqualToString:@"CIColorCrossPolynomial"]
             || [self.filterName isEqualToString:@"CIColorCubeWithColorSpace"]) {
      imgName = @"rose";
    }
    else if ([self.filterName isEqualToString:@"CILinearToSRGBToneCurve"]
             || [self.filterName isEqualToString:@"CISRGBToneCurveToLinear"]) {
      imgName = @"horse";
    }
    else if ([self.filterName isEqualToString:@"CITemperatureAndTint"]
             || [self.filterName isEqualToString:@"CIToneCurve"]
             || [self.filterName isEqualToString:@"CIVibrance"]) {
      imgName = @"decoration";
    }
    else if ([self.filterName isEqualToString:@"CIColorCube"]) {
      imgName = @"beach";
    }
    else if ([self.filterName isEqualToString:@"CIMaskToAlpha"]) {
      imgName = @"flowerwhitebgblack";
    }
    else if ([self.filterName isEqualToString:@"CIPhotoEffectChrome"]
             || [self.filterName isEqualToString:@"CIPhotoEffectFade"]
             || [self.filterName isEqualToString:@"CIPhotoEffectInstant"]
             || [self.filterName isEqualToString:@"CIPhotoEffectMono"]
             || [self.filterName isEqualToString:@"CIPhotoEffectNoir"]
             || [self.filterName isEqualToString:@"CIPhotoEffectProcess"]
             || [self.filterName isEqualToString:@"CIPhotoEffectTonal"]
             || [self.filterName isEqualToString:@"CIPhotoEffectTransfer"]
             ) {
      imgName = @"bicycle";
    }
    else if ([self.filterName isEqualToString:@"CIVignette"]
             || [self.filterName isEqualToString:@"CIVignetteEffect"]
             ) {
      imgName = @"daisie";
    }
    
    
    UIImage *gotImage = [UIImage imageNamed:imgName];
    
    orientation = gotImage.imageOrientation;
    beginImage = [CIImage imageWithCGImage:gotImage.CGImage];
    [mutableInputKeys removeObject:kCIInputImageKey];
    [filter setValue:beginImage forKey:kCIInputImageKey];
  }
  NSString *kCIInputMaskKey = @"inputMask";
  if ([mutableInputKeys containsObject:kCIInputMaskKey] == YES) {
    [mutableInputKeys removeObject:kCIInputMaskKey];
    UIImage *maskImg = [UIImage imageNamed:@"mask2"];
    CIImage *ciMaskImg = [CIImage imageWithCGImage:maskImg.CGImage];
    [filter setValue:ciMaskImg forKey:kCIInputMaskKey];
  }
  if ([mutableInputKeys containsObject:kCIInputGradientImageKey] == YES) {
    [mutableInputKeys removeObject:kCIInputGradientImageKey];
    UIImage *gradImg = [UIImage imageNamed:@"grad3"];
    CIImage *ciGradImg = [CIImage imageWithCGImage:gradImg.CGImage];
    [filter setValue:ciGradImg forKey:kCIInputGradientImageKey];
  }
  if ([mutableInputKeys containsObject:kCIInputBackgroundImageKey] == YES) {
    [mutableInputKeys removeObject:kCIInputBackgroundImageKey];
    UIImage *bgImg = [UIImage imageNamed:@"paper"];
    CIImage *ciBgImg = [CIImage imageWithCGImage:bgImg.CGImage];
    [filter setValue:ciBgImg forKey:kCIInputBackgroundImageKey];
  }
  NSString *kCIInputDisplacementImageKey = @"inputDisplacementImage";
  if ([mutableInputKeys containsObject:kCIInputDisplacementImageKey] == YES) {
    [mutableInputKeys removeObject:kCIInputDisplacementImageKey];
    UIImage *bgImg = [UIImage imageNamed:@"paper"];
    CIImage *ciBgImg = [CIImage imageWithCGImage:bgImg.CGImage];
    [filter setValue:ciBgImg forKey:kCIInputDisplacementImageKey];
  }
  NSString *kCIInputTextureKey = @"inputTexture";
  if ([mutableInputKeys containsObject:kCIInputTextureKey] == YES) {
    [mutableInputKeys removeObject:kCIInputTextureKey];
    UIImage *bgImg = [UIImage imageNamed:@"glass"];
    CIImage *ciBgImg = [CIImage imageWithCGImage:bgImg.CGImage];
    [filter setValue:ciBgImg forKey:kCIInputTextureKey];
  }
  NSString *kCIInputMessageKey = @"inputMessage";
  if ([mutableInputKeys containsObject:kCIInputMessageKey] == YES) {
    [mutableInputKeys removeObject:kCIInputMessageKey];
    NSString *msg = @"Hello World";
    NSData *msgData = [msg dataUsingEncoding:NSISOLatin1StringEncoding];
    [filter setValue:msgData forKey:kCIInputMessageKey];
  }
  if ([mutableInputKeys containsObject:kCIInputShadingImageKey] == YES) {
    [mutableInputKeys removeObject:kCIInputShadingImageKey];
    UIImage *shadingImg = [UIImage imageNamed:@"shading_img"];
    CIImage *ciShadingImg = [CIImage imageWithCGImage:shadingImg.CGImage];
    [filter setValue:ciShadingImg forKey:kCIInputShadingImageKey];
  }
  if ([mutableInputKeys containsObject:kCIInputTargetImageKey] == YES) {
    [mutableInputKeys removeObject:kCIInputTargetImageKey];
    UIImage *img = [UIImage imageNamed:@"target_img1"];
    CIImage *ciImg = [CIImage imageWithCGImage:img.CGImage];
    [filter setValue:ciImg forKey:kCIInputTargetImageKey];
  }
  if ([mutableInputKeys containsObject:kCIInputMaskImageKey] == YES) {
    [mutableInputKeys removeObject:kCIInputMaskImageKey];
    UIImage *img = [UIImage imageNamed:@"mask_img1"];
    CIImage *ciImg = [CIImage imageWithCGImage:img.CGImage];
    [filter setValue:ciImg forKey:kCIInputMaskImageKey];
  }
  
  NSLog(@"attrs = %@", filter.attributes);
  self.inputKeys = [mutableInputKeys copy];
  self.mutableAttrs = [NSMutableArray new];
  for (NSString *inputKey in self.inputKeys) {
    NSMutableDictionary *attrs = [[NSMutableDictionary alloc] initWithDictionary: filter.attributes[inputKey]];
    [self.mutableAttrs addObject:attrs];
    
    id defaultValue = attrs[kCIAttributeDefault];
    
    NSString *classStr = attrs[kCIAttributeClass];
    Class classType = NSClassFromString(classStr);
    if (classType == [CIVector class]) {
      CIVector *defaultVec = defaultValue;
      if (defaultVec.count == 4) {
        CGRect rect = CGRectMake(defaultVec.X, defaultVec.Y, defaultVec.Z, defaultVec.W);
        if (CGRectIsInfinite(rect) == YES) {
          CIVector *newDefaultVec = [CIVector vectorWithX:100 Y:100 Z:100 W:100];
          defaultValue = newDefaultVec;
          attrs[kCIAttributeDefault] = defaultValue;
        }
      }
    }
    
    [filter setValue:defaultValue forKey:inputKey];
  }
  [self filterImage];
}

-(void)filterImage {
  CIImage *outputImage = filter.outputImage;
  CGImageRef cgimg;
  if (CGRectIsInfinite([outputImage extent]) == YES) {
    if (beginImage != nil) {
      cgimg = [context createCGImage:outputImage fromRect:[beginImage extent]];
    }
    else {
      cgimg = [context createCGImage:outputImage fromRect:self.imageView.bounds];
    }
  }
  else {
//    cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    cgimg = [context createCGImage:outputImage fromRect:[beginImage extent]];
  }
  UIImage *newImage = [UIImage imageWithCGImage:cgimg scale:1.0 orientation:orientation];
  self.imageView.image = newImage;
  CGImageRelease(cgimg);
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
  
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.inputKeys.count;
}

-(UInt8)numOfParametersForSection: (NSInteger)section {
  NSString *inputKey = self.inputKeys[section];
  NSDictionary *attrs = filter.attributes[inputKey];
  NSString *classStr = attrs[kCIAttributeClass];
  Class classType = NSClassFromString(classStr);
  if (classType == [NSNumber class]) {
    return 1;
  }
  else if (classType == [CIVector class]) {
    CIVector *defaultValue = attrs[kCIAttributeDefault];
    return defaultValue.count;
  }
  else if (classType == [CIColor class]) {
    return 4;
  }
  else if (classType == [NSValue class]) {
    NSString *attrType = attrs[kCIAttributeType];
    if ([attrType isEqualToString:kCIAttributeTypeTransform]) {
      return 6;
    }
  }
  
  return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self numOfParametersForSection:section];
}

-(SliderCell *)cellForNumberClassAtIndexPath:(NSIndexPath *)indexPath {
  SliderCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
  NSString *inputKey = self.inputKeys[indexPath.section];
  NSMutableDictionary *attrs = self.mutableAttrs[indexPath.section];
  
  float minValue = 0;
  if (attrs[kCIAttributeSliderMin] != nil) {
    minValue = [attrs[kCIAttributeSliderMin] floatValue];
  }
  else if (attrs[kCIAttributeMin] != nil) {
    minValue = [attrs[kCIAttributeMin] floatValue];
  }
  
  float maxValue = indexPath.row == 0 ? beginImage.extent.size.width : beginImage.extent.size.height;
  if (attrs[kCIAttributeSliderMax] != nil) {
    maxValue = [attrs[kCIAttributeSliderMax] floatValue];
  }
  else if (attrs[kCIAttributeMax] != nil) {
    maxValue = [attrs[kCIAttributeMax] floatValue];
  }
  
  float defaultValue = [attrs[kCIAttributeDefault] floatValue];
  NSString *displayName = attrs[kCIAttributeDisplayName];
  [cell setDisplayName:displayName minValue:minValue maxValue:maxValue defaultValue:defaultValue];
  if ([self.filterName isEqualToString:@"CIAztecCodeGenerator"]) {
    cell.allowStrip = YES;
  }
  cell.sliderValueDidChangeCallback = ^(float value) {
    attrs[kCIAttributeDefault] = @(value);
    [filter setValue:@(value) forKey:inputKey];
    [self filterImage];
  };

  return cell;
}

-(SliderCell*)cellForVectorClassAtIndexPath:(NSIndexPath*)indexPath {
  SliderCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
  NSString *inputKey = self.inputKeys[indexPath.section];
  NSMutableDictionary *attrs = self.mutableAttrs[indexPath.section];
  
  CIVector *defaultValue = attrs[kCIAttributeDefault];
  
  if (defaultValue.count == 2) {
    // Set min value
    float minValue = 0;
    if (attrs[kCIAttributeSliderMin] != nil) {
      minValue = [attrs[kCIAttributeSliderMin] floatValue];
    }
    else if (attrs[kCIAttributeMin] != nil) {
      minValue = [attrs[kCIAttributeMin] floatValue];
    }
    
    // Set max value
    float maxValue = 0;
    if (beginImage != nil) {
      maxValue = indexPath.row == 0 ? beginImage.extent.size.width : beginImage.extent.size.height;
    }
    else if(defaultValue != nil) {
      //        maxValue = [defaultValue valueAtIndex:indexPath.row];
      maxValue = indexPath.row == 0 ? self.imageView.bounds.size.width : self.imageView.bounds.size.height;
    }
    
    if (attrs[kCIAttributeSliderMax] != nil) {
      maxValue = [attrs[kCIAttributeSliderMax] floatValue];
    }
    else if (attrs[kCIAttributeMax] != nil) {
      maxValue = [attrs[kCIAttributeMax] floatValue];
    }
    
    if ([self.filterName isEqualToString:@"CITemperatureAndTint"]) {
      minValue = 0;
      maxValue = 15000;
    }
    else if ([self.filterName isEqualToString:@"CIToneCurve"]) {
      minValue = 0;
      maxValue = 1;
    }
    
    // Get display name
    NSString *displayName = [NSString stringWithFormat:@"%c", "XY"[indexPath.row]];
    CGFloat defaultSingleValue = indexPath.row == 0 ? defaultValue.X : defaultValue.Y;
    
    // Set values for cell
    [cell setDisplayName:displayName minValue:minValue maxValue:maxValue defaultValue:defaultSingleValue];
    cell.sliderValueDidChangeCallback = ^(float value) {
      CIVector *defaultValue = attrs[kCIAttributeDefault];
      size_t vCount = defaultValue.count;
      CGFloat* vals = calloc(vCount, sizeof(CGFloat));
      for (int i=0; i<vCount; i++)
        vals[i] = [defaultValue valueAtIndex:i];
      
      vals[indexPath.row] = value;
      CIVector* vNew  = [CIVector vectorWithValues:vals count:vCount];
      attrs[kCIAttributeDefault] = vNew;
      [filter setValue:vNew forKey:inputKey];
      [self filterImage];
    };
  }
  else if (defaultValue.count == 3) {
    CGFloat min = 0;
    CGFloat max = 1;
    CGFloat specValue = [defaultValue valueAtIndex:indexPath.row];
    
    NSString *attrType = attrs[kCIAttributeType];
    if ([attrType isEqualToString:kCIAttributeTypePosition3]) {
      switch (indexPath.row) {
        case 0:
          max = beginImage.extent.size.width;
          break;
        case 1:
          max = beginImage.extent.size.height;
          break;
        case 2:
          max = 150;
          break;
        default:
          break;
      }
    }
    
    NSString *displayName = [NSString stringWithFormat:@"%c", "XYZ"[indexPath.row]];
    [cell setDisplayName:displayName minValue:min maxValue:max defaultValue:specValue];
    cell.sliderValueDidChangeCallback = ^(float value) {
      CIVector *defaultValue = attrs[kCIAttributeDefault];
      size_t vCount = defaultValue.count;
      CGFloat* vals = calloc(vCount, sizeof(CGFloat));
      for (int i=0; i<vCount; i++)
        vals[i] = [defaultValue valueAtIndex:i];
      
      vals[indexPath.row] = value;
      CIVector* vNew  = [CIVector vectorWithValues:vals count:vCount];
      attrs[kCIAttributeDefault] = vNew;
      [filter setValue:vNew forKey:inputKey];
      [self filterImage];
    };
  }
  else if (defaultValue.count == 4) {
    CGFloat min = 0;
    CGFloat max = 1;
    CGFloat specValue = [defaultValue valueAtIndex:indexPath.row];
    
    NSString *attrType = attrs[kCIAttributeType];
    if ([attrType isEqualToString:kCIAttributeTypeRectangle]) {
      switch (indexPath.row) {
        case 0:
        case 2:
          min = 0;
          max = beginImage.extent.size.width;
          break;
        case 1:
        case 3:
          min = 0;
          max = beginImage.extent.size.height;
          break;
        default:
          break;
      }
    }
    
    NSString *displayName = [NSString stringWithFormat:@"%c", "XYZW"[indexPath.row]];
    [cell setDisplayName:displayName minValue:min maxValue:max defaultValue:specValue];
    cell.sliderValueDidChangeCallback = ^(float value) {
      CIVector *defaultValue = attrs[kCIAttributeDefault];
      size_t vCount = defaultValue.count;
      CGFloat* vals = calloc(vCount, sizeof(CGFloat));
      for (int i=0; i<vCount; i++)
        vals[i] = [defaultValue valueAtIndex:i];
      
      vals[indexPath.row] = value;
      CIVector* vNew  = [CIVector vectorWithValues:vals count:vCount];
      attrs[kCIAttributeDefault] = vNew;
      [filter setValue:vNew forKey:inputKey];
      [self filterImage];
    };
  }
  else if (defaultValue.count > 4) {
    NSString *displayName = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    [cell setDisplayName:displayName minValue:0 maxValue:1 defaultValue:[defaultValue valueAtIndex:indexPath.row]];
    cell.sliderValueDidChangeCallback = ^(float value) {
      CIVector *defaultValue = attrs[kCIAttributeDefault];
      size_t vCount = defaultValue.count;
      CGFloat* vals = calloc(vCount, sizeof(CGFloat));
      for (int i=0; i<vCount; i++)
        vals[i] = [defaultValue valueAtIndex:i];
      
      vals[indexPath.row] = value;
      CIVector* vNew  = [CIVector vectorWithValues:vals count:vCount];
      attrs[kCIAttributeDefault] = vNew;
      [filter setValue:vNew forKey:inputKey];
      [self filterImage];
    };
  }
  
  return cell;
}

-(SliderCell*)cellForColorClassAtIndexPath:(NSIndexPath*)indexPath {
  SliderCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
  NSString *inputKey = self.inputKeys[indexPath.section];
  NSMutableDictionary *attrs = self.mutableAttrs[indexPath.section];
  
  CIColor *defaultValue = attrs[kCIAttributeDefault];
  NSString *displayName = [NSString stringWithFormat:@"%c", "RGBA"[indexPath.row]];
  CGFloat colorValue = 0.0;
  switch (indexPath.row) {
    case 0:
      colorValue = defaultValue.red;
      break;
    case 1:
      colorValue = defaultValue.green;
      break;
    case 2:
      colorValue = defaultValue.blue;
      break;
    case 3:
      colorValue = defaultValue.alpha;
      break;
    default:
      break;
  }
  [cell setDisplayName:displayName minValue:0 maxValue:1 defaultValue:colorValue];
  cell.sliderValueDidChangeCallback = ^(float newValue) {
    CIColor *defaultValue = attrs[kCIAttributeDefault];
    
    CGFloat r = [defaultValue red];
    CGFloat g = [defaultValue green];
    CGFloat b = [defaultValue blue];
    CGFloat a = [defaultValue alpha];
    
    switch (indexPath.row) {
      case 0: r = newValue; break;
      case 1: g = newValue; break;
      case 2: b = newValue; break;
      case 3: a = newValue; break;
      default:
        NSAssert(0, @"Invalid element index");
    }
    
    CIColor *newColor = [CIColor colorWithRed:r green:g blue:b alpha:a];
    
    attrs[kCIAttributeDefault] = newColor;
    [filter setValue:newColor forKey:inputKey];
    [self filterImage];
  };
  
  return cell;
}

-(SliderCell*)cellForValueClassAtIndexPath:(NSIndexPath*)indexPath {
  SliderCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
  NSString *inputKey = self.inputKeys[indexPath.section];
  NSMutableDictionary *attrs = self.mutableAttrs[indexPath.section];
  
  NSString *attrType = attrs[kCIAttributeType];
  if ([attrType isEqualToString:kCIAttributeTypeTransform]) {
    NSString *displayName = [NSString stringWithFormat:@"%@", @[@"a",@"b",@"c",@"d",@"tx",@"ty"][indexPath.row]];
    CGAffineTransform defaultTransform;
    [attrs[kCIAttributeDefault] getValue:&defaultTransform];
    
    CGFloat defaultValue = 0.0;
    switch (indexPath.row) {
      case 0: defaultValue = defaultTransform.a; break;
      case 1: defaultValue = defaultTransform.b; break;
      case 2: defaultValue = defaultTransform.c; break;
      case 3: defaultValue = defaultTransform.d; break;
      case 4: defaultValue = defaultTransform.tx; break;
      case 5: defaultValue = defaultTransform.ty; break;
      default:
        NSAssert(0, @"Invalid element index");
    }
    
    CGFloat min = -M_PI * 2;
    CGFloat max = M_PI * 2;
    if (indexPath.row == 4 || indexPath.row == 5) {
      min = -self.imageView.bounds.size.width;
      max = self.imageView.bounds.size.width;
    }
    
    [cell setDisplayName:displayName minValue:min maxValue:max defaultValue:defaultValue];
    cell.sliderValueDidChangeCallback = ^(float newValue) {
      CGAffineTransform defaultTransform;
      [attrs[kCIAttributeDefault] getValue:&defaultTransform];
      switch (indexPath.row) {
        case 0: defaultTransform.a = newValue; break;
        case 1: defaultTransform.b = newValue; break;
        case 2: defaultTransform.c = newValue; break;
        case 3: defaultTransform.d = newValue; break;
        case 4: defaultTransform.tx = newValue; break;
        case 5: defaultTransform.ty = newValue; break;
        default:
          NSAssert(0, @"Invalid element index");
      }
      NSValue *newTransformValue = [NSValue valueWithCGAffineTransform:defaultTransform];
      attrs[kCIAttributeDefault] = newTransformValue;
      [filter setValue:newTransformValue forKey:inputKey];
      [self filterImage];
    };
  }

  return cell;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  SliderCell *cell;
  NSMutableDictionary *attrs = self.mutableAttrs[indexPath.section];
  NSString *classStr = attrs[kCIAttributeClass];
  Class classType = NSClassFromString(classStr);
  if (classType == [NSNumber class]) {
    cell = [self cellForNumberClassAtIndexPath:indexPath];
  }
  else if (classType == [CIVector class]) {
    cell = [self cellForVectorClassAtIndexPath:indexPath];
  }
  else if (classType == [CIColor class]) {
    cell = [self cellForColorClassAtIndexPath:indexPath];
  }
  else if (classType == [NSValue class]) {
    cell = [self cellForValueClassAtIndexPath:indexPath];
  }
  
  cell.affectImmediately = self.affectImmediatelySwitch.isOn;
  
  return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 78;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  UInt8 params = [self numOfParametersForSection:section];
  
  if (params > 1) {
    NSString *inputKey = self.inputKeys[section];
    NSDictionary *data = filter.attributes[inputKey];
    NSString *displayName = data[kCIAttributeDisplayName];
    return displayName;
  }
  else {
    return @" ";
  }
}

-(void)inputInfoButtonDidTap:(UIButton*)sender {
  NSMutableDictionary *inAttrs = self.mutableAttrs[sender.tag];
  NSString *desc = inAttrs[kCIAttributeDescription];
  
  CGFloat padding = 8;
  CGFloat w = self.view.bounds.size.width * 0.7;
  UIFont *f = [UIFont systemFontOfSize:15];
  CGSize constraint = CGSizeMake(w, CGFLOAT_MAX);
  NSStringDrawingContext *ctx = [[NSStringDrawingContext alloc] init];
  CGSize boundingBox = [desc boundingRectWithSize:constraint
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:f}
                                          context:ctx].size;
  CGSize size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
  CGFloat h = size.height;
  
  UIViewController *popoverVC = [UIViewController new];
  popoverVC.preferredContentSize = CGSizeMake(w + padding * 2, h + padding * 2);
  popoverVC.modalPresentationStyle = UIModalPresentationPopover;
  UIView *contentView = popoverVC.view;
  contentView.backgroundColor = [UIColor whiteColor];
  UILabel *descLB = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding, w, h)];
  descLB.numberOfLines = 0;
  descLB.textColor = [UIColor darkGrayColor];
  descLB.font = f;
  descLB.text = desc;
  [contentView addSubview:descLB];
  
  self.presentationController = [popoverVC popoverPresentationController];
  self.presentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
  self.presentationController.sourceView = sender;
  self.presentationController.sourceRect = sender.bounds;
  self.presentationController.delegate = self;
  
  [self presentViewController:popoverVC animated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
  NSMutableDictionary *inAttrs = self.mutableAttrs[section];
  NSString *desc = inAttrs[kCIAttributeDescription];
  if (desc != nil) {
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView*)view;
    
    UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeInfoDark];
    infoBtn.tag = section;
    infoBtn.tintColor = [UIColor lightGrayColor];
    infoBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [infoBtn addTarget:self action:@selector(inputInfoButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:infoBtn];
    
    [[infoBtn.bottomAnchor constraintEqualToAnchor:headerView.bottomAnchor] setActive:YES];
    [[infoBtn.rightAnchor constraintEqualToAnchor:headerView.rightAnchor constant:8] setActive:YES];
    [[infoBtn.widthAnchor constraintEqualToConstant:30] setActive:YES];
    [[infoBtn.heightAnchor constraintEqualToAnchor:infoBtn.widthAnchor] setActive:YES];
  }
}

#pragma mark - UIPopoverPresentationControllerDelegate 

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
  return UIModalPresentationNone;
}

#pragma mark - Image Picker Controller Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
  UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
  orientation = img.imageOrientation;
  beginImage = [CIImage imageWithCGImage:img.CGImage];
  [filter setValue:beginImage forKey:kCIInputImageKey];
  [self filterImage];
  [self dismissViewControllerAnimated:YES completion:nil];
}


@end
