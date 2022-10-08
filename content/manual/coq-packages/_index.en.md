---
title: "Coq packages"
weight: 4
draft: false
---

Tactician has first-class support for packages installed through the [Opam](https://opam.ocaml.org/) package
manager. Below we explain how to install Coq packages in such a way that Tactician can learn from its contents.
We also give recommendations on packaging your own development when you use Tactician in this development.

#### Instrumenting Coq packages

To instrument packages such that Tactician can learn from them during compilation/installation, you simply
execute the following command:
```bash
tactician inject
```
After that, almost any package installed through `opam install` will be instrumented. There are some exceptions,
such as developments that come with their own standard library. For these developments special support can be
built into Tactician. Currently, there is special support for these packages:
- [coq-hott](http://coq.io/opam/coq-hott.8.11.html)

If your favorite package cannot currently be instrumented, please open an
[issue](https://github.com/coq-tactician/coq-tactician/issues).

If at any point you want to remove Tactician instrumentation from the build process, you can run
`tactician eject`. This command will also help you recompile your currently installed packages to remove
Tactician support.

**Note:** On macOS, due to limitations of the operating system, some packages cannot be instrumented. Currently only coq-hott is known not to work.

#### Packaging developments while using Tactician

When you work on a Coq development that is intended to be packaged with Opam, we recommend that you do _not_
create a hard dependency on the `coq-tactician` package. This will create an unnecessary burden on your users,
who might not want to use Tactician. For this reason, it is recommended that you enable Tactician in your
day-to-day work by loading it through your `coqrc` file. The command `tactician enable` will help you with this.

This does leave the question how users can compile Tactician's commands _not_ having Tactician installed. To
resolve this, your package can depend on `coq-tactician-dummy` (or you can just copy
[this](https://github.com/coq-tactician/coq-tactician-dummy/blob/master/theories/Ltac1Dummy.v) 12 line file
into your development). You can load this package using
```coq
From Tactician Require Import Ltac1Dummy.
```

The dummy package contains trivial implementations of Tactician commands. In particular:

- `search` will generate an error. You should modify all instances of `search` to include the generated
   witness of the form `search with cache tac`. The dummy version will try to use the witness, but does not
   perform a new search when the witness fails.
- The tactic `tactician ignore tac` is simply a wrapper for `tac`.
- The option `Unset Tactician Record` will do nothing. However, it will generate a warning. If you want to
  ignore this warning, you can surround these commands as follows:
  ```coq
  Set Warnings "-unknown-option".
  Unset Tactician Record.
  Set Warnings "unknown-option".
  ```
- `Suggest` is not functional, and you should not keep this command in your development when you release it.
