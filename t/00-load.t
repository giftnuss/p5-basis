#!/usr/bin/perl

; use Sub::Uplevel
; use strict
; package main

; use Test::More tests => 5

; BEGIN { use_ok( 'basis' ) }

; diag( "Testing basis $basis::VERSION, Perl $], $^X" )

########################################################
# Test with inline classes

; package My::Base

; sub import { $My::Base::v="i" }

; my $skip
; BEGIN 
    { eval "require base"
    ; $skip = !!$@
    }

SKIP:
    { package main
    ; skip("module base specific test",4) if $skip
    ; local $basis::base = 'base'
    ; package My::Shoe
    ; eval "use basis 'My::Base'"

    ; package main

    ; is($My::Base::VERSION, "-1, set by base.pm")
    ; ok(! My::Shoe->isa("Sub::Uplevel"))
    ; ok(My::Shoe->isa("My::Base") , "isa")
    ; is($My::Base::v , "i", "import call")
    }

