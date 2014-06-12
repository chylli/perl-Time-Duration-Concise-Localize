package Time::Duration::Concise::Localize;

use 5.006;
use strict;
use warnings FATAL => 'all';

use Moo;
extends 'Time::Duration::Concise';

use Data::Dumper;
use Module::Runtime;

our $VERSION = '0.01';

=head1 NAME

Time::Duration::Concise::Localize is an approach to localize concise time druation string representation.

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

    use Time::Duration::Concise::Localize;

    my $duration = Time::Duration::Concise::Localize->new(
        'interval' => '1.5h',
        'localize_class' => 'My::i18N',
        'localize_method => sub {
            # Your custom localization method
            # Two parameters will be supplied
	    # $_[0] ---> value
	    # $_[1] ---> unit
            return your_loalize_method( $_[0], $_[1] );
         }
    );

    $duration->as_string;

=head1 FIELDS

=head2 interval (REQUIRED)

concise interval string

=head2 localize_class (REQUIRED)

your custom localization class name

=head2 localize_method (REQUIRED)

your custom localization anonymous method call

default paramenters to your class methods would be $val, $unit

=cut

has 'localize_class' => (
    is => 'rw',
    required => 1
);

has 'localize_method' => (
    is => 'rw',
    required => 1
);

=head1 METHODS

=head2 as_string

Localized duration string

=cut

sub as_string {
    my ( $self ) = @_;

    Module::Runtime::require_module( $self->localize_class );

    my $localize_method = $self->localize_method;
    my @duration_translated;
    foreach my $duration ( @{$self->duration_array()} ){
        push(
            @duration_translated,
            &$localize_method( $duration->{'value'}, $duration->{'unit'} )
        );
    }
    return join(', ', @duration_translated);
}

=head2 entry_code

A code suitable for displaying to the client to select individually.  The largest available integral unit.

=cut

sub entry_code {
    my ( $self ) = @_;

    my %length_to_period = %Time::Duration::Concise::LENGTH_TO_PERIOD;
    my @keys = sort { $b <=> $a } keys %length_to_period;

    my $entry_code = '0s';
    while ($entry_code eq '0s' and my $period_length = shift @keys) {
        if (not $self->seconds % $period_length) {
            my $period_size = $self->seconds / $period_length;
            $entry_code = $period_size . substr($length_to_period{$period_length}, 0, 1);
        }
    }
    return $entry_code;
}

=head1 AUTHOR

Binary.com, C<< <perl at binary.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-time-duration-concise-localize at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Time-Duration-Concise-Localize>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Time::Duration::Concise::Localize


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Time-Duration-Concise-Localize>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Time-Duration-Concise-Localize>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Time-Duration-Concise-Localize>

=item * Search CPAN

L<http://search.cpan.org/dist/Time-Duration-Concise-Localize/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2014 Binary.com.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of Time::Duration::Concise::Localize
