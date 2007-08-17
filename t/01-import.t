#!/usr/bin/perl

; use Sub::Uplevel
; use strict
; package main

; use Test::More tests => 9

; BEGIN { use_ok( 'basis' ) }

########################################################
# Test with inline classes

; package My::Base

; sub import { $My::Base::v="i" }

; sub wildlife { 0 }

; package My::Shoe
; use basis 'My::Base', 'Exporter'
  
; our @EXPORT_OK=qw/guard/
  
; sub guard { 1 }

; package Kan::Guru
; use basis 'My::Shoe' => ['guard']

; package main

; use Data::Dumper

; is($My::Base::VERSION, "-1, set by base.pm")
; ok(! My::Shoe->isa("Sub::Uplevel"))
; ok(My::Shoe->isa("My::Base") , "isa")
; ok(My::Shoe->isa("Exporter"))
; is($My::Base::v , "i"        , "import call")
  
; ok(Kan::Guru->can('guard') && Kan::Guru->guard)
; is("@My::Shoe::ISA","My::Base Exporter")
; is("@Kan::Guru::ISA","My::Shoe")
