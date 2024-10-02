def onePlusOneIsTwo : 1 + 1 = 2 := rfl

def onePlus : Prop := 1 + 1 = 2


theorem onePlusOne : 1 + 1 = 2 := by
  simp

theorem onePlusNisSucc : α + 1 = Nat.succ α := by
  simp

-- simp can't solve that, strange!
theorem addAndString : 1 + 1 = 2 ∧ "Str".append "ing" = "String" := by
  constructor
  rfl
  show "Str".append "ing" = "String"
  rfl


theorem andImpliesOr : A ∧ B → A ∨ B :=
  λ andEvidence =>
    match andEvidence with
    | And.intro a _ => Or.inl a

#check andImpliesOr

def thirdElement (xs : List α) : Option α := xs[2]?

def woodLandCritters : List String :=
  ["hedgehog", "frog", "snail"]

#eval thirdElement woodLandCritters

-- Prove the following theorems using rfl:
-- 2 + 3 = 5,

def isFive : 2 + 3 = 5 := rfl

-- 15 - 8 = 7,

def isSeven : 15 - 8 = 7 := rfl

-- "Hello, ".append "world" = "Hello, world".

def isHelloWorld : "Hello, ".append "World!" = "Hello, World!" := rfl

-- What happens if rfl is used to prove 5 < 18? Why?
-- rfl can't work with anything other than equalities.

def wrongProp : 5 < 18 := by simp

-- Prove the following theorems using by simp:
-- 2 + 3 = 5,

theorem isFiveSimp : 2 + 3 = 5 := by simp

-- 15 - 8 = 7,

theorem isSevenSimp : 15 - 8 = 7 := by simp

-- "Hello, ".append "world" = "Hello, world",

theorem isHello : "Hello, ".append "World!" = "Hello, World!" := by simp

-- 5 < 18.

theorem isWrong : 5 < 18 := by simp

-- Write a function that looks up the fifth entry in a list.
-- Pass the evidence that this lookup is safe as an argument to the
-- function.

def fith (xs : List α) : Option α := xs[5]?

#eval fith woodLandCritters

def mulNums : Nat → Nat → Nat
  | _, 0 => 0
  | n, k + 1 => n + (mulNums n k)

def addNums : Nat → Nat → Nat
  | n, 0 => n
  | n, k + 1 => Nat.succ (addNums n k)

#eval mulNums 10 1000
#eval addNums 10 30


#check Type 32
