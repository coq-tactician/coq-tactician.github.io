---
title: "PyTactician"
weight: 6
draft: false
layout: docs
---

PyTactician is a library to help write proving agents and explore datasets.
The major version number `x` of this library
indicates the version of the dataset and communication protocol. Any PyTactician
version `x.y` is compatible with the communication protocol `x`.

### Installation

Binary wheels are provided for Linux and MacOS (on
[PyPI](https://pypi.org/project/pytactician)). On those platforms you can
install by executing `pip install pytactician`. If you need to install from
source, you need to have Cap'n Proto >= 0.8 installed on your system. See the
main repo
[README](https://github.com/coq-tactician/coq-tactician-api#prerequisites) for
more details on prerequisites. Once you have the prerequisites, you can install
by running `pip install .` from the root of the repository.

### Usage

PyTactician provides a library to work with the datasets extracted from Coq and
to directly interface with Coq through Tacticians API.
- [PyTactician Library Documentation](https://coq-tactician.github.io/api/pytactician-pdoc).
- To get started quickly, there are some simple [example
  scripts](https://coq-tactician.github.io/api/pytactician-pdoc/pytact/scripts.html)
  that interface with the [dataset](../datasets).

In addition, PyTactician contains a number of executables that can be used to
analyze datasets and interact with Coq. Available executables are as follows
(use the `--help` flag for each executable to learn about all the options).

- `pytact-check [-h] [--jobs JOBS] [--quick] [--verbose VERBOSE] dir`
   Run sanity checks on a dataset and print some statistics.
- `pytact-visualize [-h] [--port PORT] [--hostname HOSTNAME] [--dev] [--fast | --workers WORKERS] dataset`:
   Start an interactive server that visualizes a dataset.
- `pytact-server [-h] [--tcp TCP] [--record RECORD_FILE] {graph,text}`
  Example python server capable of communicating with Coq through Tactician's 'synth' tactic
  To learn how to interface Coq and Tactician with this server, see the sections below.
- `pytact-oracle [-h] [--tcp PORT] [--record RECORD_FILE] {graph,text} dataset`
  A tactic prediction server acting as an oracle, retrieving it's information from a dataset
- `pytact-fake-coq [-h] (--tcp TCP_LOCATION | --stdin EXECUTABLE) data`
  A fake Coq client that connects to a prediction server and feeds it a stream of previously recorded messages.
- `pytact-prover`: A dummy example client that interfaces with Coq and Tactician for proof exploration
  driven by the client.
