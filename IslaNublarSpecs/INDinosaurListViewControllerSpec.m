//
// Created by amber on 1/9/14.
//

#import "Kiwi.h"
#import "INDinosaurListViewController.h"

@interface INDinosaurListViewController (Spec)

@property(nonatomic, strong) NSArray *dinosaurs;

- (void)setTextForCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end

SPEC_BEGIN(INDinosaurListViewControllerSpec)

describe(@"INDinosaurListViewController", ^{

    __block INDinosaurListViewController *controller;

    beforeEach(^{
        controller = [[INDinosaurListViewController alloc] init];
    });

    it(@"has 1 row in this extremely contrived example", ^{
        controller.dinosaurs = @[@{@"name": @"dinoface killah"}];

        NSInteger numberOfRows = [controller tableView:nil numberOfRowsInSection:0];

        [[theValue(numberOfRows) should] equal:theValue(1)];
    });

    it(@"sets the cell's text to be the dino name", ^{
        NSString *dinoName = @"dinoface killah";
        controller.dinosaurs = @[@{@"name": dinoName}];
        UITableViewCell *cell = [UITableViewCell nullMock];
        UILabel *label = [UILabel nullMock];
        [cell stub:@selector(textLabel) andReturn:label];

        [[label should] receive:@selector(setText:) withArguments:dinoName];
        
        [controller setTextForCell:cell atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    });

});

SPEC_END
