
chwal  [OPTIONS]  This  script randomly selects wallpapers from a
directory and applies a colorscheme using  wallust.  It  supports
theme  caching,  marking  wallpapers  for  removal,  and optional
pre/post hooks.

Shell utility for colorscheme and wallpaper selection  with  wal‐
lust.  Version 1.1

Usage: chwal [OPTIONS]

Options:
  ‐d, ‐‐dir DIR         Specify the wallpaper directory
  ‐h, ‐‐help            Show this help message
  ‐l, ‐‐load            Pre‐load themes for images in the wallpa‐
per directory
  ‐p,  ‐‐pre  PRE_HOOK    Specify a script to run before changing
the wallpaper
  ‐P, ‐‐post POST_HOOK  Specify a script to  run  after  changing
the wallpaper
  ‐m, ‐‐mark            Mark the current wallpaper
  ‐V, ‐‐version         Show the version of the script


chwal ‐d /path/to/wallpapers ‐l

chwal ‐m

This  project  uses  GNU Make to generate documentation and shell
completion files. To install chwal, the manpages, and  the  shell
completions  simply  run ’make install’ and everything will go to
the correct location.

  all  Show the help message by default
  check  Check all dependencies
  clean  Remove generated files
  info  Show the help message
  install  Install script, completions, and manpage
  man  Generate manpage
  uninstall  Uninstall script, completions, and manpage


Alessandro Rizzoni <rizzoni.alex@gmail.com>  Copyright  (c)  2025
Alessandro Rizzoni

Permission  is  hereby granted, free of charge, to any person ob‐
taining a copy of  this  software  and  associated  documentation
files  (the "Software"), to deal in the Software without restric‐
tion, including without limitation the rights to use, copy,  mod‐
ify,  merge,  publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom  the  Software  is
furnished to do so, subject to the following conditions:

The  above  copyright  notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF  ANY  KIND,
EXPRESS  OR  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE  AND  NONIN‐
FRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE  FOR  ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN  THE
SOFTWARE.


