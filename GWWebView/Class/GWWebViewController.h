//
//  GWWebViewController.h
//  GWWebView
//
//  Created by 115 on 13-12-30.
//  Copyright (c) 2013年 xiaoye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface GWWebViewController : NSObject
@property (weak) IBOutlet WebView *webView;
@property (weak) IBOutlet NSButton *sourchBtn;//搜索
@property (weak) IBOutlet NSButton *finderBtn;//检索宝贝
@property (weak) IBOutlet NSButton *nextBtn;//翻页
@property (weak) IBOutlet NSButton *detailsBtn;//进入宝贝详情
@property (weak) IBOutlet NSButton *collectBtn;//收藏宝贝
@property (weak) IBOutlet NSButton *shopBtn;//进入店铺
//@property (weak) IBOutlet NSButton *collectShopBtn;//收藏店铺

@end
