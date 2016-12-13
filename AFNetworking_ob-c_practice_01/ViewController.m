//
//  ViewController.m
//  AFNetworking_ob-c_practice_01
//
//  Created by yuichi.watanabe on 2016/12/13.
//  Copyright © 2016年 yuuichi.watanabe. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// ----------------------------------------------------------------





// ----------------------------------------------------------------


//AFHTTPRequestOperationManager ...NSURLConnectionがベース
//AFHTTPSessionManager          ...NSURLSessionがベース
// 3.0では、NSURLConnectionがベースのコードが全て削除されている
// NSURLSessionは、iOS7以降であれば使える
// NSURLSession をラッピングしてる。
// AFURLSessionManager、         ...APIサーバからjsonを取得するような処理に
// AFHTTPSessionManager がある     ...アップロード/ダウンロード

- (void) callGetRequest
{
    // こんな書き方は、使えなくなった
    //AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    //[manager GET:@"http://hoge/sample.json"
    //  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //      NSLog(@"response: %@", responseObject);
    //  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //      NSLog(@"Error: %@", error);
    //  }];
    
    NSString                * url       = @"http://api.example.com/v1/article/123";
    AFHTTPSessionManager    * manager   = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        // json取得に成功した場合の処理
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        // エラーの場合の処理
    }
];
    
}



- (void) callPostRequest
{
    // こんな書き方は、使えなくなった
    //AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    //NSDictionary* param = @{@"param1" : @"value1", @"param2" : @"value2"};
    //[manager POST:@"http://hoge/sample.json" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //    NSLog(@"response: %@", responseObject);
    //} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //    NSLog(@"Error: %@", error);
    //}];
    
    NSDictionary            *json    = @{@"age":@25,@"name":@"Taro"};
    NSString                *url     = @"http://api.example.com/v1/CreateArticle";
    AFHTTPSessionManager    *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer]; // JSON形式で送りたい場合の一行
    [manager POST:url parameters:json progress:nil  success:^(NSURLSessionTask *task, id responseObject) {  // GETがPOSTに paramatersがnilからjsonに変わった
            // POSTに成功した場合の処理
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            // エラーの場合の処理
        }
    ];
}


// 分割して送る時 (パケット)
- (void) callPostMultiPartRequest
{
    NSString                *url        = @"http://api.example.com/v1/upload";
    NSDictionary            *parameters = @{@"key": @"value"};
    NSURL                   *filePath   = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    AFHTTPSessionManager    *manager    = [AFHTTPSessionManager manager];
 
    [manager POST:url parameters:parameters
        constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileURL:filePath name:@"image" error:nil];
        }
        success:^(NSURLSessionTask *task, id responseObject) {
            // POSTに成功した場合の処理
        }
        failure:^(NSURLSessionTask *task, NSError *error) {
            // エラーの場合の処理
        }
    ];
}


















@end
