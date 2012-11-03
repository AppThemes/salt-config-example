#!/bin/bash

pear upgrade pear

pear channel-discover pear.phpunit.de
pear channel-discover components.ez.no
pear channel-discover pear.symfony.com

pear install --alldeps phpunit/PHPUnit

if [ ! which phpunit ]; then
	exit 1
fi
