//
// Created by amber on 1/9/14.
//

#import "Kiwi.h"
#import "INDinosaurListViewController.h"

@interface INDinosaurListViewController (Spec)

@property(nonatomic, strong) NSArray *dinosaurs;

@end

SPEC_BEGIN(INDinosaurListViewControllerSpec)

describe(@"INDinosaurListViewController", ^{

    it(@"has 1 row in this extremely contrived example", ^{
        INDinosaurListViewController *controller = [[INDinosaurListViewController alloc] init];
        controller.dinosaurs = @[@{@"name": @"dinoface killah"}];

        NSInteger numberOfRows = [controller tableView:nil numberOfRowsInSection:0];

        [[theValue(numberOfRows) should] equal:theValue(800)];
    });

});

SPEC_END
