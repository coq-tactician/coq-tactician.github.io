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

Lemma concat_nil_r : ∀ ls, ls ++ [] = ls.
suggest. (* does nothing because of an empty database *)
intros.
induction ls.
- simpl. reflexivity.
- simpl. f_equal. apply IHls.
Qed.

Lemma concat_assoc : ∀ ls ls₂ ls₃, (ls ++ ls₂) ++ ls₃ = ls ++ (ls₂ ++ ls₃).
suggest.
search.
(* Try copying in the caching tactic printed by Tactician on the left *)
Qed.

Inductive sublist : list -> list -> Prop :=
| pf_nil : sublist [] []
| pf_cons₁ ls₁ ls₂ n : sublist ls₁ ls₂ -> sublist ls₁ (n::ls₂)
| pf_cons₂ ls₁ ls₂ n : sublist ls₁ ls₂ -> sublist (n::ls₁) (n::ls₂).

Ltac solve_sublist := solve [match goal with
| |- sublist [] [] => apply pf_nil
| |- sublist (_::_) [] => fail
| |- sublist _ _ =>
       (apply pf_cons₁ + apply pf_cons₂); solve_sublist
| |- _ => solve [auto]
end].

Lemma ex1 : sublist (9::3::[]) (4::7::9::3::[]).
solve_sublist.
Qed.
Lemma ex2 ls : 1::2::ls ++ [] = 1::2::ls.
rewrite concat_nil_r. reflexivity.
Qed.

Lemma dec2 ls₁ ls₂: sublist ls₁ ls₂ ->
  sublist (7::9::13::ls₁) (8::5::7::[] ++ 9::13::ls₂ ++ []).
search.
Qed.
