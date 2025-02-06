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
    SDL3 Asynchronous I/O

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategoryAsyncIO, SDL3 AsyncIO Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.asyncio;
import sdl.types;

extern(C) nothrow @nogc:

/**
    The asynchronous I/O operation structure.

    This operates as an opaque handle. One can then request read or write
    operations on it.

    See_Also:
        $(D SDL_AsyncIOFromFile)

    History:
        Available since SDL 3.2.0.
*/
struct SDL_AsyncIO;

/**
    Types of asynchronous I/O tasks.

    History:
        Available since SDL 3.2.0.
*/
enum SDL_AsyncIOTaskType {
    
    /**
        A read operation.
    */
    READ,
    
    /**
        A write operation.
    */
    WRITE,
    
    /**
        A close operation.
    */
    CLOSE
}

/**
    Possible outcomes of an asynchronous I/O task.

    History:
        Available since SDL 3.2.0.
*/
enum SDL_AsyncIOResult {

    /**
        Request was completed without error.
    */
    COMPLETE,

    /**
        Request failed for some reason; check SDL_GetError()!
    */
    FAILURE,

    /**
        Request was canceled before completing.
    */
    CANCELED
}

/**
    Information about a completed asynchronous I/O request.
    
    History:
        Available since SDL 3.2.0.
*/
struct SDL_AsyncIOOutcome {
    
    /**
        What generated this task.
        
        This pointer will be invalid if it was closed!
    */
    SDL_AsyncIO* asyncio;
    
    /**
        What sort of task was this? Read, write, etc?
    */
    SDL_AsyncIOTaskType type;
    
    /**
        The result of the work (success, failure, cancellation).
    */
    SDL_AsyncIOResult result;
    
    /**
        Buffer where data was read/written.
    */
    void* buffer;
    
    /**
        Offset in the SDL_AsyncIO where data was read/written.
    */
    Uint64 offset;
    
    /**
        Number of bytes the task was to read/write.
    */
    Uint64 bytes_requested;
    
    /**
        Actual number of bytes that were read/written.
    */
    Uint64 bytes_transferred;
    
    /**
        Pointer provided by the app when starting the task
    */
    void* userdata;
}

/**
    A queue of completed asynchronous I/O tasks.

    When starting an asynchronous operation, you specify a queue for the new
    task. A queue can be asked later if any tasks in it have completed,
    allowing an app to manage multiple pending tasks in one place, in whatever
    order they complete.

    History:
        Available since SDL 3.2.0.
    
    See_Also:
        $(D SDL_CreateAsyncIOQueue)
        $(D SDL_ReadAsyncIO)
        $(D SDL_WriteAsyncIO)
        $(D SDL_GetAsyncIOResult)
        $(D SDL_WaitAsyncIOResult)
*/
struct SDL_AsyncIOQueue;


/**
    Use this function to create a new SDL_AsyncIO object for reading from and/or writing to a named file.

    The `mode` string understands the following values:
    - `"r"`: Open a file for reading only. It must exist.
    - `"w"`: Open a file for writing only. It will create missing files or
      truncate existing ones.
    - `"r+"`: Open a file for update both reading and writing. The file must
      exist.
    - `"w+"`: Create an empty file for both reading and writing. If a file with
      the same name already exists its content is erased and the file is
      treated as a new empty file.
    
    There is no "b" mode, as there is only "binary" style I/O, and no "a" mode
    for appending, since you specify the position when starting a task.
    This function supports Unicode filenames, but they must be encoded in UTF-8
    format, regardless of the underlying operating system.
    
    This call is _not_ asynchronous; it will open the file before returning,
    under the assumption that doing so is generally a fast operation. Future
    reads and writes to the opened file will be async, however.

    Params: 
        file =  a UTF-8 string representing the filename to open.
        mode =  an ASCII string representing the mode to be used for opening
                the file.

    Returns:
        a pointer to the SDL_AsyncIO structure that is created or NULL on failure;  
        call $(D SDL_GetError) for more information.

    History:
        Available since SDL 3.2.0.
    
    See_Also:
        $(D SDL_CloseAsyncIO)
        $(D SDL_ReadAsyncIO)
        $(D SDL_WriteAsyncIO)
*/
extern SDL_AsyncIO* SDL_AsyncIOFromFile(const(char)* file, const(char)* mode);


/**
    Use this function to get the size of the data stream in an $(D SDL_AsyncIO).

    This call is *not* asynchronous; it assumes that obtaining this info is a
    non-blocking operation in most reasonable cases.

    Params:
        asyncio = The SDL_AsyncIO to get the size of the data stream from.

    Returns: 
        the size of the data stream in the $(D SDL_IOStream) on success or a
        negative error code on failure; call $(D SDL_GetError) for more
        information.
    
    Threadsafety:
        It is safe to call this function from any thread.

    History:
        Available since SDL 3.2.0.
*/
extern Sint64 SDL_GetAsyncIOSize(SDL_AsyncIO* asyncio);

/**
    Start an async read.

    This function reads up to `size` bytes from `offset` position in the data
    source to the area pointed at by `ptr`. This function may read less bytes
    than requested.

    This function returns as quickly as possible; it does not wait for the read
    to complete. On a successful return, this work will continue in the
    background. If the work begins, even failure is asynchronous: a failing
    return value from this function only means the work couldn't start at all.

    `ptr` must remain available until the work is done, and may be accessed by
    the system at any time until then. Do not allocate it on the stack, as this
    might take longer than the life of the calling function to complete!

    An SDL_AsyncIOQueue must be specified. The newly-created task will be added
    to it when it completes its work.

    Param:
        asyncio =   a pointer to an SDL_AsyncIO structure.
        ptr =       a pointer to a buffer to read data into.
        offset =    the position to start reading in the data source.
        size =      the number of bytes to read from the data source.
        queue =     a queue to add the new SDL_AsyncIO to.
        userdata =  an app-defined pointer that will be provided with the task
                    results.

    Returns:
        $(D true) on success or $(D false) on failure; call $(D SDL_GetError) for more
        information.

    See_Also:
        $(D SDL_WriteAsyncIO)
        $(D SDL_CreateAsyncIOQueue)
    
    Threadsafety:
        It is safe to call this function from any thread.

    History:
        Available since SDL 3.2.0.
*/
extern bool SDL_ReadAsyncIO(SDL_AsyncIO* asyncio, void* ptr, Uint64 offset, Uint64 size, SDL_AsyncIOQueue* queue, void* userdata);

/**
    Start an async write.

    This function writes `size` bytes from `offset` position in the data source
    to the area pointed at by `ptr`.

    This function returns as quickly as possible; it does not wait for the
    write to complete. On a successful return, this work will continue in the
    background. If the work begins, even failure is asynchronous: a failing
    return value from this function only means the work couldn't start at all.

    `ptr` must remain available until the work is done, and may be accessed by
    the system at any time until then. Do not allocate it on the stack, as this
    might take longer than the life of the calling function to complete!

    An $(D SDL_AsyncIOQueue) must be specified. The newly-created task will be 
    added to it when it completes its work.

    Params:
        asyncio =   a pointer to an SDL_AsyncIO structure.
        ptr =       a pointer to a buffer to write data from.
        offset =    the position to start writing to the data source.
        size =      the number of bytes to write to the data source.
        queue =     a queue to add the new SDL_AsyncIO to.
        userdata =  an app-defined pointer that will be provided with the task
                    results.
    
    Returns:
        $(D true) on success or $(D false) on failure; call $(D SDL_GetError) for more
        information.

    See_Also:
        $(D SDL_ReadAsyncIO)
        $(D SDL_CreateAsyncIOQueue)
    
    Threadsafety:
        It is safe to call this function from any thread.

    History:
        Available since SDL 3.2.0.
*/
extern bool SDL_WriteAsyncIO(SDL_AsyncIO* asyncio, void* ptr, Uint64 offset, Uint64 size, SDL_AsyncIOQueue* queue, void* userdata);

/**
    Close and free any allocated resources for an async I/O object.

    Closing a file is *also* an asynchronous task! If a write failure were to
    happen during the closing process, for example, the task results will
    report it as usual.

    Closing a file that has been written to does not guarantee the data has
    made it to physical media; it may remain in the operating system's file
    cache, for later writing to disk. This means that a successfully-closed
    file can be lost if the system crashes or loses power in this small window.
    To prevent this, call this function with the `flush` parameter set to true.
    This will make the operation take longer, and perhaps increase system load
    in general, but a successful result guarantees that the data has made it to
    physical storage. Don't use this for temporary files, caches, and
    unimportant data, and definitely use it for crucial irreplaceable files,
    like game saves.

    This function guarantees that the close will happen after any other pending
    tasks to `asyncio`, so it's safe to open a file, start several operations,
    close the file immediately, then check for all results later. This function
    will not block until the tasks have completed.

    Once this function returns true, `asyncio` is no longer valid, regardless
    of any future outcomes. Any completed tasks might still contain this
    pointer in their SDL_AsyncIOOutcome data, in case the app was using this
    value to track information, but it should not be used again.

    If this function returns false, the close wasn't started at all, and it's
    safe to attempt to close again later.

    An $(D SDL_AsyncIOQueue) must be specified. The newly-created task will be 
    added to it when it completes its work.

    Params:
        asyncio =   a pointer to an SDL_AsyncIO structure to close.
        flush =     true if data should sync to disk before the task completes.
        queue =     a queue to add the new SDL_AsyncIO to.
        userdata =  an app-defined pointer that will be provided with the task
                    results.

    Returns:
        $(D true) on success or $(D false) on failure; call $(D SDL_GetError)
        for more information.
    
    Threadsafety:
        It is safe to call this function from any thread.

    History:
        Available since SDL 3.2.0.
*/
extern bool SDL_CloseAsyncIO(SDL_AsyncIO* asyncio, bool flush, SDL_AsyncIOQueue* queue, void* userdata);

/**
    Create a task queue for tracking multiple I/O operations.

    Async I/O operations are assigned to a queue when started. The queue can be
    checked for completed tasks thereafter.
    
    Returns:
        A new task queue object or $(D null) if there was an error; call
        $(D SDL_GetError) for more information.
    
    See_Also:
        $(D SDL_DestroyAsyncIOQueue)
        $(D SDL_GetAsyncIOResult)
        $(D SDL_WaitAsyncIOResult)
    
    Threadsafety:
        It is safe to call this function from any thread.

    History:
        Available since SDL 3.2.0.
*/
extern SDL_AsyncIOQueue* SDL_CreateAsyncIOQueue();

/**
    Destroy a previously-created async I/O task queue.

    If there are still tasks pending for this queue, this call will block until
    those tasks are finished. All those tasks will be deallocated. Their
    results will be lost to the app.

    Any pending reads from $(D SDL_LoadFileAsync) that are still in this queue
    will have their buffers deallocated by this function, to prevent a memory
    leak.

    Once this function is called, the queue is no longer valid and should not
    be used, including by other threads that might access it while destruction
    is blocking on pending tasks.

    Do not destroy a queue that still has threads waiting on it through
    $(D SDL_WaitAsyncIOResult). You can call $(D SDL_SignalAsyncIOQueue) first to
    unblock those threads, and take measures (such as $(D SDL_WaitThread)) to make
    sure they have finished their wait and won't wait on the queue again.

    Params:
        queue = the task queue to destroy.
    
    Threadsafety:
        It is safe to call this function from any thread, so long as
        no other thread is waiting on the queue with
        $(D SDL_WaitAsyncIOResult).

    History:
        Available since SDL 3.2.0.
*/
extern void SDL_DestroyAsyncIOQueue(SDL_AsyncIOQueue* queue);

/**
    Query an async I/O task queue for completed tasks.

    If a task assigned to this queue has finished, this will return true and
    fill in `outcome` with the details of the task. If no task in the queue has
    finished, this function will return false. This function does not block.

    If a task has completed, this function will free its resources and the task
    pointer will no longer be valid. The task will be removed from the queue.

    It is safe for multiple threads to call this function on the same queue at
    once; a completed task will only go to one of the threads.

    Params:
        queue =     the async I/O task queue to query.
        outcome =   details of a finished task will be written here. 
                    May not be $(D null).
    Returns:
        $(D true) if a task has completed, $(D false) otherwise.

    See_Also:
        $(D SDL_WaitAsyncIOResult)

    Threadsafety:
        It is safe to call this function from any thread.

    History:
        Available since SDL 3.2.0.
*/
extern bool SDL_GetAsyncIOResult(SDL_AsyncIOQueue* queue, SDL_AsyncIOOutcome* outcome);

/**
    Block until an async I/O task queue has a completed task.

    This function puts the calling thread to sleep until there a task assigned
    to the queue that has finished.

    If a task assigned to the queue has finished, this will return true and
    fill in `outcome` with the details of the task. If no task in the queue has
    finished, this function will return false.

    If a task has completed, this function will free its resources and the task
    pointer will no longer be valid. The task will be removed from the queue.

    It is safe for multiple threads to call this function on the same queue at
    once; a completed task will only go to one of the threads.

    Note that by the nature of various platforms, more than one waiting thread
    may wake to handle a single task, but only one will obtain it, so
    `timeoutMS` is a *maximum* wait time, and this function may return false
    sooner.

    This function may return false if there was a system error, the OS
    inadvertently awoke multiple threads, or if $(D SDL_SignalAsyncIOQueue) was
    called to wake up all waiting threads without a finished task.

    A timeout can be used to specify a maximum wait time, but rather than
    polling, it is possible to have a timeout of -1 to wait forever, and use
    $(D SDL_SignalAsyncIOQueue) to wake up the waiting threads later.


    Params:
        queue =     the async I/O task queue to wait on.
        outcome =   details of a finished task will be written here. May not be
                    $(D null).
        timeoutMS = the maximum time to wait, in milliseconds, or -1 to wait
                    indefinitely.
    
    Returns:
        $(D true) if task has completed, $(D false) otherwise.

    See_Also:
        $(D SDL_SignalAsyncIOQueue)

    Threadsafety:
        It is safe to call this function from any thread.

    History:
        Available since SDL 3.2.0.
*/
extern bool SDL_WaitAsyncIOResult(SDL_AsyncIOQueue* queue, SDL_AsyncIOOutcome* outcome, Sint32 timeoutMS);

/**
    Wake up any threads that are blocking in $(D SDL_WaitAsyncIOResult).

    This will unblock any threads that are sleeping in a call to
    $(D SDL_WaitAsyncIOResult) for the specified queue, and cause them to return
    from that function.

    This can be useful when destroying a queue to make sure nothing is touching
    it indefinitely. In this case, once this call completes, the caller should
    take measures to make sure any previously-blocked threads have returned
    from their wait and will not touch the queue again (perhaps by setting a
    flag to tell the threads to terminate and then using $(D SDL_WaitThread) to
    make sure they've done so).

    Params:
        queue = the async I/O task queue to signal.

    See_Also:
        $(D SDL_WaitAsyncIOResult)

    Threadsafety:
        It is safe to call this function from any thread.

    History:
        Available since SDL 3.2.0.
*/
extern void SDL_SignalAsyncIOQueue(SDL_AsyncIOQueue* queue);

/**
    Load all the data from a file path, asynchronously.

    This function returns as quickly as possible; it does not wait for the read
    to complete. On a successful return, this work will continue in the
    background. If the work begins, even failure is asynchronous: a failing
    return value from this function only means the work couldn't start at all.

    The data is allocated with a zero byte at the end (null terminated) for
    convenience. This extra byte is not included in $(D SDL_AsyncIOOutcome)'s
    bytes_transferred value.

    This function will allocate the buffer to contain the file. It must be
    deallocated by calling $(D SDL_free) on $(D SDL_AsyncIOOutcome)'s buffer
    field after completion.

    An $(D SDL_AsyncIOQueue) must be specified. The newly-created task will
    be added to it when it completes its work.

    Params:
        file =      the path to read all available data from.
        queue =     a queue to add the new $(D SDL_AsyncIO) to.
        userdata =  an app-defined pointer that will be provided with the task
                    results.

    Returns:
        $(D true) on success or $(D false) on failure; call $(D SDL_GetError)
        for more information.

    See_Also:
        $(D SDL_LoadFile_IO)

    History:
        Available since SDL 3.2.0.
*/
extern bool SDL_LoadFileAsync(const(char)* file, SDL_AsyncIOQueue* queue, void* userdata);