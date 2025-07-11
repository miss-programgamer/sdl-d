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
    SDL Tray

    SDL offers a way to add items to the "system tray" (more correctly called
    the "notification area" on Windows). On platforms that offer this concept,
    an SDL app can add a tray icon, submenus, checkboxes, and clickable
    entries, and register a callback that is fired when the user clicks on
    these pieces.

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryTray, SDL3 Tray Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.tray;
import sdl.stdc;
import sdl.video;
import sdl.surface;

extern (C) nothrow @nogc:

/**
    An opaque handle representing a toplevel system tray object.
*/
struct SDL_Tray;

/**
    An opaque handle representing a menu/submenu on a system tray object.
*/
struct SDL_TrayMenu;

/**
    An opaque handle representing an entry on a system tray object.
*/
struct SDL_TrayEntry;

/**
    Flags that control the creation of system tray entries.

    Some of these flags are required; exactly one of them must be specified at
    the time a tray entry is created. Other flags are optional; zero or more of
    those can be OR'ed together with the required flag.

    See_Also:
        $(D SDL_InsertTrayEntryAt)
*/
alias SDL_TrayEntryFlags = Uint32;

/**
    Make the entry a simple button. Required.
*/
enum SDL_TRAYENTRY_BUTTON =   0x00000001u; 

/**
    Make the entry a checkbox. Required.
*/
enum SDL_TRAYENTRY_CHECKBOX = 0x00000002u; 

/**
    Prepare the entry to have a submenu. Required
*/
enum SDL_TRAYENTRY_SUBMENU =  0x00000004u; 

/**
    Make the entry disabled. Optional.
*/
enum SDL_TRAYENTRY_DISABLED = 0x80000000u; 

/**
    Make the entry checked. This is valid only for checkboxes. Optional.
*/
enum SDL_TRAYENTRY_CHECKED =  0x40000000u; 

/**
    A callback that is invoked when a tray entry is selected.

    Params:
        userdata =  An optional pointer to pass extra data to the callback when
                    it will be invoked.
        entry =     The tray entry that was selected.

    See_Also:
        $(D SDL_SetTrayEntryCallback)
*/
alias SDL_TrayCallback = void function(void* userdata, SDL_TrayEntry* entry);

/**
    Create an icon to be placed in the operating system's tray, or equivalent.

    Many platforms advise not using a system tray unless persistence is a
    necessary feature. Avoid needlessly creating a tray icon, as the user may
    feel like it clutters their interface.

    Using tray icons require the video subsystem.

    Params:
        icon =      A surface to be used as icon. May be $(D null).
        tooltip =   A tooltip to be displayed when the mouse hovers the icon in
                    UTF-8 encoding. Not supported on all platforms. May be $(D null).
    
    Returns:
        The newly created system tray icon.

    Threadsafety:
        This function should only be called on the main thread.

    See_Also:
        $(D SDL_CreateTrayMenu)
        $(D SDL_GetTrayMenu)
        $(D SDL_DestroyTray)
*/
extern SDL_Tray* SDL_CreateTray(SDL_Surface* icon, const(char)* tooltip);

/**
    Updates the system tray icon's icon.

    Params:
        tray =  The tray icon to be updated.
        icon =  The new icon. May be $(D null).

    Threadsafety:
        This function should be called on the thread that created the
        tray.

    See_Also:
        $(D SDL_CreateTray)
*/
extern void SDL_SetTrayIcon(SDL_Tray* tray, SDL_Surface* icon);

/**
    Updates the system tray icon's tooltip.

    Params:
        tray =      The tray icon to be updated.
        tooltip =   The new tooltip in UTF-8 encoding. May be $(D null).

    Threadsafety:
        This function should be called on the thread that created the
        tray.

    See_Also:
        $(D SDL_CreateTray)
*/
extern void SDL_SetTrayTooltip(SDL_Tray* tray, const(char)* tooltip);

/**
    Create a menu for a system tray.

    This should be called at most once per tray icon.

    This function does the same thing as SDL_CreateTraySubmenu(), except that
    it takes a SDL_Tray instead of a SDL_TrayEntry.

    A menu does not need to be destroyed; it will be destroyed with the tray.

    Params:
        tray =  The tray to bind the menu to.
    
    Returns:
        the newly created menu.

    Threadsafety:
        This function should be called on the thread that created the
        tray.

    See_Also:
        $(D SDL_CreateTray)
        $(D SDL_GetTrayMenu)
        $(D SDL_GetTrayMenuParentTray)
*/
extern SDL_TrayMenu* SDL_CreateTrayMenu(SDL_Tray* tray);

/**
    Create a submenu for a system tray entry.

    This should be called at most once per tray entry.

    This function does the same thing as SDL_CreateTrayMenu, except that it
    takes a SDL_TrayEntry instead of a SDL_Tray.

    A menu does not need to be destroyed; it will be destroyed with the tray.

    Params:
        entry = The tray entry to bind the menu to.
    
    Returns:
        the newly created menu.

    Threadsafety:
        This function should be called on the thread that created the
        tray.

    See_Also:
        $(D SDL_InsertTrayEntryAt)
        $(D SDL_GetTraySubmenu)
        $(D SDL_GetTrayMenuParentEntry)
*/
extern SDL_TrayMenu* SDL_CreateTraySubmenu(SDL_TrayEntry* entry);

/**
    Gets a previously created tray menu.

    You should have called SDL_CreateTrayMenu() on the tray object. This
    function allows you to fetch it again later.

    This function does the same thing as SDL_GetTraySubmenu(), except that it
    takes a SDL_Tray instead of a SDL_TrayEntry.

    A menu does not need to be destroyed; it will be destroyed with the tray.

    Params:
        tray =  The tray entry to bind the menu to.
    
    Returns:
        the newly created menu.

    Threadsafety:
        This function should be called on the thread that created the
        tray.

    See_Also:
        $(D SDL_CreateTray)
        $(D SDL_CreateTrayMenu)
*/
extern SDL_TrayMenu* SDL_GetTrayMenu(SDL_Tray* tray);

/**
    Gets a previously created tray entry submenu.

    You should have called SDL_CreateTraySubmenu() on the entry object. This
    function allows you to fetch it again later.

    This function does the same thing as SDL_GetTrayMenu(), except that it
    takes a SDL_TrayEntry instead of a SDL_Tray.

    A menu does not need to be destroyed; it will be destroyed with the tray.

    Params:
        entry = The tray entry to bind the menu to.
    
    Returns:
        the newly created menu.

    Threadsafety:
        This function should be called on the thread that created the
        tray.

    See_Also:
        $(D SDL_InsertTrayEntryAt)
        $(D SDL_CreateTraySubmenu)
*/
extern SDL_TrayMenu* SDL_GetTraySubmenu(SDL_TrayEntry* entry);

/**
    Returns a list of entries in the menu, in order.

    Params:
        menu =  The menu to get entries from.
        count = An optional pointer to obtain the number of entries in the
                menu.
    
    Returns:
        A $(D null)-terminated list of entries within the given menu. The
        pointer becomes invalid when any function that inserts or deletes
        entries in the menu is called.

    Threadsafety:
        This function should be called on the thread that created the
        tray.

    See_Also:
        $(D SDL_RemoveTrayEntry)
        $(D SDL_InsertTrayEntryAt)
*/
extern const(SDL_TrayEntry)** SDL_GetTrayEntries(SDL_TrayMenu* menu, int* count);

/**
    Removes a tray entry.

    Params:
        entry = The entry to be deleted.

    Threadsafety:
        This function should be called on the thread that created the
        tray.

    See_Also:
        $(D SDL_GetTrayEntries)
        $(D SDL_InsertTrayEntryAt)
*/
extern void SDL_RemoveTrayEntry(SDL_TrayEntry* entry);

/**
    Insert a tray entry at a given position.

    If label is $(D null), the entry will be a separator. Many functions won't work
    for an entry that is a separator.

    An entry does not need to be destroyed; it will be destroyed with the tray.

    Params:
        menu =  The menu to append the entry to.
        pos =   The desired position for the new entry. Entries at or following
                this place will be moved. If pos is -1, the entry is appended.
        label = The text to be displayed on the entry, in UTF-8 encoding, or
                $(D null) for a separator.
        flags = A combination of flags, some of which are mandatory.
    
    Returns:
        the newly created entry, or $(D null) if pos is out of bounds.

    Threadsafety:
        This function should be called on the thread that created the
        tray.

    See_Also:
        $(D SDL_TrayEntryFlags)
        $(D SDL_GetTrayEntries)
        $(D SDL_RemoveTrayEntry)
        $(D SDL_GetTrayEntryParent)
*/
extern SDL_TrayEntry* SDL_InsertTrayEntryAt(SDL_TrayMenu* menu, int pos, const(char)* label, SDL_TrayEntryFlags flags);

/**
    Sets the label of an entry.

    An entry cannot change between a separator and an ordinary entry; that is,
    it is not possible to set a non-$(D null) label on an entry that has a $(D null)
    label (separators), or to set a $(D null) label to an entry that has a non-$(D null)
    label. The function will silently fail if that happens.

    Params:
        entry = The entry to be updated.
        label = The new label for the entry in UTF-8 encoding.

    Threadsafety:
        This function should be called on the thread that created the
        tray.

    See_Also:
        $(D SDL_GetTrayEntries)
        $(D SDL_InsertTrayEntryAt)
        $(D SDL_GetTrayEntryLabel)
*/
extern void SDL_SetTrayEntryLabel(SDL_TrayEntry* entry, const(char)* label);

/**
    Gets the label of an entry.

    If the returned value is $(D null), the entry is a separator.

    Params:
        entry = The entry to be read.
    
    Returns:
        the label of the entry in UTF-8 encoding.

    Threadsafety:
        This function should be called on the thread that created the
        tray.

    See_Also:
        $(D SDL_GetTrayEntries)
        $(D SDL_InsertTrayEntryAt)
        $(D SDL_SetTrayEntryLabel)
*/
extern const(char)* SDL_GetTrayEntryLabel(SDL_TrayEntry* entry);

/**
    Sets whether or not an entry is checked.

    The entry must have been created with the SDL_TRAYENTRY_CHECKBOX flag.

    Params:
        entry =     The entry to be updated.
        checked =   $(D true) if the entry should be checked; 
                    $(D false) otherwise.

    Threadsafety:
        This function should be called on the thread that created the
        tray.

    See_Also:
        $(D SDL_GetTrayEntries)
        $(D SDL_InsertTrayEntryAt)
        $(D SDL_GetTrayEntryChecked)
*/
extern void SDL_SetTrayEntryChecked(SDL_TrayEntry* entry, bool checked);

/**
    Gets whether or not an entry is checked.

    The entry must have been created with the SDL_TRAYENTRY_CHECKBOX flag.

    Params:
        entry = The entry to be read.
    
    Returns:
        $(D true) if the entry is checked; 
        $(D false) otherwise.

    Threadsafety:
        This function should be called on the thread that created the
        tray.

    See_Also:
        $(D SDL_GetTrayEntries)
        $(D SDL_InsertTrayEntryAt)
        $(D SDL_SetTrayEntryChecked)
*/
extern bool SDL_GetTrayEntryChecked(SDL_TrayEntry* entry);

/**
    Sets whether or not an entry is enabled.

    Params:
        entry =     The entry to be updated.
        enabled =   $(D true) if the entry should be enabled;
                    $(D false) otherwise.

    Threadsafety:
        This function should be called on the thread that created the
        tray.

    See_Also:
        $(D SDL_GetTrayEntries)
        $(D SDL_InsertTrayEntryAt)
        $(D SDL_GetTrayEntryEnabled)
*/
extern void SDL_SetTrayEntryEnabled(SDL_TrayEntry* entry, bool enabled);

/**
    Gets whether or not an entry is enabled.

    Params:
        entry = The entry to be read.
    
    Returns:
        $(D true) if the entry is enabled;
        $(D false) otherwise.

    Threadsafety:
        This function should be called on the thread that created the
        tray.

    See_Also:
        $(D SDL_GetTrayEntries)
        $(D SDL_InsertTrayEntryAt)
        $(D SDL_SetTrayEntryEnabled)
*/
extern bool SDL_GetTrayEntryEnabled(SDL_TrayEntry* entry);

/**
    Sets a callback to be invoked when the entry is selected.

    Params:
        entry =     The entry to be updated.
        callback =  A callback to be invoked when the entry is selected.
        userdata =  An optional pointer to pass extra data to the callback when
                    it will be invoked.

    Threadsafety:
        This function should be called on the thread that created the
        tray.

    See_Also:
        $(D SDL_GetTrayEntries)
        $(D SDL_InsertTrayEntryAt)
*/
extern void SDL_SetTrayEntryCallback(SDL_TrayEntry* entry, SDL_TrayCallback callback, void* userdata);

/**
    Simulate a click on a tray entry.

    Params:
        entry = The entry to activate.

    Threadsafety:
        This function should be called on the thread that created the
        tray.
*/
extern void SDL_ClickTrayEntry(SDL_TrayEntry* entry);

/**
    Destroys a tray object.

    This also destroys all associated menus and entries.

    Params:
        tray =   The tray icon to be destroyed.

    Threadsafety:
        This function should be called on the thread that created the
        tray.

    See_Also:
        $(D SDL_CreateTray)
*/
extern void SDL_DestroyTray(SDL_Tray* tray);

/**
    Gets the menu containing a certain tray entry.

    Params:
        entry = The entry for which to get the parent menu.
    
    Returns:
        the parent menu.

    Threadsafety:
        This function should be called on the thread that created the
        tray.

    See_Also:
        $(D SDL_InsertTrayEntryAt)
*/
extern SDL_TrayMenu* SDL_GetTrayEntryParent(SDL_TrayEntry* entry);

/**
    Gets the entry for which the menu is a submenu, if the current menu is a
    submenu.

    Either this function or SDL_GetTrayMenuParentTray() will return non-$(D null)
    for any given menu.

    Params:
        menu =  The menu for which to get the parent entry.
    
    Returns:
        The parent entry, or $(D null) if this menu is not a submenu.

    Threadsafety:
        This function should be called on the thread that created the
        tray.

    See_Also:
        $(D SDL_CreateTraySubmenu)
        $(D SDL_GetTrayMenuParentTray)
*/
extern SDL_TrayEntry* SDL_GetTrayMenuParentEntry(SDL_TrayMenu* menu);

/**
    Gets the tray for which this menu is the first-level menu, if the current
    menu isn't a submenu.

    Either this function or SDL_GetTrayMenuParentEntry() will 
    return non-$(D null) for any given menu.

    Params:
        menu = the menu for which to get the parent enttrayry.
    
    Returns:
        The parent tray, or $(D null) if this menu is a submenu.

    Threadsafety:
        This function should be called on the thread that created the
        tray.

    See_Also:
        $(D SDL_CreateTrayMenu)
        $(D SDL_GetTrayMenuParentEntry)
*/
extern SDL_Tray* SDL_GetTrayMenuParentTray(SDL_TrayMenu* menu);

/**
    Update the trays.

    This is called automatically by the event loop and is only needed if you're
    using trays but aren't handling SDL events.

    Threadsafety:
        This function should only be called on the main thread.
*/
extern void SDL_UpdateTrays();
