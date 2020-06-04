//
//  DocVC.m
//  CoreImageFilters
//
//  Created by Quang Tran on 3/19/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "DocVC.h"

@interface DocVC ()<UIWebViewDelegate>

@end

@implementation DocVC {
  UIWebView *webView;
  UIActivityIndicatorView *loadingView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.edgesForExtendedLayout = UIRectEdgeNone;
  
  UIBarButtonItem *closeBBI = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView:)];
  self.navigationItem.rightBarButtonItem = closeBBI;
  
  webView = [[UIWebView alloc] init];
  webView.delegate = self;
  webView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:webView];
  [[webView.topAnchor constraintEqualToAnchor:self.view.topAnchor] setActive:true];
  [[webView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor] setActive:true];
  [[webView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor] setActive:true];
  [[webView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor] setActive:true];
  [webView loadRequest:[NSURLRequest requestWithURL:self.docURL]];
  
  loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  loadingView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:loadingView];
  [[loadingView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor] setActive:YES];
  [[loadingView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor] setActive:YES];
  [loadingView startAnimating];
}

-(void)dismissView: (UIBarButtonItem *)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  [loadingView stopAnimating];
}

@end
