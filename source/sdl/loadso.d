/*
    DSDL
    Copyright (C) 2025 Inochi2D Project <luna@foxgirls.gay>

    This software is provided 'as-is', without any express or implied
    warranty.  In no event will the authors be held liable for any damages
    arising from the use of this software.

    Permission is granted to anyone to use this software for any purpose,
    including commercial applications, and to alter it and redistribute it
    freely, subject to the following restrictions:

    1. The origin of this software must not be misrepresented; you must not
        claim that you wrote the original software. If you use this software
        in a product, an acknowledgment in the product documentation would be
        appreciated but is not required.
    2. Altered source versions must be plainly marked as such, and must not be
        misrepresented as being the original software.
    3. This notice may not be removed or altered from any source distribution.

    ==========================================================================

    Simple DirectMedia Layer
    Copyright (C) 1997-2025 Sam Lantinga <slouken@libsdl.org>

    This software is provided 'as-is', without any express or implied
    warranty.  In no event will the authors be held liable for any damages
    arising from the use of this software.

    Permission is granted to anyone to use this software for any purpose,
    including commercial applications, and to alter it and redistribute it
    freely, subject to the following restrictions:

    1. The origin of this software must not be misrepresented; you must not
        claim that you wrote the original software. If you use this software
        in a product, an acknowledgment in the product documentation would be
        appreciated but is not required.
    2. Altered source versions must be plainly marked as such, and must not be
        misrepresented as being the original software.
    3. This notice may not be removed or altered from any source distribution.
*/

/**
    SDL System-dependent library loading routines.

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategorySharedObject, SDL3 Shared Object Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.loadso;
import sdl.stdc;
import sdl.error;

extern (C) nothrow @nogc:

/**
    An opaque datatype that represents a loaded shared object.

    See_Also:
        $(D SDL_LoadObject)
        $(D SDL_LoadFunction)
        $(D SDL_UnloadObject)
*/
struct SDL_SharedObject;

/**
    Dynamically load a shared object.

    Params:
        sofile = A system-dependent name of the object file.
    
    Returns:
        An opaque pointer to the object handle or $(D null) on failure; 
        call SDL_GetError() for more information.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_LoadFunction)
        $(D SDL_UnloadObject)
*/
extern SDL_SharedObject* SDL_LoadObject(const(char)* sofile);

/**
    Look up the address of the named function in a shared object.

    This function pointer is no longer valid after calling $(D SDL_UnloadObject).

    This function can only look up C function names. Other languages may have
    name mangling and intrinsic language support that varies from compiler to
    compiler.

    Make sure you declare your function pointers with the same calling
    convention as the actual library function. Your code will crash
    mysteriously if you do not do this.

    If the requested function doesn't exist, NULL is returned.

    Params:
        handle =    A valid shared object handle returned by $(D SDL_LoadObject).
        name =      The name of the function to look up.
    
    Returns:
        A pointer to the function or NULL on failure; call SDL_GetError()
        for more information.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_LoadObject)
*/
extern SDL_FunctionPointer SDL_LoadFunction(SDL_SharedObject* handle, const(char)* name);

/**
    Unload a shared object from memory.

    Note that any pointers from this object looked up through
    ($D SDL_LoadFunction) will no longer be valid.

    Params:
        handle = A valid shared object handle returned by $(D SDL_LoadObject).

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_LoadObject)
*/
extern void SDL_UnloadObject(SDL_SharedObject* handle);