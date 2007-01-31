#!/usr/bin/perl

; use strict
; package main

; use Test::More tests => 2

; BEGIN { use_ok( 'basis' ) }

; diag( "Testing basis $basis::VERSION, Perl $], $^X" )

########################################################
# Test with inline classes

; package My::Base

; sub import { $My::Base::v="i" }

my $error1
; package My::Shoe
; BEGIN { eval "use basis 'My::Base'" 
        ; $error1=$@
        }
; package main

; my $expect=qr/'basis' was not able to setup the base class 'My::Base' for 'My::Shoe'/

; like($error1,$expect)

