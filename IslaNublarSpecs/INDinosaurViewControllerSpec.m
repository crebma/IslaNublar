//
// Created by amber on 1/9/14.
//

#import "Kiwi.h"
#import "INDinosaurViewController.h"

@interface INDinosaurViewController ()

@property(nonatomic, strong) NSDictionary *dinosaur;

@end

SPEC_BEGIN(INDinosaurViewControllerSpec)

describe(@"INDinosaurViewController", ^{

    it(@"sets the name on the label!", ^{
        NSString *dinoName = @"the dinosaur with the most awesome pants";
        INDinosaurViewController *controller = [[INDinosaurViewController alloc] init];
        controller.dinosaur = @{
                            @"name": dinoName,
                            @"description": @"his pants are very fancy",
                            @"status": @"obviously awesome",
                            @"picture": @"a picture goes here"
                    };
        UILabel *nameLabel = [UILabel nullMock];
        [controller stub:@selector(name) andReturn:nameLabel];

        [[nameLabel should] receive:@selector(setText:) withArguments:dinoName];

        [controller viewDidAppear:YES];
    });

});

SPEC_END
