# painted-iterm

`painted-iterm` allows you to configure the color of your [iTerm2][iterm2]
windows based on the hostname, IP, or SSH configuration. This allows you to
color code your windows to help prevent errors. It supports 256 colors.

[iterm2]:http://iterm2.com/


## Install

1. [Install Homebrew][brewinstall] -- The missing package manager for macOS
2. Add the "tap":
    ```shell
    brew tap TimidRobot/tap
    ```
3. Install `painted-iterm`:
    ```
    brew install painted-iterm
    ```
4. iTerm2 > Preferences > Appearance: Enable "Show Border around window"

[brewinstall]:http://brew.sh/#install


## SSH Configuration

The SSH configuration is the easiest way to configure iTerm2 window colors. It
is also the only way to do so for appliances that don't have a bash shell. The
SSH configuration is most commonly done only locally in `~/.ssh/config`.

The following example paints the iTerm2 window color of prod-firewall bright
red and paints the iTerm2 window color of dev-server green:

    ```
    Host prod-firewall
        HostName prod-firewall.example.com
        User admin
        LocalCommand painted-ansi 1

    Host dev-server
        HostName dev-server.example.com
        User admin
        LocalCommand painted-label DEV

    Host *
        PermitLocalCommand yes
    ```

The `painted-label` example requires the `.bashrc` configuration below (so
that the `PAINTED_CONFIG` varible is available).


## `.bashrc` Configuration

The following `.bashrc` excerpt configures a traffic light environment scheme
used at many shops:

    ```shell
    export TERM=xterm-256color

    # Label             Match Pattern                               ANSI Color
    export PAINTED_CONFIG='
    Laptop              ^lappy$                                     8
    Bastions            ^bastion                                    52
    Office              ^192\.168\.0\.                              18
    DMZ                 ^10\.10\.10\.                               202
    PROD                ^10\.10\.20\.                               1
    DEV                 ^10\.10\.30\.|^10\.33\.33\.                 28
    last_default        .                                           11
    '
    source .painted_iterm_include.sh
    ```

The configured `.bashrc` and `.painted_iterm_include.sh` must exist on the
remote host.


## Helper Functions and Scripts

- **[`painted-ansi`][ansi]**: paints window color based on ANSI color code.
- **[`painted-label`][label]**: paints window color based on configured label
  (requires export of `PAINTED_CONFIG`).
- **[`painted-rgb`][rgb]**: paints window color based on R G B values.
- **[`painted-colors`][colors]**: shows 256 ANSI color codes.
- **[`painted-config`][config]**: shows currently configured paint scheme
  (outputs formatted `PAINTED_CONFIG` provided your `.bashrc` is configured
  correctly)

[ansi]: bin/painted-ansi
[label]: bin/painted-label
[rgb]: bin/painted-rgb
[colors]: bin/painted-colors
[config]: painted_iterm_include.sh


## Screenshots

![screenshot of painted-colors output][imagepainted]
![screenshot of painted-config output][imageconfig]

[imagepainted]: painted-colors.png
[imageconfig]: painted-config.png


## Resources

- [Proprietary Escape Codes - Documentation - iTerm2][escape]
- [256 Terminal colors and their 24bit equivalent (or similar)][256term]

[escape]:http://iterm2.com/documentation-escape-codes.html
[256term]:http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html


## Requirements

- macOS
- [iTerm2][iterm2]


## License

- [`LICENSE`](LICENSE) (Expat/[MIT][mit] License)

[mit]: http://www.opensource.org/licenses/MIT "The MIT License | Open Source
Initiative"
