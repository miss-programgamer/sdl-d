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
    SDL CPU Info

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryCPUInfo, SDL3 CategoryCPUInfo Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.cpuinfo;
extern(C) nothrow @nogc:

/**
    A guess for the cacheline size used for padding.

    Most x86 processors have a 64 byte cache line. The 64-bit PowerPC
    processors have a 128 byte cache line. We use the larger value to be
    generally safe.
*/
version(X86) enum SDL_CACHE_LINE_SIZE = 64;
else version(X86_64) enum SDL_CACHE_LINE_SIZE = 64;
else version(PPC64) enum SDL_CACHE_LINE_SIZE = 128;
else enum SDL_CACHE_LINE_SIZE = 128; // Fallback


/**
    Get the number of logical CPU cores available.

    Returns:
        The total number of logical CPU cores. On CPUs that include
        technologies such as hyperthreading, the number of logical cores
        may be more than the number of physical cores.

    Threadsafety:
        It is safe to call this function from any thread.
*/
extern int SDL_GetNumLogicalCPUCores();

/**
    Determine the L1 cache line size of the CPU.

    This is useful for determining multi-threaded structure padding or SIMD
    prefetch sizes.

    Returns:
        The L1 cache line size of the CPU, in bytes.

    Threadsafety:
        It is safe to call this function from any thread.
*/
extern int SDL_GetCPUCacheLineSize();

/**
    Determine whether the CPU has AltiVec features.

    This always returns $(D false) on CPUs that aren't using PowerPC instruction
    sets.

    Returns:
        $(D true) if the CPU has AltiVec features,
        $(D false) otherwise.

    Threadsafety:
        It is safe to call this function from any thread.
*/
extern bool SDL_HasAltiVec();

/**
    Determine whether the CPU has MMX features.

    This always returns $(D false) on CPUs that aren't using Intel instruction sets.

    Returns:
        $(D true) if the CPU has MMX features,
        $(D false) otherwise.

    Threadsafety:
        It is safe to call this function from any thread.
*/
extern bool SDL_HasMMX();

/**
    Determine whether the CPU has SSE features.

    This always returns $(D false) on CPUs that aren't using Intel instruction sets.

    Returns:
        $(D true) if the CPU has SSE features,
        $(D false) otherwise.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_HasSSE2)
        $(D SDL_HasSSE3)
        $(D SDL_HasSSE41)
        $(D SDL_HasSSE42)
*/
extern bool SDL_HasSSE();

/**
    Determine whether the CPU has SSE2 features.

    This always returns $(D false) on CPUs that aren't using Intel instruction sets.

    Returns:
        $(D true) if the CPU has SSE2 features,
        $(D false) otherwise.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_HasSSE)
        $(D SDL_HasSSE3)
        $(D SDL_HasSSE41)
        $(D SDL_HasSSE42)
*/
extern bool SDL_HasSSE2();

/**
    Determine whether the CPU has SSE3 features.

    This always returns $(D false) on CPUs that aren't using Intel instruction sets.

    Returns:
        $(D true) if the CPU has SSE3 features,
        $(D false) otherwise.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_HasSSE)
        $(D SDL_HasSSE2)
        $(D SDL_HasSSE41)
        $(D SDL_HasSSE42)
*/
extern bool SDL_HasSSE3();

/**
    Determine whether the CPU has SSE4.1 features.

    This always returns $(D false) on CPUs that aren't using Intel instruction sets.

    Returns:
        $(D true) if the CPU has SSE4.1 features,
        $(D false) otherwise.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_HasSSE)
        $(D SDL_HasSSE2)
        $(D SDL_HasSSE3)
        $(D SDL_HasSSE42)
*/
extern bool SDL_HasSSE41();

/**
    Determine whether the CPU has SSE4.2 features.

    This always returns $(D false) on CPUs that aren't using Intel instruction sets.

    Returns:
        $(D true) if the CPU has SSE4.2 features,
        $(D false) otherwise.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_HasSSE)
        $(D SDL_HasSSE2)
        $(D SDL_HasSSE3)
        $(D SDL_HasSSE41)
*/
extern bool SDL_HasSSE42();

/**
    Determine whether the CPU has AVX features.

    This always returns $(D false) on CPUs that aren't using Intel instruction sets.

    Returns:
        $(D true) if the CPU has AVX features,
        $(D false) otherwise.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_HasAVX2)
        $(D SDL_HasAVX512F)
*/
extern bool SDL_HasAVX();

/**
    Determine whether the CPU has AVX2 features.

    This always returns $(D false) on CPUs that aren't using Intel instruction sets.

    Returns:
        $(D true) if the CPU has AVX2 features,
        $(D false) otherwise.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_HasAVX)
        $(D SDL_HasAVX512F)
*/
extern bool SDL_HasAVX2();

/**
    Determine whether the CPU has AVX-512F (foundation) features.

    This always returns $(D false) on CPUs that aren't using Intel instruction sets.

    Returns:
        $(D true) if the CPU has AVX-512F features,
        $(D false) otherwise.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_HasAVX)
        $(D SDL_HasAVX2)
*/
extern bool SDL_HasAVX512F();

/**
    Determine whether the CPU has ARM SIMD (ARMv6) features.

    This is different from ARM NEON, which is a different instruction set.

    This always returns $(D false) on CPUs that aren't using ARM instruction sets.

    Returns:
        $(D true) if the CPU has ARM SIMD features,
        $(D false) otherwise.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_HasNEON)
*/
extern bool SDL_HasARMSIMD();

/**
    Determine whether the CPU has NEON (ARM SIMD) features.

    This always returns $(D false) on CPUs that aren't using ARM instruction sets.

    Returns:
        $(D true) if the CPU has ARM NEON features,
        $(D false) otherwise.

    Threadsafety:
        It is safe to call this function from any thread.
*/
extern bool SDL_HasNEON();

/**
    Determine whether the CPU has LSX (LOONGARCH SIMD) features.

    This always returns $(D false) on CPUs that aren't using LOONGARCH instruction
    sets.

    Returns:
        $(D true) if the CPU has LOONGARCH LSX features,
        $(D false) otherwise.

    Threadsafety:
        It is safe to call this function from any thread.
*/
extern bool SDL_HasLSX();

/**
    Determine whether the CPU has LASX (LOONGARCH SIMD) features.

    This always returns $(D false) on CPUs that aren't using LOONGARCH instruction
    sets.

    Returns:
        $(D true) if the CPU has LOONGARCH LASX features,
        $(D false) otherwise.

    Threadsafety:
        It is safe to call this function from any thread.
*/
extern bool SDL_HasLASX();

/**
    Get the amount of RAM configured in the system.

    Returns:
        The amount of RAM configured in the system in MiB.

    Threadsafety:
        It is safe to call this function from any thread.
*/
extern int SDL_GetSystemRAM();

/**
    Report the alignment this system needs for SIMD allocations.

    This will return the minimum number of bytes to which a pointer must be
    aligned to be compatible with SIMD instructions on the current machine. For
    example, if the machine supports SSE only, it will return 16, but if it
    supports AVX-512F, it'll return 64 (etc). This only reports values for
    instruction sets SDL knows about, so if your SDL build doesn't have
    SDL_HasAVX512F(), then it might return 16 for the SSE support it sees and
    not 64 for the AVX-512 instructions that exist but SDL doesn't know about.
    Plan accordingly.

    Returns:
        The alignment in bytes needed for available, known SIMD
        instructions.

    Threadsafety:
        It is safe to call this function from any thread.

    See_Also:
        $(D SDL_aligned_alloc)
        $(D SDL_aligned_free)
*/
extern size_t SDL_GetSIMDAlignment();
