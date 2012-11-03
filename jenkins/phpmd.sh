#!/bin/bash

pear channel-discover pear.phpmd.org
pear channel-discover pear.pdepend.org

pear install --alldeps phpmd/PHP_PMD

if [ ! which phpmd ]; then
	exit 1
fi
