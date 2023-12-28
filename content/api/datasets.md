---
title: "Datasets"
weight: 7
draft: false
layout: docs
---

Datasets are published on Zenodo:

- [Data for API v15 on Coq v8.11](https://zenodo.org/records/10028721)

Interactively explore
  the dataset [here](http://grid01.ciirc.cvut.cz:8080/). The dataset includes [hierarchies](http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init) of modules, [global context](http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init/Logic/context) information, [definitions](http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init/Logic/definition/36), [tactical proofs](http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init/Logic/definition/36/proof) and tactic [proof transformations](http://grid01.ciirc.cvut.cz:8080/coq-tactician-stdlib.8.11.dev/theories/Init/Logic/definition/36/proof/step/4/outcome/0).

The data is encoded using the [Cap'n Proto serialization protocol][4], allowing
for fast random access to the graph and metadata from many programming
languages. The (latest) schema file can be found in
[graph_api.capnp](https://github.com/coq-tactician/coq-tactician-api/blob/coq8.11/graph_api.capnp).
For each Coq compilation unit `X`, the dataset includes the original `X.v` source file.
Alongside that file is a `X.bin` file with Cap'n Proto structure containing the
data extracted during the compilation of `X`.

[4]: https://capnproto.org

For Python, a library called [PyTactician][5] is provided that allows for easy
and efficient access to the data. It includes software to visualize the dataset,
a sanity checker for the dataset, an example prediction server that interfaces
with Coq, an Oracle prediction server and an example proof exploration client.
This library is a good starting point to explore the dataset.

[5]: ../pytactician

The data in this archive is represented as a [SquashFS][6] image `dataset.squ`.
If you are using PyTactician, you can load the dataset by pointing
directly to this image. This will automatically mount the image in directory
`dataset/`. For example:

    pytact-check dataset.squ
    pytact-visualize dataset.squ

In order to make this work, [squashfuse][7] needs to be installed through your
favorite package manager. If you prefer to mount manually, or if you are not
using the PyTactician library, you can mount the image using

    squashfuse dataset.squ dataset/
    pytact-check dataset/
    pytact-visualize dataset/

If you have root access, you can mount the image more efficiently through

    mount dataset.squ dataset/

Finally, you can also unpack the image without mounting it. However, on systems
with limited memory or slow hard-disks this will lead to performance
degradations while accessing the dataset. Experiments show that due to the high
decompression speed of the image's LZ4 compression algorithm, mounting is almost
always preferrable to unpacking. Nevertheless, if you wish to unpack, you can
run:

    unsquashfs -dest dataset/ dataset.squ

If you wish to inspect the raw data in the dataset manually, you can use [capnp
convert][8] to decode an individual file in the dataset to JSON as follows:

    cat dataset/coq-tactician-stdlib.8.11.dev/theories/Init/Logic.bin | \
        capnp convert binary:json meta/graph_api.capnp Dataset

You can process the resulting JSON further using, for example, the `jq` command.

[6]: https://docs.kernel.org/filesystems/squashfs.html
[7]: https://github.com/vasi/squashfuse
[8]: https://capnproto.org/capnp-tool.html
