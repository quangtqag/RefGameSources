//
//  ViewController.m
//  BlendModes
//
//  Created by Quang Tran on 4/4/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "ViewController.h"
#import "BlendModeCell.h"
#import "TemplateCell.h"
#import "ImageFiltration.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UICollectionView *templatesCV;
@property (weak, nonatomic) IBOutlet UICollectionView *modesCV;

@property(nonatomic, strong) UIImagePickerController *imgPC;
@property(nonatomic, strong) NSArray<NSString*> *filterNames;
@property(nonatomic, strong) CIContext *context;
@property(nonatomic, strong) UIImage *inImg;
@property(nonatomic, strong) UIImage *bgImg;
@property(nonatomic, strong) NSMutableArray<UIImage*> *templates;
@property(nonatomic, strong) NSMutableDictionary<NSIndexPath*, ImageFiltration*> *filtrationOperationsDict;
@property(nonatomic, strong) NSOperationQueue *filtrationQueue;
@property(nonatomic, strong) NSIndexPath *selectedTemplateIndexPath;

@end

@implementation ViewController

NSString *const kTemplateFolderName = @"templates";

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.toolbar setBackgroundImage:[UIImage new] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
  self.toolbar.backgroundColor = [UIColor clearColor];
  self.toolbar.clipsToBounds = YES;
  
  // Config Image Picker Controller
  self.imgPC = [[UIImagePickerController alloc] init];
  self.imgPC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  self.imgPC.delegate = self;
  self.imgPC.editing = YES;
  
  // Config Collection Views
  self.templatesCV.delegate = self;
  self.templatesCV.dataSource = self;
  self.templatesCV.tag = 1;
  
  self.modesCV.delegate = self;
  self.modesCV.dataSource = self;
  self.modesCV.tag = 2;
  
  [self buildTemplates];
  
  // Set input image, background image
  self.context = [CIContext contextWithOptions:nil];
//  self.inImg = [UIImage imageNamed:@"img1"];
  self.inImg = [UIImage imageNamed:@"Bison"];
  self.bgImg = self.templates.firstObject;
  self.selectedTemplateIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
  [self preprocessInputImage];
  self.imgView.image = self.inImg;
  [self preprocessBgImage];
  
  // Setup filter operation queue
  self.filtrationQueue = [[NSOperationQueue alloc] init];
  self.filtrationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
  self.filtrationQueue.name = @"Image Filtration queue";
  
  self.filtrationOperationsDict = [NSMutableDictionary new];
  NSMutableArray *allFilterNames = [[NSMutableArray alloc] initWithArray: [CIFilter filterNamesInCategory:kCICategoryCompositeOperation]];

  // Remove some unnecessary filters
  // Remove CIMultiplyCompositing b/c with input image and bg image have the same size
  // then CIMultiplyCompositing and CIMultiplyBlendMode give the same result
  [allFilterNames removeObject:@"CIMultiplyCompositing"];
  
  // If input image and bg image have the same size then it only show input image
  [allFilterNames removeObject:@"CISourceAtopCompositing"];
  
  // Remove CISourceInCompositing, CISourceOutCompositing, CISourceOverCompositing
  // b/c the main purpose of them are crop image
  [allFilterNames removeObject:@"CISourceInCompositing"];
  [allFilterNames removeObject:@"CISourceOutCompositing"];
  [allFilterNames removeObject:@"CISourceOverCompositing"];
  self.filterNames = allFilterNames;
}

-(void)buildTemplates {
  NSString *dirPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:kTemplateFolderName];
  NSError * error;
  NSArray * fileNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath error:&error];
  self.templates = [NSMutableArray new];
  for (NSString *fileName in fileNames) {
    NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
    UIImage *img = [UIImage imageWithContentsOfFile:filePath];
    [self.templates addObject:img];
  }
}

- (IBAction)changeInputImgBtnDidTap:(UIBarButtonItem *)sender {
  self.imgPC.view.tag = 1;
  [self presentViewController:self.imgPC animated:YES completion:nil];
}

- (IBAction)saveImgBtnDidTap:(UIBarButtonItem *)sender {
//  UIImageWriteToSavedPhotosAlbum(self.imgView.image, nil, nil, nil);
  UIImageWriteToSavedPhotosAlbum(self.imgView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
  UILabel *lbl = [UILabel new];
  lbl.text = @"Image Saved!";
  lbl.textColor = [UIColor whiteColor];
  lbl.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5];
  lbl.font = [UIFont systemFontOfSize:20];
  lbl.translatesAutoresizingMaskIntoConstraints = NO;
  lbl.layer.cornerRadius = 5;
  lbl.layer.masksToBounds = YES;
  lbl.textAlignment = NSTextAlignmentCenter;
  lbl.alpha = 0;
  [self.view addSubview:lbl];
  
  [[lbl.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-20] setActive:YES];
  [[lbl.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20] setActive:YES];
  [[lbl.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20] setActive:YES];
  [[lbl.heightAnchor constraintEqualToConstant:40] setActive:YES];
  
  [UIView animateWithDuration:0.5 animations:^{
    lbl.alpha = 1;
  } completion:^(BOOL finished) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [UIView animateWithDuration:0.5 animations:^{
        lbl.alpha = 0;
      } completion:^(BOOL finished) {
        [lbl removeFromSuperview];
      }];
    });
  }];
}

- (IBAction)shareImgBtnDidTap:(UIBarButtonItem *)sender {
  UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems:@[self.imgView.image] applicationActivities:nil];
  [self presentViewController:avc animated:true completion:nil];
}

-(BOOL)prefersStatusBarHidden {
  return YES;
}

-(void)cancelAndResetAllFilterOperations {
  // Cancel all operations
  NSArray<NSIndexPath* > *indices = self.filtrationOperationsDict.allKeys;
  for (NSIndexPath *ip in indices) {
    ImageFiltration *imgfil = self.filtrationOperationsDict[ip];
    if (imgfil != nil) {
      [imgfil cancel];
    }
  }
  
  // Reset filtration operation dict
  [self.filtrationOperationsDict removeAllObjects];
  [self.modesCV reloadData];
}

-(UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size {
  UIGraphicsBeginImageContext(size);
  [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
  UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return destImage;
}

-(UIImage *)scaleImage:(UIImage *)image withValue:(CGFloat)value {
  return [self resizeImage:image toSize:CGSizeMake(image.size.width/value, image.size.height/value)];
}

-(void)preprocessInputImage {
  CGSize inSize = self.inImg.size;
  CGSize bgSize = self.bgImg.size;
  
  CGFloat wc = 1.0;
  if (inSize.width > bgSize.width) {
    wc = inSize.width / bgSize.width;
  }
  CGFloat hc = 1.0;
  if (inSize.height > bgSize.height) {
    hc = inSize.height / bgSize.height;
  }
  CGFloat scale = MAX(wc, hc);
  if (scale > 1.0) {
    UIImage *scaledInImg = [self scaleImage:self.inImg withValue:scale];
    self.inImg = scaledInImg;
  }
}

-(UIImage *)cropImage:(UIImage *)img toRect:(CGRect)rect {
  CGImageRef imageRef = CGImageCreateWithImageInRect([img CGImage], rect);
  UIImage *croppedImg = [UIImage imageWithCGImage:imageRef];
  CGImageRelease(imageRef);
  return croppedImg;
}

-(void)preprocessBgImage {
  self.bgImg = [self cropImage:self.bgImg toRect:CGRectMake(0, 0, self.inImg.size.width, self.inImg.size.height)];
}

#pragma mark - Collection View

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  // Templates
  if (collectionView.tag == 1) {
    return 2;
  }
  // Modes
  else {
    return 1;
  }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  // Templates
  if (collectionView.tag == 1) {
    if (section == 0) {
      return 1;
    }
    else {
      return self.templates.count;
    }
  }
  // Modes
  else {
    return self.filterNames.count;
  }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  // Templates
  if (collectionView.tag == 1) {
    TemplateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
      cell.imgView.image = [UIImage imageNamed:@"plus"];
      cell.imgView.contentMode = UIViewContentModeCenter;
      cell.imgView.tintColor = [UIColor lightGrayColor];
      cell.layer.borderColor = [[UIColor lightGrayColor] CGColor];
      cell.layer.borderWidth = 1;  
    }
    else {
      cell.imgView.image = self.templates[indexPath.row];
      cell.imgView.contentMode = UIViewContentModeScaleAspectFill;
      
      if ([indexPath isEqual:self.selectedTemplateIndexPath]) {
        cell.layer.borderColor = [[UIColor darkGrayColor] CGColor];
        cell.layer.borderWidth = 3;
      }
      else {
        cell.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        cell.layer.borderWidth = 1;
      }
    }
    
    cell.layer.masksToBounds = YES;
    return cell;
  }
  // Modes
  else {
    BlendModeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSString *filterName = self.filterNames[indexPath.row];
    CIFilter *filter = [CIFilter filterWithName:filterName];
    NSString *filterDisplayName = filter.attributes[kCIAttributeFilterDisplayName];
    cell.titleLbl.text = filterDisplayName;
    
    ImageFiltration *imgfil = self.filtrationOperationsDict[indexPath];
    if (imgfil == nil) {
      [cell.loadingView startAnimating];
      cell.imgView.image = nil;
      
      PhotoRecord *pr = [PhotoRecord new];
      pr.inImg = self.inImg;
      pr.bgImg = self.bgImg;
      pr.filterName = self.filterNames[indexPath.row];
      
      ImageFiltration *imgfil = [[ImageFiltration alloc] initWithPhotoRecord:pr];
      imgfil.completionBlock = ^{
        if (imgfil.cancelled == YES) {
          return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
          [collectionView reloadItemsAtIndexPaths:@[indexPath]];
        });
      };
      self.filtrationOperationsDict[indexPath] = imgfil;
      [self.filtrationQueue addOperation:imgfil];
    }
    else {
      UIImage *outImg = imgfil.photoRecord.outImg;
      if (outImg == nil) {
        [cell.loadingView startAnimating];
        cell.imgView.image = nil;
      }
      else {
        [cell.loadingView stopAnimating];
        cell.imgView.image = outImg;
      }
    }
    
    cell.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    cell.layer.borderWidth = 1;
    cell.layer.masksToBounds = YES;
    return cell;
  }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  if (collectionView.tag == 1) {
    return CGSizeMake(CGRectGetHeight(collectionView.frame), CGRectGetHeight(collectionView.frame));
  }
  else {
    return CGSizeMake(CGRectGetWidth(collectionView.frame)/3, CGRectGetWidth(collectionView.frame)/3);
  }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
  return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  // Templates
  if (collectionView.tag == 1) {
    if (indexPath.section == 0) {
      self.imgPC.view.tag = 0;
      [self presentViewController:self.imgPC animated:YES completion:nil];
    }
    else {
      self.bgImg = self.templates[indexPath.row];
      [self preprocessInputImage];
      [self preprocessBgImage];
      [self cancelAndResetAllFilterOperations];
      
      self.selectedTemplateIndexPath = indexPath;
      [collectionView reloadData];
    }
  }
  // Modes
  else {
    ImageFiltration *imgfil = self.filtrationOperationsDict[indexPath];
    if (imgfil != nil) {
      self.imgView.image = imgfil.photoRecord.outImg;
    }
  }
}

#pragma mark - Image Picker Controller Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
  UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
  
  // Template picker
  if (picker.view.tag == 0) {
    self.bgImg = img;
    [self preprocessInputImage];
    [self preprocessBgImage];
    [self cancelAndResetAllFilterOperations];
    
    NSIndexPath *newBgIndexPath = [NSIndexPath indexPathForRow:self.templates.count inSection:1];
    self.selectedTemplateIndexPath = newBgIndexPath;
    [self.templates addObject:img];
    [self.templatesCV insertItemsAtIndexPaths:@[newBgIndexPath]];
    [self.templatesCV selectItemAtIndexPath:newBgIndexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
  }
  // Input image picker
  else {
    self.inImg = img;
    [self preprocessInputImage];
    [self preprocessBgImage];
    self.imgView.image = self.inImg;
    [self cancelAndResetAllFilterOperations];
  }
  
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
