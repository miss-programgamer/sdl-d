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
    SDL Timer

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryTimer, SDL3 Timer Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.timer;

extern(C) nothrow @nogc:

/**
    Number of milliseconds in a second.

    This is always 1000.
*/
enum SDL_MS_PER_SECOND = 1000;

/**
    Number of microseconds in a second.

    This is always 1000000.
*/
enum SDL_US_PER_SECOND = 1000000;

/**
    Number of nanoseconds in a second.

    This is always 1000000000.
*/
enum SDL_NS_PER_SECOND = 1000000000L;

/**
    Number of nanoseconds in a millisecond.

    This is always 1000000.
*/
enum SDL_NS_PER_MS = 1000000;

/**
    Number of nanoseconds in a microsecond.

    This is always 1000.
*/
enum SDL_NS_PER_US = 1000;


/**
    Get the number of milliseconds that have elapsed since the SDL library
    initialization.

    Returns:
        An unsigned 64‑bit integer that represents the number of
        milliseconds that have elapsed since the SDL library was
        initialized (typically via a call to SDL_Init).

    Threadsafety:
        It is safe to call this function from any thread.
*/
extern ulong SDL_GetTicks();

/**
    Get the number of nanoseconds since SDL library initialization.

    Returns:
        An unsigned 64-bit value representing the number of nanoseconds
        since the SDL library initialized.

    Threadsafety:
        It is safe to call this function from any thread. 
*/
extern ulong SDL_GetTicksNS();

/**
    Get the current value of the high resolution counter.

    This function is typically used for profiling.

    The counter values are only meaningful relative to each other. Differences
    between values can be converted to times by using
    SDL_GetPerformanceFrequency().

    Returns:
        The current counter value.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_GetPerformanceFrequency)
*/
extern ulong SDL_GetPerformanceCounter();

/**
    Get the count per second of the high resolution counter.

    Returns:
        A platform-specific count per second.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
    $(D SDL_GetPerformanceCounter)
*/
extern ulong SDL_GetPerformanceFrequency();

/**
    Wait a specified number of milliseconds before returning.

    This function waits a specified number of milliseconds before returning. It
    waits at least the specified time, but possibly longer due to OS
    scheduling.

    Params:
        ms = The number of milliseconds to delay.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_DelayNS)
        $(D SDL_DelayPrecise)
*/
extern void SDL_Delay(uint ms);

/**
    Wait a specified number of nanoseconds before returning.

    This function waits a specified number of nanoseconds before returning. It
    waits at least the specified time, but possibly longer due to OS
    scheduling.

    Params:
        ns = The number of nanoseconds to delay.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_Delay)
        $(D SDL_DelayPrecise)
*/
extern void SDL_DelayNS(ulong ns);

/**
    Wait a specified number of nanoseconds before returning.

    This function waits a specified number of nanoseconds before returning. It
    will attempt to wait as close to the requested time as possible, busy
    waiting if necessary, but could return later due to OS scheduling.

    Params:
        ns = The number of nanoseconds to delay.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_Delay)
        $(D SDL_DelayNS)
*/
extern void SDL_DelayPrecise(ulong ns);

/**
    Definition of the timer ID type.
*/
alias SDL_TimerID = uint;

/**
    Function prototype for the millisecond timer callback function.

    The callback function is passed the current timer interval and returns the
    next timer interval, in milliseconds. If the returned value is the same as
    the one passed in, the periodic alarm continues, otherwise a new alarm is
    scheduled. If the callback returns 0, the periodic alarm is canceled and
    will be removed.

    Params:
        userdata =  An arbitrary pointer provided by the app through 
                    SDL_AddTimer, for its own use.
        timerID =   the current timer being processed.
        interval =  the current callback time interval.
    
    Returns:
        The new callback time interval, or 0 to disable further runs of
        the callback.

    Threadsafety:
        SDL may call this callback at any time from a background
        thread; the application is responsible for locking resources
        the callback touches that need to be protected.

    See_Also:
        $(D SDL_AddTimer)
 */
alias SDL_TimerCallback = uint function(void* userdata, SDL_TimerID timerID, uint interval);

/**
    Call a callback function at a future time.

    The callback function is passed the current timer interval and the user
    supplied parameter from the SDL_AddTimer() call and should return the next
    timer interval. If the value returned from the callback is 0, the timer is
    canceled and will be removed.

    The callback is run on a separate thread, and for short timeouts can
    potentially be called before this function returns.

    Timers take into account the amount of time it took to execute the
    callback. For example, if the callback took 250 ms to execute and returned
    1000 (ms), the timer would only wait another 750 ms before its next
    iteration.

    Timing may be inexact due to OS scheduling. Be sure to note the current
    time with SDL_GetTicksNS() or SDL_GetPerformanceCounter() in case your
    callback needs to adjust for variances.

    Params:
        interval =  the timer delay, in milliseconds, passed to `callback`.
        callback =  the SDL_TimerCallback function to call when the specified 
                    `interval` elapses.
        userdata =  a pointer that is passed to `callback`.
    
    Returns:
        A timer ID or 0 on failure; call SDL_GetError() for more
        information.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_AddTimerNS)
        $(D SDL_RemoveTimer)
*/
extern SDL_TimerID SDL_AddTimer(uint interval, SDL_TimerCallback callback, void *userdata);

/**
    Function prototype for the nanosecond timer callback function.

    The callback function is passed the current timer interval and returns the
    next timer interval, in nanoseconds. If the returned value is the same as
    the one passed in, the periodic alarm continues, otherwise a new alarm is
    scheduled. If the callback returns 0, the periodic alarm is canceled and
    will be removed.

    Params:
        userdata =  An arbitrary pointer provided by the app through 
                    SDL_AddTimer, for its own use.
        timerID =   The current timer being processed.
        interval =  The current callback time interval.
    
    Returns:
        The new callback time interval, or 0 to disable further runs of
        the callback.

    Threadsafety:
        SDL may call this callback at any time from a background
        thread; the application is responsible for locking resources
        the callback touches that need to be protected.

    See_Also:
        $(D SDL_AddTimerNS)
*/
alias SDL_NSTimerCallback = extern(C) ulong function(void* userdata, SDL_TimerID timerID, ulong interval);

/**
    Call a callback function at a future time.

    The callback function is passed the current timer interval and the user
    supplied parameter from the SDL_AddTimerNS() call and should return the
    next timer interval. If the value returned from the callback is 0, the
    timer is canceled and will be removed.

    The callback is run on a separate thread, and for short timeouts can
    potentially be called before this function returns.

    Timers take into account the amount of time it took to execute the
    callback. For example, if the callback took 250 ns to execute and returned
    1000 (ns), the timer would only wait another 750 ns before its next
    iteration.

    Timing may be inexact due to OS scheduling. Be sure to note the current
    time with SDL_GetTicksNS() or SDL_GetPerformanceCounter() in case your
    callback needs to adjust for variances.

    Params:
        interval =  The timer delay, in nanoseconds, passed to `callback`.
        callback =  The SDL_TimerCallback function to call when the specified 
                    `interval` elapses.
        userdata =  A pointer that is passed to `callback`.
    
    Returns:
        A timer ID or 0 on failure; call SDL_GetError() for more
        information.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_AddTimer)
        $(D SDL_RemoveTimer)
*/
extern SDL_TimerID SDL_AddTimerNS(ulong interval, SDL_NSTimerCallback callback, void *userdata);

/**
    Remove a timer created with SDL_AddTimer().

    Params:
        id = The ID of the timer to remove.
    
    Returns:
        $(D true) on success or $(D false) on failure; 
        call $(D SDL_GetError) for more information.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_AddTimer)
*/
extern bool SDL_RemoveTimer(SDL_TimerID id);
