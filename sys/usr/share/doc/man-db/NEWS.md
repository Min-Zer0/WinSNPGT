man-db 2.11.1 (15 November 2022)
================================

Build:

 * Transfer Git repository to https://gitlab.com/man-db/man-db.

Fixes:

 * SECURITY: Replace `$` characters in page names with `?` when constructing
   `less` prompts.
 * Silence error message when processing an empty manual page hierarchy with
   a nonexistent cache directory.
 * `man(1)` now sorts whatis references below real pages, even if the whatis
   references are from a section with higher priority.

Improvements:

 * Add section `3type` to the default section list just after `2`.  This is
   used by the Linux man-pages package.
 * Recognize more Hungarian translations of the `NAME` section.

man-db 2.11.0 (15 October 2022)
===============================

Fixes:

 * `mandb` now correctly records filters in the database if it uses cached
   whatis information.
 * Upgrade Gnulib, fixing syntax error on glibc systems with GCC 11.
 * The `CATWIDTH` configuration file directive now overrides `MINCATWIDTH`
   and `MAXCATWIDTH`.
 * Database entries for links were often incorrectly stored as if they were
   entries for the ultimate source of the page.  They are now stored with
   the correct type.
 * Store links in the database using the section and extension of the link
   rather than of the ultimate source file.
 * Consider pages for adding to the database even if they seem to already
   exist; this performance optimization is no longer needed due to caching,
   and it produced inconsistent results in some unusual cases.
 * `man` now runs any required preprocessors in the same order that `groff`
   does, rather than trusting the order of filters in a page's preprocessor
   string.
 * Fix building on MinGW.  (I haven't been able to test this; help from
   MinGW experts would be welcome.)

Improvements:

 * Add more recognized case variants for localized versions of the `NAME`
   section.
 * Maintain multi keys in sorted order, improving database reproducibility.
 * Pick a more consistent name for the target of a whatis entry in the
   database.
 * Extend rules for when to replace one database entry with another,
   producing more stable behaviour.
 * Fully reorganize databases after writing them, allowing the reproduction
   of bitwise-identical databases regardless of scan order (at least with
   GDBM).

man-db 2.10.2 (17 March 2022)
=============================

Build:

 * Regenerating man-db's build system now explicitly requires Automake >=
   1.14.  (This was already the case since at least man-db 2.10.0, but was
   previously undocumented.)

Fixes:

 * Make `man -H` sleep for a few seconds after starting the browser, since
   it may background itself before loading files (Dr. Werner Fink).
 * If an override directory is configured using `--with-override-dir`, it is
   now applied more consistently when building the manpath, and whether a
   page was found in an override directory is considered when sorting
   candidates for display (Mihail Konev).

Improvements:

 * Make the man-db manual build reproducible.
 * Add some hardening options to the `systemd` service.
 * `configure` now has a `--with-snapdir` option, for use on systems where
   `snapd` is configured to use a directory other than `/snap`.

man-db 2.10.1 (10 February 2022)
================================

Fixes:

 * Fix occasional `mandb-symlink-target-timestamp` test failure.
 * Fix inadvertent reliance on a GCC extension that caused build failures
   with Clang.
 * Fix building without `iconv`.
 * Fix building on Cygwin.

man-db 2.10.0 (4 February 2022)
===============================

Build:

 * Move Git repository to GitLab (https://gitlab.com/cjwatson/man-db).
 * Building man-db now requires a C99 compiler.
 * Building man-db now requires Autoconf >= 2.64.

Fixes:

 * Manpath deduplication no longer mishandles the case where another entry
   in the manpath is a suffix of a candidate path to append.
 * Fix potential crash in path searching if `getcwd` fails for reasons other
   than running out of memory.
 * Fix crash in `globbing` test tool if run with no non-option arguments.
 * `lexgrog` now produces output in the user's locale.
 * Downgrade "malformed .lf request" warning to a debug message and rephrase
   it somewhat, since `.lf` requests can use `*roff` arithmetic expressions
   and we can't reasonably parse those.
 * Avoid modifying the database without changing its mtime, which had been
   possible since 2.7.0 if `mandb`'s purge phase found work to do but the
   main phase didn't, and which confused some backup systems into reporting
   possible filesystem corruption.
 * `man` no longer inadvertently modifies the `MANSECT` environment variable
   before passing it on to its subprocesses.
 * `mandb` now stores the mtime of link targets as the mtime of their
   corresponding database entries, rather than sometimes storing the mtime
   of the link instead.
 * Since man-db 2.4.2, `man` has behaved as if the `-l` option was given if
   a manual page argument contains a slash.  Since man-db 2.5.6, this has
   interacted slightly poorly with the subpage feature, emitting spurious
   error messages if given multiple manual page arguments some of which
   include a slash.  `man` no longer emits spurious error messages in this
   case.

Improvements:

 * Reduce overhead of `MAN_DISABLE_SECCOMP=1` compared to building without
   `libseccomp`.
 * Document `MAN_DISABLE_SECCOMP` and `PIPELINE_DEBUG` environment variables
   in `man(1)`.
 * Add `man-pages(7)` reference to `man(1)`.
 * Recognize Arabic and Persian translations of the `NAME` section.
 * Delay the `systemd` timer using `RandomizedDelaySec`, so that multiple
   containers/VMs on the same host are less prone to running `mandb` all at
   the same time.
 * Significantly improve `mandb(8)` and `man -K` performance in the common
   case where pages are of moderate size and compressed using `zlib`: `mandb
   -c` goes from 344 seconds to 10 seconds on a test system.

man-db 2.9.4 (8 February 2021)
==============================

Improvements:

 * Recognise Romanian translations of the NAME section.
 * Treat `\[en]` (etc.) as another synonym for `\-` in NAME sections,
   alongside the existing `\(en` (etc.).

Fixes:

 * Make the `seccomp` sandbox work better with libcs such as `musl` (S.
   Gilles).
 * Make the `seccomp` sandbox allow `clock_gettime64` as well as
   `clock_gettime` (S. Gilles).

man-db 2.9.3 (22 June 2020)
===========================

Fixes:

 * Fix manual page translation infrastructure to compare `po4a` versions
   with more than two components correctly.
 * Avoid incorrect markup in `man(1)` with `po4a >= 0.58`.

man-db 2.9.2 (1 June 2020)
==========================

Fixes:

 * Fix `man -X75-12` and `man -X100-12` to set the document font size (using
   `-rS12`) as well as the device (using `-TX75-12` or `-TX100-12`).
 * Fix incompatibility of `man -X` and friends with the `seccomp` sandbox.

Improvements:

 * Add a bug tracker link to man-db's own manual pages.
 * Add support for `zstd`-compressed manual pages, thanks to Bernhard
   Rosenkränzer.

man-db 2.9.1 (25 February 2020)
===============================

Improvements:

 * Drop `fdutimens` patch for GNU/Hurd; the bug it was working around was
   fixed in glibc 2.28.
 * Add `MANDB_MAP` entry mapping `/snap/man` to `/var/cache/man/snap`.

man-db 2.9.0 (23 October 2019)
==============================

Fixes:

 * `man --recode` and `manconv` now adjust encoding declarations on the
   first line of their input to refer to the new encoding.
 * Fix comparison of candidate manual pages to correctly handle the case
   where the language elements are the same and match the locale, but the
   territory elements differ.

Improvements:

 * Many typographical improvements to man-db's own manual pages, largely
   thanks to Bjarni Ingi Gislason.
 * Rewrite parts of `man(1)` to make it a more accessible introduction.
 * If run with no arguments or only a section, `man` now suggests running
   `man man`.
 * `man` now understands the `<page>(<section>)` form on its command line,
   so for example `man 'chmod(2)'` is now the same as `man 2 chmod`.  While
   this requires more quoting, it may also be more convenient when copying
   and pasting cross-references to manual pages.
 * `manconv` now guesses the input encoding based on the file name if it is
   not explicitly specified.
 * There is a new `man-recode` program.  It fulfils a purpose similar to
   `man --recode`, but has an interface designed for bulk conversion and so
   can be much faster when used on a large number of pages.

Compatibility notes:

 * Remove the ability to undefine `COMP_SRC` at build-time to disable
   reading compressed manual pages.  This was always only a
   micro-optimisation, and it wasn't worth the extra code complexity.  You
   can still configure without any compressors (either by not having them
   available at build time, or by configuring with `--with-gzip=` etc.) to
   achieve much the same practical effect, although the test suite still
   requires at least `gunzip`.

man-db 2.8.7 (26 August 2019)
=============================

Fixes:

 * Further workarounds for ESET File Security: allow `sendmsg` when it is in
   use.
 * The `seccomp` sandbox now causes disallowed system calls to return
   `EPERM` rather than raising `SIGSYS`, in the hope of being less
   disruptive to preload hacks.
 * Make `seccomp` sandbox allow `getrandom`, used by Hardened Malloc.
 * `man` no longer saves cat pages if `--no-hyphenation` or
   `--no-justification` is used.
 * Move decompression code out of `libman`.  This should really fix a link
   failure using the Darwin linker (unsuccessfully attempted in 2.8.6), and
   possibly on other platforms too.
 * Pass the database file name around in function parameters, rather than
   storing it in a global variable with an unresolved symbol from
   `libmandb`.  Like the previous item, this fixes a link failure using the
   Darwin linker, and possibly on other platforms too.
 * Return database entries in sorted order when using NDBM.  (This is based
   on a similar fix to the GDBM backend in man-db 2.4.2.)

Improvements:

 * Recognise Esperanto, Tamil, and Ukrainian translations of the `NAME`
   section.

man-db 2.8.6.1 (5 August 2019)
==============================

Fixes:

 * Fix missing memory copies in `ult_src` that caused segfaults in `mandb`.

man-db 2.8.6 (3 August 2019)
============================

Fixes:

 * If more than one of `../man`, `man`, `../share/man`, and `share/man`
   exist relative to a directory on `$PATH`, then all of them are now added
   to the automatically-determined manpath; previously, only the first was
   considered.
 * Remove arbitrary limit on manpath size.
 * The `systemd` database maintenance service now runs `mandb` with the
   `--quiet` option, avoiding excess log messages.
 * Default to `--without-systemdsystemunitdir` and
   `--without-systemdtmpfilesdir` on non-Linux systems.
 * Fix failure to link `libman` using the Darwin linker.
 * `apropos -w` now works when given a non-lower-case pattern.

Improvements:

 * Convert most list and hash table code to Gnulib's container types: these
   are more flexible and normally more concise than home-grown equivalents.
 * There is a new configure option `--disable-manual`, which causes the
   man-db manual not to be built or installed.

man-db 2.8.5 (5 January 2019)
=============================

Build:

 * Building man-db now requires Autoconf >= 2.63 and Automake >= 1.11.2.

Fixes:

 * Fix build with Berkeley DB.
 * Fail to configure if `flex` is needed but missing.
 * Fix the comment in the first line of the configuration file in the case
   where `configure` was not given a `--with-config-file` option.
 * Fix several resource and memory leaks.
 * Fix handling of `\-` in the right-hand side of a `NAME` section.
 * Work around Microsoft's proprietary "System Center Endpoint Protection"
   antivirus program in the seccomp sandbox.

Improvements:

 * Ship a `systemd` timer to perform daily database maintenance.
 * Allow disabling the installation of the `systemd` `tmpfiles` snippet and
   the `systemd` timer by configuring with `--with-systemdtmpfilesdir=no`
   and `--with-systemdsystemunitdir=no` respectively.

man-db 2.8.4 (27 July 2018)
===========================

Fixes:

 * Rely on decompressors reading from their standard input rather than
   redundantly passing them the input file on their command line.  This
   works better with downstream AppArmor confinement of decompressors.
 * Fix invalid syntax in `tmpfiles.d/man-db.conf` when configured with
   `--disable-cache-owner`.
 * Make `seccomp` sandbox allow `sched_getaffinity`, sometimes used by `xz`.
 * Check for `mandb_nfmt` and `mandb_tfmt` in the manual page hierarchy as
   documented, not in the current directory.  This was broken by the
   working-directory-handling changes in 2.8.3.  Note that this change means
   that `man -l` will never use an external formatter (which was never
   documented behaviour and was surely a bad idea).
 * Make `seccomp` sandbox allow some shared memory operations across the
   board rather than just when ESET File Security is in use; the Astrill VPN
   seems to require something similar, and there are doubtless other such
   preload hacks.
 * Some versions of ESET File Security call `msgget` and `msgsnd`; if this
   program is in use, then allow those.

man-db 2.8.3 (5 April 2018)
===========================

Fixes:

 * Make `seccomp` sandbox allow `madvise`, since that's used by `lbzip2`.
 * Make `seccomp` sandbox allow `kill` and `tgkill` outright, since `groff`
   uses `kill` to pass on signals to its child processes.
 * Make `seccomp` sandbox allow sibling architectures on
   `x86`/`x86_64`/`x32`, since people sometimes mix and match architectures
   there for performance reasons.
 * Fix version check in locale macro loading to tolerate `groff` release
   candidates.
 * `man` now only changes working directory in child processes, so never
   fails due to being unable to change back to its original working
   directory.
 * `accessdb`, `apropos`, and `lexgrog` no longer emit spurious `gettext`
   headers in their `--help` output when localised.

man-db 2.8.2 (28 February 2018)
===============================

Fixes:

 * Make `seccomp` sandbox allow `kill` and `tgkill` when the signal is
   directed at the current process or one of its threads; this is needed by
   `xz`.
 * Make `seccomp` sandbox allow `ioctl(fd, TIOCGWINSZ)`, since that's used
   by `musl`.
 * Work around the proprietary "ESET File Security" antivirus program in
   `seccomp` sandbox: if this is in use then we need to allow some
   socket-related system calls.
 * Work around the `snoopy` `execve()` wrapper and logger in `seccomp`
   sandbox: if this is in use then we need to allow some socket-related
   system calls.
 * Interpret `EFAULT` from `seccomp_load` as meaning that `seccomp` is
   unavailable, since this can be returned by some versions of `qemu-user`.

man-db 2.8.1 (9 February 2018)
==============================

Fixes:

 * Fix `seccomp` sandbox build on Linux/POWER.
 * Fix `manconv` execution under `seccomp` when `man` is installed setuid.
 * Make `seccomp` sandbox allow `mremap` (used by `iconv`, for example).

Improvements:

 * `configure` now has a `--without-libseccomp` option to disable the use of
   `seccomp` even if the library is available.

man-db 2.8.0 (4 February 2018)
==============================

Fixes:

 * Fix locale macro loading for Chinese to load the macro file corresponding
   to just the language part of the user's locale.
 * Honour `--enable-cache-owner` in generated `systemd` `tmpfiles` snippet
   rather than hardcoding `man`.
 * If `man` adds prefixes to a page to handle such things as disabling
   hyphenation, then take account of those when looking for a preprocessor
   line at the start of the page.
 * Fix a segfault in `man -D --help`.

Improvements:

 * Treat `\(en` as another synonym for `\-` in NAME sections.
 * Confine most subprocesses that handle untrusted data using `seccomp`.
   This mainly deals with subprocesses that perform encoding conversions,
   (de)compressors, `groff` programs, and a few other odds and ends.
   `groff` programs use a slightly more permissive filter since they need to
   create temporary files, so additional path-based confinement (e.g. using
   AppArmor) is still useful.

   If this goes wrong, then `MAN_DISABLE_SECCOMP=1` can be set in the
   environment to disable it, but please report any such problem as a bug.

 * `man` now falls back to `cat` if the compile-time default pager is not
   executable.

man-db 2.7.6.1 (12 December 2016)
=================================

Fixes:

 * Don't `chmod` `CACHEDIR.TAG` if it doesn't exist.
 * Correct installation of Swedish manual pages.

man-db 2.7.6 (11 December 2016)
===============================

Fixes:

 * Fix build warnings with Perl 5.22.
 * Document that `man -K` searches page source, not rendered text.
 * Fix a long-standing bug in man-db's internal cleanup stack mechanism: if
   a cleanup function was pushed unexpectedly between a push/pop pair, then
   popping the stack would remove the wrong cleanup function and chaos could
   ensue.  Avoid this by being more precise about which cleanup function
   should be popped.
 * SECURITY: Eliminate dangerous setgid-root directories.  In the default
   configuration, cache files and directories are now owned by `man:man`
   rather than `man:root`; `man` and `mandb` are now setgid `man` as well as
   setuid `man` (except in the `--disable-setuid` case).  This is a much
   simpler and safer solution to the original problem that caused my
   predecessor to make directories setgid `root`, and doesn't introduce any
   interesting new privilege since the `man` group's only real purpose is to
   be the `man` user's primary group and nothing in cache directories is
   group-writeable.

   Maintainers of distribution packages should take care to review their
   installation rules in light of this change.

   As far as I know this has no CVE ID, but it is described
   [here](https://www.halfdog.net/Security/2015/SetgidDirectoryPrivilegeEscalation/).

 * Fix manual page translation infrastructure to render tables correctly
   with `po4a` 0.47.

Improvements:

 * `man` now understands the `<page>.<section>` form on its command line, so
   for example `man chmod.2` is now the same as `man 2 chmod`.  (Contributed
   by Mihail Konev.)
 * The owner of cache files is now configured separately from whether `man`
   and `mandb` are installed setuid, using the `--enable-cache-owner[=USER]`
   option.

man-db 2.7.5 (6 November 2015)
==============================

Fixes:

 * Adjust line number when inserting extra roff input.
 * Disable roff input insertion with `--recode`.
 * Build text manual with `LC_ALL=C`, to help reproducible builds.

man-db 2.7.4 (8 October 2015)
=============================

Fixes:

 * Fix crash when eliminating manpath duplicates if canonicalising a manpath
   entry fails.
 * Fix a build system bug that sometimes caused substitutions in manual
   pages to be left unexpanded.
 * `man` exits with status 3 rather than 0 if its formatting command exits
   non-zero, even if its display command exits zero.
 * `man` honours `MANWIDTH` in conjunction with the `-Z` option, to make it
   easier to diagnose warnings in manual pages.

man-db 2.7.3 (9 September 2015)
===============================

Fixes:

 * Tools that consider the terminal line length now try the `TIOCGWINSZ`
   ioctl on `/dev/tty` as well as standard input/output.
 * `mandb` does a better job of coping with index files having incorrect
   ownership.
 * Squeeze blank lines internally rather than relying on the pager
   supporting the `-s` option.
 * Fix use-after-free in `ult_src`.
 * Fix crash when running from a missing and unreadable current directory,
   such as an orphaned subdirectory of `/proc`.
 * Restore the ability to use `man -a` noninteractively.

man-db 2.7.2 (16 August 2015)
=============================

Fixes:

 * `man -k` and `man -f` now pass any provided `-l` option through to the
   underlying `apropos`/`whatis` programs.
 * `apropos` and `whatis` no longer truncate names if long output was
   requested.
 * The database handle is no longer stored in a global variable, fixing a
   class of possible double-close bugs.

man-db 2.7.1 (7 November 2014)
==============================

Fixes:

 * Various portability fixes for Solaris, contributed by Peter Bray.
 * `man` now runs correctly when its current working directory has been
   deleted.  (As a result of this fix, man-db now requires `libpipeline >=
   1.4.0`.)
 * `man -a` sends its prompts to `/dev/tty` rather than to `stderr`, and
   likewise reads replies from `/dev/tty` rather than from `stdin`.

man-db 2.7.0.2 (28 September 2014)
==================================

Fixes:

 * Be more careful to avoid using or double-closing closed database handles.
   Fixes test suite failures on some systems.
 * Patch the `fdutimens` function imported from Gnulib to work around a
   libc bug in GNU/Hurd.

man-db 2.7.0.1 (24 September 2014)
==================================

Fixes:

 * Fix test suite in the case where the system supports high-precision
   timestamps but the file system containing the build directory does not.

man-db 2.7.0 (22 September 2014)
================================

Upgrading from previous versions:

 * For the first time since version 2.4.0, the database format has changed
   slightly, so you will need to run `mandb --create` after installing the
   new version to rebuild your databases from scratch.  (Distribution
   packages should do this automatically for system databases.)

Fixes:

 * `lexgrog` now filters terminal escape sequences out of cat pages before
   trying to parse them.
 * Tools that consider the terminal line length now prioritise the `COLUMNS`
   environment variable above the `TIOCGWINSZ` ioctl.
 * Manpath elements are no longer canonicalised before being inserted into
   the search path; this caused the use of incorrect catpaths in some cases.
   This was broken by the `LANGUAGE`-handling fixes in 2.5.4.

Improvements:

 * Ship a `systemd` `tmpfiles` snippet to clean up old cat files after a
   week.
 * The modification time of manual databases is now simply stored in the
   mtime of the database files themselves, rather than using a special row.
   This makes databases reproducible between otherwise-identical
   installations, as long as the underlying database has predictable
   behaviour.  As a bonus, man-db now uses high-precision timestamps to
   determine whether it needs to update databases.
 * Timestamps of manual pages are also now stored in the database with high
   precision and compared accordingly.
 * Files are now ordered by first physical extent before reading them, for
   substantial performance improvements in operations such as `mandb` and
   `man -K`.
 * `man -H` shows a better error message if no browser is configured.
 * `zsoelim` is now installed in `$pkglibexecdir`, to avoid clashes with
   other packages.

man-db 2.6.7.1 (10 April 2014)
==============================

Fixes:

 * Remove test suite dependency on `realpath(1)`.

man-db 2.6.7 (10 April 2014)
============================

Fixes:

 * Fix a test failure when configured with `--enable-undoc`.
 * Run the pager in `man`'s original working directory rather than in the
   manual hierarchy.  (As a result of this fix, man-db now requires
   libpipeline >= 1.3.0.)
 * `mandb` only creates a cache directory tag if the catpath is different
   from the manpath, since it should only be created in directories that
   consist entirely of cached information.

man-db 2.6.6 (23 January 2014)
==============================

man-db is now revision-controlled using git (https://git-scm.com/).  See
`docs/HACKING` for the location of the repository.

Fixes:

 * `apropos`'s `--and` option now works again; it was broken by the
   optimisations in 2.6.2.
 * Restore compatibility with Automake 1.10.
 * Improve support for translation of common elements of help messages.
 * Don't issue error messages when the database refers to a page that no
   longer exists.
 * Pass macro and hyphenation language tags to `groff` again (broken in
   2.6.5).

Improvements:

 * `./configure --with-override-dir=OVERRIDE` arranges to look for manual
   pages in `DIR/OVERRIDE` before each path element `DIR`.

man-db 2.6.5 (27 June 2013)
===========================

Fixes:

 * `man`'s `--warnings` option works again on systems with versions of
   `groff` that support it (broken in 2.6.4).
 * `man` automatically falls back to `C.UTF-8` and then `en_US.UTF-8` if
   trying to find a UTF-8 locale on a system without
   `/usr/share/i18n/SUPPORTED`.

man-db 2.6.4 (23 June 2013)
===========================

Fixes:

 * `man(1)` and `catman(8)` now document the default section list set at
   configure time.
 * Build fixes for Automake 1.13.
 * man-db 2.6.0 arranged to search the full manpath when expanding `.so`
   directives in manual pages (so that `.so name.1` works as well as `.so
   man1/name.1`), but this incorrectly did not take effect for manual pages
   that consist only of a `.so` directive.  This is now fixed.

Improvements:

 * The `MANLESS` environment variable is now treated as if it were a default
   value for the `-r` option to `man`: occurrences of the text `$MAN_PN` are
   expanded, and explicitly using the `-r` option overrides the default.
 * The (unfortunately still hardcoded) maximum length for paths to manual
   page hierarchies in the configuration file is now 511 characters rather
   than 49.
 * `MANPATH` entries now undergo `glob(7)`-style wildcard expansion,
   allowing entries such as `/opt/*/man`.

man-db 2.6.3 (17 September 2012)
================================

Fixes:

 * Build fixes for glibc 2.16 and Automake 1.12.

man-db 2.6.2 (18 June 2012)
===========================

Fixes:

 * `apropos` prints an error message and returns non-zero when it finds no
   matches.  (Regression introduced in 2.5.1.)
 * The presence of a 64-bit GDBM database on the manpath no longer causes a
   32-bit `man` process to exit with a fatal error.

Improvements:

 * `apropos` is much faster when run with many arguments.
 * `whatis` may be given the full path to an executable as an argument, in
   which case it will look up the base name of that executable in the
   appropriate parts of the manpath.

man-db 2.6.1 (14 February 2012)
===============================

Fixes:

 * `--with-db=db*` and `--with-db=ndbm` compile again.
 * Translated manual pages are no longer displayed starting with a spurious
   blank line.
 * `straycats` tries to ensure that `col` is invoked with `LC_CTYPE` set to
   a UTF-8 locale.
 * Fix double-free in `mandb` when encountering a symlink outside the manual
   hierarchy, thanks to Peter Schiffer.

Improvements:

 * `mandb` creates a cache directory tag, per the [Cache Directory Tagging
   Standard](http://www.brynosaurus.com/cachedir/).
 * Add support for Lzip-compressed manual pages, thanks to Matias A. Fonzo.
 * Running `man -w` (with a new `--path` alias) without a name now prints
   the manpath, for compatibility with other `man` implementations.  The
   `vim` viewdoc plugin makes use of this.

man-db 2.6.0.2 (13 April 2011)
==============================

Fixes:

 * Fix a segfault when scanning links to empty pages.
 * Once we've seen at least one record in a page's `NAME` section, ignore
   any further records that don't include a `whatis` description, as they
   tend to be noise.

man-db 2.6.0.1 (10 April 2011)
==============================

Fixes:

 * Ensure that the target of a symlink or `.so` chain is always recorded as
   a real page.
 * Read a user-specified configuration file even if `HOME` is unset.

man-db 2.6.0 (9 April 2011)
===========================

Fixes:

 * Fix build with versions of GNU `ld` that default to
   `--no-copy-dt-needed-entries`.
 * Fix failure to display manual pages in some encodings when installed
   setuid.
 * Wrap long table cells in `man(1)`, fixing test failures with `groff`
   1.21.
 * If an explicit section is passed to `man`, then pages that match that
   section exactly will be preferred over pages that only have that section
   as a prefix.
 * Fix a segfault when `man -K` tries to display certain pages.
 * Fix a segfault in some situations when processes are killed by `SIGHUP`,
   `SIGINT`, or `SIGTERM`.

Improvements:

 * As promised in the release notes for man-db 2.5.8, man-db no longer ships
   its own copy of [libpipeline](https://nongnu.org/libpipeline/).  You must
   build and install that library separately.
 * Search the full manpath when expanding `.so` directives in manual pages.
   As part of this, `.so name.1` should now work as well as `.so
   man1/name.1`.
 * `lexgrog` handles roff named glyphs and `perldoc` strings in `NAME`
   sections.
 * `man` no longer starts a pager if standard output is not a tty.
 * The `-s` option to `whatis` and `apropos` now takes a colon- or
   comma-separated list of sections, similar to `man -S`.
 * `mandb` error output is neater when `stderr` is not a terminal.
 * Add basic support for the implementation of `nroff`/`troff` in the
   Heirloom Documentation Tools.  Title lengths are not properly set as yet,
   and many features are untested.
 * `mandb` removes `cat*` and NLS subdirectories of `cat` directories whose
   corresponding `man` directories no longer exist.
 * `mandb` forces `SIGPIPE` back to its default disposition on startup, to
   avoid noisy output in case it was started in a context where `SIGPIPE`
   was ignored.
 * `SECTION` entries in a user configuration file now override those in the
   system configuration file, rather than appending to them.
 * The default `less` prompt now includes "(press h for help or q to quit)"
   to help novices find their way around.
 * man-db may now be built to use Berkeley DB version 5 (`--with-db=db5`).

man-db 2.5.9 (17 November 2010)
===============================

Fixes:

 * Fix test failures on some systems.  A change made in 2.5.8 was overly
   sensitive to directory ordering.
 * Configuring with `--disable-nls` works again.

man-db 2.5.8 (15 November 2010)
===============================

Fixes:

 * Fix assertion failure on `man -l` with an uncompressed page and any of
   `--no-hyphenation`, `--no-justification`, or a non-English page.
 * 2.5.7 introduced a regression when running `catman` in some locales, most
   notably in the C locale: while converting the output to UTF-8, `iconv`
   was run after the compressor rather than before it.  This release fixes
   that.

Improvements:

 * Add support for XZ-compressed manual pages, thanks to Darren Salt.
 * Try underscore-separated subpages as well as hyphen-separated ones,
   thanks to Tanguy Ortolo.
 * Build `libman` and `libmandb` as shared libraries, reducing installed
   footprint by about 200K (at least on GNU/Linux).
 * `libintl` is no longer shipped with man-db.  If your system does not
   already have GNU `libintl` installed and you want man-db's messages to be
   translated, then please install [GNU
   libintl](https://www.gnu.org/software/gettext/) separately.
 * Warnings about unrecognised locales are now suppressed if the
   `DPKG_RUNNING_VERSION` environment variable is set (i.e. man-db is
   running within a Debian package's maintainer script), since the system
   locales are often out of sync with the C library in that context.  Thanks
   to the Debian Perl maintainers for the idea.
 * Allow building with an external
   [libpipeline](https://nongnu.org/libpipeline/), which has been split out
   from man-db.  This is a transitional measure: a future version of man-db
   will stop shipping its own copy of `libpipeline`.
 * `mandb` should no longer repeatedly rescan manual page hierarchies when a
   `whatis` entry turns into a broken link.

man-db 2.5.7 (16 February 2010)
===============================

Fixes:

 * If a subprocess exits before `man` manages to read all the output from
   it, it now drains the output file descriptor rather than immediately
   discarding it.
 * If `/usr/share/i18n/SUPPORTED` is available, `man` attempts to use it to
   ensure that `LC_CTYPE` is set to an appropriate locale for the selected
   character set when invoking `col`.  This fixes `LANG=C man -E UTF-8`, as
   used by lintian.
 * Don't run tests if cross-compiling.
 * Fix possible `mandb` crash when `MAN_MUST_CREATE` is unset.

Improvements:

 * `man` can now tell `nroff` to disable justification if the
   `--no-justification` option is used.
 * If the full path to an executable is given as an argument, `man` will try
   looking up the corresponding manual page in the appropriate part of the
   manpath, rather than just trying to format the text of the executable as
   a manual page.
 * In the GNU manual hierarchy layout, search `man<sec><ext>` directories as
   well as just `man<sec>` (e.g. `/usr/share/man/man3p` as well as
   `/usr/share/man/man3`).
 * By request, `man` now prefers getting a page from the best manual section
   over getting a page in the correct language.
 * All programs now support a `MAN_DEBUG` environment variable which can be
   used in place of the `-d`/`--debug` option.  This is useful in some
   situations where a program is being called deep in a process tree.
 * man-db now builds with heirloom-doctools, thanks to Diego Pettenò of
   Gentoo.
 * Add support for emulating `pipe()` with `socketpair()`, which is faster
   on some systems; thanks to Werner Fink of SUSE.
 * Cat pages are now always saved in UTF-8, and converted to the proper
   encoding at display time, which means that cat pages can now be saved
   regardless of locale. Note that a consequence of this is that cat pages
   now include formatting information (e.g.  overstriking) and need to be
   run through `col(1)` before display.

man-db 2.5.6 (26 August 2009)
=============================

Fixes:

 * Exact-section database lookups were incorrectly returning all database
   entries whose section names were prefixes of the requested section name.
   In some cases this could confuse `mandb` into never believing that the
   database was up to date.
 * Fix handling of pages with comma-separated names ("foo, bar, baz") in
   their `NAME` sections, broken by a change in 2.5.0 (!) to ignore manual
   page names containing spaces.
 * Fixed a buffer overflow in the pipeline library's line-reading functions.
   I don't believe this to be exploitable: at worst we might believe that
   there's some garbage at the end of manual pages (whose contents are
   untrusted anyway) and this bug typically resulted in a failed assertion
   the next time anything tried to read a line.
 * Plugged two substantial memory leaks in the pipeline library.
 * `whatis` and `apropos` only display any given manual page, or pointers to
   it, once.
 * `man` now sets `less(1)`'s environment up correctly for manual pages
   encoded in CP1251.
 * `manconv` no longer confuses situations such as "this UTF-8 character is
   not representable in the target encoding" with "this text is not in
   UTF-8".

Improvements:

 * The default configuration file now includes section 0, used on some
   systems to document C library header files.
 * `make check` now passes in the presence of a UTF-8-aware `col`, such as
   that in util-linux-ng.
 * The `man -K` option is now supported to search the full text of all
   manual pages.  This was inspired by a similar option in the other `man`
   package (currently at version 1.6f) currently maintained by Federico
   Lucifredi and formerly by Andries Brouwer, but I took advantage of
   man-db's pipeline library to implement it entirely in-process, without
   having to start a separate `grep` process for every manual page.  In my
   tests with fairly typical searches across variously all manual pages or
   just one section, man-db's implementation ran between 3 and 10 times
   faster.
 * Database directories are now only created when there are corresponding
   manual page directories, not just because they're mentioned in the
   configuration file.
 * By default, `man` will now try to interpret pairs of manual page names
   given on the command line as equivalent to a single manual page name
   containing a hyphen (e.g. `man foo bar` => `foo-bar(1)`).  This supports
   the common pattern of programs that implement a number of subcommands,
   allowing them to provide manual pages for each that can be accessed using
   similar syntax as would be used to invoke the subcommands themselves.
   Suggested by H. Peter Anvin, Federico Lucifredi, and others on the git
   mailing list.
 * The build process is now quieter by default.  Use `./configure
   --disable-silent-rules` or `make V=0` if you don't like this or your
   `make(1)` doesn't support the non-standard extension required.
 * `make install` now installs the manual.
 * `manconv` understands a wider range of Emacs-style coding tags.
 * Recommendations to change `MAN_DB_CREATES`, `MAN_DB_UPDATES`, and
   `MAN_CATS` `#define` options in `manconfig.h` have been replaced by new
   `configure` options `--enable-automatic-create`,
   `--disable-automatic-update`, and `--disable-cats` respectively.  Note
   that automatic user database creation is now off by default, as it is
   often too slow for the usefulness it adds; use
   `--enable-automatic-create` to enable it.

man-db 2.5.5 (14 March 2009)
============================

Fixes:

 * Pages that declare a non-default encoding in their preprocessor lines are
   now handled correctly.
 * Fix an uninitialised variable when sorting manual page candidates that
   could lead to excessive memory allocation and possible crashes.

Improvements:

 * man-db's `make check` now tests that all its own manual pages format
   without errors or warnings from `groff`, to ensure a better-quality
   release.

man-db 2.5.4 (24 February 2009)
===============================

Fixes:

 * Build fixes for systems without GNU Make, and for systems without
   `gettext`; this successfully covers at least FreeBSD.
 * The `distclean` target now works if `po4a` isn't installed.
 * Exit as soon as possible if database writes return `ENOSPC`.
 * `lexgrog` now stops on any unrecognised roff request, rather than
   continuing and often littering the database with garbage.
 * `man` no longer requires both standard input and standard output to be
   terminals in order to use the terminal line length.  The line length from
   standard output is preferred if available.
 * The manpath was built completely wrongly when multiple entries were
   present in `LANGUAGE`: duplicates were handled strangely, and languages
   were effectively iterated in reverse order.  It should be rather more
   sensible now.

Improvements:

 * The `MAN_KEEP_STDERR` environment variable can now be used to override
   `man`'s default of discarding `stderr` when `stdout` is a terminal.
 * Handling of terminal widths for cat pages is now configurable, using the
   `MINCATWIDTH`, `MAXCATWIDTH`, and `CATWIDTH` configuration file
   directives.
 * `man -a` now detects duplicate manual page candidates more reliably, and
   sorts them better.
 * Belarusian, Estonian, Greek, Latvian, Lithuanian, Macedonian, Romanian,
   Slovenian, and Ukrainian pages are now supported.
 * `man` can now search for pages using regular expressions (with `--regex`)
   or shell wildcards (with `--wildcard`).  By default this searches both
   page names and descriptions, like `apropos`, but if the `--names-only`
   option is used then it searches page names only, like `whatis`.
 * `man` can now tell `nroff` to disable hyphenation if the
   `--no-hyphenation` option is used.
 * man-db already searched for manual pages in `../man` and `man`
   directories relative to each `$PATH` component; it now searches in
   `../share/man` and `share/man` directories too.
 * Groff 1.20 was recently released, including the `preconv` preprocessor.
   Although man-db has supported `preconv` to some extent since 2.4.4,
   man-db's `configure` now detects its presence and infers that `groff`
   supports Unicode input using it; `man` also now takes slightly better
   advantage of `preconv` than before.
 * Per-locale `groff` macros are now loaded if possible, allowing us to take
   advantage of such things as localised versions of predefined strings and
   language-aware hyphenation.  This only works with Groff 1.20.2 or better
   (not yet released), since earlier versions did not allow us to suppress
   warnings in the event that the appropriate macro file is not available.

man-db 2.5.3 (17 November 2008)
===============================

Fixes:

 * Cleaned up a number of possible crashes, memory leaks, and missing error
   checks found by the Coverity Scan project.
 * Fix build if `MAN_CATS` is undefined.
 * If the `LINGUAS` environment variable is set while running `configure`,
   it now controls building and installation of localised manual pages as
   well as program translations.
 * The `LANGUAGE` environment variable is now tokenised properly, rather
   than only taking the first two characters of each element.
 * Fix build if `--disable-nls` is used or `iconv` is not available.
 * `man` now correctly propagates the exit code of `whatis` or `apropos`
   when called with the `-f` or `-k` option respectively.

Improvements:

 * A number of inconsistencies and readability problems with man-db's own
   manual pages have been cleaned up, thanks mainly to Yuri Kozlov.
 * Reduce the number of warnings emitted when using an unrecognised locale.
 * `manconv` and `zsoelim` are now called internally rather than by
   executing external programs, to improve performance.
 * man-db now uses GDBM (`--with-db=gdbm`) in preference to Berkeley DB
   (`--with-db=db` or `--with-db=dbN` where `N` is 1, 2, 3, or 4) by
   default, since hardware improvements have rendered Berkeley DB's speed
   advantages negligible for our purposes and the relatively frequent
   `SONAME` and on-disk format changes are not worth the hassle.
   Distributors should note that if they follow this change then they will
   need to arrange for databases to be rebuilt on upgrade to this version.
 * Manual pages may now be compressed with LZMA (although this is probably
   only worth it for very large pages).
 * Duplicate manual page hierarchies due to symlinks (e.g. `/usr/man` ->
   `/usr/share/man`) are detected and removed from the search order.
 * A locale modifier (e.g. `@latin`) in a directory name must now match the
   locale if the former is set, in addition to the language and territory.
 * Bare `.so` includes (e.g. `.so foo.1` rather than `.so man1/foo.1`) now
   work, although only within the same manual page hierarchy for now.

man-db 2.5.2 (5 May 2008)
=========================

Fixes:

 * `man -H` (without a browser argument) was completely broken in 2.5.1 and
   is now fixed.
 * `man` no longer breaks in Japanese locales when using `less` as a pager.

Improvements:

 * The `--encoding` option to `man` can now take a true character encoding
   rather than a `*roff` device; the latter was an unreliable, inflexible,
   and awkward way to select an output encoding.  The old semantics are
   still supported for backward compatibility.
 * Whatis parsing stops at `.ie` or `.if` conditionals.
 * CJK locale specifications where the codeset component is equivalent to
   but not stringwise-identical to UTF-8 (e.g.  `zh_CN.utf8`) are handled
   better.
 * `man(1)`'s `OPTIONS` section is ordered more comprehensibly.
 * `apropos`, `lexgrog`, `man`, `mandb`, and `whatis` ignore encoding
   conversion errors for the last possible encoding of the source page.
   This helps, for example, with pages including misencoded non-ASCII names
   of authors; it usually seems better to allow these pages to pass with
   small errors than to break them entirely.

man-db 2.5.1 (28 January 2008)
==============================

Fixes:

 * The manual is now built automatically, avoiding some ordering problems on
   `make distclean`.
 * Manual pages are converted to the proper input encoding for `troff`
   output as well as `nroff` output.
 * The `-t`, `-T`, `-X`, and `-Z` options to `man` work again; in 2.5.0,
   they read input from `stdin` rather than from the manual page.
 * `apropos` and `whatis` no longer segfault when given an explicit locale
   using `-L`.
 * `man` now understands that `groff`'s `ascii` device takes ASCII input,
   not ISO-8859-1.
 * `man` no longer discards `stderr` when writing to a file or a pipe; this
   was broken by an overenthusiastic change in 2.5.0.
 * `manconv` now falls back to the next encoding in its list if any
   characters in an entire 64KB block fail to decode using the current
   encoding, as was originally intended.
 * `manconv` is more careful about extracting `coding:` directives from
   manual pages.
 * Ctrl-C and Ctrl-\ now work again at the prompt issued by `man -a`.

Improvements:

 * There is a new `--with-sections` `configure` option to change the default
   value of `SECTION` in the configuration file.
 * Automake is now used to generate Makefiles.  Among other things, this
   fixes `VPATH` builds and some bugs in dependency generation, and should
   allow building with non-GNU versions of make.
 * man-db now uses the Gnulib portability library, allowing the removal of
   earlier haphazard portability code.  While this results in a somewhat
   larger source distribution, it makes man-db easier to maintain and should
   make it easier to build on systems to which the maintainer does not have
   access.
 * In the process of switching to Gnulib, the last vestiges of pre-C89
   support have been removed; they were documented to be broken anyway.
 * If the `MANROFFOPT` environment variable is set, `man` now appends its
   value to the `*roff` command line.
 * `man` now accepts a `--recode` option to output a source manual page
   converted to a specified encoding.
 * For compatibility with System V, `man` accepts `-s` as an alias for `-S`,
   and permits sections to be comma-separated as well as colon-separated.
 * All programs, except the obsolete `wrapper`, now accept a `--debug`
   option.  (`accessdb`, `lexgrog`, and `zsoelim` were lacking it.)
 * `man` now accepts a `--warnings` option to enable `groff` warnings.

man-db 2.5.0 (7 October 2007)
=============================

Fixes:

 * `mandb --quiet` now suppresses several more warnings.
 * The output of `apropos` no longer includes duplicates when multiple
   search terms are used.

Improvements:

 * Databases are now created for non-English manual hierarchies.  All
   database entries should be encoded in UTF-8; man-db converts from the
   character set of the manual hierarchy and to the character set specified
   in the user's locale as necessary.
 * Per-locale directory handling has been improved.  Directories such as
   `fr.UTF-8` may be used for occasions when it is appropriate to specify
   the character set but not the country, and so a full locale name is
   inconvenient.
 * There is a new `manconv` program which can try multiple possible
   encodings for a file, thus allowing UTF-8 manual pages to be installed in
   any directory even without an explicit encoding declaration.
 * A decompression library is now in place.  This allows man-db to use
   `zlib` to decompress gzipped files, and allows most of its uses of
   temporary files to be removed.  The only remaining exceptions are cat
   file creation (which uses a temporary file in the cat tree rather than in
   `/tmp`) and viewing HTML manual pages (which uses a temporary directory).
   Otherwise, man-db should now work fine even with a read-only `/tmp`
   during system recovery.
 * Cat pages are now saved in the background while the pager is active, so
   `man` will only need to block afterwards if the pager is exited very
   quickly.
 * `--with-*` options are now available at `configure` time for most of the
   auxiliary program locations that you might want to override.
 * `man` now supports the `MANPAGER` environment variable, overriding
   `PAGER`.
 * `apropos`/`whatis` output is now truncated to the terminal width by
   default.  As with `man`, this may be overridden using the `MANWIDTH`
   environment variable.
 * `lexgrog` now ignores alleged manual page names containing spaces, as
   these usually indicate parsing errors or ill-formed `NAME` sections and
   they clutter up `apropos` output badly.  I'm only aware of one legitimate
   counterexample, the Intercal compiler "oo, ick", which no longer appears
   to be known by that name anyway; let me know if there are any others.
 * `man` now discards `stderr` from formatting subprocesses when outputting
   to a pager, to avoid visual corruption from any error messages.
 * If the `MAN_KEEP_FORMATTING` environment variable is set to any non-empty
   value, then `man` will preserve formatting characters in its output even
   when standard output is not a terminal.  This may be useful for programs
   such as `pinfo` that call `man` and can interpret its formatted output.
 * Setting `NOCACHE` in the configuration file now prevents `man` from ever
   creating cat pages automatically.
 * `apropos` now accepts the `--and` option to display only items that match
   all the supplied keywords.

man-db 2.4.4 (12 February 2007)
===============================

man-db is now revision-controlled using
[bzr](https://bazaar.canonical.com/).  See `docs/HACKING` for the location
of the archive (including all CVS history, imported by Canonical).

Fixes:

 * SECURITY: Fix a buffer overrun if using `-H` and the designated web
   browser (argument to `-H` or `$BROWSER`) contains multiple `%s`
   expansions.  This is CVE-2006-4250.
 * Ignore `SIGINT` and `SIGQUIT` while running subprocesses, so that typing
   Ctrl-C doesn't kill `less` (broken in 2.4.3).
 * Similarly, ignore `SIGPIPE` in subprocesses.
 * Various fixes to `SIGCHLD` handling in pipeline library, preventing
   "waitpid failed: No child processes" errors.
 * Skip `exec` in configuration file commands (perhaps left over from old
   installations), which the pipeline execution library cannot handle
   directly.

Improvements:

 * Add support for Chinese in the `--enable-mb-groff` case.
 * `lexgrog` now handles pages with multiple descriptions more usefully, by
   displaying one description per output line.

man-db 2.4.3 (3 July 2005)
==========================

Fixes:

 * Avoid problems creating databases on systems with badly broken clocks set
   before the Unix epoch.
 * Fix detection of decompression programs, so that `man` doesn't attempt to
   execute man pages when it doesn't have a corresponding decompression
   program.

Improvements:

 * `apropos` and `whatis` now accept a `--section` option to restrict their
   search to a particular manual section.
 * The pipeline execution library is now used for most calls to external
   programs, avoiding use of the shell.
 * When `stdout` is not a terminal, man pages will be formatted in plain
   text without the use of backspace or ANSI formatting characters.
 * When invoking `apropos` (`man -k`) or `whatis` (`man -f`) as external
   programs, `man` now only passes through command-line options understood
   by the respective programs.
 * Improve handling of locales with versions and/or modifiers.
 * Add support for Croatian, Galician, Indonesian, Slovak, and Turkish
   pages.
 * man-db may now be built to use Berkeley DB version 4 (`--with-db=db4`).

Compatibility notes:

 * Setting the line length of manual pages now requires `groff` 1.18 or
   later.

man-db 2.4.2 (20 September 2003)
================================

Fixes:

 * SECURITY: Fix a number of buffer overruns in configuration file handling,
   ultimate source location, and `MANPATH` processing.  This is CVE
   CAN-2003-0620.
 * SECURITY: Restrict the use of the `DEFINE` directive in `~/.manpath` to
   code running with dropped privilege.  Previously, the `compressor`
   variable could be used to run arbitrary code with raised privilege.  This
   is CVE CAN-2003-0645.
 * Make sure to initialize `mandata` structures to zero.  The uses of
   uninitialized memory resulting from this had been leading to random
   segfaults.
 * Drop privileges in order to be able to read pages in non-world-readable
   user manpaths while setuid.
 * `man` can be built with `--disable-setuid` again.
 * `man`'s locale support has been revamped.  The encoding of source manual
   pages is no longer related to the encoding of the input passed to `*roff`
   or to `*roff`'s terminal output device.  These frequently differ,
   especially in UTF-8 locales but in other circumstances as well, and a
   "just send 8-bit data" approach is no longer adequate.  If you are using
   a version of `groff` with the Debian multibyte patch applied, pass the
   `--enable-mb-groff` option to configure.
 * When using GDBM, `accessdb` and `apropos` did not return database entries
   in sorted order, since GDBM's key traversal interface is not
   lexicographically ordered.  The database layer has been corrected to cope
   with this.
 * Directories found in strange places in manual hierarchies don't crash
   `mandb`.

Improvements:

 * `man` now calls `mandb` to update databases rather than doing it itself.
   This leaves cat pages as the sole remaining reason for `man` to be
   setuid.
 * The "undocumented" message is only displayed if a corresponding
   executable is found on the `$PATH`.
 * All programs that read `~/.manpath` now take a `-C` option to cause them
   to read a different user configuration file instead.
 * The `--enable-debug` option to `configure` has been removed.  man-db's
   `Makefile`s now always calculate full dependencies for C files.
 * `mandb` caches the contents of directories, significantly speeding up the
   purging of obsolete entries.
 * `mandb` now knows how to purge database entries corresponding to removed
   stray cat pages.
 * In addition, a pipeline execution library has been written, which will
   make it possible to eliminate all or almost all use of the shell in a
   future release.  Unfortunately, time pressures due to the security issues
   above meant that the pipeline library was not well enough tested for use
   in this release, so it is present but unused.  That will be the first
   item for 2.4.3.

man-db 2.4.1 (22 December 2002)
===============================

The man-db CVS repository has moved from sourceforge.net to
savannah.nongnu.org.

Fixes:

 * Don't enter an infinite loop when the `SYSTEM` environment variable is
   set.
 * `man` doesn't segfault when trying to follow a broken symlink.
 * `mandb` no longer corrupts databases when deleting entries that are part
   of multi keys.
 * Prevent a possible buffer overflow when encountering large multi keys.
 * Man page names are escaped when globbing, so `[(1)` can now be found even
   if the database is not up to date.
 * Correct an `access()` check that led to `man -X -l -` producing no
   output.
 * `lexgrog` can now cope with man pages containing only a `.so` link.
 * Manual hierarchies with a specific encoding are put into the search path
   in the correct order.  A bug in `$LANGUAGE` handling had formerly meant
   that `de` would take precedence over `de_DE.UTF-8`.

Improvements:

 * `man`'s behaviour when searching for page names that begin with a digit
   has been made more intuitive, as has its treatment of section names that
   are extensions of ones mentioned in the configuration file but are not
   themselves explicitly named as sections.
 * The default line length for pages formatted for terminal output has been
   increased (reducing margin size) to match the default in `groff` 1.18.
 * Proofread the manual.
 * The `-w` flag to `man` has been changed to display the name of only the
   source `nroff` file.  A `-W` flag has been introduced which displays the
   name of the cat file as well.  If both flags are given to `man`, it will
   behave as before.
 * If `bzip2` is installed, pages compressed with `bzip2` can now be
   displayed.
 * Add support for displaying an additional message when no man page is
   found, which can be used to direct users to a generic "undocumented"
   page.
 * The manual hierarchy layout will now be guessed where possible if an
   explicit `--enable-mandirs` argument is not passed to `configure`.

man-db 2.4.0 (26 June 2002)
===========================

I have changed the package name to man-db, as the underscore was awkward.

Upgrading from version 2.3.x:

 * The database format has changed slightly, so you will need to run `mandb
   --create` after installing the new version to rebuild your databases from
   scratch.  (Distribution packages should do this automatically for system
   databases.)

Fixes:

 * The GNU `nroff` test in `configure` now works when `/bin/sh` is `ash`.
 * When scanning pages for `NAME` sections, `lexgrog` and `mandb` no longer
   accidentally eat the line after each occurrence of the no-op request `.`.
 * `man --local` drops privileges throughout to avoid problems with
   non-world-readable home directories.
 * Newly created cat directories are `chown`ed to the `man` user when
   running as root.
 * `man --html` no longer creates its temporary file with raised privileges,
   so that it now works with a setuid `man`.
 * `man` detects preprocessors correctly when setuid.
 * Various segfault fixes: explicitly null-terminate data returned by the
   Berkeley DB library to avoid some rare crashes; don't reuse a freed
   pointer in some cases of pages with multiple names; handle `MANPATH`s
   containing `::` more safely.
 * Correctly parse manual pages using DOS line-ending conventions.
 * Work around a misfeature in Berkeley DB: it pauses for several seconds if
   asked to read a zero-length database, on the assumption that somebody is
   still writing the metadata page.  `man` is generally better off just
   ignoring the database in this case.
 * Work around corrupted databases in the case where the `nextkey` pointer
   chain contains a loop.

Improvements:

 * `man` looks in the filesystem followed by the database, rather than the
   other way round.  Unix filesystems are quite good databases for this
   purpose, and the `man` database is only superior when looking up names
   that don't have associated links in the filesystem.
 * `apropos --wildcard --exact` makes sure wildcards match an entire
   description or page name, unlike `apropos --wildcard` which may match on
   word boundaries too.
 * `man`'s page-searching code has been substantially rearranged, and now
   only starts displaying pages when it has finished searching for
   candidates.  This allows pages to be sorted more sensibly.
 * Manual pages are formatted in UTF-8 if that is the current locale's
   character set.  The `-E` option is now available to force a particular
   encoding.  Note that some versions of (e.g.) `less` have problems
   displaying UTF-8 in conjunction with backspace characters; `groff` 1.18
   should alleviate this by using ANSI colour escapes instead.
 * The `less` prompt string sets `-PM` as well as `-Pm`.
 * Invoking `man` from within `less` now sets the correct page title in the
   inner `less`.
 * Unless the `--match-case` option is used, `man` will search for pages
   case-insensitively.
 * Update the mechanism for setting the line length so that it also works
   with `groff` 1.18.
 * The `-R` switch is added to the `less` prompt string, which is needed to
   display the ANSI colour escapes generated by `groff` 1.18 correctly.
 * The `$MANLESS` environment variable may be used to override the normal
   creation of the `less` prompt string.
 * Translation updates for French, German, and Spanish, and a new Catalan
   translation.  See `man/THANKS`.

man\_db-2.3.20 (7 September 2001)
=================================

Fixes:

 * A typo in 2.3.19 caused character sets for many languages to be detected
   incorrectly.  This especially affected multibyte languages.
 * Long options in the environment variable `LESS` are handled correctly.
 * When checking if cat pages need to be updated, check for different
   timestamps rather than whether the cat page is newer, as otherwise we
   were confused by tools like `tar` that preserve timestamps in their
   archives.  Each cat page is now set to have the same mtime as its
   corresponding man page.
 * Look up the correct character set each time a page is displayed rather
   than just the first time, in case pages in several different character
   sets are viewed in a single session.
 * `groff` requests are no longer assumed to be case-insensitive when
   scanning for preprocessors, so for example `mdoc`'s `.Eq` request isn't
   mistaken for the `.EQ` which introduces `eqn` commands.
 * Escape arguments passed to the shell that might contain dangerous
   characters.
 * Avoid an infinite loop if the `LANGUAGE` environment variable is set but
   empty.
 * The `--create` option to `mandb` now implies `--no-purge`.
 * Temporary files are handled with more secure permissions.

Improvements:

 * Use a variant of `mkstemp()` rather than `tempnam()`, to avoid classic
   race conditions.  (I don't believe the races were usefully exploitable.)
 * Tolerate `whatis` entries in a database that point to themselves.
 * Detect more translations of the `NAME` section.
 * Add examples of man pages written in POD and SGML.
 * `lexgrog` is now installed in `/usr/bin` by default, with proper argument
   parsing, an improved output format, and a man page.  It is expected to be
   used by programs that need to validate man pages.
 * The `-H` (`--html`) option to `man` is now compiled in by default, and
   supports the BROWSER specification (as
   [documented](http://www.tuxedo.org/~esr/BROWSER/) and
   [amended](https://www.dwheeler.com/browse/secure_browser.html)).

man\_db-2.3.19 (5 July 2001)
============================

Fixes:

 * The user configuration file `~/.manpath` is no longer trusted when
   deciding whether to drop privileges.  In the process, user cat directory
   handling has been improved.
 * Commands of the form `man -S "" foo` formerly emptied the list of
   acceptable sections and then searched the database anyway, and commands
   of the form `man -S ::: foo` segfaulted.  Both now use the standard list
   of sections.
 * The `HUP` and `TERM` signals are now handled better.
 * `straycats` processing invokes `col -bx` rather than `col-bx`.
 * The `root` user is now correctly allowed to update databases in system
   manpaths.
 * `apropos` and `whatis` no longer enter infinite recursion if a database
   contains an entry pointing to itself.

Improvements:

 * When compiled with `--enable-setuid`, `man` and `mandb` can be installed
   non-setuid.  In this mode, they will be unable to write cat pages in
   system directories or to modify system databases, but will otherwise
   operate correctly.  This allows a single binary package to support setuid
   and non-setuid modes of operation.
 * The ordering of manual sections is read from `SECTION` directives in the
   configuration file rather than being hard-coded.
 * The `MANDB_MAP` configuration file directive is documented more clearly.
 * Multiple `whatis` entries separated by commas, break requests, and/or
   paragraph requests are handled more intelligently.
 * Fill control requests (`.nf` and `.fi`) cause `lexgrog` to assume a break
   at each newline.
 * Duplicate manpath entries (often generated in the course of national
   language support) are removed, so that `man -a` works better.
 * man\_db's binaries are installed unstripped by default.
 * Since supporting certain layouts of manual page hierarchies causes
   problems for others, the layout is now selectable via `configure`.  The
   default is to try all layouts.
 * `man` only does an on-the-fly update of the database caches when the
   `--update` option is given.
 * Manual pages are displayed with a line length appropriate to the current
   terminal.  If a non-standard line length is used (i.e. the terminal is
   not between 66 and 80 characters wide) then cat pages will not be saved.
 * `mandb` tries to purge obsolete entries from its databases.  Using the
   `--create` flag should now usually only be necessary in cases of database
   corruption.

man\_db-2.3.18 (14 May 2001)
============================

man\_db-2.3.18 is an interim release under new maintenance by Colin Watson,
merging much of the work done by former maintainers (Graeme Wilford and
Fabrizio Polacco).  It incorporates several years of changes made in the
Debian GNU/Linux distribution's package of man\_db.

Here are a few highlights, with the names of the maintainers responsible for
them.  As I am documenting after the fact of other people's changes of a few
years ago, I have undoubtedly missed a number of fixes and improvements; I
promise to keep track of these as I go along in future.

Fixes:

 * Multiple security fixes, including better handling of temporary files, a
   format string vulnerability fix, and more careful dropping of privileges
   when running setuid.  [Fabrizio, Colin]
 * Databases no longer disappear temporarily while they are being
   regenerated.  [Fabrizio]
 * Corrected handling of locale environment variables.  Setting several
   colon-separated locales in `$LANGUAGE` also works now.  [Colin]
 * `whatis` and `apropos` are more careful about the possibility of a
   corrupted database.  [Fabrizio, Colin]

Improvements:

 * If `root` has private manual hierarchies, cat pages generated from them
   are no longer chowned to a less-privileged user.  [Wilf]
 * Rewrote configuration file handling, adding `DEFINE` directives to set
   paths to external programs.  The configuration file is now called
   `man_db.conf`.  [Wilf]
 * Support FHS paths (`/usr/share/man` and `/var/cache/man`) in preference
   to FSSTND paths (`/usr/man` and `/var/catman`).  [Fabrizio]
 * Converted from `catgets` to GNU `gettext` for national language support.
   [Fabrizio, Colin]
 * Several new and improved localized message catalogues and translated man
   pages.  [Fabrizio, Colin, other contributors]
 * Added `accessdb` utility, which displays the contents of a manual page
   database.  [Fabrizio]
 * Added user configuration file `~/.manpath`, with the same syntax as the
   global configuration file.  [Fabrizio]
 * Leading or trailing colons in the `MANPATH` environment variable cause
   the manpath derived from configuration files to be prepended or appended
   respectively.  A double colon in the middle of the environment variable
   causes the configuration file manpath to be inserted between the colons.
   [Fabrizio]
 * Added experimental `-H` and `-Thtml` options to take advantage of
   `groff`'s new HTML driver.  [Fabrizio]
 * `lexgrog` now scans manual pages to guess which preprocessors are needed.
   [Fabrizio]
 * Create cat directories on the fly if necessary.  [Fabrizio]
 * Supply a wrapper which explicitly drops privileges to uid `man` if `man`
   or `mandb` is run as root.  In the future, splitting out setuid functions
   into a separate helper process may remove the need for this paranoia.
   [Fabrizio]
 * Add `--test` option to `mandb`, which merely reports errors in manual
   page hierarchies rather than actually creating or updating a database.
   [Fabrizio, Colin]
 * Manual pages may now be symlinks outside the mantree.  This should pose
   no significant security concerns, and utilities such as GNU stow create
   such symlinks.  [Colin]
 * Deprecate `whatis` references for `man`, and display a warning if
   displaying a page relies on going through a `whatis` reference.  They
   often lead to confusingly non-obviously-deterministic behaviour, and
   guaranteeing that `man` will honour them even when the database is out of
   date causes performance problems.  [Colin]

man\_db-2.3.11 (21 September 1995)
==================================

 * The man\_db manual is bundled in source form.
 * Components of `$PATH` not in the config file were checked for `man`
   subdirectories.  Now they are also checked for `../man`.
 * Untarring a new manual page (with a timestamp older than the relative cat
   file) over the original did *not* cause `man`/`catman` to reformat the
   replacement.  This is changed.  As a side effect, untarring an unchanged
   man file over the original will also cause a reformat.

man\_db-2.3.10 (13 July 1995)
=============================

Fixes:

 * Global databases were not owned by setuid owner (if applicable).  As a
   consequence only `mandb` could update the databases unless `man` was run
   by superuser.  Stupid bug.
 * The keyword passed to `apropos` _never_ matched the first word of any
   whatis line.
 * `FAVOUR_STRAYCATS` code (if enabled), did not work properly.
 * `zsoelim` did not work as advertised.

Improvements:

 * `man` removes its temporary files upon abnormal termination.
 * `apropos` does proper word matching rather than the fuzzy matching of
   2.3.5.  E.g. supplying any of the keywords: `ld.so`, `a.out`, `dynamic`,
   `linker` or `loader` will match the following entry:

     ld.so (8)            - a.out dynamic linker/loader

   whereas `a.out` and `loader` used to fail.

 * `man`/`whatis`/`apropos` return with exit code 16 if manual page/file or
   keyword is not matched.  Previously exit code 0 was used making it
   difficult for callers to know if the lookup was successful.
 * Addition of German message catalogue.
 * `apropos` and `man -k` do POSIX specified regex matching rather than
   keyword searches if the environment variable `POSIXLY_CORRECT` is
   defined.
 * Added glob-only support of native system manual hierarchies on HP-UX, OSF
   and Solaris operating systems.  Improved the `whatis` parsing code to
   cope with majority of HP-UX manual pages.
 * Ported to NeXTstep.

man\_db-2.3.5 (21 April 1995)
=============================

Added support for:

 * Non-standard section names i.e. multi-character

 * Compressed manual pages.

   A new utility `zsoelim` is included to correctly handle `nroff` `.so`
   requests that point to a file which has been compressed.

 * Compressed stray cats.

   By definition, stray cats are not re-creatable as they have no relative
   source manual page.  As they may have non-default compression extensions
   and may reside on read-only media, stray cats have the same compression
   support as manual pages.

 * FSSTND proposed "extension" support.

   Specific package manual pages may be installed in the standard sections
   but with a package-unique extension appended as in `exit(3tcl)` -
   `../man/man3/exit.3tcl`.  Using the command `man -e tcl exit` would then
   display an `exit` manual page with a `tcl` extension, if available.  Of
   course, `man 3tcl exit` works as always.

 * FSSTND proposed NLS man subdirectories of the form
   `.../man/<locale>/man<sec>/`.

 * NLS message catalogue hooks.

   Provision has been made for the programs to emit their messages in a
   language dependent form.

 * `whatis` referred manual pages.

   Some manual pages contain relevant information for commands or programs
   that would not otherwise reference the page.  The `whatis` part of the
   manual page is used to create virtual links to these pages by all of the
   names mentioned within it.  Examples include names such as `.` and `:`
   referencing the local shell manual page.

 * `catman` utility, used to pre-format the manual pages into cat pages.

 * Operating systems other than Linux.

   man\_db has been reported to compile on the following platforms: Linux,
   SunOS, Solaris, Ultrix, OSF, HP-UX, AIX, IRIX (although portability does
   not extend to support of native manual tree structures on some of these
   systems, e.g. HP-UX).

 * Berkeley DB library routines.

   This complements the support of both `gdbm` and `ndbm` which already
   existed.  DB databases may be shared across platforms.

 * `$MANOPTS` environment variable.

   The environment variable `MANOPTS` may be set to any string in command
   line option/argument format.  It is parsed by `man(1)` prior to its
   actual command line.

 * Per manual hierarchy cat directory locations.

   It is possible to redirect your cat pages to other directories or even
   other file systems.

 * Per manual hierarchy `nroff`/`[tg]roff` format scripts.

   Ability to create custom formatter scripts that are called by `man(1)` to
   enable format/display of non-standard manual pages or manual pages
   requiring a special macro package.

 * Extension of `man -l`.

   Arguments following `-l` are interpreted as local files requiring format
   and display.  Extensions are:

   - `man -l -` formats and displays `stdin`.
   - `man -l foo.1.gz` decompresses, formats and displays `foo.1.gz`.

 * Latin1 manual pages/choice of `nroff` output device.

 * Viewing of ASCII manual pages formatted for a latin1 output device on a 7
   bit ASCII terminal (`-7`).

 * `whatis` and `apropos` utilities support regex and wildcard matching.

 * `checkman`.

   Shell script utility that will find and display duplicated manual pages
   found across manual page hierarchies.

 * `mkcatdirs`.

   Shell script utility to create appropriate cat directories after
   installation and setup.

Conceptual improvements:

 * Replacement of single database with multiple modular databases.  Easier
   integration of additional information into the databases in the future.

 * Both user and global databases share the same name `index.<db-type>`,
   where `<db-type>` could be `bt`, `db`, or `pag` and `dir`.

 * Databases contain `whatis` text.

   `makewhatis` and text `whatis` databases are redundant, although `whatis`
   and `apropos` will use the text `whatis` database for information if they
   cannot read from a relevant index database.

 * Straycats handled without need for 'placeholders'.

 * Friendly `less(1)` prompt.

   If `man(1)` uses `less(1)` as its pager (dependent on both static and
   dynamic factors), the prompt is modified to suit the manual page being
   displayed.  The modification performed is also changeable by the user.

 * man\_db manual.

   man\_db has a manual that covers the setup, maintenance and use of a
   generic online manual page system.

 * Modes of operation.

   The man\_db utilities can be compiled with various modes of operation in
   mind.  E.g. `man` can be stopped from updating databases and/or creating
   cat files in situations where security is extremely important.  See the
   man\_db manual for details.

Speed improvements:

 * Background compression/saving of cat files.

   Cat files are compressed and saved in the background, whilst the user is
   able to browse the formatted page directly.

 * Merge of `straycats` and `makewhatis` into `mandb`.

   While `mandb` has slowed, it now incorporates `makewhatis` and
   `straycats` functionality and is much faster as a whole.  2.0a2 used
   `grep`/`awk`, 2.2 used C regex and 2.3 now uses `lex` sourced C to strip
   out the `whatis` information from the raw man or cat files.

 * Berkeley DB support.

   Provides lower database initialisation overhead as compared with `gdbm`.

 * Extremely fast `whatis(1)` searches.

   `whatis(1)` uses keyed database lookups to retrieve whatis strings for
   standard (non regex/wildcard) searches.

Fixes:

 * Correct handling of `$MANSECT`.

   The environment variable `MANSECT` is no longer ignored.

 * Acknowledgement of `$MANPATH` order.

   manpath elements are searched in the order specified.
