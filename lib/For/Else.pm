package For::Else;

use strict;
use warnings;

our $VERSION = q{0.01};

use Filter::Simple;

use Text::Balanced qw{ 
	extract_codeblock
};

FILTER_ONLY
	'code' => sub {
		my $source = q{};

		while( s{ (.*?) ( for(?:each)? [^(]* [(] (.*?) [)] \s* ) }{}smx )
		{
			$source     .= $1;
			my $foreach  = $2;
			my $list     = $3;

			my @result = extract_codeblock();

			if ( $result[1] =~ m{ \A \s* else }smx )
			{
				$_ = qq{
					if ( $list )
					{
						$foreach $result[0]
					}
					$result[1]
				};

				next;
			}

			$source .= $foreach . $result[0];
			$_       = $result[1];
		}

		$_ =  $source . $_;
	};

1;

__END__

=head1 NAME

For::Else - Else blocks for foreach

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

	use For::Else;

	foreach my $item ( @items )
	{
		_do_something_with_item();
	}
	else
	{
		die "@items was empty";
	}

=head1 DESCRIPTION

We usually iterate over a list like the following:

	foreach my $item ( @items )
	{
		_do_something_with_item();
	}

However, a lot of the time I find myself needing to accomodate for the
exceptional case where the list is empty:

	if ( @items )
	{
		foreach my $item ( @items )
		{
			_do_something_with_item();
		}
	}
	else
	{
		die "@items was empty";
	}

Since we don't enter into a C<foreach> block when there are no items in the
list anyway, I find the C<if> to be rather redundant. Wouldn't it be nice to
get rid of it so we can do the following?

	foreach my $item ( @items )
	{
		_do_something_with_item();
	}
	else
	{
		die "@items was empty";
	}

Now you can!

=head1 DEPENDENCIES

L<Text::Balanced>

L<Filter::Simple>
	
=head1 BUGS / FEATURES

WARNING: Does not do recursive blocks yet!

Please report any bugs or features. Better yet, submit a patch :)

=head1 SEE ALSO

Fur::Elise by Ludwig van Beethoven

=head1 AUTHOR

Alfie John, C<alfie at hackfu.org>

=head1 COPYRIGHT AND LICENCE

Copyright (C) 2006 by Alfie John

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
