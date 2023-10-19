---
title: "Changelog posts"
layout: "changelog"
draft: false
---

### Announcing Tactician version 1.0 beta2

After almost three years of development, we are happy to announce Tactician 1.0 beta2. It is available for all
Coq versions between v8.12 and v8.18. Tactician is a proof
synthesis system that uses data from existing theorems in order to help users write new proofs. It can adapt
to, and learn from new developments on the fly. For details, see the [website](https://coq-tactician.github.io)
and the list of [publications](https://coq-tactician.github.io/publications).

Most of the development time in the past three years went to bug fixes, stability improvements, performance
improvements and other internal changes. No detailed changelog was kept, but we believe the usability has
improved significantly. There have also been a number of important user-facing changes:

- The `search` tactic has been renamed to `synth` to avoid confusion with Coq's internal `Search` command.
  (The `Suggest` command remains the same.)
- Starting from Coq v8.17, the standard library has been split from Coq's core, resulting in the packages
  `coq-core` and `coq-stdlib`. The `coq-tactician` package now depends only `coq-core`. This allows
  Tactician to instrument `coq-stdlib` while it is being installed in order to learn from it, obviating the
  need for the `coq-tactician-stdlib` package. (See the [manual](https://coq-tactician.github.io/manual/) for 
  further instructions.)
- In the past years, the landscape of available Coq editors has changed significantly. The support for the
  various editors is as follows:
  + Coqide: Fully supported.
  + Emacs with Proof General: Fully supported.
  + Coq-lsp: Partially supported. Tactician can be loaded through `From Tactician Require Import Ltac1`,
    but support for injecting Tactician through launching VsCode with `tactician exec code` is unavailable.
  + VsCoq Legacy: Supported. Support for launching VsCode through `tactician exec code` is available starting Coq
    v8.12.
  + VsCoq 2.0: Currently incompatible with Tactician.

  If you encounter any issues with these editors, please open an
  [issue](https://github.com/coq-tactician/coq-tactician/issues).
- Tactician is now fully open source under the MIT license. As such, this is an invitation for other researchers
  to use the data available in Tactician to build their own proof synthesizer. If you have a great idea,
  don't hesitate to reach out for a potential collaboration.

Any feedback on this beta release is appreciated. Do not hesitate to open an 
[issue](https://github.com/coq-tactician/coq-tactician/issues).

### Announcing Tactician version 1.0 beta1

We would like to announce Tactician 1.0 beta1, the first official release of Tactician.
Tactician is a tactic learner and prover for the Coq Proof Assistant.
The system will help users make tactical proof decisions while they retain control over the general proof
strategy. To this end, Tactician will learn from previously written tactic scripts, and either gives the user
suggestions about the next tactic to be executed or altogether takes over the burden of proof synthesis.
Tactician’s goal is to provide the user with a seamless, interactive, and intuitive experience together with
strong, adaptive proof automation.

Even though a lot still remains to be done,
with this version we believe that the system is mature enough to be used in real developments. We would like
to solicit any feedback on the system you might have. Feel free to open issues in the
[issue tracker](https://github.com/coq-tactician/coq-tactician/issues).

Tactician is available for Coq v8.11, v8.12, v8.13 and master and on Linux, macOS and Windows. Installation
instructions can be found in the [manual](/manual). An online demo can be found [here](/demo.html). Tactician has
first-class support for Opam, and can automatically learn from almost any Coq package. For the exceptions,
special support can be added. Currently, special support exists for the HoTT homotopy type theory library. If
tactician cannot instrument your favorite package and you would like to see support, please open an
[issue](https://github.com/coq-tactician/coq-tactician/issues).

This release contains too many features and improvements to list exhaustively. We invite you to explore the
system on your own and find them yourself. However, a sneak-peak of significant improvements are tactic
discharging for sections and local parameter prediction.

#### Future direction
This release of Tactician is aimed at providing Coq users with an easy to use system that can be used in real
Coq developments. The next step in our grand plan is to transform Tactician into a machine learning platform,
where AI-researchers can add agents to Tactician (a plugin for a plugin) using an easy-to-use API.
The goal of this API is to take away the hard Coq engineering problems and only leave the hard machine learning
problems.

This API is still under heavy development. We are therefore not yet inviting the wider AI-community to work
with Tactician. However, we are looking for collaborators/beta-testers. So if you have a good machine learning
idea that you would like to implement on top of Tactician, please get in touch.
