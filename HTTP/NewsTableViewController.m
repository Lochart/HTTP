//
//  NewsTableViewController.m
//  HTTP
//
//  Created by Nikolay on 10.03.16.
//  Copyright © 2016 Nikolay. All rights reserved.
//

#import "NewsTableViewController.h"
#import "RestApi.h"

@interface NewsTableViewController () <RectApiDelegate>
@property (nonatomic, strong) RestApi *restAPI;
@property (nonatomic, strong) NSMutableArray *webTitle;
@property (nonatomic, strong) NSMutableArray *sectionNames;
@end

@implementation NewsTableViewController

-(RestApi *)restAPI{
    if (!self.restAPI) {
        self.restAPI = [[RestApi alloc]init];
    }
    return self.restAPI;
}

-(NSMutableArray *)webTitle{
    if (!self.webTitle) {
        self.webTitle = [[NSMutableArray alloc]init];
    }
    return self.webTitle;
}

-(NSMutableArray *)sectionNames{
    if (!self.sectionNames) {
        self.sectionNames = [[NSMutableArray alloc]init];
    }
    return self.sectionNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self httpGetRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)httpGetRequest{
    NSString *str = @"http://content.guardianapis.com/search?api-key=test";
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:GET];
    self.restAPI.delegate = self;
    [self.restAPI httpRquest:request];
}

-(void)httpPostRequest{
    NSString *postBody = @"api-key=test";
    NSString *str = @"http://content.guardianapis.com/search";
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:POST];
    [request setHTTPBody:[postBody dataUsingEncoding:NSUTF8StringEncoding]];
    self.restAPI.delegate = self;
    [self.restAPI httpRquest:request];

}

-(void)getReceivedData:(NSMutableArray *)data sendar:(RestApi *)sendar{
    NSError *error = nil;
    NSDictionary *resceiveData = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:&error];
    NSDictionary *response = [[NSDictionary alloc] initWithDictionary:[resceiveData
                                                                       objectForKey:@"response"]];
    NSArray *results = [[NSArray alloc] initWithArray:[response
                                                       objectForKey:@"results"]];
    for (int i; i < results.count; i++) {
        NSDictionary *resultsItems = [results objectAtIndex:i];
        NSString *webTitle = [resultsItems objectForKey:@"webTitle"];
        [self.webTitle addObject:webTitle];
        NSString *sectionName = [resultsItems objectForKey:@"sectionName"];
        [self.sectionNames addObject:sectionName];
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.webTitle.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *Cell = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell
                                                            forIndexPath:indexPath];
    
    cell.textLabel.text = [self.webTitle objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.sectionNames objectAtIndex:indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
