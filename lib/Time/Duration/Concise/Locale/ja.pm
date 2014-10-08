package Time::Duration::Concise::Locale::ja;

use 5.006;
use strict;
use warnings FATAL => 'all';

our $VERSION = '0.1';

=head1 NAME

Time::Duration::Concise::Locale::ja - Japanese locale translation.

=head1 DESCRIPTION

Time::Duration::Concise uses Time::Duration::Concise::Locale::ja to localize concise time duration string representation.

=head1 VERSION

Version 0.1

=head1 METHODS

=head2 translation

Localized translation hash

=cut

sub translation {
    my ( $self ) = @_;
    return {
	'second'  => '秒', 
	'seconds' => '秒',
	'minute'  => '分',
	'minutes' => '分',
	'hour'    => '時間',
	'hours'   => '時間',
    'day'     => '日',
	'days'    => '日',
	'month'   => '月',
	'months'  => 'ヶ月',
	'year'    => '年',
    };
}

=head1 AUTHOR

Binary.com, C<< <perl at binary.com> >>

=cut

1;    # End of Time::Duration::Concise::Locale::ja
