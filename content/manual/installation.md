---
title: "Installation"
weight: 2
draft: false
---

#### Windows

We recommend that you install Tactician either in a virtual machine, or under the Windows Subsystem for Linux.
Instructions for installing Coq in this environment can be found
[here](https://github.com/coq/coq/wiki/Installation-of-Coq-on-Windows). Further installation of Tactician
is analogous to the [Linux and macOS instructions](#linux-and-macos)

Alternatively, we offer an experimental, unsigned installer based on Coq's installer for Windows.
Although all basic functionality works, this version is limited because it is difficult to impossible
to install additional packages, and therefore it is also difficult to impossible for Tactician to learn
from such packages.

#### Linux and macOS

**Note:** On macOS the instrumentation of packages currently only works in the development version of Tactician.

Below are detailed instructions to install Coq and Tactician through the Opam package manager.
If you are already familiar with Coq and Opam, you can find a summary [here](/manual).

#### Prerequisites

The installation of Coq and Tactician happens through [Opam](https://opam.ocaml.org/).
If you already have a version of Coq installed through the package manager of your linux distribution
you need to install a second version via Opam.
The first step is to
[install](https://opam.ocaml.org/doc/Install.html#Using-your-distribution-39-s-package-system)
Opam version 2.x through your favorite package manager. You can check that the installed version
is newer than 2.0 by running `opam --version`. Some package managers do not yet include Opam 2.0.
For Ubuntu 18.04 and higher a custom ppa is [available](https://opam.ocaml.org/doc/Install.html#Ubuntu).
On other systems, you can use a
[binary installation script](https://opam.ocaml.org/doc/Install.html#Binary-distribution).

After installation, some commands need to be executed to properly configure Opam. The following command
will initialize Opam's local state and will prompt you about installing hooks into your terminal that
will automatically update your `PATH` to include binaries installed through Opam.
```bash
opam init --bare # Answer yes to questions
```
As the initialization script suggests, you might want to write `source ~/.bash_profile`
in your `~/.bashrc` file. Otherwise you wil have to run `eval $(opam env)` everytime you start Coq
from a new terminal.

Now you need to create a switch to install Coq and Tactician in:
```bash
opam switch create coq-switch --empty
eval $(opam env)
```

This should be all that is required to prepare your system to install Coq and Tactician.

#### Installation of Tactician for Coq versions >= v8.17

To install Coq, Coqide (optional but recommended) and Tactician, run the following commands:

```bash
opam repo add coq-released https://coq.inria.fr/opam/released
opam install coq-core coq-tactician # Answer yes to all questions
tactician inject
opam install coq coqide
```
On some exotic linux distibutions, the commands above may not know how to install system packages.
In that case, you have to manually install them through your systems package manager, and then
re-run these commands

After installation, Tactician is not immediately enabled. This can be done by running the command
`tactician enable`. This command will add some code to your `coqrc` file (a file that
Coq loads automatically every time it is started) that will load Tactician. Further information about
why Tactician is loaded this way can be found [here](/manual/coq-packages). If you wish to disable
Tactician, this can be done with the command `tactician disable`.

#### Trying an example

Tactician should now be ready to work. To make sure of this, you can test Tactician on an example file.
First, start the Coq editor using the command
```bash
coqide &
```

Then open the [example file](../../Example.v) into the editor, and play around with it (moving around the
document in CoqIde happens using the arrows at the top). Make sure that the two new commands provided
by Tactician, `Suggest` and `synth` function properly.

#### Installation of Tactician for Coq versions < v8.17

For versions of Coq older than v8.17, there was no split between Coq's core and standard library into
the packages `coq-core` and `coq-stdlib`. This means that for those versions, Tactician is unable to
inject itself into the build process of `coq-stdlib`, because of a circular dependency. Hence, it is
unable to learn from the proofs available in the standard library.

To remedy this, a special package `coq-tactician-stdlib` was created, that recompiles the standard library
with Tacticians instrumentation loaded. **Warning: This will backup and overwrite Coq's standard library.
Upon removal of the package, the original files will be restored.**

```bash
opam repo add coq-released https://coq.inria.fr/opam/released
opam install coq.8.16.1 coqide coq-tactician coq-tactician-stdlib # Answer yes to all questions
tactician inject
```

After installing `coq-tactician-stdlib`, Tactician has learned from the standard library and should
be able to synthesize proofs regarding it.
