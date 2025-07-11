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
    SDL Miscellaneous Functions

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryMisc, SDL3 Misc Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.misc;

extern (C) nothrow @nogc:

/**
    Open a URL/URI in the browser or other appropriate external application.

    Open a URL in a separate, system-provided application. How this works will
    vary wildly depending on the platform. This will likely launch what makes
    sense to handle a specific URL's protocol (a web browser for `http://`,
    etc), but it might also be able to launch file managers for directories and
    other things.

    What happens when you open a URL varies wildly as well: your game window
    may lose focus (and may or may not lose focus if your game was fullscreen
    or grabbing input at the time). On mobile devices, your app will likely
    move to the background or your process might be paused. Any given platform
    may or may not handle a given URL.

    If this is unimplemented (or simply unavailable) for a platform, this will
    fail with an error. A successful result does not mean the URL loaded, just
    that we launched _something_ to handle it (or at least believe we did).

    All this to say: this function can be useful, but you should definitely
    test it on every platform you target.

    Params:
        url =   A valid URL/URI to open. Use `file:///full/path/to/file`
                for local files, if supported.
    
    Returns:
        $(D true) on success or $(D false) on failure; 
        call SDL_GetError() for more information.
*/
extern bool SDL_OpenURL(const(char)* url);

