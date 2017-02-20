theory prog_prov
imports Main
begin

fun conj :: "bool \<Rightarrow> bool \<Rightarrow> bool" where
"conj True True = True" |
"conj _ _ = False"
  
fun add :: "nat \<Rightarrow> nat \<Rightarrow> nat" where
"add 0 n = n" |
"add (Suc m) n = Suc (add m n)"

lemma add_02: "add m 0 = m"
  apply(induction m)
   apply(auto)
    done

fun app :: "'a list \<Rightarrow> 'a list \<Rightarrow> 'a list" where
"app Nil ys = ys" | 
"app (Cons x xs) ys = Cons x (app xs ys)"  


fun rev :: "'a list \<Rightarrow> 'a list" where
"rev Nil = Nil" |
"rev (Cons x xs) = app (rev xs) (Cons x Nil)"

value "rev(Cons True (Cons False Nil))"

value "rev(Cons a (Cons b Nil))"

lemma app_Nil2 [simp]: "app xs Nil = xs"
apply (induction xs)
apply(auto)
done

lemma app_assoc [simp]: "app (app xs ys) zs = app xs (app ys zs)"
apply (induction xs)
apply(auto)
done

lemma rev_app [simp]: "rev (app xs ys) = app (rev ys) (rev xs)"  
apply(induction xs)
apply(auto)
done

value "1+(2::nat)"
value "1+(2::int)"
value "1-(2::nat)"
value "1-(2::int)"

lemma add_assoc_0 [simp] : "add a 0 = add 0 a"
apply(induction a)
apply(auto)
done

lemma add_app_l [simp]: "Suc (add a b) = add (Suc a) b"
apply(induction a)
apply(auto)
done


type_synonym string = "char list"

datatype 'a tree = Tip | Node "'a tree" 'a "'a tree"

fun mirror:: "'a tree \<Rightarrow> 'a tree" where
"mirror Tip = Tip" |
"mirror (Node l a r) = Node (mirror r) a (mirror l)"

lemma "mirror (mirror t) = t"
apply(induction t)
apply(auto)
done

datatype 'a option = None | Some 'a

fun lookup:: "('a * 'b) list \<Rightarrow> 'a \<Rightarrow> 'b option" where
"lookup [] x = None" |
"lookup ((a, b)# ps) x = (if a=x then Some b else lookup ps x)"

definition sq :: "nat \<Rightarrow> nat" where
"sq n = n * n"

abbreviation sq' :: "nat \<Rightarrow> nat" where
"sq' n \<equiv> n * n"

fun div2 :: "nat \<Rightarrow> nat" where
"div2 0 = 0"
| "div2 (Suc 0) = 0"
| "div2 (Suc(Suc n)) = Suc (div2 n)"

lemma "div2(n) = n div 2"
apply(induction n rule: div2.induct)
apply(auto)
done

fun itrev :: "'a list \<Rightarrow> 'a list \<Rightarrow> 'a list" where
"itrev [] ys = ys"
| "itrev (x#xs) ys = itrev xs (x#ys)"

lemma "\<forall> x. \<exists> y. x = y" by auto

lemma "A \<subseteq> B \<inter> C \<Longrightarrow> A \<subseteq> B \<union> C" by auto

lemma "\<lbrakk>\<forall> xs \<in> A. \<exists> ys. xs = ys @ ys; us \<in> A \<rbrakk> \<Longrightarrow> \<exists> n. length us = n + n"
  by fastforce
    
lemma "\<lbrakk>\<forall> x y. T x y \<or> T y x; \<forall> x y. A x y \<and> A y x \<longrightarrow> x = y; \<forall> x y. T x y \<longrightarrow> A x y \<rbrakk> \<Longrightarrow> 
\<forall> x y. A x y \<longrightarrow> T x y" by blast

lemma "\<lbrakk> (a::nat)\<le>x+b; 2*x < c\<rbrakk> \<Longrightarrow> 2*a +1 \<le> 2*b +c " by arith

inductive ev :: "nat\<Rightarrow>bool" where 
  ev0 : "ev 0"
  | evSS : "ev n \<Longrightarrow> ev (n+2)"

datatype 'a queue = AQueue "'a list" "'a list"
  
definition empty:: "'a queue" where
  "empty = AQueue [] []"
    
export_code empty in OCaml
  module_name tutorial file "tutorial.ocaml"

end