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
    SDL MessageBox

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryMessageBox, SDL3 MessageBox Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.messagebox;
import sdl.stdc;
import sdl.video;

extern(C) nothrow @nogc:

/**
    Message box flags.

    If supported will display warning icon, etc.
*/
enum SDL_MessageBoxFlags : Uint32 {
    
    /**
        Error dialog
    */
    SDL_MESSAGEBOX_ERROR =                    0x00000010u,
    
    /**
        Warning dialog
    */
    SDL_MESSAGEBOX_WARNING =                  0x00000020u,
    
    /**
        Informational dialog
    */
    SDL_MESSAGEBOX_INFORMATION =              0x00000040u,
    
    /**
        Buttons placed left to right
    */
    SDL_MESSAGEBOX_BUTTONS_LEFT_TO_RIGHT =    0x00000080u,
    
    /**
        Buttons placed right to left
    */
    SDL_MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT =    0x00000100u,
}

/**
    SDL_MessageBoxButtonData flags.
*/
alias SDL_MessageBoxButtonFlags = Uint32;

/**
    Marks the default button when return is hit
*/
enum SDL_MessageBoxButtonFlags SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT = 0x00000001u;

/**
    Marks the default button when escape is hit
*/
enum SDL_MessageBoxButtonFlags SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT = 0x00000002u;

/**
    Individual button data.
*/
struct SDL_MessageBoxButtonData {
    
    /**
        Flags
    */
    SDL_MessageBoxButtonFlags flags;
    
    /**
        User defined button id (value returned via SDL_ShowMessageBox)
    */
    int buttonID;        
    
    /**
        The UTF-8 button text
    */
    const(char)* text;   
} 

/**
    RGB value used in a message box color scheme
*/
struct SDL_MessageBoxColor {

    /**
        Red color channel.
    */
    Uint8 r;
    
    /**
        Green color channel.
    */
    Uint8 g;
    
    /**
        Blue color channel.
    */
    Uint8 b;
}

/**
    An enumeration of indices inside the colors array of
    SDL_MessageBoxColorScheme.
*/
enum SDL_MessageBoxColorType : size_t {
    SDL_MESSAGEBOX_COLOR_BACKGROUND,
    SDL_MESSAGEBOX_COLOR_TEXT,
    SDL_MESSAGEBOX_COLOR_BUTTON_BORDER,
    SDL_MESSAGEBOX_COLOR_BUTTON_BACKGROUND,
    SDL_MESSAGEBOX_COLOR_BUTTON_SELECTED,
    SDL_MESSAGEBOX_COLOR_COUNT                    /**< Size of the colors array of SDL_MessageBoxColorScheme. */
}

/**
    A set of colors to use for message box dialogs
*/
struct SDL_MessageBoxColorScheme {

    /**
        Colors
    */
    SDL_MessageBoxColor[cast(size_t)SDL_MessageBoxColorType.SDL_MESSAGEBOX_COLOR_COUNT] colors;
}

/**
    MessageBox structure containing title, text, window, etc.
*/
struct SDL_MessageBoxData {

    /**
        Flags
    */
    SDL_MessageBoxFlags flags;
    
    /**
        Parent window, can be NULL
    */
    SDL_Window *window;                  
    
    /**
        UTF-8 title
    */
    const(char)* title;                  
    
    /**
        UTF-8 message text
    */
    const(char)* message;                

    /**
        Number of window buttons
    */
    int numbuttons;

    /**
        Array of window buttons
    */
    const(SDL_MessageBoxButtonData)* buttons;

    /**
        SDL_MessageBoxColorScheme, can be NULL to use system settings
    */
    const(SDL_MessageBoxColorScheme)* colorScheme;
}

/**
    Create a modal message box.

    If your needs aren't complex, it might be easier to use
    SDL_ShowSimpleMessageBox.

    This function should be called on the thread that created the parent
    window, or on the main thread if the messagebox has no parent. It will
    block execution of that thread until the user clicks a button or closes the
    messagebox.

    This function may be called at any time, even before SDL_Init(). This makes
    it useful for reporting errors like a failure to create a renderer or
    OpenGL context.

    On X11, SDL rolls its own dialog box with X11 primitives instead of a
    formal toolkit like GTK+ or Qt.

    Note that if SDL_Init() would fail because there isn't any available video
    target, this function is likely to fail for the same reasons. If this is a
    concern, check the return value from this function and fall back to writing
    to stderr if you can.

    Params:
        messageboxdata =    the SDL_MessageBoxData structure with title, text and
                            other options.
        buttonid =          the pointer to which user id of hit button should be
                            copied.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_ShowSimpleMessageBox)
*/
extern bool SDL_ShowMessageBox(const(SDL_MessageBoxData)* messageboxdata, int *buttonid);

/**
    Display a simple modal message box.

    If your needs aren't complex, this function is preferred over
    SDL_ShowMessageBox.

    `flags` may be any of the following:

    - `SDL_MESSAGEBOX_ERROR`: error dialog
    - `SDL_MESSAGEBOX_WARNING`: warning dialog
    - `SDL_MESSAGEBOX_INFORMATION`: informational dialog

    This function should be called on the thread that created the parent
    window, or on the main thread if the messagebox has no parent. It will
    block execution of that thread until the user clicks a button or closes the
    messagebox.

    This function may be called at any time, even before SDL_Init(). This makes
    it useful for reporting errors like a failure to create a renderer or
    OpenGL context.

    On X11, SDL rolls its own dialog box with X11 primitives instead of a
    formal toolkit like GTK+ or Qt.

    Note that if SDL_Init() would fail because there isn't any available video
    target, this function is likely to fail for the same reasons. If this is a
    concern, check the return value from this function and fall back to writing
    to stderr if you can.

    Params:
        flags =     an SDL_MessageBoxFlags value.
        title =     UTF-8 title text.
        message =   UTF-8 message text.
        window =    the parent window, or NULL for no parent.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.

    See_Also:
        $(D SDL_ShowMessageBox)
*/
extern bool SDL_ShowSimpleMessageBox(SDL_MessageBoxFlags flags, const(char)* title, const(char)* message, SDL_Window *window);
