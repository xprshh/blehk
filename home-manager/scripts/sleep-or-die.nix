{ lib, pkgs, ... }:

let
  # Define the application to notify and shut down
  sleep-or-die =
    let
      # Set default icon and sound path
      image = "-i dialog-warning-symbolic";  # Default icon
      sound = if cfg.sound == null then "ffplay -nodisp -autoexit ~/nixos/media/majoras_mask_bell.wav" else "ffplay -nodisp -autoexit ${cfg.sound}";
    in
    pkgs.writeShellApplication {
      name = "sod";
      runtimeInputs = [ pkgs.libnotify pkgs.ffmpeg ];  # Dependencies
      text = ''
        # Send critical notification with image/icon
        notify-send -u critical "${cfg.title}" "${cfg.message}" ${image}
        # Play sound if provided
        ${sound}
        # Schedule a shutdown in 60 minutes
        shutdown +60 "This was automatically invoked by 'sleep-or-die'"
      '';
    };

in

# Configuration options for the sleep-or-die program
{
  options.sleep-or-die = {
    enable = mkEnableOption "sleep-or-die";  # Option to enable the service

    # Notification title and message
    title = mkOption {
      type = types.str;
      description = "The title of the notification";
      default = "Go to sleep!";
    };

    message = mkOption {
      type = types.str;
      description = "The message of the notification";
      default = "You are missing on sleep! You have one hour to use your PC before it shuts off.";
    };

    # Custom image path for the notification (optional)
    image = mkOption {
      type = types.nullOr types.path;
      description = "The image to display on the notification.";
      default = null;
    };

    # Path to the sound to be played on notification (optional)
    sound = mkOption {
      type = types.nullOr types.path;
      description = "The sound to play on notification.";
      default = "~/nixos/media/majoras_mask_bell.wav";  # Default sound
    };

    # Time to start the daemon
    startAt = mkOption {
      type = types.str;
      default = "22:00:00";  # Default start time
      description = "The time to start the daemon.";
    };
  };

  # If enabled, configure the systemd service for sleep-or-die
  config = mkIf cfg.enable {
    systemd.user.services.sleep-or-die = {
      inherit (cfg) startAt;
      serviceConfig = {
        RestartSec = 5;
        ExecStart = "${lib.getExe' sleep-or-die "sod"}";  # Start the shell application
      };
    };
  };
}
