//
//  ListViewController.m
//  NerdFeed
//
//  Created by Alexander Auritt on 3/26/13.
//  Copyright (c) 2013 Alexander Auritt. All rights reserved.
//

#import "ListViewController.h"
#import "RSSChannel.h"

@implementation ListViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return nil;
}

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    [self fetchEntries];
  }
  return self;
}

- (void)fetchEntries
{
  xmlData = [[NSMutableData alloc] init];
  NSURL *url = [NSURL URLWithString:
    @"http://forums.bignerdranch.com/smartfeed.php?"
    @"limit=1_DAY&sort_by=standard&feed_type=RSS2.0&feed_style=COMPACT"];
  
//  NSURL *url = [NSURL URLWithString:@"http://www.apple.com/pr/feeds/pr.rss"];
  
  NSURLRequest *req = [NSURLRequest requestWithURL:url];
  connection = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
}

- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
  [xmlData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
  connection = nil;
  xmlData = nil;
  NSString *errorString = [NSString stringWithFormat:@"Fetch failed: %@", [error localizedDescription]];
  UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error"
                                               message:errorString
                                              delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
  [av show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
//  NSString *xmlCheck = [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
//  NSLog(@"xmlCheck = %@", xmlCheck);
  NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
  [parser setDelegate:self];
  [parser parse];
  xmlData = nil;
  connection = nil;
  [[self tableView] reloadData];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
  NSLog(@"%@ found a %@ element", self, elementName);
  if ([elementName isEqual:@"channe"]) {
    channel = [[RSSChannel alloc] init];
    [channel setParentParserDelegate:self];
    [parser setDelegate:channel];
  }
}
@end
