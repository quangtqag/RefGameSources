//
//  CategoryTVC.m
//  CoreImageFilters
//
//  Created by Quang Tran on 3/19/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "CategoryTVC.h"
#import "FilterTVC.h"

@interface CategoryTVC ()
@property(nonatomic, strong) NSArray* categories;
@end

@implementation CategoryTVC

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
  
  self.categories = @[kCICategoryBlur,
                      kCICategoryColorAdjustment,
                      kCICategoryColorEffect,
                      kCICategoryCompositeOperation,
                      kCICategoryDistortionEffect,
                      kCICategoryGenerator,
                      kCICategoryGeometryAdjustment,
                      kCICategoryGradient,
                      kCICategoryHalftoneEffect,
                      kCICategoryReduction,
                      kCICategorySharpen,
                      kCICategoryStylize,
                      kCICategoryTileEffect,
                      kCICategoryTransition];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
  cell.textLabel.text = self.categories[indexPath.row];
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  FilterTVC *filterTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FilterTVC"];
  filterTVC.category = self.categories[indexPath.row];
  [self showViewController:filterTVC sender:self];
}

@end
