package Apache::DirXML;

require 5.005_62;
use strict;
use warnings;
use XML::Directory;
use Apache::Constants qw(:common );

our $VERSION = '0.10';


sub handler {
    my $r = shift;
    my %query = $r->args;
    my $path;
    my $dets = 2;
    my $depth = 1000;
    my $ret;

    $dets = $query{dets} if $query{dets};
    $depth = $query{depth} if $query{depth};

    if ($query{path}) {

	my $dir = new XML::Directory($query{path},$dets,$depth);
	my $rc  = $dir->parse;
	$ret = $dir->get_string;

    } else {

	$ret .= "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
	$ret .= "<dirtree>\n";
	$ret .= "<error number=\"100\">Path not defined!</error>\n";
	$ret .= "</dirtree>\n";
    }

    $r->status(OK);
    $r->content_type("text/xml");
    $r->no_cache(1);
    $r->send_http_header();
    $r->print($ret);

    return OK;
}

1;

__END__

=head1 NAME

Apache::DirXML - mod_perl wrapper over XML::Directory

=head1 SYNOPSIS

 <Location /xdir>
     SetHandler perl-script
     PerlHandler Apache::DirXML
     PerlSendHeader On
 </Location>

 http://hostname/xdir?p=<path>

=head1 DESCRIPTION

This is a mod_perl module that serves as Apache interface to
XML::Directory. It allows to send parameters in http request and
receive a result (XML representation of a directory tree) in http
response.

Parameters include:

=over

=item path

absolute path to a directory to be parsed, mandatory

=item dets

level of details - see XML::Directory documetation for details, optional

=item depth

maximal number of nested sub-directories - see XML::Directory documetation 
for details, optional

Note: The directory specified by the path parameter is not protected by
Apache access rules. Rights to use this handler should be determined inside
the <Location> directive and rights to see content of particular directories
should be handled on system level.

=back

=head1 VERSION

Current version is 0.51.

=head1 LICENSING

Copyright (c) 2001 Ginger Alliance. All rights reserved. This program is free 
software; you can redistribute it and/or modify it under the same terms as 
Perl itself. 

=head1 AUTHOR

Petr Cimprich, petr@gingerall.cz

=head1 SEE ALSO

XML::Directory, perl(1).

=cut
