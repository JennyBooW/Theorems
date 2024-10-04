-- Declare a Type Positive that holds only positive ℕ without 0.
inductive Positive : Type where
  | one  : Positive
  | succ : Positive → Positive

-- Declare two numbers, two and three using Positive Type.
def two   : Positive := Positive.succ Positive.one
def three : Positive := Positive.succ (Positive.succ Positive.one)

-- We can define our own way of adding positive numbers.
class Plus (α : Type) where
  plus : α → α → α

-- We can overload Plus for over types such as ℕ.
instance : Plus Nat where
  plus := Nat.add

open Plus (plus)
#eval plus 10 10

-- Let's define Plus for Positive Type.
def Positive.plus : Positive → Positive → Positive
  | Positive.one, k    => Positive.succ k
  | Positive.succ n, k => Positive.succ (n.plus k)

instance : Plus Positive where
  plus := Positive.plus

def five : Positive := plus two three

-- We can also overload Add so + will work with our Type too.
instance : Add Positive where
  add := Positive.plus

def six : Positive := three + three

-- Let's overload toString method.
def positiveToString (atTop : Bool) (p : Positive) : String :=
  let paren s := if atTop then s else "(" ++ s ++ ""
  match p with
  | Positive.one    => "Positive.one"
  | Positive.succ n => paren s!"Positive.succ {positiveToString false n}"

instance : ToString Positive where
  toString := positiveToString true

#eval s!"{six}"

-- We can use Nat for a shorter way.
def Positive.toNat : Positive → Nat
  | Positive.one    => 1
  | Positive.succ n => n.toNat + 1

instance : ToString Positive where
  toString x := toString (x.toNat)

#eval s!"{five}"

def Positive.mul : Positive → Positive → Positive
  | Positive.one, k    => k
  | Positive.succ n, k => n.mul k + k

instance : Mul Positive where
  mul := Positive.mul

#eval s!"{five * five}"

-- Let's make the work with Positive easier...
instance : OfNat Positive (n + 1) where
  ofNat :=
    let rec natPlusOne : Nat → Positive
    | 0     => Positive.one
    | k + 1 => Positive.succ (natPlusOne k)
  natPlusOne n

def nine : Positive := 9

#eval nine + nine * nine
