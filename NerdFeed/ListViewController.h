//
//  ListViewController.h
//  NerdFeed
//
//  Created by Alexander Auritt on 3/26/13.
//  Copyright (c) 2013 Alexander Auritt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListViewController : UITableViewController
{
  NSURLConnection *connection;
  NSMutableData *xmlData;
}

- (void)fetchEntries;

@end


