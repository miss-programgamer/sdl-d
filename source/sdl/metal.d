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
    Metal Interface

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryMetal, SDL3 Metal Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.metal;
import sdl.stdc;
import sdl.video;

extern(C) nothrow @nogc:

/**
    A handle to a CAMetalLayer-backed NSView (macOS) or UIView (iOS/tvOS).
    
    History:
        Available since SDL 3.2.0.
*/
alias SDL_MetalView = void*;

/**
    A handle to a CAMetalLayer.
    
    History:
        Available since SDL 3.2.0.
*/
alias SDL_MetalLayer = void*;

/**
    Create a CAMetalLayer-backed NSView/UIView and attach it to the specified
    window.

    On macOS, this does *not* associate a MTLDevice with the CAMetalLayer on
    its own. It is up to user code to do that.

    The returned handle can be casted directly to a NSView or UIView. To access
    the backing CAMetalLayer, call $(D SDL_Metal_GetLayer).

    Params:
        window = the window
    
    Returns:
        NSView or UIView handle.

    See_Also:
        $(D SDL_Metal_DestroyView)
        $(D SDL_Metal_GetLayer)

    History:
        Available since SDL 3.2.0.
*/
extern SDL_MetalView SDL_Metal_CreateView(SDL_Window* window);

/**
    Destroy an existing SDL_MetalView object.

    This should be called before $(D SDL_DestroyWindow), 
    if $(D SDL_Metal_CreateView) was called after $(D SDL_CreateWindow).

    Params:
        view = the SDL_MetalView object.

    See_Also:
        $(D SDL_Metal_CreateView)

    History:
        Available since SDL 3.2.0.
*/
extern void SDL_Metal_DestroyView(SDL_MetalView view);

/**
    Get a pointer to the backing CAMetalLayer for the given view.
    
    Params:
        view = the $(D SDL_MetalView) object.
    
    Returns:
        a CAMetalLayer handle.

    See_Also:
        $(D SDL_Metal_CreateView)

    History:
        Available since SDL 3.2.0.
*/
extern SDL_MetalLayer SDL_Metal_GetLayer(SDL_MetalView view);