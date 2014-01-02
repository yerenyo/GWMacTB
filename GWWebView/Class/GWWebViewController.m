//
//  GWWebViewController.m
//  GWWebView
//
//  Created by 115 on 13-12-30.
//  Copyright (c) 2013年 xiaoye. All rights reserved.
//

#import "GWWebViewController.h"

@implementation GWWebViewController
- (void)awakeFromNib{
    /* set ourself to the app's delegate so our
     applicationShouldTerminateAfterLastWindowClosed
     method will be called. */
	[NSApp setDelegate: self];
    [self initSubviews];
}


/* this NSApplication delegate method will allow our application
 to 'quit' when the user closes the main window.
 */
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
	return YES;  /* quit when main window is closed */
}

- (void)initSubviews{
    [_webView setFrameLoadDelegate:self];
	[_webView setUIDelegate: self];
	[_webView setResourceLoadDelegate: self];
	[[_webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.taobao.com"]]];
    [_sourchBtn setTarget:self];
    [_sourchBtn setAction:@selector(onSearch:)];
    [_finderBtn setTarget:self];
    [_finderBtn setAction:@selector(onFinder:)];
    [_nextBtn setTarget:self];
    [_nextBtn setAction:@selector(onNextPage:)];
    [_detailsBtn setTarget:self];
    [_detailsBtn setAction:@selector(onDetails:)];
}

- (void)onSearch:(NSButton *)sender{
    [_webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function myFunction() { "
     "var field = document.getElementsByName('q')[0];"
     "field.value='新款女装';"
     "document.forms[0].submit();"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [_webView stringByEvaluatingJavaScriptFromString:@"myFunction();"];
}
- (void)onFinder:(NSButton *)sender{

}

    
- (void)onNextPage:(NSButton *)sender{
    [_webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function myFunction1() { "
     "var field = document.getElementsByClassName('page-next');"
     "field.onclick();"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [_webView stringByEvaluatingJavaScriptFromString:@"myFunction1();"];

}

- (void)onDetails:(NSButton *)sender{
    
}


- (NSURLRequest *)webView:(WebView *)webView resource:(id)identifier willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse fromDataSource:(WebDataSource *)dataSource {
    NSLog(@"%@", request);
    return request;
}
@end
