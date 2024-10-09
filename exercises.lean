-- Exercises
-- Define Type that allows only Even numbers to be represented by it.

namespace Even

inductive Even : Type where
  | zero : Even
  | succ : Even -> Even

def Even.plus : Even → Even → Even
  | Even.zero, k   => Even.succ k
  | Even.succ n, k => Even.succ (n.plus k)

instance : Add Even where
  add := Even.plus

def Even.mul : Even → Even → Even
  | Even.zero, _   => Even.zero
  | Even.succ n, k => n.mul k + k

instance : Mul Even where
  mul := Even.mul

instance : OfNat Even n where
  ofNat :=
    let rec natToEven : Nat → Even
    | 0     => Even.zero
    | n + 1 =>
    if n % 2 == 0
    then Even.succ (natToEven n)
    else natToEven n
  natToEven n

def Even.toNat : Even → Nat
  | Even.zero   => 0
  | Even.succ n => n.toNat + 2

instance : ToString Even where
  toString x := toString (x.toNat)


def two  : Even := 2
def four : Even := 4
def five : Even := 5

theorem isFour    : two * two = four := rfl
theorem isEigth   : two * two * two = four * two := rfl
theorem isSixteen : (two * two) * (two * two) = four * four := rfl

end Even

-- HTTP Requests
-- An HTTP request begins with an identification of a HTTP method,
-- such as GET or POST, along with a URI and an HTTP version.
-- Define an inductive type that represents an interesting subset of the HTTP methods,
-- and a structure that represents HTTP responses. Responses should have a
-- ToString instance that makes it possible to debug them. Use a type class to
-- associate different IO actions with each HTTP method, and write a test harness as
-- an IO action that calls each method and prints the result.
namespace Requests

inductive Requests : Type where
  | GET    : Requests
  | POST   : Requests
  | PUT    : Requests
  | DELETE : Requests

structure HttpResponse where
  statusCode : Nat
  body       : String
deriving Inhabited, Repr

instance : ToString HttpResponse where
  toString (response : HttpResponse) : String :=
  s!"Status Code: {response.statusCode}\nBody: {response.body}"

class HttpAction (m : Type → Type) where
  execute : Requests → m HttpResponse

instance : HttpAction IO where
  execute method :=
    match method with
    | Requests.GET      => pure { statusCode := 200, body := "GET request successuful"   : HttpResponse}
    | Requests.POST     => pure { statusCode := 201, body := "POST request successuful"  : HttpResponse}
    | Requests.PUT      => pure { statusCode := 204, body := "PUT request successuful"   : HttpResponse}
    | Requests.DELETE   => pure { statusCode := 200, body := "DELTE request successuful" : HttpResponse }


def testHttp : IO Unit := do
  for method in #[Requests.GET, Requests.POST, Requests.PUT, Requests.DELETE] do
    let response ← HttpAction.execute method
    IO.println response

def main : IO Unit :=
  testHttp

#eval main

end Requests
