---
title: "About Tactician"
draft: false
---

{{< faq "What is Tactician?" >}}
Tactician is a tactic learner and prover for the Coq Proof Assistant.
The system will help users make tactical proof decisions while they retain
control over the general proof strategy. To this end, Tactician will learn
from previously written tactic scripts, and either gives the user suggestions
about the next tactic to be executed or altogether takes over the burden of
proof synthesis. Tactician's goal is to provide the user with a seamless,
interactive, and intuitive experience together with strong, adaptive proof
automation.
{{</ faq >}}

{{< faq "Can I use Tactician in a complex project with many dependencies?" >}}
Yes, the system has first-class support for Opam, Coq's package manager. When
you install dependencies, Tactician can automatically instrument those
developments and learn from them. When you work on your project, Tactician
will have background knowledge on all modules you `Require`.

On the flip side, using Tactician in your project does not mean you now have a hard
dependency on Tactician. When the system finds a proof, it presents you with
a caching witness that you can copy into your source file. As long as this witness
remains valid, you can compile your project without having the main Tactician code-base
installed. You only need 10 lines of helper tactics, which you can install
through the `coq-tactician-dummy` package, or simply copy them into your development.
{{</ faq >}}

{{< faq "Is Tactician useful for teaching?" >}}
We have not yet performed a large-scale test on students, but we believe that
the system may indeed be used in this capacity. Installation is straightforward
and the system functions on Linux, macOS and Windows. The automation is
push-button style without needing any configuration, and when a proof cannot be
found, Tactician can still suggest tactics that may be useful.
{{</ faq >}}

{{< faq "I have a great Machine Learning idea; can I implement it on top of Tactician?" >}}
At the moment Tactician is not open to the greater machine learning community for
experimentation. However, in the future we would like to offer Tactician as a
platform that allows ML-researchers to create mathematics-solving agents and put
them in the hands of Coq users. For now, we are looking for beta-testers to
collaborate with and give this platform a clear shape. So if you have a good
machine learning for theorem proving idea, please reach out to use to see if
a collaboration is possible.
{{</ faq >}}

{{< faq "How good is Tactician?" >}}
todo
{{</ faq >}}
