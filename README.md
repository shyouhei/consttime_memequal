# consttime_memequal? : thin wrapper to OS-provided constant-time memory comparison routine.

This kind of routine must be provided a priori but [[Feature
#10098]](https://bugs.ruby-lang.org/issues/10098) is not yet
implemented.  We have to make glude code for now.

## Provided functionality

This library provides one global function named `consttime_memequal?`.
Which is of course not very ruby-ish, I know, but best describes what
is going on.

```ruby
consttime_memequal?(b1, b2, len=b1.bytesize) # => true / false
```

Compares first _len_ bytes of _b1_ and _b2_.  Returns `true` if they
are identical.  Returns `false` if they are distinct.

## Q&As

### Why the name `consttime_memequal?`

NetBSD has [consttime_memequal(3)](https://www.freebsd.org/cgi/man.cgi?query=consttime_memequal&manpath=NetBSD+7.0).  We followed it.

### This library fails to load on my machine.  Why?

Install OpenSSL (or LibreSSL).

### I can't install OpenSSL for reasons.  What to do?

Install OpenBSD instead (or NetBSD).

### I wrote a general implementation! Can I pull request?

No you don't.  By the nature of its provided functionality, someone
who implement this have to be very careful about side-channel attacks.
You definitely shouldn't do it for yourself.  Make your OS provide one
for you.

Bug fix etc. are much appreciated!

### Then what can I do?

Go to [[Feature #10098]](https://bugs.ruby-lang.org/issues/10098) and
persuade the core devs to implement that feature.  That's the lethal
solution to the situation.
