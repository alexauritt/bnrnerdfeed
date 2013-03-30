//
//  ListViewController.h
//  NerdFeed
//
//  Created by Alexander Auritt on 3/26/13.
//  Copyright (c) 2013 Alexander Auritt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebViewController.h"

@class RSSChannel;

@interface ListViewController : UITableViewController<NSXMLParserDelegate>
{
  NSURLConnection *connection;
  NSMutableData *xmlData;
  RSSChannel *channel;
}

@property (nonatomic, strong) WebViewController *webViewController;
- (void)fetchEntries;

@end


