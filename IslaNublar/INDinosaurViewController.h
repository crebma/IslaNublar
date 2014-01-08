//
//  INDinosaurViewController.h
//  IslaNublar
//
//  Created by Amber Conville on 1/8/14.
//  Copyright (c) 2014 crebma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface INDinosaurViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UILabel *status;

- (id)initWithDinosaur:(NSDictionary *)dinosaur;

@end
