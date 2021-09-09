---
title: "Publications"
weight: 1
draft: false
layout: "changelog"
---

- [Online Machine Learning Techniques for Coq: A Comparison](https://link.springer.com/chapter/10.1007%2F978-3-030-81097-9_5)
  **Abstract:** We present a comparison of several online machine learning techniques for tactical learning and proving in the Coq proof assistant. This work builds on top of Tactician, a plugin for Coq that learns from proofs written by the user to synthesize new proofs. Learning happens in an online manner, meaning that Tactician’s machine learning model is updated immediately every time the user performs a step in an interactive proof. This has important advantages compared to the more studied offline learning systems: (1) it provides the user with a seamless, interactive experience with Tactician and, (2) it takes advantage of locality of proof similarity, which means that proofs similar to the current proof are likely to be found close by. We implement two online methods, namely approximate k-nearest neighbors based on locality sensitive hashing forests and random decision forests. Additionally, we conduct experiments with gradient boosted trees in an offline setting using XGBoost. We compare the relative performance of Tactician using these three learning methods on Coq’s standard library.

- [The Tactician: A Seamless, Interactive Tactic Learner and Prover for Coq](https://doi.org/10.1007/978-3-030-53518-6_17)
  
  **Note:** An extended version of this paper is available [on arXiv](https://arxiv.org/abs/2008.00120)
  
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
