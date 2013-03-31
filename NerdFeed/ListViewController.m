//
//  ListViewController.m
//  NerdFeed
//
//  Created by Alexander Auritt on 3/26/13.
//  Copyright (c) 2013 Alexander Auritt. All rights reserved.
//

#import "ListViewController.h"
#import "RSSChannel.h"
#import "RSSItem.h"
#import "WebViewController.h"

@implementation ListViewController
@synthesize webViewController;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [[channel items] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
  }
  RSSItem *item = [[channel items] objectAtIndex:[indexPath row]];
  [[cell textLabel] setText:[item title]];
  
  return cell;
}

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    [self fetchEntries];
  }
  return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [[self navigationController] pushViewController:webViewController animated:YES];
  
  RSSItem *entry = [[channel items] objectAtIndex:[indexPath row]];
  NSURL *url = [NSURL URLWithString:[entry link]];
  NSURLRequest *req = [NSURLRequest requestWithURL:url];
  [[webViewController webView] loadRequest:req];
  [[webViewController navigationItem] setTitle:[entry title]];
}

- (void)fetchEntries
{
  xmlData = [[NSMutableData alloc] init];
//  NSURL *url = [NSURL URLWithString:
//    @"http://forums.bignerdranch.com/smartfeed.php?"
//    @"limit=1_DAY&sort_by=standard&feed_type=RSS2.0&feed_style=COMPACT"];
  
  NSURL *url = [NSURL URLWithString:@"http://www.apple.com/pr/feeds/pr.rss"];
  
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
  NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
  [parser setDelegate:self];
  [parser parse];
  xmlData = nil;
  connection = nil;
  [[self tableView] reloadData];
  
//  NSLog(@"%@\n %@\n %@\n", channel, [channel title], [channel infoString]);
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{

  if ([elementName isEqual:@"channel"]) {
//    NSLog(@"%@ found a %@ element here in LVC", self, elementName);
    channel = [[RSSChannel alloc] init];
    [channel setParentParserDelegate:self];
    [parser setDelegate:channel];
  }
}
@end
