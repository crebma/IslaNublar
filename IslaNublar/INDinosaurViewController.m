//
//  INDinosaurViewController.m
//  IslaNublar
//
//  Created by Amber Conville on 1/8/14.
//  Copyright (c) 2014 crebma. All rights reserved.
//

#import "INDinosaurViewController.h"
#import "AFImageRequestOperation.h"

@interface INDinosaurViewController ()

@property(nonatomic, strong) NSDictionary *dinosaur;

@end

@implementation INDinosaurViewController

- (id)initWithDinosaur:(NSDictionary *)dinosaur {
    self = [super initWithNibName:@"INDinosaurViewController" bundle:nil];
    if (self) {
        self.dinosaur = dinosaur;
        //800 other things you dont want to deal with right now
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.name.text = [self.dinosaur objectForKey:@"name"];
    self.description.text = [self.dinosaur objectForKey:@"description"];
    self.status.text = [self.dinosaur objectForKey:@"status"];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[self.dinosaur objectForKey:@"picture"]]];
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request
                                                      success:^(UIImage *image) {
                                                          self.picture.image = image;
                                                      }];
    [operation start];
}

@end
