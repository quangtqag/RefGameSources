//
//  ViewController.m
//  CoreImageFilters
//
//  Created by Quang Tran on 3/18/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "FilterTVC.h"
#import "OneImageVC.h"

@interface FilterTVC ()

@end

@implementation FilterTVC {
  NSArray *filters;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = self.category;
  
  filters = [CIFilter filterNamesInCategory:self.category];
  self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return filters.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  NSString *filterName = filters[indexPath.row];
  cell.textLabel.text = filterName;
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *filterName = filters[indexPath.row];
  OneImageVC *vc = [[OneImageVC alloc] init];
  vc.filterName = filterName;
//  [self showViewController:vc sender:self];
  [self presentViewController:vc animated:YES completion:nil];
  
}

@end
