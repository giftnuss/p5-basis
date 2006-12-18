use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'basis',
    license             => 'perl',
    dist_author         => 'Sebastian Knapp <sk@computer-leipzig.com>',
    dist_version_from   => 'lib/basis.pm',
	requires => {
        'perl'          => '5.6.0',
        'Sub::Uplevel'  => '0',
	},
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'basis-*' ],
	create_makefile_pl  => 'traditional' 
);

$builder->create_build_script();
