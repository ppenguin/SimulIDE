# makefile only used to fetch/refresh sources,
# real build delegated to nix build .nix/

REV ?= 1908

.PHONY: all
all: rmsrc fetch nixbld

.PHONY: rmsrc
rmsrc:
	rm -rf resources src SimulIDE.pro

.PHONY: fetch
fetch: scripts/getfromlp.sh
	$< $(REV)

.PHONY: nixbld
nixbld:
	nix build .nix/#simulide
