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
    SDL Error Handling

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryError, SDL3 Error Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.error;
import sdl.stdc;

extern(C) nothrow @nogc:

/**
    Set the SDL error message for the current thread.

    Calling this function will replace any previous error message that was set.

    Examples:
        This function always returns false, since SDL frequently uses false to
        signify a failing result, leading to this idiom:

        ---
        if (error_code) {
            return SDL_SetError("This operation has failed: %d", error_code);
        }
        ---

    Params:
        fmt =   a printf()-style message format string.
        ... =   additional parameters matching % tokens in the `fmt` string, if
                any.
    
    Returns:
        false

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_ClearError)
        $(D SDL_GetError)
*/
extern bool SDL_SetError(const(char)* fmt, ...);

/**
    Set an error indicating that memory allocation failed.

    This function does not do any memory allocation.

    Returns:
        false

    Threadsafety:
        It is safe to call this function from any thread.
*/
extern bool SDL_OutOfMemory();

/**
    Retrieve a message about the last error that occurred on the current
    thread.

    It is possible for multiple errors to occur before calling SDL_GetError().
    Only the last error is returned.

    The message is only applicable when an SDL function has signaled an error.
    You must check the return values of SDL function calls to determine when to
    appropriately call SDL_GetError(). You should *not* use the results of
    SDL_GetError() to decide if an error has occurred! Sometimes SDL will set
    an error string even when reporting success.

    SDL will *not* clear the error string for successful API calls. You *must*
    check return values for failure cases before you can assume the error
    string applies.

    Error strings are set per-thread, so an error set in a different thread
    will not interfere with the current thread's operation.

    The returned value is a thread-local string which will remain valid until
    the current thread's error string is changed. The caller should make a copy
    if the value is needed after the next SDL API call.

    Returns:
        a message with information about the specific error that occurred,
        or an empty string if there hasn't been an error message set since
        the last call to SDL_ClearError().

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_ClearError)
        $(D SDL_SetError)
*/
extern const(char)*  SDL_GetError();

/**
    Clear any previous error message for this thread.

    Returns:
        true

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_GetError)
        $(D SDL_SetError)
*/
extern bool SDL_ClearError();
