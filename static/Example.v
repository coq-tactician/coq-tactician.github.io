Require Import Utf8.

Inductive list :=
| nil  : list
| cons : nat → list → list.

Notation "[]" := nil.
Notation "x :: ls" := (cons x ls).

Fixpoint concat ls₁ ls₂ :=
  match ls₁ with
  | []      => ls₂
  | x::ls₁' => x::(concat ls₁' ls₂)
  end where "ls₁ ++ ls₂" := (concat ls₁ ls₂).

(* First we teach the automation something, simply by proving a lemma. *)
Lemma concat_nil_r : forall ls, ls ++ [] = ls.
Proof.
intros.
induction ls.
- simpl. reflexivity.
- simpl. f_equal. apply IHls.
Qed.

(* The system has immediately learnt from this lemma, and is now ready to
   help you prove the next one: *)
Lemma concat_assoc : forall ls ls₂ ls₃, (ls ++ ls₂) ++ ls₃ = ls ++ (ls₂ ++ ls₃).
Proof.
Suggest.
synth.
(* Try copying in the caching tactic printed by Tactician on the right *)
Qed.

(* This is a more advanced example of how to teach the automation about custom
   Ltac definitions. *)
Inductive nc_sublist : list -> list -> Prop :=
| ns_nil : nc_sublist [] []
| ns_cons₁ ls₁ ls₂ n : nc_sublist ls₁ ls₂ -> nc_sublist ls₁ (n::ls₂)
| ns_cons₂ ls₁ ls₂ n : nc_sublist ls₁ ls₂ -> nc_sublist (n::ls₁) (n::ls₂).

Ltac solve_nc_sublist := solve [match goal with
| |- nc_sublist [] [] => apply ns_nil
| |- nc_sublist (_::_) [] => fail
| |- nc_sublist _ _ =>
       (apply ns_cons₁ + apply ns_cons₂); solve_nc_sublist
| |- _ => solve [auto]
end].

Lemma ex1 : nc_sublist (9::3::[]) (4::7::9::3::[]).
solve_nc_sublist.
Qed.
Lemma ex2 ls : 1::2::ls ++ [] = 1::2::ls.
rewrite concat_nil_r. reflexivity.
(* Note that 'synth' can also find a proof by repoving concat_nil_r.
   However, we need the example of rewriting with concat_nil_r for the next
   lemma. *)
Qed.

Lemma dec2 ls₁ ls₂: nc_sublist ls₁ ls₂ ->
  nc_sublist (7::9::13::ls₁) (8::5::7::[] ++ 9::13::ls₂ ++ []).
synth.
Qed.
