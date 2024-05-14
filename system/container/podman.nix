{ pkgs-unstable, ...}:
{
	virtualisation.containers.enable = true;
	virtualisation = {
		podman = {
			enable = true;
			package = pkgs-unstable.podman;

			# Enable `docker` alias for podman
			# dockerCompat = true

			# Required for containers under podman-compose to be able to talk to each other.
			defaultNetwork.settings.dns_enabled = true;
		};
	};

	environment.systemPackages = with pkgs-unstable; [
		dive # Look into docker image layers
		podman-tui # Status of container in terminal
    # docker-compose # start group of containers for dev
    podman-compose # start group of containers for dev
	];
}
