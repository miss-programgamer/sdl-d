# Simple DirectMedia Library for D

This package contains bindings to SDL3 and newer, unlike other D packages, this links directly to the SDL library at compile time.

The consumer of this package need to provide the SDL3 shared object file to D, see the [dub documentation](https://dub.pm) for more info.

## Contributing
When binding SDL3, the documentation *should* be ported over to DDOC, this makes for a nicer user experience when using
DSDL with code completion.

Pull-requests are welcome.