use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'basis',
    license             => 'perl',
    dist_author         => 'Sebastian Knapp <sk@computer-leipzig.com>',
	dist_version        => '0.05',
	requires => {
        'perl'          => '5.6.0',
        'Sub::Uplevel'  => '0.12',
	},
    build_requires => {
        'Test::More' => 0,
    },
    configure_requires => {
        'Module::Build' => '0.38'
    },
    add_to_cleanup      => [ 'basis-*' ],
    create_makefile_pl  => 'traditional', 
);

$builder->create_build_script();
