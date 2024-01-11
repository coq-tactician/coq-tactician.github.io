---
title: "Changelog posts"
layout: "changelog"
draft: false
---

### Announcing Graph2Tac and Text2Tac provers based on Tactician's API for external agents

We are happy to announce the availability of two neural proving agents,
[Graph2Tac & Text2Tac](https://coq-tactician.github.io/api/graph2tac/), based on
Tactician's new [API for external
agents](https://coq-tactician.github.io/api/introduction/). These agents help
proof engineers synthesize new tactic proofs. Both systems take a deep learning
approach to predict appropriate tactics for proof states:

- **Graph2Tac** is a novel graph neural network architecture. It's crucial
  innovation is that it can build an understanding of the math concepts in an
  entire Coq development and all of its dependencies on-the-fly. That is, it
  analyzes the structure of definitions and lemmas and builds an internal
  representation of each object in the global context. Then, when presented with
  a proof state that references these mathematical concepts, Graph2Tac can
  leverage its deep knowledge to predict tactics and arguments.
- **Text2Tac** is a language model for synthesizing tactics. It receives the
  current proof state as a human-readable prompt and “completes” this prompt by
  synthesizing a tactic.

Both solvers are deeply integrated into Coq through the Tactician platform and
its new API. Coq users can ask the models for tactic suggestions through the
`Suggest` command. Proof search can be initiated with the `synth` tactic.
Installation instructions can be found
[here](https://coq-tactician.github.io/api/graph2tac/). Details on the
architecture, and performance of the models are found in the paper [Graph2Tac:
Learning Hierarchical Representations of Math Concepts in Theorem
proving](https://arxiv.org/abs/2401.02949).

Graph2Tac and Text2Tac are made possible by Tactician's new capability to export
Coq's knowledge base to external agents. This allows solving agents to be
written in any programming language, such as Python. Tactician's API is intended
as a platform where machine learning researchers and proof engineers come
together. Machine learning researchers can utilize Tactician's datasets,
interaction protocols and benchmarking functionality to build and evaluate new
proving agents. These agents can be integrated into the workflow of proof
engineers. See the
[introduction](https://coq-tactician.github.io/api/introduction/) for more
information. The platform consists of the following components:

- **[Datasets](https://coq-tactician.github.io/api/datasets/)**: Pre-made, large-scale datasets of formal
  knowledge extracted from a variety of Coq developments. Interactively explore
  the dataset [here](http://grid01.ciirc.cvut.cz:8080/). The dataset includes [hierarchies](http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init) of modules, [global context](http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init/Logic/context) information, [definitions](http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init/Logic/definition/36), [tactical proofs](http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init/Logic/definition/36/proof) and tactic [proof transformations](http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init/Logic/definition/36/proof/step/4/outcome/0).
  The dataset encodes data both as text and as a graph.
  + The text-based representation is meant to be human-readable and would typically be used to train language models.
  + The graph-based representation aims to provide complete and faithful
    representation of Coq's internal knowledge. The graph is a single,
    interconnected web of data that is designed to be as explicit as possible.
    It would typically be used to train graph neural networks.
- **[Interaction protocols](https://coq-tactician.github.io/api/commands/)**: External agents can interface with Coq, either by providing tactic predictions for Tactician's search procedure for the `synth` tactic, or by exploring the proof tree themselves through the `Tactician Explore` command. Agents receive a full copy of Coq's internal kernel knowledge, which they can utilize to make decisions.
- **[PyTactician](https://coq-tactician.github.io/api/pytactician/)**: A Python library to facilitate reading the dataset and interface with Coq.
- **[Benchmarking](https://github.com/coq-tactician/benchmark-system)**: Tools
  to evaluate the proving strength of agents on arbitrary Opam packages.
  Benchmarks can be run on a laptop, a high-powered server and even massively
  parallelized on a High Perfomance Computing (HPC) cluster.

A detailed exposition on the datasets, the construction of the graph-based
representation, construction of machine-readable tactic proofs and more can be
found in these publications:
- [The Tactician's Web of Large-Scale Formal Knowledge](https://arxiv.org/abs/2401.02950)
- [Hashing Modulo Context-Sensitive α-Equivalence](https://arxiv.org/abs/2401.02948)

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
