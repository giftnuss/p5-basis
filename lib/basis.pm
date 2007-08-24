  package basis
; use base 'base'
; use Sub::Uplevel 0.12 # 0.9 does not, 0.10/0.11 ?

; our $VERSION = '0.04'

; sub import
    { shift()
    ; my @basis=@_

    # filter argument arrays
    ; my %args
    ; for ($i=0; $i<=$#basis; $i++)
        { if(ref $basis[$i+1] eq 'ARRAY')
	    { $args{$basis[$i]}=splice(@basis,$i+1,1)
	    }
	  else
	    { $args{$basis[$i]}=[]
	    }
	}

    ; my $return = uplevel(1,\&base::import,'base',@basis)
    # this checks if the above works, which is not the case
    # if Sub::Uplevel was loaded to late
    # it is better to die if this not works
    ; my $inheritor=caller(0)
    ; foreach ( @basis )
        { next if $inheritor->isa($_) 
        ; require Carp;
        ; Carp::croak(<<ERROR)
'basis' was not able to setup the base class '$_' for '$inheritor'.
Maybe Sub::Uplevel was loaded to late for your script.   
ERROR
        }
    ; foreach my $m ( @basis )
        { my $import = $m->can('import') 
        ; uplevel( 1, $import , $m , @{$args{$m}} ) if $import 
        }
    ; $return
    }

; 1

__END__

=head1 NAME

basis - use base with import call

=head1 VERSION

Version 0.04

=head1 SYNOPSIS

Similar to base:
    
    package Baz;
    use basis qw/Foo bal/;
	
Or with arguments for import:

    package Foob;
    use basis Bary => [go => "away"];

=head1 DESCRIPTION

It uses Sub::Uplevel to do the construct

  BEGIN {
	  use base qw/Foo bal/;
	  Foo->import;
	  bal->import('tor');
  };

transparently for the parent and child class.

If the classname is followed by a array reference, than
the dereferenced array is used in the import
call as argument.

=head1 IMPORTANT NOTE

The call of Sub::Uplevel might come to late, so the uplevel call will not work
If you use this module, the same rule as for Sub::Uplevel applies:

Use Sub::Uplevel as early as possible in your program.

Now this modul croaks when Sub::Uplevel is not used earlier enough.
	
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
addon finds your blessing. Thank you David A Golden for maintenance and
improvement of Sub::Uplevel.
	
=head1 SEE ALSO

L<Sub::Uplevel>
L<base>

=head1 COPYRIGHT & LICENSE

Copyright 2006 Computer-Leipzig, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

