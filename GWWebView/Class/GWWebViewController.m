//
//  GWWebViewController.m
//  GWWebView
//
//  Created by 115 on 13-12-30.
//  Copyright (c) 2013年 xiaoye. All rights reserved.
//

#import "GWWebViewController.h"
@interface GWWebViewController()

@end
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
     "field[0].submit();"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [_webView stringByEvaluatingJavaScriptFromString:@"myFunction1();"];

}

- (void)onDetails:(NSButton *)sender{
    
}


//- (NSURLRequest *)webView:(WebView *)webView resource:(id)identifier willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse fromDataSource:(WebDataSource *)dataSource {
//    NSLog(@"%@", request);
//    return request;
//}

#pragma mark - webkit 方法用于js 回调oc方法
//用于js调用oc方法时判断
+ (BOOL)isSelectorExcludedFromWebScript:(SEL)selector {
//    if (selector == @selector(doOutputToLog:)
//        || selector == @selector(changeJavaScriptText:)
//        || selector == @selector(reportSharedValue)) {
//        return NO;
//    }
    return YES;
}
//用于js调用oc属性时判断
+ (BOOL)isKeyExcludedFromWebScript:(const char *)property {
	NSLog(@"%@ received %@ for '%s'", self, NSStringFromSelector(_cmd), property);
	if (strcmp(property, "sharedValue") == 0) {
        return NO;
    }
    return YES;
}
//绑定oc方法与js调用oc对象方法名
+ (NSString *) webScriptNameForSelector:(SEL)sel {
//    if (sel == @selector(doOutputToLog:)) {
		return @"log";
//    } else if (sel == @selector(changeJavaScriptText:)) {
		return @"setscript";
//	} else {
		return nil;
//	}
}


//webview load成后 才可以调用 js
- (void)webView:(WebView *)webView windowScriptObjectAvailable:(WebScriptObject *)windowScriptObject {
	NSLog(@"%@ received %@", self, NSStringFromSelector(_cmd));
    
    /* here we'll add our object to the window object as an object named
     'console'.  We can use this object in JavaScript by referencing the 'console'
     property of the 'window' object.   */
    [windowScriptObject setValue:self forKey:@"console"];
    
}

/* sent to the WebView's ui delegate when alert() is called in JavaScript.
 If you call alert() in your JavaScript methods, it will call this
 method and display the alert message in the log.  In Safari, this method
 displays an alert that presents the message to the user.
 */
- (void)webView:(WebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message {
	NSLog(@"%@ received %@ with '%@'", self, NSStringFromSelector(_cmd), message);
}

#pragma mark - js调用 oc方法
- (void)nextpage:(NSString *)urlString{
    if (urlString && urlString.length >0) {
        [[_webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
        [self performSelector:@selector(onFinder:) withObject:nil afterDelay:2];
    }
}

@end
