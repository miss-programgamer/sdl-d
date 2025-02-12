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
    SDL Mouse Handling

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryMouse, SDL3 Mouse Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.mouse;
import sdl.stdc;

extern(C) nothrow @nogc:


/**
* This is a unique ID for a mouse for the time it is connected to the system,
* and is never reused for the lifetime of the application.
*
* If the mouse is disconnected and reconnected, it will get a new ID.
*
* The value 0 is an invalid ID.
*
* \since This datatype is available since SDL 3.2.0.
*/
alias SDL_MouseID = Uint32;

/**
* The structure used to identify an SDL cursor.
*
* This is opaque data.
*
* \since This struct is available since SDL 3.2.0.
*/
struct SDL_Cursor;

enum SDL_SystemCursor {
    SDL_SYSTEM_CURSOR_DEFAULT,      /**< Default cursor. Usually an arrow. */
    SDL_SYSTEM_CURSOR_TEXT,         /**< Text selection. Usually an I-beam. */
    SDL_SYSTEM_CURSOR_WAIT,         /**< Wait. Usually an hourglass or watch or spinning ball. */
    SDL_SYSTEM_CURSOR_CROSSHAIR,    /**< Crosshair. */
    SDL_SYSTEM_CURSOR_PROGRESS,     /**< Program is busy but still interactive. Usually it's WAIT with an arrow. */
    SDL_SYSTEM_CURSOR_NWSE_RESIZE,  /**< Double arrow pointing northwest and southeast. */
    SDL_SYSTEM_CURSOR_NESW_RESIZE,  /**< Double arrow pointing northeast and southwest. */
    SDL_SYSTEM_CURSOR_EW_RESIZE,    /**< Double arrow pointing west and east. */
    SDL_SYSTEM_CURSOR_NS_RESIZE,    /**< Double arrow pointing north and south. */
    SDL_SYSTEM_CURSOR_MOVE,         /**< Four pointed arrow pointing north, south, east, and west. */
    SDL_SYSTEM_CURSOR_NOT_ALLOWED,  /**< Not permitted. Usually a slashed circle or crossbones. */
    SDL_SYSTEM_CURSOR_POINTER,      /**< Pointer that indicates a link. Usually a pointing hand. */
    SDL_SYSTEM_CURSOR_NW_RESIZE,    /**< Window resize top-left. This may be a single arrow or a double arrow like NWSE_RESIZE. */
    SDL_SYSTEM_CURSOR_N_RESIZE,     /**< Window resize top. May be NS_RESIZE. */
    SDL_SYSTEM_CURSOR_NE_RESIZE,    /**< Window resize top-right. May be NESW_RESIZE. */
    SDL_SYSTEM_CURSOR_E_RESIZE,     /**< Window resize right. May be EW_RESIZE. */
    SDL_SYSTEM_CURSOR_SE_RESIZE,    /**< Window resize bottom-right. May be NWSE_RESIZE. */
    SDL_SYSTEM_CURSOR_S_RESIZE,     /**< Window resize bottom. May be NS_RESIZE. */
    SDL_SYSTEM_CURSOR_SW_RESIZE,    /**< Window resize bottom-left. May be NESW_RESIZE. */
    SDL_SYSTEM_CURSOR_W_RESIZE,     /**< Window resize left. May be EW_RESIZE. */
    SDL_SYSTEM_CURSOR_COUNT
}

enum SDL_MouseWheelDirection {
    SDL_MOUSEWHEEL_NORMAL,    /**< The scroll direction is normal */
    SDL_MOUSEWHEEL_FLIPPED    /**< The scroll direction is flipped / natural */
}

/**
* A bitmask of pressed mouse buttons, as reported by SDL_GetMouseState, etc.
*
* - Button 1: Left mouse button
* - Button 2: Middle mouse button
* - Button 3: Right mouse button
* - Button 4: Side mouse button 1
* - Button 5: Side mouse button 2
*
* \since This datatype is available since SDL 3.2.0.
*
* \sa SDL_GetMouseState
* \sa SDL_GetGlobalMouseState
* \sa SDL_GetRelativeMouseState
*/
enum SDL_MouseButtonFlags : Uint32 {
    BUTTON_LEFT =     1,
    BUTTON_MIDDLE =   2,
    BUTTON_RIGHT =    3,
    BUTTON_X1 =       4,
    BUTTON_X2 =       5,
}

enum SDL_BUTTON_MASK(Uint32 X) = cast(SDL_MouseButtonFlags)(1u << ((X)-1));
enum SDL_BUTTON_LMASK   = cast(SDL_MouseButtonFlags)SDL_BUTTON_MASK!(SDL_MouseButtonFlags.BUTTON_LEFT);
enum SDL_BUTTON_MMASK   = cast(SDL_MouseButtonFlags)SDL_BUTTON_MASK!(SDL_MouseButtonFlags.BUTTON_MIDDLE);
enum SDL_BUTTON_RMASK   = cast(SDL_MouseButtonFlags)SDL_BUTTON_MASK!(SDL_MouseButtonFlags.BUTTON_RIGHT);
enum SDL_BUTTON_X1MASK  = cast(SDL_MouseButtonFlags)SDL_BUTTON_MASK!(SDL_MouseButtonFlags.BUTTON_X1);
enum SDL_BUTTON_X2MASK  = cast(SDL_MouseButtonFlags)SDL_BUTTON_MASK!(SDL_MouseButtonFlags.BUTTON_X2);