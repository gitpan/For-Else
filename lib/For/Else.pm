package For::Else;

use strict;
use warnings;

our $VERSION = q{0.02};

use Filter::Simple;

# Recursive regexp first pointed out to me in Acme::Butfirst (see perlre for
# extended patterns ). Acme:: is a land^H^H^H^Hgold mine!

my $parens_block;

$parens_block = qr{
	[(]
		(?>
			[^()]+ | (??{ $parens_block })
		)*
	[)]
}smx;

my $code_block;

$code_block = qr{
	{
		(?>
			[^{}]+ | (??{ $code_block })
		)*
	}
}smx;

FILTER_ONLY
	'code' => sub {
		1 while
			s{
				( for(?:each)? [^(]* ($parens_block) \s*
					$code_block )                    \s*
				( else                               \s*
					$code_block )
			}{
				if $2
				{
					$1
				}
				$3
			}smx;
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

L<Filter::Simple>
	
=head1 BUGS / FEATURES

B<Note:> Does not interpolate void-contextual expressions yet e.g. ranges,
qw{}, etc.

Please report any bugs or features. Better yet, submit a patch :)

=head1 SEE ALSO

Fur::Elise by Ludwig van Beethoven

=head1 AUTHOR

Alfie John, C<alfie at hackfu.org>

=head1 COPYRIGHT AND LICENCE

Copyright (C) 2006 by Alfie John

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
