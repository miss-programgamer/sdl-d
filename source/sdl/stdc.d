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
module sdl.stdc;

extern (C) nothrow @nogc:

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
*/
alias SDL_FunctionPointer = void function();

/**
    Allocate uninitialized memory.

    The allocated memory returned by this function must be freed with
    SDL_free().

    If `size` is 0, it will be set to 1.

    If you want to allocate memory aligned to a specific alignment, consider
    using SDL_aligned_alloc().

    \param size the size to allocate.
    \returns a pointer to the allocated memory, or NULL if allocation failed.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.

    \sa SDL_free
    \sa SDL_calloc
    \sa SDL_realloc
    \sa SDL_aligned_alloc
*/
extern void* SDL_malloc(size_t size);

/**
    Allocate a zero-initialized array.

    The memory returned by this function must be freed with SDL_free().

    If either of `nmemb` or `size` is 0, they will both be set to 1.

    \param nmemb the number of elements in the array.
    \param size the size of each element of the array.
    \returns a pointer to the allocated array, or NULL if allocation failed.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.

    \sa SDL_free
    \sa SDL_malloc
    \sa SDL_realloc
*/
extern void* SDL_calloc(size_t nmemb, size_t size);

/**
    Change the size of allocated memory.

    The memory returned by this function must be freed with SDL_free().

    If `size` is 0, it will be set to 1. Note that this is unlike some other C
    runtime `realloc` implementations, which may treat `realloc(mem, 0)` the
    same way as `free(mem)`.

    If `mem` is NULL, the behavior of this function is equivalent to
    SDL_malloc(). Otherwise, the function can have one of three possible
    outcomes:

    - If it returns the same pointer as `mem`, it means that `mem` was resized
    in place without freeing.
    - If it returns a different non-NULL pointer, it means that `mem` was freed
    and cannot be dereferenced anymore.
    - If it returns NULL (indicating failure), then `mem` will remain valid and
    must still be freed with SDL_free().

    \param mem a pointer to allocated memory to reallocate, or NULL.
    \param size the new size of the memory.
    \returns a pointer to the newly allocated memory, or NULL if allocation
            failed.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.

    \sa SDL_free
    \sa SDL_malloc
    \sa SDL_calloc
*/
extern void* SDL_realloc(void* mem, size_t size);

/**
    Free allocated memory.

    The pointer is no longer valid after this call and cannot be dereferenced
    anymore.

    If `mem` is NULL, this function does nothing.

    \param mem a pointer to allocated memory, or NULL.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.

    \sa SDL_malloc
    \sa SDL_calloc
    \sa SDL_realloc
*/
extern void SDL_free(void* mem);

/**
    A callback used to implement SDL_malloc().

    SDL will always ensure that the passed `size` is greater than 0.

    \param size the size to allocate.
    \returns a pointer to the allocated memory, or NULL if allocation failed.

    \threadsafety It should be safe to call this callback from any thread.

    \since This datatype is available since SDL 3.2.0.

    \sa SDL_malloc
    \sa SDL_GetOriginalMemoryFunctions
    \sa SDL_GetMemoryFunctions
    \sa SDL_SetMemoryFunctions
*/
alias SDL_malloc_func = void* function(size_t size);

/**
    A callback used to implement SDL_calloc().

    SDL will always ensure that the passed `nmemb` and `size` are both greater
    than 0.

    \param nmemb the number of elements in the array.
    \param size the size of each element of the array.
    \returns a pointer to the allocated array, or NULL if allocation failed.

    \threadsafety It should be safe to call this callback from any thread.

    \since This datatype is available since SDL 3.2.0.

    \sa SDL_calloc
    \sa SDL_GetOriginalMemoryFunctions
    \sa SDL_GetMemoryFunctions
    \sa SDL_SetMemoryFunctions
*/
alias SDL_calloc_func = void* function(size_t nmemb, size_t size);

/**
    A callback used to implement SDL_realloc().

    SDL will always ensure that the passed `size` is greater than 0.

    \param mem a pointer to allocated memory to reallocate, or NULL.
    \param size the new size of the memory.
    \returns a pointer to the newly allocated memory, or NULL if allocation
            failed.

    \threadsafety It should be safe to call this callback from any thread.

    \since This datatype is available since SDL 3.2.0.

    \sa SDL_realloc
    \sa SDL_GetOriginalMemoryFunctions
    \sa SDL_GetMemoryFunctions
    \sa SDL_SetMemoryFunctions
*/
alias SDL_realloc_func = void* function(void * mem, size_t size);

/**
    A callback used to implement SDL_free().

    SDL will always ensure that the passed `mem` is a non-NULL pointer.

    \param mem a pointer to allocated memory.

    \threadsafety It should be safe to call this callback from any thread.

    \since This datatype is available since SDL 3.2.0.

    \sa SDL_free
    \sa SDL_GetOriginalMemoryFunctions
    \sa SDL_GetMemoryFunctions
    \sa SDL_SetMemoryFunctions
*/
alias SDL_free_func = void function(void* mem);

/**
    Get the original set of SDL memory functions.

    This is what SDL_malloc and friends will use by default, if there has been
    no call to SDL_SetMemoryFunctions. This is not necessarily using the C
    runtime's `malloc` functions behind the scenes! Different platforms and
    build configurations might do any number of unexpected things.

    \param malloc_func filled with malloc function.
    \param calloc_func filled with calloc function.
    \param realloc_func filled with realloc function.
    \param free_func filled with free function.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.
*/
extern void SDL_GetOriginalMemoryFunctions(
    SDL_malloc_func* malloc_func,
    SDL_calloc_func* calloc_func,
    SDL_realloc_func* realloc_func,
    SDL_free_func* free_func);

/**
    Get the current set of SDL memory functions.

    \param malloc_func filled with malloc function.
    \param calloc_func filled with calloc function.
    \param realloc_func filled with realloc function.
    \param free_func filled with free function.

    \threadsafety This does not hold a lock, so do not call this in the
                unlikely event of a background thread calling
                SDL_SetMemoryFunctions simultaneously.

    \since This function is available since SDL 3.2.0.

    \sa SDL_SetMemoryFunctions
    \sa SDL_GetOriginalMemoryFunctions
*/
extern void SDL_GetMemoryFunctions(
    SDL_malloc_func* malloc_func,
    SDL_calloc_func* calloc_func,
    SDL_realloc_func* realloc_func,
    SDL_free_func* free_func);

/**
    Replace SDL's memory allocation functions with a custom set.

    It is not safe to call this function once any allocations have been made,
    as future calls to SDL_free will use the new allocator, even if they came
    from an SDL_malloc made with the old one!

    If used, usually this needs to be the first call made into the SDL library,
    if not the very first thing done at program startup time.

    \param malloc_func custom malloc function.
    \param calloc_func custom calloc function.
    \param realloc_func custom realloc function.
    \param free_func custom free function.
    \returns true on success or false on failure; call SDL_GetError() for more
            information.

    \threadsafety It is safe to call this function from any thread, but one
                should not replace the memory functions once any allocations
                are made!

    \since This function is available since SDL 3.2.0.

    \sa SDL_GetMemoryFunctions
    \sa SDL_GetOriginalMemoryFunctions
*/
extern bool SDL_SetMemoryFunctions(
    SDL_malloc_func malloc_func,
    SDL_calloc_func calloc_func,
    SDL_realloc_func realloc_func,
    SDL_free_func free_func);

/**
    Allocate memory aligned to a specific alignment.

    The memory returned by this function must be freed with SDL_aligned_free(),
    _not_ SDL_free().

    If `alignment` is less than the size of `void *`, it will be increased to
    match that.

    The returned memory address will be a multiple of the alignment value, and
    the size of the memory allocated will be a multiple of the alignment value.

    \param alignment the alignment of the memory.
    \param size the size to allocate.
    \returns a pointer to the aligned memory, or NULL if allocation failed.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.

    \sa SDL_aligned_free
*/
extern void* SDL_aligned_alloc(size_t alignment, size_t size);

/**
    Free memory allocated by SDL_aligned_alloc().

    The pointer is no longer valid after this call and cannot be dereferenced
    anymore.

    If `mem` is NULL, this function does nothing.

    \param mem a pointer previously returned by SDL_aligned_alloc(), or NULL.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.

    \sa SDL_aligned_alloc
*/
extern void SDL_aligned_free(void* mem);

/**
    Get the number of outstanding (unfreed) allocations.

    \returns the number of allocations or -1 if allocation counting is
            disabled.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.
*/
extern int SDL_GetNumAllocations();

/**
    A thread-safe set of environment variables

    \since This struct is available since SDL 3.2.0.

    \sa SDL_GetEnvironment
    \sa SDL_CreateEnvironment
    \sa SDL_GetEnvironmentVariable
    \sa SDL_GetEnvironmentVariables
    \sa SDL_SetEnvironmentVariable
    \sa SDL_UnsetEnvironmentVariable
    \sa SDL_DestroyEnvironment
*/
struct SDL_Environment;

/**
    Get the process environment.

    This is initialized at application start and is not affected by setenv()
    and unsetenv() calls after that point. Use SDL_SetEnvironmentVariable() and
    SDL_UnsetEnvironmentVariable() if you want to modify this environment, or
    SDL_setenv_unsafe() or SDL_unsetenv_unsafe() if you want changes to persist
    in the C runtime environment after SDL_Quit().

    \returns a pointer to the environment for the process or NULL on failure;
            call SDL_GetError() for more information.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.

    \sa SDL_GetEnvironmentVariable
    \sa SDL_GetEnvironmentVariables
    \sa SDL_SetEnvironmentVariable
    \sa SDL_UnsetEnvironmentVariable
*/
extern SDL_Environment* SDL_GetEnvironment();

/**
    Create a set of environment variables

    \param populated true to initialize it from the C runtime environment,
                    false to create an empty environment.
    \returns a pointer to the new environment or NULL on failure; call
            SDL_GetError() for more information.

    \threadsafety If `populated` is false, it is safe to call this function
                from any thread, otherwise it is safe if no other threads are
                calling setenv() or unsetenv()

    \since This function is available since SDL 3.2.0.

    \sa SDL_GetEnvironmentVariable
    \sa SDL_GetEnvironmentVariables
    \sa SDL_SetEnvironmentVariable
    \sa SDL_UnsetEnvironmentVariable
    \sa SDL_DestroyEnvironment
*/
extern SDL_Environment* SDL_CreateEnvironment(bool populated);

/**
    Get the value of a variable in the environment.

    \param env the environment to query.
    \param name the name of the variable to get.
    \returns a pointer to the value of the variable or NULL if it can't be
            found.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.

    \sa SDL_GetEnvironment
    \sa SDL_CreateEnvironment
    \sa SDL_GetEnvironmentVariables
    \sa SDL_SetEnvironmentVariable
    \sa SDL_UnsetEnvironmentVariable
*/
extern const(char)* SDL_GetEnvironmentVariable(SDL_Environment* env, const(char)* name);

/**
    Get all variables in the environment.

    \param env the environment to query.
    \returns a NULL terminated array of pointers to environment variables in
            the form "variable=value" or NULL on failure; call SDL_GetError()
            for more information. This is a single allocation that should be
            freed with SDL_free() when it is no longer needed.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.

    \sa SDL_GetEnvironment
    \sa SDL_CreateEnvironment
    \sa SDL_GetEnvironmentVariables
    \sa SDL_SetEnvironmentVariable
    \sa SDL_UnsetEnvironmentVariable
*/
extern char** SDL_GetEnvironmentVariables(SDL_Environment* env);

/**
    Set the value of a variable in the environment.

    \param env the environment to modify.
    \param name the name of the variable to set.
    \param value the value of the variable to set.
    \param overwrite true to overwrite the variable if it exists, false to
                    return success without setting the variable if it already
                    exists.
    \returns true on success or false on failure; call SDL_GetError() for more
            information.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.

    \sa SDL_GetEnvironment
    \sa SDL_CreateEnvironment
    \sa SDL_GetEnvironmentVariable
    \sa SDL_GetEnvironmentVariables
    \sa SDL_UnsetEnvironmentVariable
*/
extern bool SDL_SetEnvironmentVariable(SDL_Environment* env, const(char)* name, const(char)* value, bool overwrite);

/**
    Clear a variable from the environment.

    \param env the environment to modify.
    \param name the name of the variable to unset.
    \returns true on success or false on failure; call SDL_GetError() for more
            information.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.

    \sa SDL_GetEnvironment
    \sa SDL_CreateEnvironment
    \sa SDL_GetEnvironmentVariable
    \sa SDL_GetEnvironmentVariables
    \sa SDL_SetEnvironmentVariable
    \sa SDL_UnsetEnvironmentVariable
*/
extern bool SDL_UnsetEnvironmentVariable(SDL_Environment* env, const(char)* name);

/**
    Destroy a set of environment variables.

    \param env the environment to destroy.

    \threadsafety It is safe to call this function from any thread, as long as
                the environment is no longer in use.

    \since This function is available since SDL 3.2.0.

    \sa SDL_CreateEnvironment
*/
extern void SDL_DestroyEnvironment(SDL_Environment* env);

/**
    Get the value of a variable in the environment.

    This function uses SDL's cached copy of the environment and is thread-safe.

    \param name the name of the variable to get.
    \returns a pointer to the value of the variable or NULL if it can't be
            found.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.
*/
extern const(char)* SDL_getenv(const(char)* name);

/**
    Get the value of a variable in the environment.

    This function bypasses SDL's cached copy of the environment and is not
    thread-safe.

    \param name the name of the variable to get.
    \returns a pointer to the value of the variable or NULL if it can't be
            found.

    \threadsafety This function is not thread safe, consider using SDL_getenv()
                instead.

    \since This function is available since SDL 3.2.0.

    \sa SDL_getenv
*/
extern const(char)* SDL_getenv_unsafe(const(char)* name);

/**
    Set the value of a variable in the environment.

    \param name the name of the variable to set.
    \param value the value of the variable to set.
    \param overwrite 1 to overwrite the variable if it exists, 0 to return
                    success without setting the variable if it already exists.
    \returns 0 on success, -1 on error.

    \threadsafety This function is not thread safe, consider using
                SDL_SetEnvironmentVariable() instead.

    \since This function is available since SDL 3.2.0.

    \sa SDL_SetEnvironmentVariable
*/
extern int SDL_setenv_unsafe(const(char)* name, const(char)* value, int overwrite);

/**
    Clear a variable from the environment.

    \param name the name of the variable to unset.
    \returns 0 on success, -1 on error.

    \threadsafety This function is not thread safe, consider using
                SDL_UnsetEnvironmentVariable() instead.

    \since This function is available since SDL 3.2.0.

    \sa SDL_UnsetEnvironmentVariable
*/
extern int SDL_unsetenv_unsafe(const(char)* name);

/**
    A callback used with SDL sorting and binary search functions.

    \param a a pointer to the first element being compared.
    \param b a pointer to the second element being compared.
    \returns -1 if `a` should be sorted before `b`, 1 if `b` should be sorted
            before `a`, 0 if they are equal. If two elements are equal, their
            order in the sorted array is undefined.

    \since This callback is available since SDL 3.2.0.

    \sa SDL_bsearch
    \sa SDL_qsort
*/
alias SDL_CompareCallback = int function(const(void)* a, const(void)* b);

/**
    Sort an array.

    For example:

    Examples:
        $(D_CODE
            struct data {
                int key;
                const(char)* value;
            }

            int compare(const(data)* a, const(data)* b) {
                if (a.n < b.n) {
                    return -1;
                } else if (b.n < a.n) {
                    return 1;
                } else {
                    return 0;
                }
            }

            data[] values[] = [
                { 3, "third" }, { 1, "first" }, { 2, "second" }
            ];

            SDL_qsort(values.ptr, values.length, data.sizeof, cast(SDL_CompareCallback)&compare);
        )


    \param base a pointer to the start of the array.
    \param nmemb the number of elements in the array.
    \param size the size of the elements in the array.
    \param compare a function used to compare elements in the array.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.

    \sa SDL_bsearch
    \sa SDL_qsort_r
*/
extern void SDL_qsort(void* base, size_t nmemb, size_t size, SDL_CompareCallback compare);

/**
    Perform a binary search on a previously sorted array.

    Examples:

        $(D_CODE
            struct data {
                int key;
                const(char)* value;
            }

            int compare(const(data)* a, const(data)* b) {
                if (a.n < b.n) {
                    return -1;
                } else if (b.n < a.n) {
                    return 1;
                } else {
                    return 0;
                }
            }

            data[] values = [
                { 1, "first" }, { 2, "second" }, { 3, "third" }
            ];

            data key = { 2, NULL };

            data* result = SDL_bsearch(&key, values.ptr, values.length, data.sizeof, cast(SDL_CompareCallback)&compare);
        )

    \param key a pointer to a key equal to the element being searched for.
    \param base a pointer to the start of the array.
    \param nmemb the number of elements in the array.
    \param size the size of the elements in the array.
    \param compare a function used to compare elements in the array.
    \returns a pointer to the matching element in the array, or NULL if not
            found.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.

    \sa SDL_bsearch_r
    \sa SDL_qsort
*/
extern void* SDL_bsearch(const(void)* key, const(void)* base, size_t nmemb, size_t size, SDL_CompareCallback compare);

/**
    A callback used with SDL sorting and binary search functions.

    \param userdata the `userdata` pointer passed to the sort function.
    \param a a pointer to the first element being compared.
    \param b a pointer to the second element being compared.
    \returns -1 if `a` should be sorted before `b`, 1 if `b` should be sorted
            before `a`, 0 if they are equal. If two elements are equal, their
            order in the sorted array is undefined.

    \since This callback is available since SDL 3.2.0.

    \sa SDL_qsort_r
    \sa SDL_bsearch_r
*/
alias SDL_CompareCallback_r = int function(void* userdata, const(void)* a, const(void)* b);

/**
    Sort an array, passing a userdata pointer to the compare function.

    Examples:
        $(D_CODE
            enum sort_method {
                sort_increasing,
                sort_decreasing,
            }

            struct data {
                int key;
                const(char)* value;
            }

            int compare(sort_method method, const(data)* a, const(data)* b) {
                if (a.key < b.key) {
                    return (method == sort_method.sort_increasing) ? -1 : 1;
                } else if (b.key < a.key) {
                    return (method == sort_method.sort_increasing) ? 1 : -1;
                } else {
                    return 0;
                }
            }

            data[] values = [
                { 3, "third" }, { 1, "first" }, { 2, "second" }
            ];

            // reinterpret_cast is a part of numem.
            SDL_qsort_r(values.ptr, values.length, data.sizeof, cast(SDL_CompareCallback_r)&compare, reinterpret_cast!(void*)(sort_method.sort_increasing));
        )

    \param base a pointer to the start of the array.
    \param nmemb the number of elements in the array.
    \param size the size of the elements in the array.
    \param compare a function used to compare elements in the array.
    \param userdata a pointer to pass to the compare function.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.

    \sa SDL_bsearch_r
    \sa SDL_qsort
*/
extern void SDL_qsort_r(void* base, size_t nmemb, size_t size, SDL_CompareCallback_r compare, void* userdata);

/**
    Perform a binary search on a previously sorted array, passing a userdata
    pointer to the compare function.

    For example:

    $(D_CODE 
        enum sort_method {
            sort_increasing,
            sort_decreasing,
        }

        struct data {
            int key;
            const(char)* value;
        }

        int compare(sort_method method, const(data)* a, const(data)* b) {
            if (a.key < b.key) {
                return (method == sort_method.sort_increasing) ? -1 : 1;
            } else if (b.key < a.key) {
                return (method == sort_method.sort_increasing) ? 1 : -1;
            } else {
                return 0;
            }
        }

        data[] values = [
            { 1, "first" }, { 2, "second" }, { 3, "third" }
        ];
        data key = { 2, NULL };

        // reinterpret_cast is a part of numem.
        data* result = SDL_bsearch_r(&key, values.ptr, values.length, data.sizeof, cast(SDL_CompareCallback_r)&compare, reinterpret_cast!(void*)(sort_method.sort_increasing));
    )

    \param key a pointer to a key equal to the element being searched for.
    \param base a pointer to the start of the array.
    \param nmemb the number of elements in the array.
    \param size the size of the elements in the array.
    \param compare a function used to compare elements in the array.
    \param userdata a pointer to pass to the compare function.
    \returns a pointer to the matching element in the array, or NULL if not
            found.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.

    \sa SDL_bsearch
    \sa SDL_qsort_r
*/
extern void* SDL_bsearch_r(const(void)* key, const(void)* base, size_t nmemb, size_t size, SDL_CompareCallback_r compare, void* userdata);

/**
    Compute the absolute value of `x`.

    \param x an integer value.
    \returns the absolute value of x.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.
*/
extern int SDL_abs(int x);

/**
    Query if a character is alphabetic (a letter).

    **WARNING**: Regardless of system locale, this will only treat ASCII values
    for English 'a-z' and 'A-Z' as true.

    \param x character value to check.
    \returns non-zero if x falls within the character class, zero otherwise.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.
*/
extern int SDL_isalpha(int x);

/**
    Query if a character is alphabetic (a letter) or a number.

    **WARNING**: Regardless of system locale, this will only treat ASCII values
    for English 'a-z', 'A-Z', and '0-9' as true.

    \param x character value to check.
    \returns non-zero if x falls within the character class, zero otherwise.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.
*/
extern int SDL_isalnum(int x);

/**
    Report if a character is blank (a space or tab).

    **WARNING**: Regardless of system locale, this will only treat ASCII values
    0x20 (space) or 0x9 (tab) as true.

    \param x character value to check.
    \returns non-zero if x falls within the character class, zero otherwise.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.
*/
extern int SDL_isblank(int x);

/**
    Report if a character is a control character.

    **WARNING**: Regardless of system locale, this will only treat ASCII values
    0 through 0x1F, and 0x7F, as true.

    \param x character value to check.
    \returns non-zero if x falls within the character class, zero otherwise.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.
*/
extern int SDL_iscntrl(int x);

/**
    Report if a character is a numeric digit.

    **WARNING**: Regardless of system locale, this will only treat ASCII values
    '0' (0x30) through '9' (0x39), as true.

    \param x character value to check.
    \returns non-zero if x falls within the character class, zero otherwise.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.
*/
extern int SDL_isdigit(int x);

/**
    Report if a character is a hexadecimal digit.

    **WARNING**: Regardless of system locale, this will only treat ASCII values
    'A' through 'F', 'a' through 'f', and '0' through '9', as true.

    \param x character value to check.
    \returns non-zero if x falls within the character class, zero otherwise.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.
*/
extern int SDL_isxdigit(int x);

/**
    Report if a character is a punctuation mark.

    **WARNING**: Regardless of system locale, this is equivalent to
    `((SDL_isgraph(x)) && (!SDL_isalnum(x)))`.

    \param x character value to check.
    \returns non-zero if x falls within the character class, zero otherwise.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.

    \sa SDL_isgraph
    \sa SDL_isalnum
*/
extern int SDL_ispunct(int x);

/**
    Report if a character is whitespace.

    **WARNING**: Regardless of system locale, this will only treat the
    following ASCII values as true:

    - space (0x20)
    - tab (0x09)
    - newline (0x0A)
    - vertical tab (0x0B)
    - form feed (0x0C)
    - return (0x0D)

    \param x character value to check.
    \returns non-zero if x falls within the character class, zero otherwise.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.
*/
extern int SDL_isspace(int x);

/**
    Report if a character is upper case.

    **WARNING**: Regardless of system locale, this will only treat ASCII values
    'A' through 'Z' as true.

    \param x character value to check.
    \returns non-zero if x falls within the character class, zero otherwise.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.
*/
extern int SDL_isupper(int x);

/**
    Report if a character is lower case.

    **WARNING**: Regardless of system locale, this will only treat ASCII values
    'a' through 'z' as true.

    \param x character value to check.
    \returns non-zero if x falls within the character class, zero otherwise.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.
*/
extern int SDL_islower(int x);

/**
    Report if a character is "printable".

    Be advised that "printable" has a definition that goes back to text
    terminals from the dawn of computing, making this a sort of special case
    function that is not suitable for Unicode (or most any) text management.

    **WARNING**: Regardless of system locale, this will only treat ASCII values
    ' ' (0x20) through '~' (0x7E) as true.

    \param x character value to check.
    \returns non-zero if x falls within the character class, zero otherwise.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.
*/
extern int SDL_isprint(int x);

/**
    Report if a character is any "printable" except space.

    Be advised that "printable" has a definition that goes back to text
    terminals from the dawn of computing, making this a sort of special case
    function that is not suitable for Unicode (or most any) text management.

    **WARNING**: Regardless of system locale, this is equivalent to
    `(SDL_isprint(x)) && ((x) != ' ')`.

    \param x character value to check.
    \returns non-zero if x falls within the character class, zero otherwise.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.

    \sa SDL_isprint
*/
extern int SDL_isgraph(int x);

/**
    Convert low-ASCII English letters to uppercase.

    **WARNING**: Regardless of system locale, this will only convert ASCII
    values 'a' through 'z' to uppercase.

    This function returns the uppercase equivalent of `x`. If a character
    cannot be converted, or is already uppercase, this function returns `x`.

    \param x character value to check.
    \returns capitalized version of x, or x if no conversion available.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.
*/
extern int SDL_toupper(int x);

/**
    Convert low-ASCII English letters to lowercase.

    **WARNING**: Regardless of system locale, this will only convert ASCII
    values 'A' through 'Z' to lowercase.

    This function returns the lowercase equivalent of `x`. If a character
    cannot be converted, or is already lowercase, this function returns `x`.

    \param x character value to check.
    \returns lowercase version of x, or x if no conversion available.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.
*/
extern int SDL_tolower(int x);

/**
    Calculate a CRC-16 value.

    https://en.wikipedia.org/wiki/Cyclic_redundancy_check

    This function can be called multiple times, to stream data to be
    checksummed in blocks. Each call must provide the previous CRC-16 return
    value to be updated with the next block. The first call to this function
    for a set of blocks should pass in a zero CRC value.

    \param crc the current checksum for this data set, or 0 for a new data set.
    \param data a new block of data to add to the checksum.
    \param len the size, in bytes, of the new block of data.
    \returns a CRC-16 checksum value of all blocks in the data set.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.
*/
extern Uint16 SDL_crc16(Uint16 crc, const(void)* data, size_t len);

/**
    Calculate a CRC-32 value.

    https://en.wikipedia.org/wiki/Cyclic_redundancy_check

    This function can be called multiple times, to stream data to be
    checksummed in blocks. Each call must provide the previous CRC-32 return
    value to be updated with the next block. The first call to this function
    for a set of blocks should pass in a zero CRC value.

    \param crc the current checksum for this data set, or 0 for a new data set.
    \param data a new block of data to add to the checksum.
    \param len the size, in bytes, of the new block of data.
    \returns a CRC-32 checksum value of all blocks in the data set.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.
*/
extern Uint32 SDL_crc32(Uint32 crc, const(void)* data, size_t len);

/**
    Calculate a 32-bit MurmurHash3 value for a block of data.

    https://en.wikipedia.org/wiki/MurmurHash

    A seed may be specified, which changes the final results consistently, but
    this does not work like SDL_crc16 and SDL_crc32: you can't feed a previous
    result from this function back into itself as the next seed value to
    calculate a hash in chunks; it won't produce the same hash as it would if
    the same data was provided in a single call.

    If you aren't sure what to provide for a seed, zero is fine. Murmur3 is not
    cryptographically secure, so it shouldn't be used for hashing top-secret
    data.

    \param data the data to be hashed.
    \param len the size of data, in bytes.
    \param seed a value that alters the final hash value.
    \returns a Murmur3 32-bit hash value.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.
*/
extern Uint32 SDL_murmur3_32(const(void)* data, size_t len, Uint32 seed);

/**
    Copy non-overlapping memory.

    The memory regions must not overlap. If they do, use SDL_memmove() instead.

    \param dst The destination memory region. Must not be NULL, and must not
            overlap with `src`.
    \param src The source memory region. Must not be NULL, and must not overlap
            with `dst`.
    \param len The length in bytes of both `dst` and `src`.
    \returns `dst`.

    \threadsafety It is safe to call this function from any thread.

    \since This function is available since SDL 3.2.0.

    \sa SDL_memmove
*/
extern void* SDL_memcpy(void* dst, const(void)* src, size_t len);
