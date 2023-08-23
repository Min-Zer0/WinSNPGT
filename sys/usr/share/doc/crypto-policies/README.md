This repository contains the crypto-policies data and scripts used in
Fedora.

|Release|Status|
|:-----:|:----:|
|master|[![build status](https://gitlab.com/redhat-sectech/fedora-crypto-policies/badges/master/build.svg)](https://gitlab.com/redhat-sectech/fedora-crypto-policies/commits/master)|
|F26|[![build status](https://gitlab.com/redhat-sectech/fedora-crypto-policies/badges/fedora26/build.svg)](https://gitlab.com/redhat-sectech/fedora-crypto-policies/commits/fedora26)|
|F27|[![build status](https://gitlab.com/redhat-sectech/fedora-crypto-policies/badges/fedora27/build.svg)](https://gitlab.com/redhat-sectech/fedora-crypto-policies/commits/fedora27)|
|F28|[![build status](https://gitlab.com/redhat-sectech/fedora-crypto-policies/badges/fedora28/build.svg)](https://gitlab.com/redhat-sectech/fedora-crypto-policies/commits/fedora28)|

# Purpose

The purpose is to unify the crypto policies used by different applications
and libraries. That is allow setting a consistent security level for crypto
on all applications in a Fedora system, irrespective of the crypto library
in use.

# Description

The idea is to have few predefined security policies such as LEGACY, DEFAULT
and FUTURE which are set system-wide by the administrator. Then applications
that have no special needs will follow these policies by default. That
way the management of the various crypto applications and libraries used in a
system simplifies significantly.

The current implementations works by setting the desired policy in
/etc/crypto-policies/config. After this file is changed the script
'update-crypto-policies' should be executed, and the new policies
will activate.

The supported back ends in Fedora are:
 * GnuTLS
 * OpenSSL
 * NSS
 * BIND
 * libkrb5
 * OpenSSH
 * Java via OpenJDK

The documentation of crypto policies is at [update-crypto-policies.8.txt](update-crypto-policies.8.txt).

# Generating the policies

The policies are described in PERL at `back-ends/profiles/POLICYFILE.pl`,
and they operate on strings defined in `back-ends/profiles/common.pm`.
Individual application configuration generators are present in `back-ends/`.

To generate the policies per application use the script `./generate-policies.pl
DESTDIR` or `make install`.

For testing purpose the generated policies per application with the current
config are placed in `tests/outputs` and `make check` will verify whether the
generated policies match the stored. To reset the outputs use `make
reset-outputs` and `make check` to regenerate them.

# Contributing

See [our contribution guide](CONTRIBUTING.md).
