
; package basis
; use base 'base'
; use Sub::Uplevel

; our $VERSION = '0.01'

; sub import
    { shift()
	; my @basis=@_
	; my $return = uplevel(1,\&base::import,'base',@basis)
	; foreach ( @basis )
	    { my $import = $_->can('import') 
		; uplevel( 1, $import , $_ ) if $import 
		}
	; $return
	}

; 1

__END__

=head1 NAME

basis - use base with import call

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

Similar to base:
    
    package Baz;
    use basis qw/Foo bal/;
	
=head1 DESCRIPTION

It uses Sub::Uplevel to do the construct

  BEGIN {
	  use base qw/Foo bal/;
	  Foo->import;
	  bal->import;
  };

or the other way around

   use base qw/Foo bal/;
   use Foo; use bal;
   

transparently for the parent and child class.
	
=head1 IMPORTANT NOTE

The call of Sub::Uplevel might come to late, so the uplevel call will not work
If you use this module, the same rule as for Sub::Uplevel applies:

Use Sub::Uplevel as early as possible in your program.
	
=head1 AUTHOR

Sebastian Knapp, C<< <sk at computer-leipzig.com> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-basis at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=basis>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 ACKNOWLEDGEMENTS

Thank you Michael G. Schwern for base and Sub::Uplevel. I hope this tiny 
addon finds your blessing. Thank David A Golden for maintenance	of Sub::Uplevel.
	
=head1 SEE ALSO

L<Sub::Uplevel>
L<base>

=head1 COPYRIGHT & LICENSE

Copyright 2006 Computer-Leipzig, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

