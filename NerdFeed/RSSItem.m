//
//  RSSItem.m
//  NerdFeed
//
//  Created by Alexander Auritt on 3/27/13.
//  Copyright (c) 2013 Alexander Auritt. All rights reserved.
//

#import "RSSItem.h"

@implementation RSSItem
@synthesize title, link, parentParserDelegate;

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
  NSLog(@"\t\t@ found a %@", self, elementName);
  
  if ([elementName isEqual:@"title"]) {
    currentString = [[NSMutableString alloc] init];
    [self setTitle:currentString];
  }
  else if ([elementName isEqual:@"link"]) {
    currentString = [[NSMutableString alloc] init];
    [self setLink:currentString];
  }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
  [currentString appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
  currentString = nil;
  if ([elementName isEqual:@"item"]) {
    [parser setDelegate:parentParserDelegate];
  }
}
@end
