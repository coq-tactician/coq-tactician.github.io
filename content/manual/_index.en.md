---
title: "Manual"
weight: 1
draft: false
---

#### Getting Started (experienced Coq users)

This is a super-short guide for people with prior experience with Coq and Coq packages.
If you'd like a more in-depth guide, see [installation](installation).

##### Installation

```bash
opam install coq-tactician
tactician enable # Optional but recoomended, adds Tactician to your coqrc
tactician inject # Optional, instrument installation of Opam packages
# For Coq < 8.17 only:
opam install coq-tactician-stdlib # Optional, recompiles standard library
```

##### Basic Usage

If you have chosen to run `tactician enable` during installation, Tactician will be
immediately ready to go.
The two most important commands of Tactician are `Suggest` and `synth`.
Both should be used in proof mode. You can try them out on our [example](/Example.v) file.
A more comprehensive description of Tactician's commands can be found in [usage](usage).
To instrument packages with Tactician support, see [Coq packages](coq-packages).
