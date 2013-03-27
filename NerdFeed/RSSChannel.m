//
//  RSSChannel.m
//  NerdFeed
//
//  Created by Alexander Auritt on 3/27/13.
//  Copyright (c) 2013 Alexander Auritt. All rights reserved.
//

#import "RSSChannel.h"

@implementation RSSChannel
@synthesize items, title, infoString, parentParserDelegate;

- (id)init
{
  self = [super init];
  if (self) {
    items = [[NSMutableArray alloc] init];
  }
  return self;
}

@end
