use strict;
use warnings;

use Test::More qw{ no_plan };

BEGIN{
	use_ok( q{For::Else} );
}

{
	my $test = q{empty foreach};

	my $undef;

	foreach ( () )
	{
		$undef++;
	}

	is( $undef, undef, $test );
}

{
	my $test = q{empty foreach with local variable};

	my $undef;

	foreach my $item ( () )
	{
		$undef++;
	}

	is( $undef, undef, $test );
}

{
	my $test = q{empty for};

	my $undef;

	for ( () )
	{
		$undef++;
	}

	is( $undef, undef, $test );
}

{
	my $test = q{empty for with local variable};

	my $undef;

	for my $item ( () )
	{
		$undef++;
	}

	is( $undef, undef, $test );
}

{
	my $test = q{empty foreach with else};

	my $undef = 1;

	foreach ( () )
	{
		$undef++;
	}
	else
	{
		$undef = undef;
	}

	is( $undef, undef, $test );
}

{
	my $test = q{empty foreach with else and local variable};

	my $undef = 1;

	foreach my $item ( () )
	{
		$undef++;
	}
	else
	{
		$undef = undef;
	}

	is( $undef, undef, $test );
}

{
	my $test = q{empty for with else};

	my $undef = 1;

	for ( () )
	{
		$undef++;
	}
	else
	{
		$undef = undef;
	}

	is( $undef, undef, $test );
}

{
	my $test = q{empty for with else and local variable};

	my $undef = 1;

	for my $item ( () )
	{
		$undef++;
	}
	else
	{
		$undef = undef;
	}

	is( $undef, undef, $test );
}

{
	my $test = q{non-empty foreach};

	my $undef = 1;

	my @items = 1..5;

	foreach ( @items )
	{
		$undef = undef;
	}

	is( $undef, undef, $test );
}

{
	my $test = q{non-empty foreach with local variable};

	my $undef = 1;

	my @items = 1..5;
	
	foreach my $item ( @items )
	{
		$undef = undef;
	}

	is( $undef, undef, $test );
}

{
	my $test = q{non-empty for};

	my $undef = 1;

	my @items = 1..5;

	for ( @items )
	{
		$undef = undef;
	}

	is( $undef, undef, $test );
}

{
	my $test = q{non-empty for with local variable};

	my $undef = 1;

	my @items = 1..5;
	
	for my $item ( @items )
	{
		$undef = undef;
	}

	is( $undef, undef, $test );
}

{
	my $test = q{non-empty foreach with else};

	my $undef = 1;

	my @items = 1 .. 5;
	
	foreach ( @items )
	{
		$undef = undef;
	}
	else
	{
		$undef++;
	}

	is( $undef, undef, $test );
}

{
	my $test = q{non-empty foreach with else and local variable};

	my $undef = 1;

	my @items = 1..5;
	
	foreach my $item ( @items )
	{
		$undef = undef;
	}
	else
	{
		$undef++;
	}

	is( $undef, undef, $test );
}

{
	my $test = q{non-empty for with else};

	my $undef = 1;

	my @items = 1..5;
	
	for ( @items )
	{
		$undef = undef;
	}
	else
	{
		$undef++;
	}

	is( $undef, undef, $test );
}

{
	my $test = q{non-empty for with else and local variable};

	my $undef = 1;

	my @items = 1..5;
	
	for my $item ( @items )
	{
		$undef = undef;
	}
	else
	{
		$undef++;
	}

	is( $undef, undef, $test );
}

# simple recursion

{
	my $test = q{simple recursion within foreach};

	my $undef = 1;

	my @items = 1..5;
	
	foreach my $item ( @items )
	{
		my @more_items = 1..5;
		
		foreach my $item ( @more_items )
		{
			$undef = undef;
		}
		else
		{
			$undef++;
		}
	}
	else
	{
		$undef++;
	}

	is( $undef, undef, $test );
}

{
	my $test = q{simple recursion within else};

	my $undef = 1;
	
	foreach my $item ( () )
	{
		$undef++;
	}
	else
	{
		my @items = 1..5;

		foreach my $item ( @items )
		{
			$undef = undef;
		}
		else
		{
			$undef++;
		}
	}

	is( $undef, undef, $test );
}

{
	my $test = q{deep recursion};

	my $undef = 1;

	foreach my $item ( () )
	{
		$undef++;
	}
	else
	{
		$undef++;

		if ( 1 )
		{
			my @items = 1..5;
			
			foreach ( @items )
			{
				if ( 1 )
				{
					if ( 0 )
					{
						$undef++;
					}
					else
					{
						foreach ( () )
						{
							$undef++;
						}
						else
						{
							$undef++;

							my @more_items = 1..5;

							foreach my $item ( @more_items )
							{
								if ( 0 )
								{
									$undef++;
								}
								else
								{
									$undef = undef;
								}
							}
							else
							{
								$undef++;
							}
						}
					}
				}
				else
				{
					$undef++;
				}
			}
			else
			{
				$undef++;
			}
		}
	}

	is( $undef, undef, $test );
}
