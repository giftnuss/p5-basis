#!/usr/bin/perl

; use strict
; package main

; use Test::More tests => 1

; package My::Base

; sub import { $My::Base::v="i" }

; SKIP:
    { package main
    ; local $basis::base = $basis::base
    ; BEGIN
        { eval "require base"
	; skip "base specific test",1 if $@
	; $basis::base = 'base'
        }
    ; my $error1
    ; package My::Shoe
    ; eval "use basis 'My::Base'" 
    ; $error1=$@

    ; package main

    ; my $expect=qr/'basis' via 'base' was not able to setup the base class 'My::Base' for 'My::Shoe'/

    ; like($error1,$expect)
    }
# no warning once
; defined($My::Base::v) or 1
