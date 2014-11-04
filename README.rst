Overview
========

``painted-iterm`` allows you to configure the color of your `iTerm2`_ windows
based on the hostname, IP, or SSH configuration. This allows you to color code
your windows to help prevent errors. It supports 256 colors.

.. _`iTerm2`: http://iterm2.com/


SSH Configuration
=================

The following example paints the iTerm2 window color bright red::

    Host prod-firewall
        HostName prod-firewall.example.com
        User admin
        LocalCommand painted-ansi 1


    # ...


    Host *
        PermitLocalCommand yes

The SSH configuration is the easiest way to configure iTerm2 window colors. It
is also the only way to do so for appliances that don't have a bash shell.


``.bashrc`` Configuration
=========================

The following ``.bashrc`` excerpt configures a traffic light environment scheme
used at many shops::

    export TERM=xterm-256color

    # Label             Match Pattern                               ANSI Color
    PAINTED_CONFIG='
    Laptop              ^lappy$                                     8
    Bastions            ^bastion                                    52
    Office              ^192\.168\.0\.                              18
    DMZ                 ^10\.10\.10\.                               202
    PROD                ^10\.10\.20\.                               1
    DEV                 ^10\.10\.30\.|^10\.33\.33\.                 28
    last_default        .                                           11
    '
    source painted_iterm_include.sh


Bin Scripts
===========

|painted-ansi|_: paints window color based on ANSI color code.

|painted-rgb|_: paints window color based on R G B values.

|painted-colors|_: shows 256 ANSI color codes.

.. |painted-ansi| replace:: ``bin/painted-ansi``
.. _painted-ansi: bin/painted-ansi
.. |painted-rgb| replace:: ``bin/painted-rgb``
.. _painted-rgb: bin/painted-rgb
.. |painted-colors| replace:: ``bin/painted-colors``
.. _painted-colors: bin/painted-colors



Resources
=========

- `Proprietary Escape Codes - Documentation - iTerm2`_
- `256 Terminal colors and their 24bit equivalent (or similar)`_

.. _`Proprietary Escape Codes - Documentation - iTerm2`:
   http://iterm2.com/documentation-escape-codes.html
.. _`256 Terminal colors and their 24bit equivalent (or similar)`:
   http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html


Requirements
============

- OS X
- `iTerm2`_


License
=======

- `<LICENSE>`_ (`MIT License`_)

.. _`MIT License`: http://www.opensource.org/licenses/MIT
