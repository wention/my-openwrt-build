#!/bin/sh


#debug
docker run --rm -ti -v `realpath ~/Git/lede`:/build wention/build_lede:dev bash
