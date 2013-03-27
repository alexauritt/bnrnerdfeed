//
//  RSSChannel.h
//  NerdFeed
//
//  Created by Alexander Auritt on 3/27/13.
//  Copyright (c) 2013 Alexander Auritt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSChannel : NSObject

@property (nonatomic, weak) id parentParserDelegate;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *infoString;
@property (nonatomic, readonly, strong) NSMutableArray *items;

@end
