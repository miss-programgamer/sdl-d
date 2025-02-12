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
    Atomics

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryAtomic, SDL3 Atomics Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.atomic;
import sdl.stdc;

extern(C) nothrow @nogc:

// TODO: Update Docs

/**
    An atomic spinlock.

    The atomic locks are efficient spinlocks using CPU instructions, but are
    vulnerable to starvation and can spin forever if a thread holding a lock
    has been terminated. For this reason you should minimize the code executed
    inside an atomic lock and never do expensive things like API or system
    calls while holding them.

    They are also vulnerable to starvation if the thread holding the lock is
    lower priority than other threads and doesn't get scheduled. In general you
    should use mutexes instead, since they have better performance and
    contention behavior.

    The atomic locks are not safe to lock recursively.

    Note:
        The spin lock functions and type are required and can not be
        emulated because they are used in the atomic emulation code.
*/
alias SDL_SpinLock = int;


/**
    Try to lock a spin lock by setting it to a non-zero value.

    ***Please note that spinlocks are dangerous if you don't know what you're
    doing. Please be careful using any sort of spinlock!***

    Params:
        lock =  a pointer to a lock variable.
    
    Returns:
        $(D true) if the lock succeeded, $(D false) if the lock is already held.

    See_Also:
        $(D SDL_LockSpinlock)
        $(D SDL_UnlockSpinlock)

    Threadsafety:
        It is safe to call this function from any thread.

    History:
        Available since SDL 3.2.0.
*/
extern bool SDL_TryLockSpinlock(SDL_SpinLock* lock);

/**
    Lock a spin lock by setting it to a non-zero value.

    ***Please note that spinlocks are dangerous if you don't know what you're
    doing. Please be careful using any sort of spinlock!***

    Params:
        lock =  a pointer to a lock variable.

    See_Also:
        $(D SDL_TryLockSpinlock)
        $(D SDL_UnlockSpinlock)

    Threadsafety:
        It is safe to call this function from any thread.

    History:
        Available since SDL 3.2.0.
*/
extern void SDL_LockSpinlock(SDL_SpinLock* lock);

/**
    Unlock a spin lock by setting it to 0.

    Always returns immediately.

    ***Please note that spinlocks are dangerous if you don't know what you're
    doing. Please be careful using any sort of spinlock!***

    Params:
        lock =  a pointer to a lock variable.

    See_Also:
        $(D SDL_LockSpinlock)
        $(D SDL_TryLockSpinlock)

    Threadsafety:
        It is safe to call this function from any thread.

    History:
        Available since SDL 3.2.0.
*/
extern void SDL_UnlockSpinlock(SDL_SpinLock* lock);


/**
    Insert a memory release barrier (function version).

    Please refer to SDL_MemoryBarrierRelease for details. This is a function
    version, which might be useful if you need to use this functionality from a
    scripting language, etc. Also, some of the macro versions call this
    function behind the scenes, where more heavy lifting can happen inside of
    SDL. Generally, though, an app written in C/C++/etc should use the macro
    version, as it will be more efficient.

    See_Also:
        $(D SDL_MemoryBarrierRelease)

    Threadsafety:
        Obviously this function is safe to use from any thread at any
        time, but if you find yourself needing this, you are probably
        dealing with some very sensitive code; be careful!

    History:
        Available since SDL 3.2.0.
*/
extern void SDL_MemoryBarrierReleaseFunction();

/**
    Insert a memory acquire barrier (function version).

    Please refer to SDL_MemoryBarrierRelease for details. This is a function
    version, which might be useful if you need to use this functionality from a
    scripting language, etc. Also, some of the macro versions call this
    function behind the scenes, where more heavy lifting can happen inside of
    SDL. Generally, though, an app written in C/C++/etc should use the macro
    version, as it will be more efficient.

    See_Also:
        $(D SDL_MemoryBarrierAcquire)

    Threadsafety:
        Obviously this function is safe to use from any thread at any
        time, but if you find yourself needing this, you are probably
        dealing with some very sensitive code; be careful!

    History:
        Available since SDL 3.2.0.
*/
extern void SDL_MemoryBarrierAcquireFunction();

/**
    A type representing an atomic integer value.

    This can be used to manage a value that is synchronized across multiple
    CPUs without a race condition; when an app sets a value with
    SDL_SetAtomicInt all other threads, regardless of the CPU it is running on,
    will see that value when retrieved with SDL_GetAtomicInt, regardless of CPU
    caches, etc.

    This is also useful for atomic compare-and-swap operations: a thread can
    change the value as long as its current value matches expectations. When
    done in a loop, one can guarantee data consistency across threads without a
    lock (but the usual warnings apply: if you don't know what you're doing, or
    you don't do it carefully, you can confidently cause any number of
    disasters with this, so in most cases, you _should_ use a mutex instead of
    this!).

    This is a struct so people don't accidentally use numeric operations on it
    directly. You have to use SDL atomic functions.

    See_Also:
        $(D SDL_CompareAndSwapAtomicInt)
        $(D SDL_GetAtomicInt)
        $(D SDL_SetAtomicInt)
        $(D SDL_AddAtomicInt)

    History:
        Available since SDL 3.2.0.
*/
struct SDL_AtomicInt {
    int value;
    alias value this;
}

/**
    Set an atomic variable to a new value if it is currently an old value.

    ***Note: If you don't know what this function is for, you shouldn't use
    it!***

    Params:
        a =         a pointer to an SDL_AtomicInt variable to be modified.
        oldval =    the old value.
        newval =    the new value.
    
    Returns:
        $(D true) if the atomic variable was set, $(D false) otherwise.

    See_Also:
        $(D SDL_GetAtomicInt)
        $(D SDL_SetAtomicInt)

    Threadsafety:
        It is safe to call this function from any thread.

    History:
        Available since SDL 3.2.0.
*/
extern bool SDL_CompareAndSwapAtomicInt(SDL_AtomicInt* a, int oldval, int newval);

/**
    Set an atomic variable to a value.

    This function also acts as a full memory barrier.

    ***Note: If you don't know what this function is for, you shouldn't use
    it!***

    Params:
        a = a pointer to an SDL_AtomicInt variable to be modified.
        v = the desired value.
    
    Returns:
        the previous value of the atomic variable.

    See_Also:
        $(D SDL_GetAtomicInt)

    Threadsafety:
        It is safe to call this function from any thread.

    History:
        Available since SDL 3.2.0.
*/
extern int SDL_SetAtomicInt(SDL_AtomicInt* a, int v);

/**
    Get the value of an atomic variable.

    ***Note: If you don't know what this function is for, you shouldn't use
    it!***

    Params:
        a = a pointer to an SDL_AtomicInt variable.
    
    Returns:
        the current value of an atomic variable.

    See_Also:
        $(D SDL_SetAtomicInt)

    Threadsafety:
        It is safe to call this function from any thread.

    History:
        Available since SDL 3.2.0.
*/
extern int SDL_GetAtomicInt(SDL_AtomicInt* a);

/**
    Add to an atomic variable.

    This function also acts as a full memory barrier.

    ***Note: If you don't know what this function is for, you shouldn't use
    it!***

    Params:
        a = a pointer to an SDL_AtomicInt variable to be modified.
        v = the desired value to add.
    
    Returns:
        the previous value of the atomic variable.

    See_Also:
        $(D SDL_AtomicDecRef)
        $(D SDL_AtomicIncRef)

    Threadsafety:
        It is safe to call this function from any thread.

    History:
        Available since SDL 3.2.0.
*/
extern int SDL_AddAtomicInt(SDL_AtomicInt* a, int v);


/**
    A type representing an atomic unsigned 32-bit value.

    This can be used to manage a value that is synchronized across multiple
    CPUs without a race condition; when an app sets a value with
    SDL_SetAtomicU32 all other threads, regardless of the CPU it is running on,
    will see that value when retrieved with SDL_GetAtomicU32, regardless of CPU
    caches, etc.

    This is also useful for atomic compare-and-swap operations: a thread can
    change the value as long as its current value matches expectations. When
    done in a loop, one can guarantee data consistency across threads without a
    lock (but the usual warnings apply: if you don't know what you're doing, or
    you don't do it carefully, you can confidently cause any number of
    disasters with this, so in most cases, you _should_ use a mutex instead of
    this!).

    This is a struct so people don't accidentally use numeric operations on it
    directly. You have to use SDL atomic functions.

    See_Also:
        $(D SDL_CompareAndSwapAtomicU32)
        $(D SDL_GetAtomicU32)
        $(D SDL_SetAtomicU32)

    History:
        Available since SDL 3.2.0.
*/
struct SDL_AtomicU32 { 
    Uint32 value;
    alias value this;
}


/**
    Set an atomic variable to a new value if it is currently an old value.

    ***Note: If you don't know what this function is for, you shouldn't use
    it!***

    Params:
        a =         a pointer to an SDL_AtomicU32 variable to be modified.
        oldval =    the old value.
        newval =    the new value.
    
    Returns:
        $(D true) if the atomic variable was set, $(D false) otherwise.

    See_Also:
        $(D SDL_GetAtomicU32)
        $(D SDL_SetAtomicU32)

    Threadsafety:
        It is safe to call this function from any thread.

    History:
        Available since SDL 3.2.0.
*/
extern bool SDL_CompareAndSwapAtomicU32(SDL_AtomicU32* a, Uint32 oldval, Uint32 newval);

/**
    Set an atomic variable to a value.

    This function also acts as a full memory barrier.

    ***Note: If you don't know what this function is for, you shouldn't use
    it!***

    Params:
        a = a pointer to an SDL_AtomicU32 variable to be modified.
        v = the desired value.
    
    Returns:
        the previous value of the atomic variable.

    See_Also:
        $(D SDL_GetAtomicU32)

    Threadsafety:
        It is safe to call this function from any thread.

    History:
        Available since SDL 3.2.0.
*/
extern Uint32 SDL_SetAtomicU32(SDL_AtomicU32* a, Uint32 v);

/**
    Get the value of an atomic variable.

    ***Note: If you don't know what this function is for, you shouldn't use
    it!***

    Params:
        a = a pointer to an SDL_AtomicU32 variable.
    
    Returns:
        the current value of an atomic variable.

    See_Also:
        $(D SDL_SetAtomicU32)

    Threadsafety:
        It is safe to call this function from any thread.

    History:
        Available since SDL 3.2.0.
*/
extern Uint32 SDL_GetAtomicU32(SDL_AtomicU32* a);

/**
    Set a pointer to a new value if it is currently an old value.

    ***Note: If you don't know what this function is for, you shouldn't use
    it!***

    Params:
        a =         a pointer to a pointer.
        oldval =    the old pointer value.
        newval =    the new pointer value.
    
    Returns:
        $(D true) if the pointer was set, $(D false) otherwise.

    See_Also:
        $(D SDL_CompareAndSwapAtomicInt)
        $(D SDL_GetAtomicPointer)
        $(D SDL_SetAtomicPointer)

    Threadsafety:
        It is safe to call this function from any thread.

    History:
        Available since SDL 3.2.0.
*/
extern bool SDL_CompareAndSwapAtomicPointer(void** a, void* oldval, void* newval);

/**
    Set a pointer to a value atomically.

    ***Note: If you don't know what this function is for, you shouldn't use
    it!***

    Params:
        a = a pointer to a pointer.
        v = the desired pointer value.
    
    Returns:
        the previous value of the pointer.

    See_Also:
        $(D SDL_CompareAndSwapAtomicPointer)
        $(D SDL_GetAtomicPointer)

    Threadsafety:
        It is safe to call this function from any thread.

    History:
        Available since SDL 3.2.0.
*/
extern void* SDL_SetAtomicPointer(void** a, void* v);

/**
    Get the value of a pointer atomically.

    ***Note: If you don't know what this function is for, you shouldn't use
    it!***

    Params:
        a = a pointer to a pointer.
    
    Returns:
        the current value of a pointer.

    See_Also:
        $(D SDL_CompareAndSwapAtomicPointer)
        $(D SDL_SetAtomicPointer)

    Threadsafety:
        It is safe to call this function from any thread.

    History:
        Available since SDL 3.2.0.
*/
extern void* SDL_GetAtomicPointer(void** a);