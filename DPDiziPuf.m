#import "DPDiziPuf.h"

@implementation DPDiziPuf

@synthesize descriptionLabel = _descriptionLabel;
@synthesize titleLabel = _titleLabel;
@synthesize urlLabel = _urlLabel;
@synthesize myImageView = _myImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
		//self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 50, 300, 30)];
		self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
		self.descriptionLabel = [[UILabel alloc] init];
        self.descriptionLabel.textColor = [UIColor blackColor];
        self.descriptionLabel.font = [UIFont systemFontOfSize:14];
		self.urlLabel = [[UILabel alloc] init];
        self.urlLabel.textColor = [UIColor blackColor];
        self.urlLabel.font = [UIFont systemFontOfSize:14];
        self.myImageView = [[UIImageView alloc]init];
		[self.contentView  addSubview:self.urlLabel];
        [self.contentView  addSubview:self.titleLabel];		
        [self.contentView  addSubview:self.descriptionLabel];
		[self.contentView addSubview:self.myImageView];
    }
    return self;
}

- (void)layoutSubviews {

	[super layoutSubviews];
	CGRect contentRect = self.contentView.bounds;
	CGFloat boundsX = contentRect.origin.x;
	CGRect frame;
	frame= CGRectMake(boundsX+10 ,0, 50, 50);
	self.myImageView.frame = frame;
	frame= CGRectMake(boundsX+70 ,5, 300, 25);
	self.titleLabel.frame = frame;
	frame= CGRectMake(boundsX+70 ,30, 300, 15);
	self.descriptionLabel.frame = frame;
	frame = CGRectMake(boundsX+70,45,0,15);
	self.urlLabel.frame=frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

[super setSelected:selected animated:animated];

// Configure the view for the selected state

}

@end