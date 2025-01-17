# Copyright (C) 2014 Red Hat, Inc.
#
# This file is part of cscppc.
#
# cscppc is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# cscppc is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with cscppc.  If not, see <http://www.gnu.org/licenses/>.

NUM_CPU ?= $(shell getconf _NPROCESSORS_ONLN 2>/dev/null || echo 1)

CMAKE ?= cmake
CTEST ?= ctest -j$(NUM_CPU)

.PHONY: all check clean distclean distcheck install

all:
	mkdir -p cscppc_build
	cd cscppc_build && $(CMAKE) ..
	$(MAKE) -sC cscppc_build -j$(NUM_CPU)

check: all
	cd cscppc_build && $(CTEST) --output-on-failure

clean:
	if test -e cscppc_build/Makefile; then $(MAKE) clean -C cscppc_build; fi

distclean:
	rm -rf cscppc_build

distcheck: distclean
	$(MAKE) -s check

install: all
	$(MAKE) -C cscppc_build install
