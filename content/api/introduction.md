---
title: "API Introduction"
weight: 2
draft: false
layout: docs
---

<img src="/images/web.png" alt="Web" width="100%"/>

Tactician's API provides external machine learning agents with Coq's internal
knowledge-base of mathematics. It can extract large-scale datasets from a wide
variety of Coq packages for the purpose of offline machine learning.
Additionally, it allows agents to interact with Coq. Proving servers can be
connected to Tactician's `synth` tactic and prove theorems for Coq users.
Additionally, servers can do proof exploration through the `Tactician Explore`
command. Examples of external proving agents include [Graph2Tac & Text2Tac](../graph2tac).

The data provided to agents includes definitions, theorems, proof terms and a
machine-readable representation of tactical proofs. The data is provided both in
Coq's standard text-based human-readable format and as a semantic graph. The
semantic graph is a single interconnected object that includes the entire
mathematical universe known to Coq (at a given moment in time). As such, it
provides external agents with "complete information" of Coq's internal state,
instead of "incomplete information". The agent does not need to query Coq for
information about theorems or definitions, because it has an always-up-to-date
view.

The graph is designed to represent the semantic meaning of a mathematical object
as faithfully as possible, minimizing the amount of implicit knowledge needed to
interpret the object. For example, when a definition `X` refers to another
definition `Y`, such a dependency is encoded explicitly using an edge in the
graph. No definition lookup table is need. We also shy away from using names or
de Bruijn indices as variables. Instead, variables point directly to their
binders, so that name lookup becomes a trivial operation. Such an encoding
reduces alpha-equivalence between terms to the graph-theoretic notion of
bisimilarity, and allows us to globally deduplicate any alpha-equivalent terms
in the graph.

A simple example of the semantic graph is shown below. An entire Coq document is
converted into a single graph. Alpha-equivalent sub-terms, such as `2*` are
globally shared. The graph includes all transitive objects referenced by
the document, such as `nat`, `=`, `+` and `*` (shown with a truncated tree here).

<img src="/images/web-example.svg" alt="Web example" style="display:block; margin-left: auto; margin-right: auto" width="90%"/>

A zoomed-out view of the graph is visualized on the top of this page. This graph
contains all information encoded in Coq's Prelude. See the
[paper](https://arxiv.org/abs/2401.02950) for details on the construction of the
graph.

Communication with agents happens through the [Cap'n
Proto](https://capnproto.org) serialization format and remote procedure calling
(RPC) protocol. It supports a wide variety of programming languages, including
Python, OCaml, C++, Haskell, Rust and more. This serialization was chosen
because it allows us to memory-map (`mmap`) large graph datasets, allowing fast
random-access to graphs that may not fit into main memory. Furthermore, Cap'n
Proto's RPC protocol, based on the [distributed
object-capability](https://en.wikipedia.org/wiki/Distributed_object) model,
allows us to export Coq's proof states to external agents. Agents can inspect
the proof states, and execute tactics on them, allowing exploration of the proof
search space in arbitrary order.

### Overview of the platform

Tactician's API is meant to provide a bridge between the machine learning
community and the proof engineering community. On the one hand, ML researchers
can leverage the formal knowledge generated by proof engineers to build, train
and evaluate agents. In return, these agents can be provided to proof engineers
to assist them in synthesizing more formal knowledge. Agents can be integrated
into the day-to-day workflow of proving and programming in Coq.

Components include:
- **[Graph2Tac & Text2Tac](../graph2tac)**: Pre-trained models that can make tactic predictions and integrate with Tactician's `synth` command. The first model uses the graph-based representation while the second model uses human-readable text.
- **[Datasets](../datasets)**: Pre-made, large-scale datasets of formal
  knowledge extracted from a variety of Coq developments. Interactively explore
  the dataset [here](http://grid01.ciirc.cvut.cz:8080/). The dataset includes [hierarchies](http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init) of modules, [global context](http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init/Logic/context) information, [definitions](http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init/Logic/definition/36), [tactical proofs](http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init/Logic/definition/36/proof) and tactic [proof transformations](http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init/Logic/definition/36/proof/step/4/outcome/0).
- **[Coq Commands](../commands)**: Outlines the commands added to Tactician by
  the package `coq-tactician-api` for the purpose of interacting with external
  agents.
- **[PyTactician](../pytactician)**: A Python library build on top of Cap'n
  Proto to facilitate reading the dataset and interface with Coq.
- **[Benchmarking](https://github.com/coq-tactician/benchmark-system)**: Tools
  to evaluate the proving strength of agents on arbitrary Opam packages.
  Benchmarks can be run on a laptop, a high-powered server and even massively
  parallelized on a High Perfomance Computing (HPC) cluster.





