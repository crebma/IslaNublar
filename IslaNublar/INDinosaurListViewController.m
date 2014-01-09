//
//  INDinosaurListViewController.m
//  IslaNublar
//
//  Created by Amber Conville on 1/6/14.
//  Copyright (c) 2014 crebma. All rights reserved.
//

#import "INDinosaurListViewController.h"
#import "AFJSONRequestOperation.h"
#import "INDinosaurViewController.h"

@interface INDinosaurListViewController ()

@property(nonatomic, strong) NSArray *dinosaurs;

@end

@implementation INDinosaurListViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://dino-lister.firebaseio.com/.json"]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                self.dinosaurs = JSON;
                                [self.tableView reloadData];
                            }];
                        }
                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"noes!"
                                                                                    message:[error localizedDescription]
                                                                                   delegate:nil
                                                                          cancelButtonTitle:@"ok :'("
                                                                          otherButtonTitles:nil];
                                [alertView show];
                            }];
                        }];
    [operation start];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dinosaurs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    [self setTextForCell:cell atIndexPath:indexPath];

    return cell;
}

- (void)setTextForCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [cell.textLabel setText:[[self.dinosaurs objectAtIndex:indexPath.row] valueForKey:@"name"]];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://dino-lister.firebaseio.com/%d.json", indexPath.row]]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        INDinosaurViewController *controller = [[INDinosaurViewController alloc] initWithDinosaur:JSON];
                                                        [self.navigationController pushViewController:controller animated:YES];
                                                    }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"noes!"
                                                                                                            message:[error localizedDescription]
                                                                                                           delegate:nil
                                                                                                  cancelButtonTitle:@"ok :'("
                                                                                                  otherButtonTitles:nil];
                                                        [alertView show];
                                                    }];

    [operation start];
}

@end
