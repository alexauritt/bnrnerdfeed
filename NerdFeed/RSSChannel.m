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

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
  // if we were in an element that we were collcting the string for,
  // this appropriately releases our hold on it and the permanent ivar keeps
  // ownership of it. If we weren't parsing such an element, currentString
  // is nil already.
  currentString = nil;
  
  if ([elementName isEqual:@"channel"])
    [parser setDelegate:parentParserDelegate];  
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
  NSLog(@"\t%@ found a %@ element", self, elementName);
  if ([elementName isEqual:@"title"]) {
    currentString = [[NSMutableString alloc] init];
    [self setTitle:currentString];
  }
  else if ([elementName isEqual:@"description"]) {
    currentString = [[NSMutableString alloc] init];
    [self setInfoString:currentString];
  }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
  [currentString appendString:string];
}
@end
