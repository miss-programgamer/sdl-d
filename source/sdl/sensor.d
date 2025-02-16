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
    SDL Sensor Handling

    See_Also:
        $(LINK2 https://wiki.libsdl.org/SDL3/CategorySensor, SDL3 Sensor Documentation)
    
    Copyright: © 2025 Inochi2D Project, © 1997-2025 Sam Lantinga
    License: Subject to the terms of the Zlib License, as written in the LICENSE file.
    Authors: 
        Luna Nielsen
*/
module sdl.sensor;
import sdl.properties;
import sdl.stdc;

extern (C) nothrow @nogc:

/**
    The opaque structure used to identify an opened SDL sensor.
*/
struct SDL_Sensor;

/**
    This is a unique ID for a sensor for the time it is connected to the
    system, and is never reused for the lifetime of the application.

    The value 0 is an invalid ID.
*/
alias SDL_SensorID = Uint32;

/**
    A constant to represent standard gravity for accelerometer sensors.

    The accelerometer returns the current acceleration in SI meters per second
    squared. This measurement includes the force of gravity, so a device at
    rest will have an value of SDL_STANDARD_GRAVITY away from the center of the
    earth, which is a positive Y value.
*/
enum SDL_STANDARD_GRAVITY = 9.80665f;

/**
    The different sensors defined by SDL.

    Additional sensors may be available, using platform dependent semantics.

    Here are the additional Android sensors:

    https://developer.android.com/reference/android/hardware/SensorEvent.html#values

    Accelerometer sensor notes:

    The accelerometer returns the current acceleration in SI meters per second
    squared. This measurement includes the force of gravity, so a device at
    rest will have an value of SDL_STANDARD_GRAVITY away from the center of the
    earth, which is a positive Y value.

    - `values[0]`: Acceleration on the x axis
    - `values[1]`: Acceleration on the y axis
    - `values[2]`: Acceleration on the z axis

    For phones and tablets held in natural orientation and game controllers
    held in front of you, the axes are defined as follows:

    - -X ... +X : left ... right
    - -Y ... +Y : bottom ... top
    - -Z ... +Z : farther ... closer

    The accelerometer axis data is not changed when the device is rotated.

    Gyroscope sensor notes:

    The gyroscope returns the current rate of rotation in radians per second.
    The rotation is positive in the counter-clockwise direction. That is, an
    observer looking from a positive location on one of the axes would see
    positive rotation on that axis when it appeared to be rotating
    counter-clockwise.

    - `values[0]`: Angular speed around the x axis (pitch)
    - `values[1]`: Angular speed around the y axis (yaw)
    - `values[2]`: Angular speed around the z axis (roll)

    For phones and tablets held in natural orientation and game controllers
    held in front of you, the axes are defined as follows:

    - -X ... +X : left ... right
    - -Y ... +Y : bottom ... top
    - -Z ... +Z : farther ... closer

    The gyroscope axis data is not changed when the device is rotated.

    See_Also:
        $(D SDL_GetCurrentDisplayOrientation)
*/
enum SDL_SensorType {

    /**
        Returned for an invalid sensor
    */
    SDL_SENSOR_INVALID = -1,

    /**
        Unknown sensor type
    */
    SDL_SENSOR_UNKNOWN,

    /**
        Accelerometer
    */
    SDL_SENSOR_ACCEL,

    /**
        Gyroscope
    */
    SDL_SENSOR_GYRO,

    /**
        Accelerometer for left Joy-Con controller and Wii nunchuk
    */
    SDL_SENSOR_ACCEL_L,

    /**
        Gyroscope for left Joy-Con controller
    */
    SDL_SENSOR_GYRO_L,

    /**
        Accelerometer for right Joy-Con controller
    */
    SDL_SENSOR_ACCEL_R,

    /**
        Gyroscope for right Joy-Con controller
    */
    SDL_SENSOR_GYRO_R
}

/**
    Get a list of currently connected sensors.

    Params:
        count = a pointer filled in with the number of sensors returned, may
                be NULL.
    
    Returns:
        A 0 terminated array of sensor instance IDs or NULL on failure;
        call SDL_GetError() for more information. This should be freed
        with SDL_free() when it is no longer needed.
*/
extern SDL_SensorID* SDL_GetSensors(int* count);

/**
    Get the implementation dependent name of a sensor.

    This can be called before any sensors are opened.

    Params:
        instance_id = the sensor instance ID.
    
    Returns:
        The sensor name, or NULL if `instance_id` is not valid.
*/
extern const(char)* SDL_GetSensorNameForID(SDL_SensorID instance_id);

/**
    Get the type of a sensor.

    This can be called before any sensors are opened.

    Params:
        instance_id = the sensor instance ID.
    
    Returns:
        The SDL_SensorType, or `SDL_SENSOR_INVALID` if `instance_id` is
        not valid.
*/
extern SDL_SensorType SDL_GetSensorTypeForID(SDL_SensorID instance_id);

/**
    Get the platform dependent type of a sensor.

    This can be called before any sensors are opened.

    Params:
        instance_id = the sensor instance ID.
    
    Returns:
        The sensor platform dependent type, or -1 if `instance_id` is not
        valid.
*/
extern int SDL_GetSensorNonPortableTypeForID(SDL_SensorID instance_id);

/**
    Open a sensor for use.

    Params:
        instance_id = the sensor instance ID.
    
    Returns:
        An SDL_Sensor object or NULL on failure; call SDL_GetError() for
        more information.
*/
extern SDL_Sensor* SDL_OpenSensor(SDL_SensorID instance_id);

/**
    Return the SDL_Sensor associated with an instance ID.

    Params:
        instance_id = the sensor instance ID.
    
    Returns:
        An SDL_Sensor object or NULL on failure; call SDL_GetError() for
        more information.
*/
extern SDL_Sensor* SDL_GetSensorFromID(SDL_SensorID instance_id);

/**
    Get the properties associated with a sensor.

    Params:
        sensor = the SDL_Sensor object.
    
    Returns:
        A valid property ID on success or 0 on failure; call
        SDL_GetError() for more information.
*/
extern SDL_PropertiesID SDL_GetSensorProperties(SDL_Sensor* sensor);

/**
    Get the implementation dependent name of a sensor.

    Params:
        sensor = the SDL_Sensor object.
    
    Returns:
        The sensor name or NULL on failure; call SDL_GetError() for more
        information.
*/
extern const(char)* SDL_GetSensorName(SDL_Sensor* sensor);

/**
    Get the type of a sensor.

    Params:
        sensor = the SDL_Sensor object to inspect.
    
    Returns:
        The SDL_SensorType type, or `SDL_SENSOR_INVALID` if `sensor` is
        NULL.
*/
extern SDL_SensorType SDL_GetSensorType(SDL_Sensor* sensor);

/**
    Get the platform dependent type of a sensor.

    Params:
        sensor = the SDL_Sensor object to inspect.
    
    Returns:
        The sensor platform dependent type, or -1 if `sensor` is NULL.
*/
extern int SDL_GetSensorNonPortableType(SDL_Sensor* sensor);

/**
    Get the instance ID of a sensor.

    Params:
        sensor = the SDL_Sensor object to inspect.
    
    Returns:
        The sensor instance ID, or 0 on failure; call SDL_GetError() for
        more information.
*/
extern SDL_SensorID SDL_GetSensorID(SDL_Sensor* sensor);

/**
    Get the current state of an opened sensor.

    The number of values and interpretation of the data is sensor dependent.

    Params:
        sensor =        the SDL_Sensor object to query.
        data =          a pointer filled with the current sensor state.
        num_values =    the number of values to write to data.
    
    Returns:
        true on success or false on failure; call SDL_GetError() for more
        information.
*/
extern bool SDL_GetSensorData(SDL_Sensor* sensor, float* data, int num_values);

/**
    Close a sensor previously opened with SDL_OpenSensor().

    Params:
        sensor = the SDL_Sensor object to close.
*/
extern void SDL_CloseSensor(SDL_Sensor* sensor);

/**
    Update the current state of the open sensors.

    This is called automatically by the event loop if sensor events are
    enabled.

    This needs to be called from the thread that initialized the sensor
    subsystem.
*/
extern void SDL_UpdateSensors();
