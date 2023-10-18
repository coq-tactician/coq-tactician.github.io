---
title: "Usage"
weight: 3
draft: false
---

After installation, it is easy to get started with Tactician. There are only two important commands,
described in the section below. Below, we assume that you have executed `tactician enable`, so that Tactician
is active when you start a new interactive document. You can try the commands below on our
[example file](/Example.v).

#### Basic commands

- `Suggest` is a query that will—as its name implies—suggest a list of tactics that may be useful to progress
in the current proof state of your lemma. You can simply copy them into your interactive document and run them
as any other tactic. It is not recommended to permanently keep the query `Suggest` in your developments.

- `synth` is a tactic that will try to synthesize a complete proof of the current goal. It does this based on
the same suggestions as issued by `Suggest`. This tactic will run for as long as you let it, so when you run
out of patience you might want to hit the 'interrupt' button in your editor. When the tactic finds a proof,
two things will happen.
    - The current goal will be finished, allowing you to move on to the next branch of the proof. This is
    convenient when you want to progress through the proof quickly and without any hassle.
    - Tactician will issue a caching _tactic witness_ of the form
      ```coq
      synth with cache (t1; t2; ..; tn).
      ```
      You can copy this witness, and replace the original invocation of `synth` with it. The result will be
      that the next time you execute this command, the system will first try to execute the provided witness.
      If this succeeds, the command will quickly terminate so that you do not have to wait for Tactician to
      prove goals time and time again while you navigate through an interactive document.

      On the other hand, if the tactic witness turns out to be invalid (presumably due to a change in a
      definition or the statement of the current lemma), a new proof search will automatically be initiated
      to attempt a recovery of the witness.

#### Auxiliary commands and usages

In addition to `Suggest` and `synth`, we provide the following commands for more advanced use-cases.

- `Debug Suggest` and `debug synth` are variations of the commands above that will output debugging information.

- `tactician ignore tac` will execute the tactic `tac`, but while hiding it from Tacticians machine learning
  component. This can be useful when you use a tactic you know will confuse Tactician. One example is the unsafe
  tactic [`change_no_check`](https://coq.inria.fr/refman/proof-engine/tactics.html#coq:tacn.change-no-check),
  which allows the system to easily prove any proof state it wants. Note that Tactician will automatically ignore
  `admit`.

  It is important to note that `tactician ignore` is not guaranteed to hide a tactic from Tactician when used
  as part of a larger tactic expression. For example, for the tactic expression
  ```coq
  solve [tactician ignore constructor; auto].
  ```
  it is guaranteed that the system will not learn from the individual tactic `constructor`. However, this
  tactic may or may not be used by Tactician as part of the larger expression. Whether or not this will happen
  depends on the version of Tactician and its internal settings.

- `Unset Tactician Record` will disable any further tactic recording for machine learning purposes by tactician.
  This can later be re-enabled with `Set Tactician Record`. Disabling Tactician can be useful when you want
  to define and prove some lemmas you do not want Tactician to know about. Another useful idiom is
  ```coq
  Unset Tactician Record.
  Require Import SecretLibrary.
  Set Tactician Record.
  ```
  This will hide all the contents of `SecretLibrary` from Tactician.

- It is possible and sometimes useful to perform nested invocations of `synth`. By default, Tactician will
  refrain from learning from its own commands, such as `synth`. However, this is not the case when you use it
  as part of a tactic expression. An example is the expression
  ```coq
  solve [constructor; synth].
  ```
  When you execute this tactic, the `synth` command will be part of Ltac's backtracking behavior, as expected.
  Additionally, Tactician will pick up the whole expression as a future way to prove a goal. As such, when you
  next execute `synth`, Tactician may start to nest these invocations with backtracking behavior. To keep this
  under control, nested search is bound to a depth of one.

  If you execute the command above, but do not want Tactician to start doing nested searches, you might want to
  wrap it in `tactician ignore`:
  ```coq
  tactician ignore solve [constructor; synth].
  ```
