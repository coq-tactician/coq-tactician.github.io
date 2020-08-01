---
layout: default
---

<img src="rooster-landing.png" alt="The Tactician" title="The Tactician" style="width: 100%;" />

Tactician is a tactic learner and prover for the Coq Proof Assistant.
The system will help users make tactical proof decisions while they retain
control over the general proof strategy. To this end, Tactician will learn
from previously written tactic scripts, and either gives the user suggestions
about the next tactic to be executed or altogether takes over the burden of
proof synthesis. Tactician's goal is to provide the user with a seamless,
interactive, and intuitive experience together with strong, adaptive proof
automation.


# Publications

- [The Tactician: A Seamless, Interactive Tactic Learner and Prover for Coq](https://doi.org/10.1007/978-3-030-53518-6_17)
  
  **Note:** An extended version of this paper is available [here](paper.pdf)
  
  **Abstract:** We present Tactician, a tactic learner and prover for the
  Coq Proof Assistant. Tactician helps users make tactical proof decisions
  while they retain control over the general proof strategy. To this end,
  Tactician learns from previously written tactic scripts and gives users
  either suggestions about the next tactic to be executed or altogether
  takes over the burden of proof synthesis. Tactician’s goal is to provide
  users with a seamless, interactive, and intuitive experience together with
  robust and adaptive proof automation.
  
- [Tactic Learning and Proving for the Coq Proof Assistant](https://doi.org/10.29007/wg1q)

  **Abstract:** We present a system that utilizes machine learning for tactic proof search in the Coq Proof Assistant. In a similar vein as the TacticToe project
  for HOL4, our system predicts appropriate tactics and finds proofs in the form of tactic scripts. To do this, it learns from previous tactic scripts and how 
  they are applied to proof states. The performance of the system is evaluated on the Coq Standard Library. Currently, our predictor can identify the correct 
  tactic to be applied to a proof state 23.4% of the time. Our proof searcher can fully automatically prove 39.3% of the lemmas. When combined with the CoqHammer 
  system, the two systems together prove 56.7% of the library’s lemmas.

# Installation instructions
Below are the instructions to install Coq and Tactician through the Opam package manager. If you are familiar with Opam, you can skip the next section.

## Pre-installation

Installation of Coq and Tactician happens through Opam. For people unfamiliar with OCaml and Opam follows a short installation guide for Linux (Windows is unsupported). First, [install](https://opam.ocaml.org/doc/Install.html#Using-your-distribution-39-s-package-system) Opam 2.x through your favorite package manager. You can check that the installed version is bigger than 2.0 by running `opam --version`. Some package managers do not yet include Opam 2.0. For Ubuntu 18.04 a custom ppa is [available](https://opam.ocaml.org/doc/Install.html#Ubuntu). On other systems, you can use a [binary installation script](https://opam.ocaml.org/doc/Install.html#Binary-distribution). After installation, run the following commands to properly configure Opam.

```
opam init # answer yes to any questions the initialization script may ask
eval $(opam env)
opam switch create 4.09.0
eval $(opam env)
```

This should be all that is required to prepare your system to install Coq and Tactician.

## Installation of Coq and Tactician

_Note: Tactician can be installed as an Opam package for Coq. However, the package does do some non-standard things and is not very well-tested yet. If you want to make sure that Tactician will not interfere with your regular Coq development, you might want to install it in a [local switch](https://opam.ocaml.org/blog/opam-local-switches/)._

To install Coq, Coqide (optional but recommended) and Tactician, run the following commands:

```
opam repo add tactician git+https://github.com/coq-tactician/tmp-archive.git
opam install coq coqide coq-tactician
```

Make sure that you read the messages printed after installation. In particular, run `tactician enable` to activate the system. To de-activate the system (for example if you have another switch where Tactician is not installed), you can run `tactician disable`.

## Trying an example

Tactician should now be ready to work. Tactician makes two tactics available to you. First, `suggest` will provide you with a list of tactics that the system thinks will be useful for the current proof state. Second, `search` will try to automatically synthesize a proof for the current goal. We give an example that is also presented in our paper. For this, start CoqIde using

```
coqide &
```

Then, open the [example file](Example.v) into the editor, and play around with it (moving around the document in CoqIde happens using the arrows at the top).

## Recompiling the standard library

By default, Tactician is not able to learn from the standard library. This is because the library was compiled before Tactician was installed, so it was not able to inject itself into the compilation process. We provide another package that will recompile the standard library for you. **Warning: This will backup and overwrite Coq's standard library. Upon removal of the package, the orginal files will be restored.**

```
opam install coq-tactician-stdlib
```

Do not forget to read the post-installation messages. Tactician has now learned from the standard library and should be able to synthesize proofs regarding it. 
