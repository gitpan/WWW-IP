use strict;
use warnings;
package WWW::IP;
$WWW::IP::VERSION = '0.01';
use HTTP::Tiny;
use 5.008;
use WWW::hmaip ();
use WWW::curlmyip ();
use WWW::ipinfo ();
use Try::Tiny;

# ABSTRACT: Returns your ip address with failsafe mechanism


BEGIN {
    require Exporter;
    use base 'Exporter';
    our @EXPORT = 'get_ip';
    our @EXPORT_OK = ();
}


sub get_ip {
    try {
        WWW::curlmyip::get_ip();
    } catch {
        try {
            WWW::hmaip::get_ip();
        } catch {
            try {
                WWW::ipinfo::get_ipinfo->{ip};
            }
            catch {
                die $_;
            }
        }
    };
}


1;

__END__

=pod

=encoding UTF-8

=head1 NAME

WWW::IP - Returns your ip address with failsafe mechanism

=head1 VERSION

version 0.01

=head1 SYNOPSIS

    use WWW::IP;

    my $ip = get_ip(); # 54.123.84.6

=head1 EXPORTS

Exports the C<get_ip> function.

=head1 FUNCTIONS

=head2 get_ip

Returns your ip address. Will try a number of services in succession should the 

    use WWW::IP;

    my $ip = get_ip();

=head1 SEE ALSO

These modules are used by WWW::IP:

=over

=item *

L<WWW::curlmyip> - another module that returns your ip address

=item *

L<WWW::ipinfo> - a module that returns ip address and geolocation data

=item *

L<WWW::hmaip> - another module that returns your ip address

=back

=head1 AUTHOR

David Farrell <sillymoos@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by David Farrell.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
