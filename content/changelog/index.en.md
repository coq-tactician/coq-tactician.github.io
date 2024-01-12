---
title: "Changelog posts"
layout: "changelog"
draft: false
---

### Announcing Graph2Tac, a prover based on Tactician's API for external agents

We are pleased to announce [Tactician's API][1], a new AI interface for theorem
proving, building on [Tactician][2]. This includes a new graph-based dataset of
over 520k definitions (of which 260k are theorems) in 120 Coq packages, one of
the largest datasets for AI interactive theorem proving. We also present a new
state-of-the-art neural theorem proving solver Graph2Tac, designed for proving
theorems in Coq projects with new definitions not seen during training.

[1]: https://coq-tactician.github.io/api/introduction/
[2]: https://coq-tactician.github.io/

The main contributions in this work are as follows:
1. A novel method of calculating an internal representation of definitions and
   theorems, giving Graph2Tac a deeper semantic understanding of a proof state
   and which lemmas are appropriate for it. Graph2Tac can create representations
   of objects that were not seen during training, allowing it to perform well
   even on new Coq projects.
2. One of the most comprehensive studies yet of various AI methods in
   interactive theorem proving including k-NN solvers, transformers, graph-based
   models, and hammers.
3. An interface to Coq making it possible to train and connect your own custom
   machine learning models.
4. A benchmarking system making it easy to give an apples-to-apples comparison
   to our work.

For Coq users, our neural models [Graph2Tac and Text2Tac][3], are available as
part of Tactician and can be run on a laptop (no GPU required). One can use
Tactician's `Suggest` command to suggest tactics, and `synth` tactic to find a
complete proof of a proof state.

[3]: https://coq-tactician.github.io/api/graph2tac/

The details are spelled out in these three papers:
- [Graph2Tac: Learning Hierarchical Representations of Math Concepts in Theorem proving][4]
- [The Tactician’s Web of Large-Scale Formal Knowledge][5]
- [Hashing Modulo Context-Sensitive α-Equivalence][6]

[4]: https://arxiv.org/abs/2401.02949
[5]: https://arxiv.org/abs/2401.02950
[6]: https://arxiv.org/abs/2401.02948

[**Dataset**][7]: Our dataset, which can be [explored online][8], faithfully
represents the internal representation of Coq's universe of mathematical
knowledge as a single interconnected graph. The visualization includes
[hierarchies of modules][9], [global context information][10],
[definitions][11], [tactical proofs][12], and [tactic proof
transformations][13].

The dataset contains two representations. The text-based, human-readable
representation is useful for training language models. The graph-based
representation is designed such that two terms are alpha-equivalent terms if and
only if the forward closure of their graphs is equivalent ([bisimilar][15]).
This allows us to merge alpha-equivalent subterms, heavily compressing the
dataset. Having a densely connected graph makes it ideal for graph-based machine
learning models. To support this term-sharing, we introduce a [novel
graph-sharing algorithm][14] with `O(n log n)` complexity.

[7]: https://coq-tactician.github.io/api/datasets/
[8]: http://grid01.ciirc.cvut.cz:8080
[9]: http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init
[10]: http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init/Logic/context
[11]: http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init/Logic/definition/36
[12]: http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init/Logic/definition/36/proof
[13]: http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init/Logic/definition/36/proof/step/4/outcome/0

[14]: https://arxiv.org/abs/2401.02948
[15]: https://en.wikipedia.org/wiki/Bisimulation

![Visualization of Coq's universe of mathematical knowledge](https://coq-tactician.github.io/images/web.png)

[**Graph2Tac**][16]: In practical AI theorem proving, one of the main challenges
is handling new definitions and theorems not seen during training. We want a
model which can work online, adapting itself to users' new projects in real
time, so we train on one set of projects and test on another set never seen
during training. Our novel neural theorem proving architecture, Graph2Tac, adds
a new definition task mechanism that improves theorems solved from 17.4% to
26.1%. For example, even though our model has never before seen the Poltac
package, it can solve 86.7% of Poltac theorems, more than any other Coq theorem
prover in the literature, including ProverBot9001 and CoqHammer.

[16]: https://coq-tactician.github.io/api/graph2tac/

Our definition task works by learning an embedding for each definition and
theorem in the training set, and then simultaneously training a model to predict
those learned embeddings. At inference time, when we encounter a new definition
not seen during training, we use this definition task to compute its embedding
directly.

![Graph2Tac overview](https://coq-tactician.github.io/images/graph2tac-overview.png)

Our work contains one of the most extensive comparisons with other proving
methods, including CoqHammer, a baseline transformer, and Tactician's built-in
k-NN model. The transformer model is similar to those used in GPT-f, PACT, Lisa,
etc. The k-NN model is also an online model, learning from proofs or recent
theorems, and is actually still an excellent model for short time periods, say
one minute, whereas Graph2Tac excels at the longer 10-minute mark. Appendix H of
our [paper][20] also provides an informal comparison with Proverbot9001 and
CoqGym family of solvers. We hope these comparisons will provide a lot of
discussion and move the field forward.

![comparison](https://coq-tactician.github.io/images/model_times.png)

**Tools for AI research** We provide a lot of tools for AI researchers who would
like to compare with or build on our results and for Coq developers who would
like to build practical tools for Coq users.

- [*Interaction protocols*][17]: External agents can interface with Coq, either by
providing tactic predictions for Tactician’s search procedure for the `synth`
tactic, or by exploring the proof tree themselves through the `Tactician
Explore` command. Agents receive a full copy of Coq’s internal kernel knowledge,
which they can utilize to make decisions.

- [*PyTactician*][18]: A Python library to facilitate reading the dataset and
interface with Coq.

- [*Benchmarking*][19]: Tools to evaluate the proving strength of agents on
arbitrary Opam packages. Benchmarks can be run on a laptop, a high-powered
server and even massively parallelized on a High Performance Computing (HPC)
cluster.

We would love to receive feedback both from Coq users and AI researchers,
including possible future collaborators!

Lasse Blaauwbroek, Jason Rute, Miroslav Olšák, Fidel Ivan Schaposnik Massolo,
Jelle Piepenbrock, Vasily Pestun

[17]: https://coq-tactician.github.io/api/commands/
[18]: https://coq-tactician.github.io/api/pytactician/
[19]: https://github.com/coq-tactician/benchmark-system
[20]: https://arxiv.org/pdf/2401.02949v2.pdf#page=22

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
