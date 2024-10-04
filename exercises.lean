-- Exercises
-- Another Representation
-- An alternative way to represent a positive number is as the successor of some Nat.
-- Replace the definition of Pos with a structure whose constructor is named succ
-- that contains a Nat:
-- structure Pos where
--   succ ::
--   pred : Nat
-- Define instances of Add, Mul, ToString, and OfNat that allow this version of Pos to be used conveniently.


-- Even Numbers
-- Define a datatype that represents only even numbers. Define instances of Add, Mul, and ToString that allow it to be used conveniently. OfNat requires a feature that is introduced in the next section.



-- HTTP Requests
-- An HTTP request begins with an identification of a HTTP method,
-- such as GET or POST, along with a URI and an HTTP version.
-- Define an inductive type that represents an interesting subset of the HTTP methods,
-- and a structure that represents HTTP responses. Responses should have a
-- ToString instance that makes it possible to debug them. Use a type class to
-- associate different IO actions with each HTTP method, and write a test harness as
-- an IO action that calls each method and prints the result.
