# Simple DirectMedia Library for D

This package contains bindings to SDL3 and newer, unlike other D packages, this links directly to the SDL library at compile time.

The consumer of this package need to provide the SDL3 shared object file to D, see the [dub documentation](https://dub.pm) for more info.

# Why another binding?
bindbc-sdl over time has stopped serving the purposes of the Inochi2D Project, especially with how uneven bindbc as a target can end up being.
We've decided that having a massive framework for loading some of our dependencies at runtime ends up making the developer experience worse.

Additionally, bindbc bindings generally lack inline documentation for auto-complete, and in more recent times ends up automatically generating
a lot of the binding internally using string mixins; this makes for a worse developer experience.

DSDL is a direct binding to the SDL headers, each semver release is targeted at the same versioned SDL release; starting with SDL 3.2.0.
Additionally, inline documentation has been translated from SDL's native doc comment format to DDOC, to allow for nice inline documentation when using
tools such as the code-d extension for vscode.

## Contributing
When binding SDL3, the documentation *should* be ported over to DDOC, this makes for a nicer user experience when using
DSDL with code completion.

Pull-requests are welcome.