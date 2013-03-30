//
//  WebViewController.m
//  NerdFeed
//
//  Created by Alexander Auritt on 3/30/13.
//  Copyright (c) 2013 Alexander Auritt. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

- (void)loadView
{
  CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
  UIWebView *wv = [[UIWebView alloc] initWithFrame:screenFrame];
  [wv setScalesPageToFit:YES];
  [self setView:wv];
}

- (UIWebView *)webView
{
  return (UIWebView *)[self view];
}


@end
