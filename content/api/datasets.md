---
title: "Datasets"
weight: 7
draft: false
layout: docs
---

#### Online Data Explorer

You can explore and visualize the latest dataset that has been extracted from
Coq online. The visualization should give you some intuition about what kind of
data is available and how it is encoded. If this data is interesting to you, you
can find download and usage instructions below.

<img src="/images/visualization_example.svg" alt="Visualization Example" style="float:right" width="40%">

You can find the main entry-point for the visualization [here](http://grid01.ciirc.cvut.cz:8080/).
From there, you can explore the entire dataset. Examples of objects include:
- [Module hierarchies](http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init) showing dependencies between compilation units
- [Global contexts](http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init/Logic/context) of a compilation units
- [Individual definitions](http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init/Logic/definition/36) within a global context
- [Tactical proofs](http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init/Logic/definition/36/proof) of theorems
- [Individual Proof transformations](http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init/Logic/definition/36/proof/step/4/outcome/0) of tactical proofs

#### Downloads

Datasets are published on Zenodo:

- [Data for API v15 on Coq v8.11](https://zenodo.org/records/10028721)

#### Accessing the data

The data is encoded using the [Cap'n Proto serialization protocol][4], allowing
for fast random access to the graph and metadata from many programming
languages. For Python, a library called [PyTactician][5] is provided that allows
for easy and efficient access to the data. It includes software to visualize the
dataset, a sanity checker for the dataset, an example prediction server that
interfaces with Coq, an Oracle prediction server and an example proof
exploration client. This library is a good starting point to explore the
dataset. If you are looking to use another language to access the data, your
starting point would be the [graph_api.capnp schema
file](https://github.com/coq-tactician/coq-tactician-api/blob/coq8.11/graph_api.capnp).

[4]: https://capnproto.org

[5]: ../pytactician

The data in the archive is represented as a [SquashFS][6] image `dataset.squ`.
In order to access the data, you can either mount it or decompress it. Mounting
is preferred on machines with limited memory. To mount, you need to install
[squashfuse][7] through your favorite package manager.

**Note for MacOS users:** Squashfuse is not available on MacOS. You can instead
install [squashfs][9] from Brew and decompress the dataset using the
`unsquashfs` instructions below.

Once squashfuse is installed, if you are using [PyTactician][5], you can load the
dataset by pointing directly to this image. This will automatically mount the
image in directory `dataset/`. For example:

    pytact-check dataset.squ
    pytact-visualize dataset.squ

If you prefer to mount manually, or if you are not using the PyTactician
library, you can mount the image using

    squashfuse dataset.squ dataset/
    pytact-check dataset/
    pytact-visualize dataset/
    umount dataset/ # Unmount the dataset, optional

Finally, you can also unpack the image without mounting it (this is the only
option for MacOS). On systems with limited memory or slow hard-disks this will
lead to some performance degradations while accessing the dataset. If you wish
to unpack, you can run:

    unsquashfs -dest dataset/ dataset.squ

#### Introspecting the dataset with PyTactician

You can use [PyTactician][5] as a library to write scripts that extract
information from the dataset. To get started, you can take a look at some simple
[example scripts][10]. Documentation of the API is also [available][11].

#### Raw data inspection

For each Coq compilation unit `X`, the dataset includes the original `X.v` source file.
Alongside that file is a `X.bin` file with Cap'n Proto structure containing the
data extracted during the compilation of `X`.

If you wish to inspect the raw data in the dataset manually, you can use [capnp
convert][8] to decode an individual file in the dataset to JSON as follows:

    cat dataset/coq-tactician-stdlib.8.11.dev/theories/Init/Logic.bin | \
        capnp convert binary:json meta/graph_api.capnp Dataset

You can process the resulting JSON further using, for example, the `jq` command.

[6]: https://docs.kernel.org/filesystems/squashfs.html
[7]: https://github.com/vasi/squashfuse
[8]: https://capnproto.org/capnp-tool.html
[9]: https://formulae.brew.sh/formula/squashfs
[10]: https://coq-tactician.github.io/api/pytactician-pdoc/pytact/scripts.html
[11]: https://coq-tactician.github.io/api/pytactician-pdoc/pytact/data_reader.html
