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
    SDL Power Handling

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryPower, SDL3 Mouse Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.power;
import sdl.stdc;

extern(C) nothrow @nogc:

enum SDL_PowerState {
    SDL_POWERSTATE_ERROR = -1,   /**< error determining power status */
    SDL_POWERSTATE_UNKNOWN,      /**< cannot determine power status */
    SDL_POWERSTATE_ON_BATTERY,   /**< Not plugged in, running on the battery */
    SDL_POWERSTATE_NO_BATTERY,   /**< Plugged in, no battery available */
    SDL_POWERSTATE_CHARGING,     /**< Plugged in, charging battery */
    SDL_POWERSTATE_CHARGED       /**< Plugged in, battery charged */
}