//
// Created by amber on 1/9/14.
//

#import "Kiwi.h"
#import "INDinosaurListViewController.h"
#import "AFJSONRequestOperation.h"

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

    it(@"gets some jaysone from a service!", ^{
        AFJSONRequestOperation *operation = [AFJSONRequestOperation nullMock];
        [AFJSONRequestOperation stub:@selector(JSONRequestOperationWithRequest:success:failure:) andReturn:operation];

        [[operation should] receive:@selector(start)];

        [controller tableView:nil didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    });

    it(@"sets the dinosaurs when service call is successful", ^{
        AFJSONRequestOperation *operation = [AFJSONRequestOperation nullMock];
        [AFJSONRequestOperation stub:@selector(JSONRequestOperationWithRequest:success:failure:) andReturn:operation];
        KWCaptureSpy *successCaptor = [AFJSONRequestOperation captureArgument:@selector(JSONRequestOperationWithRequest:success:failure:) atIndex:1];

        [controller viewDidAppear:YES];

        void(^success)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) = successCaptor.argument;

        NSOperationQueue *queue = [NSOperationQueue nullMock];
        [NSOperationQueue stub:@selector(mainQueue) andReturn:queue];
        [queue stub:@selector(addOperationWithBlock:) withBlock:^id(NSArray *params) {
            void(^theBlock)() = [params objectAtIndex:0];
            theBlock();
            return nil;
        }];

        NSArray *newDinos = @[@{}, @{}];
        success(nil, nil, newDinos);

        [[controller.dinosaurs should] equal:newDinos];
    });

    it(@"sets the dinosaurs when service call is successful", ^{
        AFJSONRequestOperation *operation = [AFJSONRequestOperation nullMock];
        [AFJSONRequestOperation stub:@selector(JSONRequestOperationWithRequest:success:failure:) andReturn:operation];
        KWCaptureSpy *successCaptor = [AFJSONRequestOperation captureArgument:@selector(JSONRequestOperationWithRequest:success:failure:) atIndex:1];

        [controller viewDidAppear:YES];

        void(^success)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) = successCaptor.argument;
        NSArray *newDinos = @[@{}, @{}];
        success(nil, nil, newDinos);

        [[controller.dinosaurs shouldEventually] equal:newDinos];
    });

});

SPEC_END
