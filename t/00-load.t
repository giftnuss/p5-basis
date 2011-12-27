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

SKIP: {
    package main;
    local $basis::base = $basis::base;
    BEGIN 
        { eval "require base"
        ; skip("base specific test",4) if $@
        ; $basis::base = 'base'
        }
    ; package My::Shoe
    ; use basis 'My::Base'

    ; package main

    ; use Data::Dumper

    ; is($My::Base::VERSION, "-1, set by base.pm")
    ; ok(! My::Shoe->isa("Sub::Uplevel"))
    ; ok(My::Shoe->isa("My::Base") , "isa")
    ; is($My::Base::v , "i"        , "import call")
    }

