default: all

all: vps

vps:
	nixos-rebuild switch --flake ./.#mailserver --target-host root@37.205.13.29

update:
	nix flake update

clean:
	ssh root@37.205.13.29 'nix-collect-garbage -d'
