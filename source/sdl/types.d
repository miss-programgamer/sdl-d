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
*/

/**
    Aliases for base types declared in the SDL headers.

    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.types;

extern(C) nothrow @nogc:

/**
    8-bit signed integer
*/
alias Sint8 = byte;

/**
    8-bit unsigned integer
*/
alias Uint8 = ubyte;

/**
    16-bit signed integer
*/
alias Sint16 = short;

/**
    16-bit unsigned integer
*/
alias Uint16 = ushort;

/**
    32-bit signed integer
*/
alias Sint32 = int;

/**
    32-bit unsigned integer
*/
alias Uint32 = uint;

/**
    64-bit signed integer
*/
alias Sint64 = long;

/**
    64-bit unsigned integer
*/
alias Uint64 = ulong;

/**
    SDL times are signed, 64-bit integers representing nanoseconds since the
    Unix epoch (Jan 1, 1970).

    They can be converted between Windows FILETIME values with
    $(D SDL_TimeToWindows) and $(D SDL_TimeFromWindows).

    See_Also:
        $(D SDL_Time.min)
        $(D SDL_Time.max)

    History:
        Available since SDL 3.2.0.
*/
alias SDL_Time = Sint64;

/**
    A generic function pointer.

    In theory, generic function pointers should use this, instead of `void *`,
    since some platforms could treat code addresses differently than data
    addresses. Although in current times no popular platforms make this
    distinction, it is more correct and portable to use the correct type for a
    generic pointer.

    History:
        Available since SDL 3.2.0.
*/
alias SDL_FunctionPointer = void function();