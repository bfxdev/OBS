-- Definition of globals to reproduce the Lua scripting environment in OBS - bfxdev 2020

-- Use it for IntelliSense with this line at the beginning of your script (without comment):
--    if _G['obslua']==nil then dofile('obslua-globals.lua') end

-- Main obslua module
obslua = {}

-- Constants
obslua.ARCH_BITS = 32
obslua.BUILD_CAPTIONS = 1
obslua.CALL_PARAM_IN = 1
obslua.CALL_PARAM_OUT = 2
obslua.CALL_PARAM_TYPE_BOOL = 3
obslua.CALL_PARAM_TYPE_FLOAT = 2
obslua.CALL_PARAM_TYPE_INT = 1
obslua.CALL_PARAM_TYPE_PTR = 4
obslua.CALL_PARAM_TYPE_STRING = 5
obslua.CALL_PARAM_TYPE_VOID = 0
obslua.COMPILE_LUA = 1
obslua.COMPILE_PYTHON = 1
obslua.FALSE = 0
obslua.FILE_LINE = "D:/obs2/libobs\\util\\base.h (36): "
obslua.GS_A8 = 1
obslua.GS_ADDRESS_BORDER = 3
obslua.GS_ADDRESS_CLAMP = 0
obslua.GS_ADDRESS_MIRROR = 2
obslua.GS_ADDRESS_MIRRORONCE = 4
obslua.GS_ADDRESS_WRAP = 1
obslua.GS_ALWAYS = 7
obslua.GS_BACK = 0
obslua.GS_BGRA = 5
obslua.GS_BGRX = 4
obslua.GS_BLEND_DSTALPHA = 8
obslua.GS_BLEND_DSTCOLOR = 6
obslua.GS_BLEND_INVDSTALPHA = 9
obslua.GS_BLEND_INVDSTCOLOR = 7
obslua.GS_BLEND_INVSRCALPHA = 5
obslua.GS_BLEND_INVSRCCOLOR = 3
obslua.GS_BLEND_ONE = 1
obslua.GS_BLEND_SRCALPHA = 4
obslua.GS_BLEND_SRCALPHASAT = 10
obslua.GS_BLEND_SRCCOLOR = 2
obslua.GS_BLEND_ZERO = 0
obslua.GS_BUILD_MIPMAPS = 1
obslua.GS_CLEAR_COLOR = 1
obslua.GS_CLEAR_DEPTH = 2
obslua.GS_CLEAR_STENCIL = 4
obslua.GS_DECR = 4
obslua.GS_DEVICE_DIRECT3D_11 = 2
obslua.GS_DEVICE_OPENGL = 1
obslua.GS_DUP_BUFFER = 16
obslua.GS_DXT1 = 15
obslua.GS_DXT3 = 16
obslua.GS_DXT5 = 17
obslua.GS_DYNAMIC = 2
obslua.GS_EQUAL = 3
obslua.GS_ERROR_FAIL = -1
obslua.GS_ERROR_MODULE_NOT_FOUND = -2
obslua.GS_ERROR_NOT_SUPPORTED = -3
obslua.GS_FILTER_ANISOTROPIC = 2
obslua.GS_FILTER_LINEAR = 1
obslua.GS_FILTER_MIN_LINEAR_MAG_MIP_POINT = 6
obslua.GS_FILTER_MIN_LINEAR_MAG_POINT_MIP_LINEAR = 7
obslua.GS_FILTER_MIN_MAG_LINEAR_MIP_POINT = 8
obslua.GS_FILTER_MIN_MAG_POINT_MIP_LINEAR = 3
obslua.GS_FILTER_MIN_POINT_MAG_LINEAR_MIP_POINT = 4
obslua.GS_FILTER_MIN_POINT_MAG_MIP_LINEAR = 5
obslua.GS_FILTER_POINT = 0
obslua.GS_FLIP_U = 1
obslua.GS_FLIP_V = 2
obslua.GS_FRONT = 1
obslua.GS_GEQUAL = 4
obslua.GS_GL_DUMMYTEX = 8
obslua.GS_GREATER = 5
obslua.GS_INCR = 3
obslua.GS_INVERT = 5
obslua.GS_KEEP = 0
obslua.GS_LEQUAL = 2
obslua.GS_LESS = 1
obslua.GS_LINES = 1
obslua.GS_LINESTRIP = 2
obslua.GS_MAX_TEXTURES = 8
obslua.GS_NEGATIVE_X = 1
obslua.GS_NEGATIVE_Y = 3
obslua.GS_NEGATIVE_Z = 5
obslua.GS_NEITHER = 2
obslua.GS_NEVER = 0
obslua.GS_NOTEQUAL = 6
obslua.GS_POINTS = 0
obslua.GS_POSITIVE_X = 0
obslua.GS_POSITIVE_Y = 2
obslua.GS_POSITIVE_Z = 4
obslua.GS_R10G10B10A2 = 6
obslua.GS_R16 = 8
obslua.GS_R16F = 13
obslua.GS_R32F = 14
obslua.GS_R8 = 2
obslua.GS_R8G8 = 18
obslua.GS_RENDER_TARGET = 4
obslua.GS_REPLACE = 2
obslua.GS_RG16F = 11
obslua.GS_RG32F = 12
obslua.GS_RGBA = 3
obslua.GS_RGBA16 = 7
obslua.GS_RGBA16F = 9
obslua.GS_RGBA32F = 10
obslua.GS_SHADER_PARAM_BOOL = 1
obslua.GS_SHADER_PARAM_FLOAT = 2
obslua.GS_SHADER_PARAM_INT = 3
obslua.GS_SHADER_PARAM_INT2 = 8
obslua.GS_SHADER_PARAM_INT3 = 9
obslua.GS_SHADER_PARAM_INT4 = 10
obslua.GS_SHADER_PARAM_MATRIX4X4 = 11
obslua.GS_SHADER_PARAM_STRING = 4
obslua.GS_SHADER_PARAM_TEXTURE = 12
obslua.GS_SHADER_PARAM_UNKNOWN = 0
obslua.GS_SHADER_PARAM_VEC2 = 5
obslua.GS_SHADER_PARAM_VEC3 = 6
obslua.GS_SHADER_PARAM_VEC4 = 7
obslua.GS_SHARED_KM_TEX = 64
obslua.GS_SHARED_TEX = 32
obslua.GS_STENCIL_BACK = 2
obslua.GS_STENCIL_BOTH = 3
obslua.GS_STENCIL_FRONT = 1
obslua.GS_SUCCESS = 0
obslua.GS_TEXTURE_2D = 0
obslua.GS_TEXTURE_3D = 1
obslua.GS_TEXTURE_CUBE = 2
obslua.GS_TRIS = 3
obslua.GS_TRISTRIP = 4
obslua.GS_UNKNOWN = 0
obslua.GS_UNSIGNED_LONG = 1
obslua.GS_UNSIGNED_SHORT = 0
obslua.GS_USE_DEBUG_MARKERS = 0
obslua.GS_Z16 = 1
obslua.GS_Z24_S8 = 2
obslua.GS_Z32F = 3
obslua.GS_Z32F_S8X24 = 4
obslua.GS_ZERO = 1
obslua.GS_ZS_NONE = 0
obslua.INTERACT_ALT_KEY = 8
obslua.INTERACT_CAPS_KEY = 1
obslua.INTERACT_COMMAND_KEY = 128
obslua.INTERACT_CONTROL_KEY = 4
obslua.INTERACT_IS_KEY_PAD = 512
obslua.INTERACT_IS_LEFT = 1024
obslua.INTERACT_IS_RIGHT = 2048
obslua.INTERACT_MOUSE_LEFT = 16
obslua.INTERACT_MOUSE_MIDDLE = 32
obslua.INTERACT_MOUSE_RIGHT = 64
obslua.INTERACT_NONE = 0
obslua.INTERACT_NUMLOCK_KEY = 256
obslua.INTERACT_SHIFT_KEY = 2
obslua.INT_CUR_LINE = 35
obslua.LOG_DEBUG = 400
obslua.LOG_ERROR = 100
obslua.LOG_INFO = 300
obslua.LOG_WARNING = 200
obslua.MKDIR_ERROR = -1
obslua.MKDIR_EXISTS = 1
obslua.MKDIR_SUCCESS = 0
obslua.MOUSE_LEFT = 0
obslua.MOUSE_MIDDLE = 1
obslua.MOUSE_RIGHT = 2
obslua.OBS_ALLOW_DIRECT_RENDERING = 1
obslua.OBS_BALANCE_TYPE_LINEAR = 2
obslua.OBS_BALANCE_TYPE_SINE_LAW = 0
obslua.OBS_BALANCE_TYPE_SQUARE_LAW = 1
obslua.OBS_BOUNDS_MAX_ONLY = 6
obslua.OBS_BOUNDS_NONE = 0
obslua.OBS_BOUNDS_SCALE_INNER = 2
obslua.OBS_BOUNDS_SCALE_OUTER = 3
obslua.OBS_BOUNDS_SCALE_TO_HEIGHT = 5
obslua.OBS_BOUNDS_SCALE_TO_WIDTH = 4
obslua.OBS_BOUNDS_STRETCH = 1
obslua.OBS_COMBO_FORMAT_FLOAT = 2
obslua.OBS_COMBO_FORMAT_INT = 1
obslua.OBS_COMBO_FORMAT_INVALID = 0
obslua.OBS_COMBO_FORMAT_STRING = 3
obslua.OBS_COMBO_INVALID = 0
obslua.OBS_COMBO_TYPE_EDITABLE = 1
obslua.OBS_COMBO_TYPE_INVALID = 0
obslua.OBS_COMBO_TYPE_LIST = 2
obslua.OBS_DATA_ARRAY = 5
obslua.OBS_DATA_BOOLEAN = 3
obslua.OBS_DATA_NULL = 0
obslua.OBS_DATA_NUMBER = 2
obslua.OBS_DATA_NUM_DOUBLE = 2
obslua.OBS_DATA_NUM_INT = 1
obslua.OBS_DATA_NUM_INVALID = 0
obslua.OBS_DATA_OBJECT = 4
obslua.OBS_DATA_STRING = 1
obslua.OBS_DEINTERLACE_FIELD_ORDER_BOTTOM = 1
obslua.OBS_DEINTERLACE_FIELD_ORDER_TOP = 0
obslua.OBS_DEINTERLACE_MODE_BLEND = 3
obslua.OBS_DEINTERLACE_MODE_BLEND_2X = 4
obslua.OBS_DEINTERLACE_MODE_DISABLE = 0
obslua.OBS_DEINTERLACE_MODE_DISCARD = 1
obslua.OBS_DEINTERLACE_MODE_LINEAR = 5
obslua.OBS_DEINTERLACE_MODE_LINEAR_2X = 6
obslua.OBS_DEINTERLACE_MODE_RETRO = 2
obslua.OBS_DEINTERLACE_MODE_YADIF = 7
obslua.OBS_DEINTERLACE_MODE_YADIF_2X = 8
obslua.OBS_EDITABLE_LIST_TYPE_FILES = 1
obslua.OBS_EDITABLE_LIST_TYPE_FILES_AND_URLS = 2
obslua.OBS_EDITABLE_LIST_TYPE_STRINGS = 0
obslua.OBS_EFFECT_AREA = 9
obslua.OBS_EFFECT_BICUBIC = 4
obslua.OBS_EFFECT_BILINEAR_LOWRES = 6
obslua.OBS_EFFECT_DEFAULT = 0
obslua.OBS_EFFECT_DEFAULT_RECT = 1
obslua.OBS_EFFECT_LANCZOS = 5
obslua.OBS_EFFECT_OPAQUE = 2
obslua.OBS_EFFECT_PREMULTIPLIED_ALPHA = 7
obslua.OBS_EFFECT_REPEAT = 8
obslua.OBS_EFFECT_SOLID = 3
obslua.OBS_FONT_BOLD = 1
obslua.OBS_FONT_ITALIC = 2
obslua.OBS_FONT_STRIKEOUT = 8
obslua.OBS_FONT_UNDERLINE = 4
obslua.OBS_FRONTEND_EVENT_EXIT = 17
obslua.OBS_FRONTEND_EVENT_FINISHED_LOADING = 26
obslua.OBS_FRONTEND_EVENT_PREVIEW_SCENE_CHANGED = 24
obslua.OBS_FRONTEND_EVENT_PROFILE_CHANGED = 15
obslua.OBS_FRONTEND_EVENT_PROFILE_LIST_CHANGED = 16
obslua.OBS_FRONTEND_EVENT_RECORDING_PAUSED = 27
obslua.OBS_FRONTEND_EVENT_RECORDING_STARTED = 5
obslua.OBS_FRONTEND_EVENT_RECORDING_STARTING = 4
obslua.OBS_FRONTEND_EVENT_RECORDING_STOPPED = 7
obslua.OBS_FRONTEND_EVENT_RECORDING_STOPPING = 6
obslua.OBS_FRONTEND_EVENT_RECORDING_UNPAUSED = 28
obslua.OBS_FRONTEND_EVENT_REPLAY_BUFFER_STARTED = 19
obslua.OBS_FRONTEND_EVENT_REPLAY_BUFFER_STARTING = 18
obslua.OBS_FRONTEND_EVENT_REPLAY_BUFFER_STOPPED = 21
obslua.OBS_FRONTEND_EVENT_REPLAY_BUFFER_STOPPING = 20
obslua.OBS_FRONTEND_EVENT_SCENE_CHANGED = 8
obslua.OBS_FRONTEND_EVENT_SCENE_COLLECTION_CHANGED = 13
obslua.OBS_FRONTEND_EVENT_SCENE_COLLECTION_CLEANUP = 25
obslua.OBS_FRONTEND_EVENT_SCENE_COLLECTION_LIST_CHANGED = 14
obslua.OBS_FRONTEND_EVENT_SCENE_LIST_CHANGED = 9
obslua.OBS_FRONTEND_EVENT_STREAMING_STARTED = 1
obslua.OBS_FRONTEND_EVENT_STREAMING_STARTING = 0
obslua.OBS_FRONTEND_EVENT_STREAMING_STOPPED = 3
obslua.OBS_FRONTEND_EVENT_STREAMING_STOPPING = 2
obslua.OBS_FRONTEND_EVENT_STUDIO_MODE_DISABLED = 23
obslua.OBS_FRONTEND_EVENT_STUDIO_MODE_ENABLED = 22
obslua.OBS_FRONTEND_EVENT_TRANSITION_CHANGED = 10
obslua.OBS_FRONTEND_EVENT_TRANSITION_DURATION_CHANGED = 29
obslua.OBS_FRONTEND_EVENT_TRANSITION_LIST_CHANGED = 12
obslua.OBS_FRONTEND_EVENT_TRANSITION_STOPPED = 11
obslua.OBS_GROUP_CHECKABLE = 2
obslua.OBS_GROUP_NORMAL = 1
obslua.OBS_HOTKEY_REGISTERER_ENCODER = 3
obslua.OBS_HOTKEY_REGISTERER_FRONTEND = 0
obslua.OBS_HOTKEY_REGISTERER_OUTPUT = 2
obslua.OBS_HOTKEY_REGISTERER_SERVICE = 4
obslua.OBS_HOTKEY_REGISTERER_SOURCE = 1
obslua.OBS_ICON_TYPE_AUDIO_INPUT = 4
obslua.OBS_ICON_TYPE_AUDIO_OUTPUT = 5
obslua.OBS_ICON_TYPE_BROWSER = 12
obslua.OBS_ICON_TYPE_CAMERA = 9
obslua.OBS_ICON_TYPE_COLOR = 2
obslua.OBS_ICON_TYPE_CUSTOM = 13
obslua.OBS_ICON_TYPE_DESKTOP_CAPTURE = 6
obslua.OBS_ICON_TYPE_GAME_CAPTURE = 8
obslua.OBS_ICON_TYPE_IMAGE = 1
obslua.OBS_ICON_TYPE_MEDIA = 11
obslua.OBS_ICON_TYPE_SLIDESHOW = 3
obslua.OBS_ICON_TYPE_TEXT = 10
obslua.OBS_ICON_TYPE_UNKNOWN = 0
obslua.OBS_ICON_TYPE_WINDOW_CAPTURE = 7
obslua.OBS_KEY_LAST_VALUE = 636
obslua.OBS_MEDIA_STATE_BUFFERING = 3
obslua.OBS_MEDIA_STATE_ENDED = 6
obslua.OBS_MEDIA_STATE_ERROR = 7
obslua.OBS_MEDIA_STATE_NONE = 0
obslua.OBS_MEDIA_STATE_OPENING = 2
obslua.OBS_MEDIA_STATE_PAUSED = 4
obslua.OBS_MEDIA_STATE_PLAYING = 1
obslua.OBS_MEDIA_STATE_STOPPED = 5
obslua.OBS_MONITORING_TYPE_MONITOR_AND_OUTPUT = 2
obslua.OBS_MONITORING_TYPE_MONITOR_ONLY = 1
obslua.OBS_MONITORING_TYPE_NONE = 0
obslua.OBS_NO_DIRECT_RENDERING = 0
obslua.OBS_NUMBER_SCROLLER = 0
obslua.OBS_NUMBER_SLIDER = 1
obslua.OBS_OBJ_TYPE_ENCODER = 3
obslua.OBS_OBJ_TYPE_INVALID = 0
obslua.OBS_OBJ_TYPE_OUTPUT = 2
obslua.OBS_OBJ_TYPE_SERVICE = 4
obslua.OBS_OBJ_TYPE_SOURCE = 1
obslua.OBS_ORDER_MOVE_BOTTOM = 3
obslua.OBS_ORDER_MOVE_DOWN = 1
obslua.OBS_ORDER_MOVE_TOP = 2
obslua.OBS_ORDER_MOVE_UP = 0
obslua.OBS_OUTPUT_DELAY_PRESERVE = 1
obslua.OBS_PATH_DIRECTORY = 2
obslua.OBS_PATH_FILE = 0
obslua.OBS_PATH_FILE_SAVE = 1
obslua.OBS_PROPERTIES_DEFER_UPDATE = 1
obslua.OBS_PROPERTY_BOOL = 1
obslua.OBS_PROPERTY_BUTTON = 8
obslua.OBS_PROPERTY_COLOR = 7
obslua.OBS_PROPERTY_EDITABLE_LIST = 10
obslua.OBS_PROPERTY_FLOAT = 3
obslua.OBS_PROPERTY_FONT = 9
obslua.OBS_PROPERTY_FRAME_RATE = 11
obslua.OBS_PROPERTY_GROUP = 12
obslua.OBS_PROPERTY_INT = 2
obslua.OBS_PROPERTY_INVALID = 0
obslua.OBS_PROPERTY_LIST = 6
obslua.OBS_PROPERTY_PATH = 5
obslua.OBS_PROPERTY_TEXT = 4
obslua.OBS_SCALE_AREA = 5
obslua.OBS_SCALE_BICUBIC = 2
obslua.OBS_SCALE_BILINEAR = 3
obslua.OBS_SCALE_DISABLE = 0
obslua.OBS_SCALE_LANCZOS = 4
obslua.OBS_SCALE_POINT = 1
obslua.OBS_SCENE_DUP_COPY = 1
obslua.OBS_SCENE_DUP_PRIVATE_COPY = 3
obslua.OBS_SCENE_DUP_PRIVATE_REFS = 2
obslua.OBS_SCENE_DUP_REFS = 0
obslua.OBS_SOURCE_ASYNC = 4
obslua.OBS_SOURCE_ASYNC_VIDEO = 5
obslua.OBS_SOURCE_AUDIO = 2
obslua.OBS_SOURCE_CAP_DISABLED = 1024
obslua.OBS_SOURCE_CAP_OBSOLETE = 1024
obslua.OBS_SOURCE_COMPOSITE = 64
obslua.OBS_SOURCE_CONTROLLABLE_MEDIA = 8192
obslua.OBS_SOURCE_CUSTOM_DRAW = 8
obslua.OBS_SOURCE_DEPRECATED = 256
obslua.OBS_SOURCE_DO_NOT_DUPLICATE = 128
obslua.OBS_SOURCE_DO_NOT_SELF_MONITOR = 512
obslua.OBS_SOURCE_FLAG_FORCE_MONO = 2
obslua.OBS_SOURCE_FLAG_UNUSED_1 = 1
obslua.OBS_SOURCE_INTERACTION = 32
obslua.OBS_SOURCE_MONITOR_BY_DEFAULT = 2048
obslua.OBS_SOURCE_SUBMIX = 4096
obslua.OBS_SOURCE_TYPE_FILTER = 1
obslua.OBS_SOURCE_TYPE_INPUT = 0
obslua.OBS_SOURCE_TYPE_SCENE = 3
obslua.OBS_SOURCE_TYPE_TRANSITION = 2
obslua.OBS_SOURCE_VIDEO = 1
obslua.OBS_TASK_GRAPHICS = 1
obslua.OBS_TASK_UI = 0
obslua.OBS_TEXT_DEFAULT = 0
obslua.OBS_TEXT_MULTILINE = 2
obslua.OBS_TEXT_PASSWORD = 1
obslua.OBS_TRANSITION_MODE_AUTO = 0
obslua.OBS_TRANSITION_MODE_MANUAL = 1
obslua.OBS_TRANSITION_SCALE_ASPECT = 1
obslua.OBS_TRANSITION_SCALE_MAX_ONLY = 0
obslua.OBS_TRANSITION_SCALE_STRETCH = 2
obslua.OBS_TRANSITION_SOURCE_A = 0
obslua.OBS_TRANSITION_SOURCE_B = 1
obslua.OFF = 0
obslua.ON = 1
obslua.PYTHON_LIB = "python36"
obslua.SCRIPT_DIR = "../../data/obs-scripting/64bit"
obslua.S__LINE__ = "33"
obslua.TRUE = 1
obslua.UI_ENABLED = 1
obslua.XINPUT_MOUSE_LEN = 33
obslua.base_allocator = {}
obslua.calldata = {}
obslua.gs_device_loss = {}
obslua.gs_display_mode = {}
obslua.gs_image_file = {}
obslua.gs_image_file2 = {}
obslua.gs_init_data = {}
obslua.gs_monitor_info = {}
obslua.gs_rect = {}
obslua.gs_sampler_info = {}
obslua.gs_tvertarray = {}
obslua.gs_vb_data = {}
obslua.gs_window = {}
obslua.matrix3 = {}
obslua.matrix4 = {}
obslua.obs_audio_data = {}
obslua.obs_audio_info = {}
obslua.obs_cmdline_args = {}
obslua.obs_key_combination = {}
obslua.obs_key_event = {}
obslua.obs_mouse_event = {}
obslua.obs_sceneitem_crop = {}
obslua.obs_sceneitem_order_info = {}
obslua.obs_source_audio = {}
obslua.obs_source_audio_mix = {}
obslua.obs_source_frame = {}
obslua.obs_source_frame2 = {}
obslua.obs_transform_info = {}
obslua.obs_video_info = {}
obslua.os_dirent = {}
obslua.os_glob_info = {}
obslua.os_globent = {}
obslua.os_proc_memory_usage = {}
obslua.quat = {}
obslua.vec2 = {}
obslua.vec3 = {}
obslua.vec4 = {}

--- base_get_alignment not documented
obslua.base_get_alignment = function() end

--- base_get_log_handler not documented
obslua.base_get_log_handler = function() end

--- base_set_allocator not documented
obslua.base_set_allocator = function() end

--- base_set_crash_handler not documented
obslua.base_set_crash_handler = function() end

--- void base_set_log_handler(log_handler_t handler, void *param)
---            void base_get_log_handler(log_handler_t *handler, void **param)
--- Sets/gets the current log handler.
--- @param handler log_handler_t
--- @param param void*
obslua.base_set_log_handler = function(handler, param) end

--- void bfree(void *ptr)
--- Frees memory allocated with :c:func:`bmalloc()` or :c:func:`bfree()`.
--- @param ptr void*
obslua.bfree = function(ptr) end

--- void blog(int log_level, const char *format, ...)
--- Logging function.
--- @param log_level int
--- @param format char*
obslua.blog = function(log_level, format) end

--- void* bmalloc(size_t size)
--- Allocates memory and increases the memory leak counter.
--- @param size size_t
--- @return void*
obslua.bmalloc = function(size) end

--- void* bmemdup(const void *ptr, size_t size)
--- Duplicates memory.
--- @param ptr void*
--- @param size size_t
--- @return void*
obslua.bmemdup = function(ptr, size) end

--- long bnum_allocs(void)
--- Returns current number of active allocations.
--- @return long
obslua.bnum_allocs = function() end

--- void* brealloc(void *ptr, size_t size)
--- Reallocates memory.  Use only with memory that's been allocated by
--- :c:func:`bmalloc()`.
--- @param ptr void*
--- @param size size_t
--- @return void*
obslua.brealloc = function(ptr, size) end

--- char* bstrdup(const char *str)
---            wchar_t *bwstrdup(const wchar_t *str)
--- Duplicates a string.
--- @param str char*
--- @return char*
obslua.bstrdup = function(str) end

--- char* bstrdup_n(const char *str, size_t n)
---            wchar_t *bwstrdup_n(const wchar_t *str, size_t n)
--- Duplicates a string of *n* bytes and automatically zero-terminates
--- it.
--- @param str char*
--- @param n size_t
--- @return char*
obslua.bstrdup_n = function(str, n) end

--- bwstrdup not documented
obslua.bwstrdup = function() end

--- bwstrdup_n not documented
obslua.bwstrdup_n = function() end

--- void* bzalloc(size_t size)
--- Inline function that allocates zeroed memory.
--- @param size size_t
--- @return void*
obslua.bzalloc = function(size) end

--- bool calldata_bool(const calldata_t *data, const char *name)
--- Gets a boolean parameter.
--- :param data: Calldata structure
--- :param name: Parameter name
--- :return:     Boolean value
--- @param data calldata_t*
--- @param name char*
--- @return bool
obslua.calldata_bool = function(data, name) end

--- calldata_clear not documented
obslua.calldata_clear = function() end

--- calldata_create not documented
obslua.calldata_create = function() end

--- calldata_destroy not documented
obslua.calldata_destroy = function() end

--- double calldata_float(const calldata_t *data, const char *name)
--- Gets a floating point parameter.
--- :param data: Calldata structure
--- :param name: Parameter name
--- :return:     Floating point value
--- @param data calldata_t*
--- @param name char*
--- @return double
obslua.calldata_float = function(data, name) end

--- void calldata_free(calldata_t *data)
--- Frees a calldata structure.
--- :param data: Calldata structure
--- @param data calldata_t*
obslua.calldata_free = function(data) end

--- calldata_get_bool not documented
obslua.calldata_get_bool = function() end

--- calldata_get_data not documented
obslua.calldata_get_data = function() end

--- calldata_get_float not documented
obslua.calldata_get_float = function() end

--- calldata_get_int not documented
obslua.calldata_get_int = function() end

--- calldata_get_ptr not documented
obslua.calldata_get_ptr = function() end

--- calldata_get_string not documented
obslua.calldata_get_string = function() end

--- void calldata_init(calldata_t *data)
--- Initializes a calldata structure (zeroes it).
--- :param data: Calldata structure
--- @param data calldata_t*
obslua.calldata_init = function(data) end

--- calldata_init_fixed not documented
obslua.calldata_init_fixed = function() end

--- calldata_int not documented
obslua.calldata_int = function() end

--- void* calldata_ptr(const calldata_t *data, const char *name)
--- Gets a pointer parameter.
--- :param data: Calldata structure
--- :param name: Parameter name
--- :return:     Pointer value
--- @param data calldata_t*
--- @param name char*
--- @return void*
obslua.calldata_ptr = function(data, name) end

--- calldata_sceneitem not documented
obslua.calldata_sceneitem = function() end

--- void calldata_set_bool(calldata_t *data, const char *name, bool val)
--- Sets a boolean parameter.
--- :param data: Calldata structure
--- :param name: Parameter name
--- :param val:  Boolean value
--- @param data calldata_t*
--- @param name char*
--- @param val bool
obslua.calldata_set_bool = function(data, name, val) end

--- calldata_set_data not documented
obslua.calldata_set_data = function() end

--- void calldata_set_float(calldata_t *data, const char *name, double val)
--- Sets a floating point parameter.
--- :param data: Calldata structure
--- :param name: Parameter name
--- :param val:  Floating point value
--- @param data calldata_t*
--- @param name char*
--- @param val double
obslua.calldata_set_float = function(data, name, val) end

--- void calldata_set_int(calldata_t *data, const char *name, long long val)
--- Sets an integer parameter.
--- :param data: Calldata structure
--- :param name: Parameter name
--- :param val:  Integer value
--- @param data calldata_t*
--- @param name char*
--- @param val longlong
obslua.calldata_set_int = function(data, name, val) end

--- void calldata_set_ptr(calldata_t *data, const char *name, void *ptr)
--- Sets a pointer parameter.
--- :param data: Calldata structure
--- :param name: Parameter name
--- :param val:  Pointer value
--- @param data calldata_t*
--- @param name char*
--- @param ptr void*
obslua.calldata_set_ptr = function(data, name, ptr) end

--- void calldata_set_string(calldata_t *data, const char *name, const char *str)
--- Sets a string parameter.
--- :param data: Calldata structure
--- :param name: Parameter name
--- :param val:  String
--- @param data calldata_t*
--- @param name char*
--- @param str char*
obslua.calldata_set_string = function(data, name, str) end

--- calldata_source not documented
obslua.calldata_source = function() end

--- calldata_string not documented
obslua.calldata_string = function() end

--- gs_begin_frame not documented
obslua.gs_begin_frame = function() end

--- void gs_begin_scene(void)
---            void gs_end_scene(void)
--- Begins/ends a scene (this is automatically called by libobs, there's
--- no need to call this manually).
obslua.gs_begin_scene = function() end

--- void gs_blend_function(enum gs_blend_type src, enum gs_blend_type dest)
--- Sets the blend function
--- :param src:  Blend type for the source
--- :param dest: Blend type for the destination
--- @param src gs_blend_type
--- @param dest gs_blend_type
obslua.gs_blend_function = function(src, dest) end

--- void gs_blend_function_separate(enum gs_blend_type src_c, enum gs_blend_type dest_c, enum gs_blend_type src_a, enum gs_blend_type dest_a)
--- Sets the blend function for RGB and alpha separately
--- :param src_c:  Blend type for the source RGB
--- :param dest_c: Blend type for the destination RGB
--- :param src_a:  Blend type for the source alpha
--- :param dest_a: Blend type for the destination alpha
--- @param src_c gs_blend_type
--- @param dest_c gs_blend_type
--- @param src_a gs_blend_type
--- @param dest_a gs_blend_type
obslua.gs_blend_function_separate = function(src_c, dest_c, src_a, dest_a) end

--- void gs_blend_state_pop(void)
--- Pops/restores the last blend state
obslua.gs_blend_state_pop = function() end

--- void gs_blend_state_push(void)
--- Pushes/stores the current blend state
obslua.gs_blend_state_push = function() end

--- void gs_clear(uint32_t clear_flags, const struct vec4 *color, float depth, uint8_t stencil)
--- Clears color/depth/stencil buffers.
--- :param clear_flags: Flags to clear with.  Can be one of the following
---                     values:
---                     - GS_CLEAR_COLOR   - Clears color buffer
---                     - GS_CLEAR_DEPTH   - Clears depth buffer
---                     - GS_CLEAR_STENCIL - Clears stencil buffer
--- :param color:       Color value to clear the color buffer with
--- :param depth:       Depth value to clear the depth buffer with
--- :param stencil:     Stencil value to clear the stencil buffer with
--- @param clear_flags uint32_t
--- @param color vec4*
--- @param depth float
--- @param stencil uint8_t
obslua.gs_clear = function(clear_flags, color, depth, stencil) end

--- void gs_color(uint32_t color)
--- @param color uint32_t
obslua.gs_color = function(color) end

--- void gs_color4v(const struct vec4 *v)
--- @param v vec4*
obslua.gs_color4v = function(v) end

--- void gs_copy_texture(gs_texture_t *dst, gs_texture_t *src)
--- Copies a texture
--- :param dst: Destination texture
--- :param src: Source texture
--- @param dst gs_texture_t*
--- @param src gs_texture_t*
obslua.gs_copy_texture = function(dst, src) end

--- gs_copy_texture_region not documented
obslua.gs_copy_texture_region = function() end

--- int gs_create(graphics_t **graphics, const char *module, uint32_t adapter)
--- Creates a graphics context
--- :param graphics: Pointer to receive the graphics context
--- :param module:   Module name
--- :param adapter:  Adapter index
--- :return:         Can return one of the following values:
---                  - GS_SUCCESS
---                  - GS_ERROR_FAIL
---                  - GS_ERROR_MODULE_NOT_FOUND
---                  - GS_ERROR_NOT_SUPPORTED
--- @param graphics graphics_t**
--- @param module char*
--- @param adapter uint32_t
--- @return int
obslua.gs_create = function(graphics, module, adapter) end

--- gs_create_texture_file_data not documented
obslua.gs_create_texture_file_data = function() end

--- gs_texture_t* gs_cubetexture_create(uint32_t size, enum gs_color_format color_format, uint32_t levels, const uint8_t **data, uint32_t flags)
--- Creates a cubemap texture.
--- :param size:         Width/height/depth value
--- :param color_format: Color format
--- :param levels:       Number of texture levels
--- :param data:         Pointer to array of texture data pointers
--- :param flags:        Can be 0 or a bitwise-OR combination of one or
---                      more of the following value:
---                      - GS_BUILD_MIPMAPS - Automatically builds
---                        mipmaps (Note: not fully tested)
---                      - GS_DYNAMIC - Dynamic
---                      - GS_RENDER_TARGET - Render target
--- :return:             A new cube texture object
--- @param size uint32_t
--- @param color_format gs_color_format
--- @param levels uint32_t
--- @param data uint8_t**
--- @param flags uint32_t
--- @return gs_texture_t*
obslua.gs_cubetexture_create = function(size, color_format, levels, data, flags) end

--- void gs_cubetexture_destroy(gs_texture_t *cubetex)
--- Destroys a cube texture.
--- :param cubetex: Cube texture object
--- @param cubetex gs_texture_t*
obslua.gs_cubetexture_destroy = function(cubetex) end

--- gs_cubetexture_get_color_format not documented
obslua.gs_cubetexture_get_color_format = function() end

--- uint32_t gs_cubetexture_get_size(const gs_texture_t *cubetex)
--- Get the width/height/depth value of a cube texture.
--- :param cubetex: Cube texture object
--- :return:        The width/height/depth value of the cube texture
--- @param cubetex gs_texture_t*
--- @return uint32_t
obslua.gs_cubetexture_get_size = function(cubetex) end

--- void gs_cubetexture_set_image(gs_texture_t *cubetex, uint32_t side, const void *data, uint32_t linesize, bool invert)
--- Sets an image of a cube texture side.
--- :param cubetex:  Cube texture object
--- :param side:     Side
--- :param data:     Texture data to set
--- :param linesize: Line size (pitch) of the texture data
--- :param invert:   *true* to invert texture data, *false* otherwise
--- Staging Surface Functions
--- Staging surfaces are used to efficiently copy textures from VRAM to RAM.
--- @param cubetex gs_texture_t*
--- @param side uint32_t
--- @param data void*
--- @param linesize uint32_t
--- @param invert bool
obslua.gs_cubetexture_set_image = function(cubetex, side, data, linesize, invert) end

--- gs_debug_marker_begin not documented
obslua.gs_debug_marker_begin = function() end

--- gs_debug_marker_begin_format not documented
obslua.gs_debug_marker_begin_format = function() end

--- gs_debug_marker_end not documented
obslua.gs_debug_marker_end = function() end

--- void gs_depth_function(enum gs_depth_test test)
--- Sets the depth function
--- :param test: Sets the depth test type
--- @param test gs_depth_test
obslua.gs_depth_function = function(test) end

--- void gs_destroy(graphics_t *graphics)
--- Destroys a graphics context
--- :param graphics: Graphics context
--- @param graphics graphics_t*
obslua.gs_destroy = function(graphics) end

--- void gs_draw(enum gs_draw_mode draw_mode, uint32_t start_vert, uint32_t num_verts)
--- Draws a primitive or set of primitives.
--- :param draw_mode:  The primitive draw mode to use
--- :param start_vert: Starting vertex index
--- :param num_verts:  Number of vertices
--- @param draw_mode gs_draw_mode
--- @param start_vert uint32_t
--- @param num_verts uint32_t
obslua.gs_draw = function(draw_mode, start_vert, num_verts) end

--- gs_draw_cube_backdrop not documented
obslua.gs_draw_cube_backdrop = function() end

--- void gs_draw_sprite(gs_texture_t *tex, uint32_t flip, uint32_t width, uint32_t height)
--- Draws a 2D sprite.  Sets the "image" parameter of the current effect
--- to the texture and renders a quad.
--- If width or height is 0, the width or height of the texture will be
--- used.  The flip value specifies whether the texture should be flipped
--- on the U or V axis with GS_FLIP_U and GS_FLIP_V.
--- :param tex:    Texture to draw
--- :param flip:   Can be 0 or a bitwise-OR combination of one of the
---                following values:
---                - GS_FLIP_U - Flips the texture horizontally
---                - GS_FLIP_V - Flips the texture vertically
--- :param width:  Width
--- :param height: Height
--- @param tex gs_texture_t*
--- @param flip uint32_t
--- @param width uint32_t
--- @param height uint32_t
obslua.gs_draw_sprite = function(tex, flip, width, height) end

--- void gs_draw_sprite_subregion(gs_texture_t *tex, uint32_t flip, uint32_t x, uint32_t y, uint32_t cx, uint32_t cy)
--- Draws a subregion of a 2D sprite.  Sets the "image" parameter of the
--- current effect to the texture and renders a quad.
--- :param tex:    Texture to draw
--- :param flip:   Can be 0 or a bitwise-OR combination of one of the
---                following values:
---                - GS_FLIP_U - Flips the texture horizontally
---                - GS_FLIP_V - Flips the texture vertically
--- :param x:      X value within subregion
--- :param y:      Y value within subregion
--- :param cx:     CX value of subregion
--- :param cy:     CY value of subregion
--- @param tex gs_texture_t*
--- @param flip uint32_t
--- @param x uint32_t
--- @param y uint32_t
--- @param cx uint32_t
--- @param cy uint32_t
obslua.gs_draw_sprite_subregion = function(tex, flip, x, y, cx, cy) end

--- gs_effect_t* gs_effect_create(const char *effect_string, const char *filename, char **error_string)
--- Creates an effect from a string.
--- :param effect_String: Effect string
--- :param error_string:  Receives a pointer to the error string, which
---                       must be freed with :c:func:`bfree()`.  If
---                       *NULL*, this parameter is ignored.
--- :return:              The effect object, or *NULL* on error
--- @param effect_string char*
--- @param filename char*
--- @param error_string char**
--- @return gs_effect_t*
obslua.gs_effect_create = function(effect_string, filename, error_string) end

--- gs_effect_t* gs_effect_create_from_file(const char *file, char **error_string)
--- Creates an effect from file.
--- :param file:         Path to the effect file
--- :param error_string: Receives a pointer to the error string, which
---                      must be freed with :c:func:`bfree()`.  If
---                      *NULL*, this parameter is ignored.
--- :return:             The effect object, or *NULL* on error
--- @param file char*
--- @param error_string char**
--- @return gs_effect_t*
obslua.gs_effect_create_from_file = function(file, error_string) end

--- void gs_effect_destroy(gs_effect_t *effect)
--- Destroys the effect
--- :param effect: Effect object
--- @param effect gs_effect_t*
obslua.gs_effect_destroy = function(effect) end

--- gs_technique_t* gs_effect_get_current_technique(const gs_effect_t *effect)
--- Gets the current active technique of the effect.
--- :param effect: Effect object
--- :return:       Technique object, or *NULL* if none currently active
--- @param effect gs_effect_t*
--- @return gs_technique_t*
obslua.gs_effect_get_current_technique = function(effect) end

--- void gs_effect_get_default_val(gs_eparam_t *param)
--- Returns a copy of the param's default value.
--- :param param:   Effect parameter
--- :return:        A pointer to the copied byte value of the param's default value. Freed with :c:func:`bfree()`.
--- @param param gs_eparam_t*
obslua.gs_effect_get_default_val = function(param) end

--- size_t gs_effect_get_default_val_size(gs_eparam_t *param)
--- Returns the size in bytes of the param's default value.
--- :param param:   Effect parameter
--- :return:        The size in bytes of the param's default value.
--- @param param gs_eparam_t*
--- @return size_t
obslua.gs_effect_get_default_val_size = function(param) end

--- size_t gs_effect_get_num_params(const gs_effect_t *effect)
--- Gets the number of parameters associated with the effect.
--- :param effect: Effect object
--- :return:       Number of parameters the effect has
--- @param effect gs_effect_t*
--- @return size_t
obslua.gs_effect_get_num_params = function(effect) end

--- gs_eparam_t* gs_effect_get_param_by_idx(const gs_effect_t *effect, size_t param)
--- Gets a parameter of an effect by its index.
--- :param effect: Effect object
--- :param param:  Parameter index
--- :return:       The effect parameter object, or *NULL* if index
---                invalid
--- @param effect gs_effect_t*
--- @param param size_t
--- @return gs_eparam_t*
obslua.gs_effect_get_param_by_idx = function(effect, param) end

--- gs_eparam_t* gs_effect_get_param_by_name(const gs_effect_t *effect, const char *name)
--- Gets parameter of an effect by its name.
--- :param effect: Effect object
--- :param name:   Name of the parameter
--- :return:       The effect parameter object, or *NULL* if not found
--- @param effect gs_effect_t*
--- @param name char*
--- @return gs_eparam_t*
obslua.gs_effect_get_param_by_name = function(effect, name) end

--- gs_technique_t* gs_effect_get_technique(const gs_effect_t *effect, const char *name)
--- Gets a technique of the effect.
--- :param effect: Effect object
--- :param name:   Name of the technique
--- :return:       Technique object, or *NULL* if not found
--- @param effect gs_effect_t*
--- @param name char*
--- @return gs_technique_t*
obslua.gs_effect_get_technique = function(effect, name) end

--- void* gs_effect_get_val(gs_eparam_t *param)
--- Returns a copy of the param's current value.
--- :param param:   Effect parameter
--- :return:        A pointer to the copied byte value of the param's current value. Freed with :c:func:`bfree()`.
--- @param param gs_eparam_t*
--- @return void*
obslua.gs_effect_get_val = function(param) end

--- size_t gs_effect_get_val_size(gs_eparam_t *param)
--- Returns the size in bytes of the param's current value.
--- :param param:   Effect parameter
--- :return:        The size in bytes of the param's current value.
--- @param param gs_eparam_t*
--- @return size_t
obslua.gs_effect_get_val_size = function(param) end

--- gs_eparam_t* gs_effect_get_viewproj_matrix(const gs_effect_t *effect)
--- Gets the view/projection matrix parameter ("viewproj") of the effect.
--- :param effect: Effect object
--- :return:       The view/projection matrix parameter of the effect
--- @param effect gs_effect_t*
--- @return gs_eparam_t*
obslua.gs_effect_get_viewproj_matrix = function(effect) end

--- gs_eparam_t* gs_effect_get_world_matrix(const gs_effect_t *effect)
--- Gets the world matrix parameter ("world") of the effect.
--- :param effect: Effect object
--- :return:       The world matrix parameter of the effect
--- @param effect gs_effect_t*
--- @return gs_eparam_t*
obslua.gs_effect_get_world_matrix = function(effect) end

--- bool gs_effect_loop(gs_effect_t *effect, const char *name)
--- Helper function that automatically begins techniques/passes.
--- :param effect: Effect object
--- :param name:   Name of the technique to execute
--- :return:       *true* to draw, *false* when complete
--- Here is an example of how this function is typically used:
--- .. code:: cpp
--- for (gs_effect_loop(effect, "my_technique")) {
---         /* perform drawing here */
--- @param effect gs_effect_t*
--- @param name char*
--- @return bool
obslua.gs_effect_loop = function(effect, name) end

--- void gs_effect_set_bool(gs_eparam_t *param, bool val)
--- Sets a boolean parameter.
--- :param param: Effect parameter
--- :param val:   Boolean value
--- @param param gs_eparam_t*
--- @param val bool
obslua.gs_effect_set_bool = function(param, val) end

--- void gs_effect_set_color(gs_eparam_t *param, uint32_t argb)
--- Convenience function for setting a color value via an integer value.
--- :param param: Effect parameter
--- :param argb:  Integer color value (i.e. hex value would be
---               0xAARRGGBB)
--- @param param gs_eparam_t*
--- @param argb uint32_t
obslua.gs_effect_set_color = function(param, argb) end

--- void gs_effect_set_default(gs_eparam_t *param)
--- Sets the parameter to its default value
--- :param: Effect parameter
--- @param param gs_eparam_t*
obslua.gs_effect_set_default = function(param) end

--- void gs_effect_set_float(gs_eparam_t *param, float val)
--- Sets a floating point parameter.
--- :param param: Effect parameter
--- :param val:   Floating point value
--- @param param gs_eparam_t*
--- @param val float
obslua.gs_effect_set_float = function(param, val) end

--- void gs_effect_set_int(gs_eparam_t *param, int val)
--- Sets a integer parameter.
--- :param param: Effect parameter
--- :param val:   Integer value
--- @param param gs_eparam_t*
--- @param val int
obslua.gs_effect_set_int = function(param, val) end

--- void gs_effect_set_matrix4(gs_eparam_t *param, const struct matrix4 *val)
--- Sets a matrix parameter.
--- :param param: Effect parameter
--- :param val:   Matrix
--- @param param gs_eparam_t*
--- @param val matrix4*
obslua.gs_effect_set_matrix4 = function(param, val) end

--- void gs_effect_set_next_sampler(gs_eparam_t *param, gs_samplerstate_t *sampler)
--- Manually changes the sampler for an effect parameter the next time
--- it's used.
--- :param param:   Effect parameter
--- :param sampler: Sampler state object
--- @param param gs_eparam_t*
--- @param sampler gs_samplerstate_t*
obslua.gs_effect_set_next_sampler = function(param, sampler) end

--- void gs_effect_set_texture(gs_eparam_t *param, gs_texture_t *val)
--- Sets a texture parameter.
--- :param param: Effect parameter
--- :param val:   Texture
--- @param param gs_eparam_t*
--- @param val gs_texture_t*
obslua.gs_effect_set_texture = function(param, val) end

--- void gs_effect_set_val(gs_eparam_t *param, const void *val, size_t size)
--- Sets a parameter with data manually.
--- :param param: Effect parameter
--- :param val:   Pointer to data
--- :param size:  Size of data
--- @param param gs_eparam_t*
--- @param val void*
--- @param size size_t
obslua.gs_effect_set_val = function(param, val, size) end

--- void gs_effect_set_vec2(gs_eparam_t *param, const struct vec2 *val)
--- Sets a 2-component vector parameter.
--- :param param: Effect parameter
--- :param val:   Vector
--- @param param gs_eparam_t*
--- @param val vec2*
obslua.gs_effect_set_vec2 = function(param, val) end

--- void gs_effect_set_vec3(gs_eparam_t *param, const struct vec3 *val)
--- Sets a 3-component vector parameter.
--- :param param: Effect parameter
--- :param val:   Vector
--- @param param gs_eparam_t*
--- @param val vec3*
obslua.gs_effect_set_vec3 = function(param, val) end

--- void gs_effect_set_vec4(gs_eparam_t *param, const struct vec4 *val)
--- Sets a 4-component vector parameter.
--- :param param: Effect parameter
--- :param val:   Vector
--- @param param gs_eparam_t*
--- @param val vec4*
obslua.gs_effect_set_vec4 = function(param, val) end

--- gs_effect_update_params not documented
obslua.gs_effect_update_params = function() end

--- void gs_enable_blending(bool enable)
--- Enables/disables blending
--- :param enable: *true* to enable, *false* to disable
--- @param enable bool
obslua.gs_enable_blending = function(enable) end

--- void gs_enable_color(bool red, bool green, bool blue, bool alpha)
--- Enables/disables specific color channels
--- :param red:   *true* to enable red channel, *false* to disable
--- :param green: *true* to enable green channel, *false* to disable
--- :param blue:  *true* to enable blue channel, *false* to disable
--- :param alpha: *true* to enable alpha channel, *false* to disable
--- @param red bool
--- @param green bool
--- @param blue bool
--- @param alpha bool
obslua.gs_enable_color = function(red, green, blue, alpha) end

--- void gs_enable_depth_test(bool enable)
--- Enables/disables depth testing
--- :param enable: *true* to enable, *false* to disable
--- @param enable bool
obslua.gs_enable_depth_test = function(enable) end

--- void gs_enable_stencil_test(bool enable)
--- Enables/disables stencil testing
--- :param enable: *true* to enable, *false* to disable
--- @param enable bool
obslua.gs_enable_stencil_test = function(enable) end

--- void gs_enable_stencil_write(bool enable)
--- Enables/disables stencil writing
--- :param enable: *true* to enable, *false* to disable
--- @param enable bool
obslua.gs_enable_stencil_write = function(enable) end

--- gs_end_scene not documented
obslua.gs_end_scene = function() end

--- void gs_enter_context(graphics_t *graphics)
--- Enters and locks the graphics context
--- :param graphics: Graphics context
--- @param graphics graphics_t*
obslua.gs_enter_context = function(graphics) end

--- gs_enum_adapters not documented
obslua.gs_enum_adapters = function() end

--- void gs_flush(void)
--- Flushes GPU calls
obslua.gs_flush = function() end

--- void gs_frustum(float left, float right, float top, float bottom, float znear, float zfar)
--- Sets the projection matrix to a frustum matrix
--- @param left float
--- @param right float
--- @param top float
--- @param bottom float
--- @param znear float
--- @param zfar float
obslua.gs_frustum = function(left, right, top, bottom, znear, zfar) end

--- graphics_t* gs_get_context(void)
--- :return: The currently locked graphics context for this thread
--- Matrix Stack Functions
--- @return graphics_t*
obslua.gs_get_context = function() end

--- gs_get_cull_mode not documented
obslua.gs_get_cull_mode = function() end

--- gs_get_device_name not documented
obslua.gs_get_device_name = function() end

--- gs_get_device_obj not documented
obslua.gs_get_device_obj = function() end

--- gs_get_device_type not documented
obslua.gs_get_device_type = function() end

--- gs_effect_t* gs_get_effect(void)
--- :return: The currently active effect, or *NULL* if none active
--- @return gs_effect_t*
obslua.gs_get_effect = function() end

--- gs_get_format_bpp not documented
obslua.gs_get_format_bpp = function() end

--- uint32_t gs_get_height(void)
--- Gets the height of the currently active swap chain
--- Resource Loading
--- @return uint32_t
obslua.gs_get_height = function() end

--- gs_get_input not documented
obslua.gs_get_input = function() end

--- gs_get_pixel_shader not documented
obslua.gs_get_pixel_shader = function() end

--- gs_get_render_target not documented
obslua.gs_get_render_target = function() end

--- void gs_get_size(uint32_t *cx, uint32_t *cy)
--- Gets the size of the currently active swap chain
--- :param cx: Pointer to receive width
--- :param cy: Pointer to receive height
--- @param cx uint32_t*
--- @param cy uint32_t*
obslua.gs_get_size = function(cx, cy) end

--- gs_get_texture_type not documented
obslua.gs_get_texture_type = function() end

--- gs_get_total_levels not documented
obslua.gs_get_total_levels = function() end

--- gs_get_vertex_shader not documented
obslua.gs_get_vertex_shader = function() end

--- void gs_get_viewport(struct gs_rect *rect)
--- Gets the current viewport
--- :param rect: Pointer to receive viewport rectangle
--- @param rect gs_rect*
obslua.gs_get_viewport = function(rect) end

--- uint32_t gs_get_width(void)
--- Gets the width of the currently active swap chain
--- @return uint32_t
obslua.gs_get_width = function() end

--- gs_zstencil_t* gs_get_zstencil_target(void)
--- :return: The currently active Z-stencil target
--- @return gs_zstencil_t*
obslua.gs_get_zstencil_target = function() end

--- gs_image_file2_free not documented
obslua.gs_image_file2_free = function() end

--- gs_image_file2_init not documented
obslua.gs_image_file2_init = function() end

--- gs_image_file2_init_texture not documented
obslua.gs_image_file2_init_texture = function() end

--- gs_image_file2_tick not documented
obslua.gs_image_file2_tick = function() end

--- gs_image_file2_update_texture not documented
obslua.gs_image_file2_update_texture = function() end

--- void gs_image_file_free(gs_image_file_t *image)
--- Frees an image file helper
--- :param image: Image file helper
--- @param image gs_image_file_t*
obslua.gs_image_file_free = function(image) end

--- void gs_image_file_init(gs_image_file_t *image, const char *file)
--- Loads an initializes an image file helper.  Does not initialize the
--- texture; call :c:func:`gs_image_file_init_texture()` to initialize
--- the texture.
--- :param image: Image file helper to initialize
--- :param file:  Path to the image file to load
--- @param image gs_image_file_t*
--- @param file char*
obslua.gs_image_file_init = function(image, file) end

--- void gs_image_file_init_texture(gs_image_file_t *image)
--- Initializes the texture of an image file helper.  This is separate
--- from :c:func:`gs_image_file_init()` because it allows deferring the
--- graphics initialization if needed.
--- :param image: Image file helper
--- @param image gs_image_file_t*
obslua.gs_image_file_init_texture = function(image) end

--- bool gs_image_file_tick(gs_image_file_t *image, uint64_t elapsed_time_ns)
--- Performs a tick operation on the image file helper (used primarily
--- for animated file).  Does not update the texture until
--- :c:func:`gs_image_file_update_texture()` is called.
--- :param image:           Image file helper
--- :param elapsed_time_ns: Elapsed time in nanoseconds
--- @param image gs_image_file_t*
--- @param elapsed_time_ns uint64_t
--- @return bool
obslua.gs_image_file_tick = function(image, elapsed_time_ns) end

--- void gs_image_file_update_texture(gs_image_file_t *image)
--- Updates the texture (used primarily for animated files)
--- :param image: Image file helper
--- @param image gs_image_file_t*
obslua.gs_image_file_update_texture = function(image) end

--- gs_indexbuffer_t* gs_indexbuffer_create(enum gs_index_type type, void *indices, size_t num, uint32_t flags)
--- Creates an index buffer.
--- :param type:    Index buffer type
--- :param indices: Index buffer data.  This buffer must be allocated
---                 with :c:func:`bmalloc()`, :c:func:`bzalloc()`, or
---                 :c:func:`bralloc()`, and ownership of this buffer is
---                 passed to the index buffer object.
--- :param num:     Number of indices in the buffer
--- :param flags:   Creation flags.  Can be 0 or a bitwise-OR combination
---                 of any of the following values:
---                 - GS_DYNAMIC - Can be dynamically updated in real time.
---                 - GS_DUP_BUFFER - Do not pass buffer ownership
--- :return:        A new index buffer object, or *NULL* if failed
--- @param type gs_index_type
--- @param indices void*
--- @param num size_t
--- @param flags uint32_t
--- @return gs_indexbuffer_t*
obslua.gs_indexbuffer_create = function(type, indices, num, flags) end

--- void gs_indexbuffer_destroy(gs_indexbuffer_t *indexbuffer)
--- Destroys an index buffer object.
--- :param indexbuffer: Index buffer object
--- @param indexbuffer gs_indexbuffer_t*
obslua.gs_indexbuffer_destroy = function(indexbuffer) end

--- void gs_indexbuffer_flush(gs_indexbuffer_t *indexbuffer)
--- Flushes a index buffer to its interval index data object.  To modify
--- its internal index data, call :c:func:`gs_indexbuffer_get_data()`.
--- Can only be used with dynamic index buffer objects.
--- :param indexbuffer: Index buffer object
--- @param indexbuffer gs_indexbuffer_t*
obslua.gs_indexbuffer_flush = function(indexbuffer) end

--- void gs_indexbuffer_flush_direct(gs_indexbuffer_t *indexbuffer, const void *data)
--- Flushes a index buffer to the specified index buffer data.
--- Can only be used with dynamic index buffer objects.
--- :param indexbuffer: Index buffer object
--- :param data:        Index buffer data to flush
--- @param indexbuffer gs_indexbuffer_t*
--- @param data void*
obslua.gs_indexbuffer_flush_direct = function(indexbuffer, data) end

--- gs_indexbuffer_get_data not documented
obslua.gs_indexbuffer_get_data = function() end

--- size_t gs_indexbuffer_get_num_indices(const gs_indexbuffer_t *indexbuffer)
--- Gets the number of indices associated with this index buffer.
--- :param indexbuffer: Index buffer object
--- :return:            Number of indices the vertex buffer object has
--- @param indexbuffer gs_indexbuffer_t*
--- @return size_t
obslua.gs_indexbuffer_get_num_indices = function(indexbuffer) end

--- gs_indexbuffer_get_type not documented
obslua.gs_indexbuffer_get_type = function() end

--- gs_is_compressed_format not documented
obslua.gs_is_compressed_format = function() end

--- void gs_leave_context(void)
--- Leaves and unlocks the graphics context
--- :param graphics: Graphics context
obslua.gs_leave_context = function() end

--- gs_load_default_samplerstate not documented
obslua.gs_load_default_samplerstate = function() end

--- void gs_load_indexbuffer(gs_indexbuffer_t *indexbuffer)
--- Loads a index buffer
--- :param indexbuffer: Index buffer to load, or NULL to unload
--- @param indexbuffer gs_indexbuffer_t*
obslua.gs_load_indexbuffer = function(indexbuffer) end

--- gs_load_pixelshader not documented
obslua.gs_load_pixelshader = function() end

--- void gs_load_samplerstate(gs_samplerstate_t *samplerstate, int unit)
--- Loads a sampler state (this is usually not called manually)
--- :param samplerstate: Sampler state to load, or NULL to unload
--- :param unit:         Texture unit to load sampler state for
--- @param samplerstate gs_samplerstate_t*
--- @param unit int
obslua.gs_load_samplerstate = function(samplerstate, unit) end

--- void gs_load_swapchain(gs_swapchain_t *swapchain)
--- Loads a swapchain
--- :param swapchain: Swap chain to load, or NULL to unload
--- Draw Functions
--- @param swapchain gs_swapchain_t*
obslua.gs_load_swapchain = function(swapchain) end

--- void gs_load_texture(gs_texture_t *tex, int unit)
--- Loads a texture (this is usually not called manually)
--- :param tex:  Texture to load, or NULL to unload
--- :param unit: Texture unit to load texture for
--- @param tex gs_texture_t*
--- @param unit int
obslua.gs_load_texture = function(tex, unit) end

--- void gs_load_vertexbuffer(gs_vertbuffer_t *vertbuffer)
--- Loads a vertex buffer
--- :param vertbuffer: Vertex buffer to load, or NULL to unload
--- @param vertbuffer gs_vertbuffer_t*
obslua.gs_load_vertexbuffer = function(vertbuffer) end

--- gs_load_vertexshader not documented
obslua.gs_load_vertexshader = function() end

--- void gs_matrix_get(struct matrix4 *dst)
--- Gets the current matrix
--- :param dst: Destination matrix
--- @param dst matrix4*
obslua.gs_matrix_get = function(dst) end

--- void gs_matrix_identity(void)
--- Sets the current matrix to an identity matrix.
obslua.gs_matrix_identity = function() end

--- void gs_matrix_mul(const struct matrix4 *matrix)
--- Multiplies the current matrix
--- :param matrix: Matrix to multiply the current stack matrix with
--- @param matrix matrix4*
obslua.gs_matrix_mul = function(matrix) end

--- void gs_matrix_pop(void)
--- Pops the current matrix from the matrix stack.
obslua.gs_matrix_pop = function() end

--- void gs_matrix_push(void)
--- Pushes the matrix stack and duplicates the current matrix.
obslua.gs_matrix_push = function() end

--- void gs_matrix_rotaa(const struct axisang *rot)
---            void gs_matrix_rotaa4f(float x, float y, float z, float angle)
--- Multiplies the current matrix with an axis angle
--- :param rot: Axis angle to multiple the current matrix stack with
--- @param rot axisang*
obslua.gs_matrix_rotaa = function(rot) end

--- gs_matrix_rotaa4f not documented
obslua.gs_matrix_rotaa4f = function() end

--- void gs_matrix_rotquat(const struct quat *rot)
--- Multiplies the current matrix with a quaternion
--- :param rot: Quaternion to multiple the current matrix stack with
--- @param rot quat*
obslua.gs_matrix_rotquat = function(rot) end

--- void gs_matrix_scale(const struct vec3 *scale)
---            void gs_matrix_scale3f(float x, float y, float z)
--- Scales the current matrix
--- :param scale: Scale value to scale the current matrix stack with
--- Draw Functions
--- @param scale vec3*
obslua.gs_matrix_scale = function(scale) end

--- gs_matrix_scale3f not documented
obslua.gs_matrix_scale3f = function() end

--- void gs_matrix_set(const struct matrix4 *matrix)
--- Sets the current matrix.
--- :param matrix: The matrix to set
--- @param matrix matrix4*
obslua.gs_matrix_set = function(matrix) end

--- void gs_matrix_translate(const struct vec3 *pos)
---            void gs_matrix_translate3f(float x, float y, float z)
--- Translates the current matrix
--- :param pos: Vector to translate the current matrix stack with
--- @param pos vec3*
obslua.gs_matrix_translate = function(pos) end

--- gs_matrix_translate3f not documented
obslua.gs_matrix_translate3f = function() end

--- void gs_matrix_transpose(void)
--- Transposes the current matrix.
obslua.gs_matrix_transpose = function() end

--- void gs_normal3f(float x, float y, float z)
--- @param x float
--- @param y float
--- @param z float
obslua.gs_normal3f = function(x, y, z) end

--- void gs_normal3v(const struct vec3 *v)
--- @param v vec3*
obslua.gs_normal3v = function(v) end

--- gs_nv12_available not documented
obslua.gs_nv12_available = function() end

--- void gs_ortho(float left, float right, float top, float bottom, float znear, float zfar)
--- Sets the projection matrix to an orthographic matrix
--- @param left float
--- @param right float
--- @param top float
--- @param bottom float
--- @param znear float
--- @param zfar float
obslua.gs_ortho = function(left, right, top, bottom, znear, zfar) end

--- gs_eparam_t* gs_param_get_annotation_by_idx(const gs_eparam_t *param, size_t annotation)
--- Gets an annotation of a param by its index.
--- :param param:  Param object
--- :param param:  Annotation index
--- :return:       The effect parameter object (annotation), or *NULL* if index
---                invalid
--- @param param gs_eparam_t*
--- @param annotation size_t
--- @return gs_eparam_t*
obslua.gs_param_get_annotation_by_idx = function(param, annotation) end

--- gs_eparam_t* gs_param_get_annotation_by_name(const gs_eparam_t *pardam, const char *annotation)
--- Gets parameter of an effect by its name.
--- :param param:  Param object
--- :param name:   Name of the annotation
--- :return:       The effect parameter object (annotation), or *NULL* if not found
--- @param pardam gs_eparam_t*
--- @param annotation char*
--- @return gs_eparam_t*
obslua.gs_param_get_annotation_by_name = function(pardam, annotation) end

--- size_t gs_param_get_num_annotations(const gs_eparam_t *param)
--- Gets the number of annotations associated with the parameter.
--- :param param:  Param object
--- :return:       Number of annotations the param has
--- @param param gs_eparam_t*
--- @return size_t
obslua.gs_param_get_num_annotations = function(param) end

--- void gs_perspective(float fovy, float aspect, float znear, float zfar)
--- Sets the projection matrix to a perspective mode
--- :param fovy:   Field of view (in degrees)
--- :param aspect: Aspect ratio
--- :param znear:  Near plane
--- :param zfar:   Far plane
--- @param fovy float
--- @param aspect float
--- @param znear float
--- @param zfar float
obslua.gs_perspective = function(fovy, aspect, znear, zfar) end

--- gs_pixelshader_create not documented
obslua.gs_pixelshader_create = function() end

--- gs_pixelshader_create_from_file not documented
obslua.gs_pixelshader_create_from_file = function() end

--- void gs_present(void)
--- Displays what was rendered on to the current render target
obslua.gs_present = function() end

--- void gs_projection_pop(void)
--- Pops/restores the last projection matrix pushed
--- Texture Functions
obslua.gs_projection_pop = function() end

--- void gs_projection_push(void)
--- Pushes/stores the current projection matrix
obslua.gs_projection_push = function() end

--- gs_vertbuffer_t* gs_render_save(void)
--- @return gs_vertbuffer_t*
obslua.gs_render_save = function() end

--- void gs_render_start(bool b_new)
--- @param b_new bool
obslua.gs_render_start = function(b_new) end

--- void gs_render_stop(enum gs_draw_mode mode)
--- @param mode gs_draw_mode
obslua.gs_render_stop = function(mode) end

--- void gs_reset_blend_state(void)
--- Sets the blend state to the default value: source alpha and invert
--- source alpha.
--- Swap Chains
obslua.gs_reset_blend_state = function() end

--- void gs_reset_viewport(void)
---  Sets the viewport to current swap chain size
obslua.gs_reset_viewport = function() end

--- void gs_resize(uint32_t cx, uint32_t cy)
--- Resizes the currently active swap chain
--- :param cx: New width
--- :param cy: New height
--- @param cx uint32_t
--- @param cy uint32_t
obslua.gs_resize = function(cx, cy) end

--- gs_samplerstate_t* gs_samplerstate_create(const struct gs_sampler_info *info)
--- Creates a sampler state object.
--- :param info: Sampler state information
--- :return:     New sampler state object
--- @param info gs_sampler_info*
--- @return gs_samplerstate_t*
obslua.gs_samplerstate_create = function(info) end

--- void gs_samplerstate_destroy(gs_samplerstate_t *samplerstate)
--- Destroys a sampler state object.
--- :param samplerstate: Sampler state object
--- Vertex Buffer Functions
--- @param samplerstate gs_samplerstate_t*
obslua.gs_samplerstate_destroy = function(samplerstate) end

--- void gs_set_2d_mode(void)
---  Sets the projection matrix to a default screen-sized orthographic
---  mode
obslua.gs_set_2d_mode = function() end

--- void gs_set_3d_mode(double fovy, double znear, double zfar)
---  Sets the projection matrix to a default screen-sized perspective
---  mode
---  :param fovy:  Field of view (in degrees)
---  :param znear: Near plane
---  :param zfar:  Far plane
--- @param fovy double
--- @param znear double
--- @param zfar double
obslua.gs_set_3d_mode = function(fovy, znear, zfar) end

--- void gs_set_cube_render_target(gs_texture_t *cubetex, int side, gs_zstencil_t *zstencil)
--- Sets a cubemap side as the active render target
--- :param cubetex:  Cubemap
--- :param side:     Cubemap side
--- :param zstencil: Z-stencil buffer, or *NULL* if none
--- @param cubetex gs_texture_t*
--- @param side int
--- @param zstencil gs_zstencil_t*
obslua.gs_set_cube_render_target = function(cubetex, side, zstencil) end

--- void gs_set_cull_mode(enum gs_cull_mode mode)
--- Sets the current cull mode.
--- :param mode: Cull mode
--- @param mode gs_cull_mode
obslua.gs_set_cull_mode = function(mode) end

--- void gs_set_render_target(gs_texture_t *tex, gs_zstencil_t *zstencil)
--- Sets the active render target
--- :param tex:      Texture to set as the active render target
--- :param zstencil: Z-stencil to use as the active render target
--- @param tex gs_texture_t*
--- @param zstencil gs_zstencil_t*
obslua.gs_set_render_target = function(tex, zstencil) end

--- void gs_set_scissor_rect(const struct gs_rect *rect)
--- Sets or clears the current scissor rectangle
--- :rect: Scissor rectangle, or *NULL* to clear
--- @param rect gs_rect*
obslua.gs_set_scissor_rect = function(rect) end

--- void gs_set_viewport(int x, int y, int width, int height)
--- Sets the current viewport
--- :param x:      X position relative to upper left
--- :param y:      Y position relative to upper left
--- :param width:  Width of the viewport
--- :param height: Height of the viewport
--- @param x int
--- @param y int
--- @param width int
--- @param height int
obslua.gs_set_viewport = function(x, y, width, height) end

--- void gs_stage_texture(gs_stagesurf_t *dst, gs_texture_t *src)
--- Copies a texture to a staging surface and copies it to RAM.  Ideally
--- best to give this a frame to process to prevent stalling.
--- :param dst: Staging surface
--- :param src: Texture to stage
--- @param dst gs_stagesurf_t*
--- @param src gs_texture_t*
obslua.gs_stage_texture = function(dst, src) end

--- gs_stagesurf_t* gs_stagesurface_create(uint32_t width, uint32_t height, enum gs_color_format color_format)
--- Creates a staging surface.
--- :param width:        Width
--- :param height:       Height
--- :param color_format: Color format
--- :return:             The staging surface object
--- @param width uint32_t
--- @param height uint32_t
--- @param color_format gs_color_format
--- @return gs_stagesurf_t*
obslua.gs_stagesurface_create = function(width, height, color_format) end

--- void gs_stagesurface_destroy(gs_stagesurf_t *stagesurf)
--- Destroys a staging surface.
--- :param stagesurf: Staging surface object
--- @param stagesurf gs_stagesurf_t*
obslua.gs_stagesurface_destroy = function(stagesurf) end

--- gs_stagesurface_get_color_format not documented
obslua.gs_stagesurface_get_color_format = function() end

--- gs_stagesurface_get_height not documented
obslua.gs_stagesurface_get_height = function() end

--- uint32_t gs_stagesurface_get_width(const gs_stagesurf_t *stagesurf)
---            uint32_t gs_stagesurface_get_height(const gs_stagesurf_t *stagesurf)
--- Gets the width/height of a staging surface object.
--- :param stagesurf: Staging surface object
--- :return:          Width/height of the staging surface
--- @param stagesurf gs_stagesurf_t*
--- @return uint32_t
obslua.gs_stagesurface_get_width = function(stagesurf) end

--- bool gs_stagesurface_map(gs_stagesurf_t *stagesurf, uint8_t **data, uint32_t *linesize)
--- Maps the staging surface texture (for reading).  Call
--- :c:func:`gs_stagesurface_unmap()` to unmap when complete.
--- :param stagesurf: Staging surface object
--- :param data:      Pointer to receive texture data pointer
--- :param linesize:  Pointer to receive line size (pitch) of the texture
---                   data
--- :return:          *true* if map successful, *false* otherwise
--- @param stagesurf gs_stagesurf_t*
--- @param data uint8_t**
--- @param linesize uint32_t*
--- @return bool
obslua.gs_stagesurface_map = function(stagesurf, data, linesize) end

--- void gs_stagesurface_unmap(gs_stagesurf_t *stagesurf)
--- Unmaps a staging surface.
--- :param stagesurf: Staging surface object
--- Z-Stencil Functions
--- @param stagesurf gs_stagesurf_t*
obslua.gs_stagesurface_unmap = function(stagesurf) end

--- void gs_stencil_function(enum gs_stencil_side side, enum gs_depth_test test)
--- Sets the stencil function
--- :param side: Stencil side
--- :param test: Depth test
--- @param side gs_stencil_side
--- @param test gs_depth_test
obslua.gs_stencil_function = function(side, test) end

--- void gs_stencil_op(enum gs_stencil_side side, enum gs_stencil_op_type fail, enum gs_stencil_op_type zfail, enum gs_stencil_op_type zpass)
--- Sets the stencil operation
--- :param side:  Stencil side
--- :param fail:  Operation to perform on stencil test failure
--- :param zfail: Operation to perform on depth test failure
--- :param zpass: Operation to perform on depth test success
--- @param side gs_stencil_side
--- @param fail gs_stencil_op_type
--- @param zfail gs_stencil_op_type
--- @param zpass gs_stencil_op_type
obslua.gs_stencil_op = function(side, fail, zfail, zpass) end

--- gs_swapchain_t* gs_swapchain_create(const struct gs_init_data *data)
--- Creates a swap chain (display view on a native widget)
--- :param data: Swap chain initialization data
--- :return:     New swap chain object, or *NULL* if failed
--- @param data gs_init_data*
--- @return gs_swapchain_t*
obslua.gs_swapchain_create = function(data) end

--- void gs_swapchain_destroy(gs_swapchain_t *swapchain)
--- Destroys a swap chain
--- @param swapchain gs_swapchain_t*
obslua.gs_swapchain_destroy = function(swapchain) end

--- size_t gs_technique_begin(gs_technique_t *technique)
--- Begins a technique.
--- :param technique: Technique object
--- :return:          Number of passes this technique uses
--- @param technique gs_technique_t*
--- @return size_t
obslua.gs_technique_begin = function(technique) end

--- bool gs_technique_begin_pass(gs_technique_t *technique, size_t pass)
--- Begins a pass.  Automatically loads the vertex/pixel shaders
--- associated with this pass.  Draw after calling this function.
--- :param technique: Technique object
--- :param pass:      Pass index
--- :return:          *true* if the pass is valid, *false* otherwise
--- @param technique gs_technique_t*
--- @param pass size_t
--- @return bool
obslua.gs_technique_begin_pass = function(technique, pass) end

--- bool gs_technique_begin_pass_by_name(gs_technique_t *technique, const char *name)
--- Begins a pass by its name if the pass has a name.  Automatically
--- loads the vertex/pixel shaders associated with this pass.  Draw after
--- calling this function.
--- :param technique: Technique object
--- :param name:      Name of the pass
--- :return:          *true* if the pass is valid, *false* otherwise
--- @param technique gs_technique_t*
--- @param name char*
--- @return bool
obslua.gs_technique_begin_pass_by_name = function(technique, name) end

--- void gs_technique_end(gs_technique_t *technique)
--- Ends a technique.  Make sure all active passes have been ended before
--- calling.
--- :param technique: Technique object
--- @param technique gs_technique_t*
obslua.gs_technique_end = function(technique) end

--- void gs_technique_end_pass(gs_technique_t *technique)
--- Ends a pass.
--- :param technique: Technique object
--- @param technique gs_technique_t*
obslua.gs_technique_end_pass = function(technique) end

--- gs_technique_get_pass_by_idx not documented
obslua.gs_technique_get_pass_by_idx = function() end

--- gs_technique_get_pass_by_name not documented
obslua.gs_technique_get_pass_by_name = function() end

--- void gs_texcoord(float x, float y, int unit)
--- @param x float
--- @param y float
--- @param unit int
obslua.gs_texcoord = function(x, y, unit) end

--- void gs_texcoord2v(const struct vec2 *v, int unit)
--- Graphics Types
--- .. type:: typedef struct gs_duplicator       gs_duplicator_t
--- .. type:: typedef struct gs_texture          gs_texture_t
--- .. type:: typedef struct gs_stage_surface    gs_stagesurf_t
--- .. type:: typedef struct gs_zstencil_buffer  gs_zstencil_t
--- .. type:: typedef struct gs_vertex_buffer    gs_vertbuffer_t
--- .. type:: typedef struct gs_index_buffer     gs_indexbuffer_t
--- .. type:: typedef struct gs_sampler_state    gs_samplerstate_t
--- .. type:: typedef struct gs_swap_chain       gs_swapchain_t
--- .. type:: typedef struct gs_texture_render   gs_texrender_t
--- .. type:: typedef struct gs_shader           gs_shader_t
--- .. type:: typedef struct gs_shader_param     gs_sparam_t
--- .. type:: typedef struct gs_device           gs_device_t
--- .. type:: typedef struct graphics_subsystem  graphics_t
--- @param v vec2*
--- @param unit int
obslua.gs_texcoord2v = function(v, unit) end

--- gs_texrender_begin not documented
obslua.gs_texrender_begin = function() end

--- gs_texrender_create not documented
obslua.gs_texrender_create = function() end

--- gs_texrender_destroy not documented
obslua.gs_texrender_destroy = function() end

--- gs_texrender_end not documented
obslua.gs_texrender_end = function() end

--- gs_texrender_get_texture not documented
obslua.gs_texrender_get_texture = function() end

--- gs_texrender_reset not documented
obslua.gs_texrender_reset = function() end

--- gs_texture_t* gs_texture_create(uint32_t width, uint32_t height, enum gs_color_format color_format, uint32_t levels, const uint8_t **data, uint32_t flags)
--- Creates a texture.
--- :param width:        Width
--- :param height:       Height
--- :param color_format: Color format
--- :param levels:       Number of total texture levels.  Set to 1 if no
---                      mip-mapping
--- :param data:         Pointer to array of texture data pointers
--- :param flags:        Can be 0 or a bitwise-OR combination of one or
---                      more of the following value:
---                      - GS_BUILD_MIPMAPS - Automatically builds
---                        mipmaps (Note: not fully tested)
---                      - GS_DYNAMIC - Dynamic
---                      - GS_RENDER_TARGET - Render target
--- :return:             A new texture object
--- @param width uint32_t
--- @param height uint32_t
--- @param color_format gs_color_format
--- @param levels uint32_t
--- @param data uint8_t**
--- @param flags uint32_t
--- @return gs_texture_t*
obslua.gs_texture_create = function(width, height, color_format, levels, data, flags) end

--- gs_texture_t* gs_texture_create_from_file(const char *file)
--- Creates a texture from a file.  Note that this isn't recommended for
--- animated gifs -- instead use the :ref:`image_file_helper`.
--- :param file: Image file to open
--- @param file char*
--- @return gs_texture_t*
obslua.gs_texture_create_from_file = function(file) end

--- void gs_texture_destroy(gs_texture_t *tex)
--- Destroys a texture
--- :param tex: Texture object
--- @param tex gs_texture_t*
obslua.gs_texture_destroy = function(tex) end

--- gs_texture_get_color_format not documented
obslua.gs_texture_get_color_format = function() end

--- uint32_t gs_texture_get_height(const gs_texture_t *tex)
--- Gets the texture's height
--- :param tex: Texture object
--- :return:    The texture's height
--- @param tex gs_texture_t*
--- @return uint32_t
obslua.gs_texture_get_height = function(tex) end

--- gs_texture_get_obj not documented
obslua.gs_texture_get_obj = function() end

--- uint32_t gs_texture_get_width(const gs_texture_t *tex)
--- Gets the texture's width
--- :param tex: Texture object
--- :return:    The texture's width
--- @param tex gs_texture_t*
--- @return uint32_t
obslua.gs_texture_get_width = function(tex) end

--- gs_texture_is_rect not documented
obslua.gs_texture_is_rect = function() end

--- bool gs_texture_map(gs_texture_t *tex, uint8_t **ptr, uint32_t *linesize)
--- Maps a texture.
--- :param tex:      Texture object
--- :param ptr:      Pointer to receive the pointer to the texture data
---                  to write to
--- :param linesize: Pointer to receive the line size (pitch) of the
---                  texture
--- @param tex gs_texture_t*
--- @param ptr uint8_t**
--- @param linesize uint32_t*
--- @return bool
obslua.gs_texture_map = function(tex, ptr, linesize) end

--- void gs_texture_set_image(gs_texture_t *tex, const uint8_t *data, uint32_t linesize, bool invert)
--- Sets the image of a dynamic texture
--- :param tex:      Texture object
--- :param data:     Data to set as the image
--- :param linesize: Line size (pitch) of the data
--- :param invert:   *true* to invert vertically, *false* otherwise
--- @param tex gs_texture_t*
--- @param data uint8_t*
--- @param linesize uint32_t
--- @param invert bool
obslua.gs_texture_set_image = function(tex, data, linesize, invert) end

--- void gs_texture_unmap(gs_texture_t *tex)
--- Unmaps a texture.
--- :param tex: Texture object
--- @param tex gs_texture_t*
obslua.gs_texture_unmap = function(tex) end

--- gs_timer_begin not documented
obslua.gs_timer_begin = function() end

--- gs_timer_create not documented
obslua.gs_timer_create = function() end

--- gs_timer_destroy not documented
obslua.gs_timer_destroy = function() end

--- gs_timer_end not documented
obslua.gs_timer_end = function() end

--- gs_timer_get_data not documented
obslua.gs_timer_get_data = function() end

--- gs_timer_range_begin not documented
obslua.gs_timer_range_begin = function() end

--- gs_timer_range_create not documented
obslua.gs_timer_range_create = function() end

--- gs_timer_range_destroy not documented
obslua.gs_timer_range_destroy = function() end

--- gs_timer_range_end not documented
obslua.gs_timer_range_end = function() end

--- gs_timer_range_get_data not documented
obslua.gs_timer_range_get_data = function() end

--- gs_vbdata_create not documented
obslua.gs_vbdata_create = function() end

--- gs_vbdata_destroy not documented
obslua.gs_vbdata_destroy = function() end

--- void gs_vertex2f(float x, float y)
--- @param x float
--- @param y float
obslua.gs_vertex2f = function(x, y) end

--- void gs_vertex2v(const struct vec2 *v)
--- @param v vec2*
obslua.gs_vertex2v = function(v) end

--- void gs_vertex3f(float x, float y, float z)
--- @param x float
--- @param y float
--- @param z float
obslua.gs_vertex3f = function(x, y, z) end

--- void gs_vertex3v(const struct vec3 *v)
--- @param v vec3*
obslua.gs_vertex3v = function(v) end

--- gs_vertbuffer_t* gs_vertexbuffer_create(struct gs_vb_data *data, uint32_t flags)
--- Creates a vertex buffer.
--- :param data:  Vertex buffer data to create vertex buffer with.  The
---               structure should be created with gs_vbdata_create(),
---               and then buffers in this structure should be allocated
---               with :c:func:`bmalloc()`, :c:func:`bzalloc()`, or
---               :c:func:`brealloc()`.  The ownership of the gs_vb_data
---               pointer is then passed to the function, and they should
---               not be destroyed by the caller once passed
--- :param flags: Creation flags.  Can be 0 or a bitwise-OR combination
---               of any of the following values:
---               - GS_DYNAMIC - Can be dynamically updated in real time.
---               - GS_DUP_BUFFER - Do not pass buffer ownership of the
---                 structure or the buffer pointers within the
---                 structure.
--- :return:      A new vertex buffer object, or *NULL* if failed
--- @param data gs_vb_data*
--- @param flags uint32_t
--- @return gs_vertbuffer_t*
obslua.gs_vertexbuffer_create = function(data, flags) end

--- void gs_vertexbuffer_destroy(gs_vertbuffer_t *vertbuffer)
--- Destroys a vertex buffer object.
--- :param vertbuffer: Vertex buffer object
--- @param vertbuffer gs_vertbuffer_t*
obslua.gs_vertexbuffer_destroy = function(vertbuffer) end

--- void gs_vertexbuffer_flush(gs_vertbuffer_t *vertbuffer)
--- Flushes a vertex buffer to its interval vertex data object.  To
--- modify its internal vertex data, call
--- :c:func:`gs_vertexbuffer_get_data()`.
--- Can only be used with dynamic vertex buffer objects.
--- :param vertbuffer: Vertex buffer object
--- @param vertbuffer gs_vertbuffer_t*
obslua.gs_vertexbuffer_flush = function(vertbuffer) end

--- void gs_vertexbuffer_flush_direct(gs_vertbuffer_t *vertbuffer, const struct gs_vb_data *data)
--- Directly flushes a vertex buffer to the specified vertex buffer data.
--- Can only be used with dynamic vertex buffer objects.
--- :param vertbuffer: Vertex buffer object
--- :param data:       Vertex buffer data to flush.  Components that
---                    don't need to be flushed can be left *NULL*
--- @param vertbuffer gs_vertbuffer_t*
--- @param data gs_vb_data*
obslua.gs_vertexbuffer_flush_direct = function(vertbuffer, data) end

--- gs_vertexbuffer_get_data not documented
obslua.gs_vertexbuffer_get_data = function() end

--- gs_vertexshader_create not documented
obslua.gs_vertexshader_create = function() end

--- gs_vertexshader_create_from_file not documented
obslua.gs_vertexshader_create_from_file = function() end

--- void gs_viewport_pop(void)
--- Pops/recalls the last pushed viewport
obslua.gs_viewport_pop = function() end

--- void gs_viewport_push(void)
--- Pushes/stores the current viewport
obslua.gs_viewport_push = function() end

--- gs_voltexture_create not documented
obslua.gs_voltexture_create = function() end

--- gs_voltexture_destroy not documented
obslua.gs_voltexture_destroy = function() end

--- gs_voltexture_get_color_format not documented
obslua.gs_voltexture_get_color_format = function() end

--- gs_voltexture_get_depth not documented
obslua.gs_voltexture_get_depth = function() end

--- gs_voltexture_get_height not documented
obslua.gs_voltexture_get_height = function() end

--- gs_voltexture_get_width not documented
obslua.gs_voltexture_get_width = function() end

--- gs_zstencil_t* gs_zstencil_create(uint32_t width, uint32_t height, enum gs_zstencil_format format)
--- Creates a Z-stencil surface object.
--- :param width:  Width
--- :param height: Height
--- :param format: Format
--- :return:       New Z-stencil surface object, or *NULL* if failed
--- @param width uint32_t
--- @param height uint32_t
--- @param format gs_zstencil_format
--- @return gs_zstencil_t*
obslua.gs_zstencil_create = function(width, height, format) end

--- void gs_zstencil_destroy(gs_zstencil_t *zstencil)
--- Destroys a Z-stencil buffer.
--- :param zstencil: Z-stencil surface object
--- Sampler State Functions
--- @param zstencil gs_zstencil_t*
obslua.gs_zstencil_destroy = function(zstencil) end

--- matrix3_copy not documented
obslua.matrix3_copy = function() end

--- matrix3_from_axisang not documented
obslua.matrix3_from_axisang = function() end

--- matrix3_from_matrix4 not documented
obslua.matrix3_from_matrix4 = function() end

--- matrix3_from_quat not documented
obslua.matrix3_from_quat = function() end

--- matrix3_identity not documented
obslua.matrix3_identity = function() end

--- matrix3_inv not documented
obslua.matrix3_inv = function() end

--- matrix3_mirror not documented
obslua.matrix3_mirror = function() end

--- matrix3_mirrorv not documented
obslua.matrix3_mirrorv = function() end

--- matrix3_mul not documented
obslua.matrix3_mul = function() end

--- matrix3_rotate not documented
obslua.matrix3_rotate = function() end

--- matrix3_rotate_aa not documented
obslua.matrix3_rotate_aa = function() end

--- matrix3_rotate_aa4f not documented
obslua.matrix3_rotate_aa4f = function() end

--- matrix3_scale not documented
obslua.matrix3_scale = function() end

--- matrix3_scale3f not documented
obslua.matrix3_scale3f = function() end

--- matrix3_translate not documented
obslua.matrix3_translate = function() end

--- matrix3_translate3f not documented
obslua.matrix3_translate3f = function() end

--- matrix3_transpose not documented
obslua.matrix3_transpose = function() end

--- void matrix4_copy(struct matrix4 *dst, const struct matrix4 *m)
--- Copies a matrix
--- :param dst: Destination matrix
--- :param m:   Matrix to copy
--- @param dst matrix4*
--- @param m matrix4*
obslua.matrix4_copy = function(dst, m) end

--- float matrix4_determinant(const struct matrix4 *m)
--- Gets the determinant value of a matrix
--- :param m: Matrix
--- :return:  Determinant
--- @param m matrix4*
--- @return float
obslua.matrix4_determinant = function(m) end

--- void matrix4_from_axisang(struct matrix4 *dst, const struct axisang *aa)
--- Converts an axis angle to a matrix
--- :param dst: Destination matrix
--- :param aa:  Axis angle to convert
--- @param dst matrix4*
--- @param aa axisang*
obslua.matrix4_from_axisang = function(dst, aa) end

--- matrix4_from_matrix3 not documented
obslua.matrix4_from_matrix3 = function() end

--- void matrix4_from_quat(struct matrix4 *dst, const struct quat *q)
--- Converts a quaternion to a matrix
--- :param dst: Destination matrix
--- :param q:   Quaternion to convert
--- @param dst matrix4*
--- @param q quat*
obslua.matrix4_from_quat = function(dst, q) end

--- void matrix4_identity(struct matrix4 *dst)
--- Sets an identity matrix
--- :param dst: Destination matrix
--- @param dst matrix4*
obslua.matrix4_identity = function(dst) end

--- bool matrix4_inv(struct matrix4 *dst, const struct matrix4 *m)
--- Inverts a matrix
--- :param dst: Destination matrix
--- :param m:   Matrix to invert
--- @param dst matrix4*
--- @param m matrix4*
--- @return bool
obslua.matrix4_inv = function(dst, m) end

--- void matrix4_mul(struct matrix4 *dst, const struct matrix4 *m1, const struct matrix4 *m2)
--- Multiples two matrices
--- :param dst: Destination matrix
--- :param m1:  Matrix 1
--- :param m2:  Matrix 2
--- @param dst matrix4*
--- @param m1 matrix4*
--- @param m2 matrix4*
obslua.matrix4_mul = function(dst, m1, m2) end

--- void matrix4_rotate(struct matrix4 *dst, const struct matrix4 *m, const struct quat *q)
--- Rotates a matrix by a quaternion
--- :param dst: Destination matrix
--- :param m:   Matrix to rotate
--- :param q:   Rotation quaternion
--- @param dst matrix4*
--- @param m matrix4*
--- @param q quat*
obslua.matrix4_rotate = function(dst, m, q) end

--- void matrix4_rotate_aa(struct matrix4 *dst, const struct matrix4 *m, const struct axisang *aa)
---            void matrix4_rotate_aa4f(struct matrix4 *dst, const struct matrix4 *m, float x, float y, float z, float rot)
--- Rotates a matrix by an axis angle
--- :param dst: Destination matrix
--- :param m:   Matrix to rotate
--- :param aa:  Rotation anxis angle
--- @param dst matrix4*
--- @param m matrix4*
--- @param aa axisang*
obslua.matrix4_rotate_aa = function(dst, m, aa) end

--- matrix4_rotate_aa4f not documented
obslua.matrix4_rotate_aa4f = function() end

--- matrix4_rotate_aa_i not documented
obslua.matrix4_rotate_aa_i = function() end

--- matrix4_rotate_i not documented
obslua.matrix4_rotate_i = function() end

--- void matrix4_scale(struct matrix4 *dst, const struct matrix4 *m, const struct vec3 *v)
---            void matrix4_scale3f(struct matrix4 *dst, const struct matrix4 *m, float x, float y, float z)
--- Scales each matrix component by the components of a 3-component vector
--- :param dst: Destination matrix
--- :param m:   Matrix to scale
--- :param v:   Scale vector
--- @param dst matrix4*
--- @param m matrix4*
--- @param v vec3*
obslua.matrix4_scale = function(dst, m, v) end

--- matrix4_scale3f not documented
obslua.matrix4_scale3f = function() end

--- matrix4_scale_i not documented
obslua.matrix4_scale_i = function() end

--- matrix4_translate3f not documented
obslua.matrix4_translate3f = function() end

--- void matrix4_translate3v(struct matrix4 *dst, const struct matrix4 *m, const struct vec3 *v)
---            void matrix4_translate3f(struct matrix4 *dst, const struct matrix4 *m, float x, float y, float z)
--- Translates the matrix by a 3-component vector
--- :param dst: Destination matrix
--- :param m:   Matrix to translate
--- :param v:   Translation vector
--- @param dst matrix4*
--- @param m matrix4*
--- @param v vec3*
obslua.matrix4_translate3v = function(dst, m, v) end

--- matrix4_translate3v_i not documented
obslua.matrix4_translate3v_i = function() end

--- void matrix4_translate4v(struct matrix4 *dst, const struct matrix4 *m, const struct vec4 *v)
--- Translates the matrix by a 4-component vector
--- :param dst: Destination matrix
--- :param m:   Matrix to translate
--- :param v:   Translation vector
--- @param dst matrix4*
--- @param m matrix4*
--- @param v vec4*
obslua.matrix4_translate4v = function(dst, m, v) end

--- matrix4_translate4v_i not documented
obslua.matrix4_translate4v_i = function() end

--- void matrix4_transpose(struct matrix4 *dst, const struct matrix4 *m)
--- Transposes a matrix
--- :param dst: Destination matrix
--- :param m:   Matrix to transpose
--- @param dst matrix4*
--- @param m matrix4*
obslua.matrix4_transpose = function(dst, m) end

--- obs_add_data_path not documented
obslua.obs_add_data_path = function() end

--- obs_add_main_render_callback not documented
obslua.obs_add_main_render_callback = function() end

--- void obs_add_module_path(const char *bin, const char *data)
--- Adds a module search path to be used with obs_find_modules.  If the search
--- path strings contain %module%, that text will be replaced with the module
--- name when used.
--- :param  bin:  Specifies the module's binary directory search path
--- :param  data: Specifies the module's data directory search path
--- @param bin char*
--- @param data char*
obslua.obs_add_module_path = function(bin, data) end

--- obs_add_raw_video_callback not documented
obslua.obs_add_raw_video_callback = function() end

--- obs_add_tick_callback not documented
obslua.obs_add_tick_callback = function() end

--- obs_apply_private_data not documented
obslua.obs_apply_private_data = function() end

--- obs_encoder_t* obs_audio_encoder_create(const char *id, const char *name, obs_data_t *settings, size_t mixer_idx, obs_data_t *hotkey_data)
--- Creates an audio encoder with the specified settings.
--- The "encoder" context is used for encoding video/audio data.  Use
--- :c:func:`obs_encoder_release()` to release it.
--- :param   id:             The encoder type string identifier
--- :param   name:           The desired name of the encoder.  If this is
---                          not unique, it will be made to be unique
--- :param   settings:       The settings for the encoder, or *NULL* if
---                          none
--- :param   mixer_idx:      The audio mixer index this audio encoder
---                          will capture audio from
--- :param   hotkey_data:    Saved hotkey data for the encoder, or *NULL*
---                          if none
--- :return:                 A reference to the newly created encoder, or
---                          *NULL* if failed
--- @param id char*
--- @param name char*
--- @param settings obs_data_t*
--- @param mixer_idx size_t
--- @param hotkey_data obs_data_t*
--- @return obs_encoder_t*
obslua.obs_audio_encoder_create = function(id, name, settings, mixer_idx, hotkey_data) end

--- void obs_data_addref(obs_data_t *data)
---            void obs_data_release(obs_data_t *data)
--- Adds/releases a reference to a data object.
--- @param data obs_data_t*
obslua.obs_data_addref = function(data) end

--- void obs_data_apply(obs_data_t *target, obs_data_t *apply_data)
--- Merges the data of *apply_data* in to *target*.
--- @param target obs_data_t*
--- @param apply_data obs_data_t*
obslua.obs_data_apply = function(target, apply_data) end

--- void obs_data_array_addref(obs_data_array_t *array)
--- @param array obs_data_array_t*
obslua.obs_data_array_addref = function(array) end

--- size_t obs_data_array_count(obs_data_array_t *array)
--- @param array obs_data_array_t*
--- @return size_t
obslua.obs_data_array_count = function(array) end

--- obs_data_array_t* obs_data_array_create()
--- :return: A new reference to a data array object.
--- @return obs_data_array_t*
obslua.obs_data_array_create = function() end

--- void obs_data_array_erase(obs_data_array_t *array, size_t idx)
--- @param array obs_data_array_t*
--- @param idx size_t
obslua.obs_data_array_erase = function(array, idx) end

--- void obs_data_array_insert(obs_data_array_t *array, size_t idx, obs_data_t *obj)
--- @param array obs_data_array_t*
--- @param idx size_t
--- @param obj obs_data_t*
obslua.obs_data_array_insert = function(array, idx, obj) end

--- obs_data_t* obs_data_array_item(obs_data_array_t *array, size_t idx)
--- :return: An incremented reference to the data object associated with
---          this array entry.
--- @param array obs_data_array_t*
--- @param idx size_t
--- @return obs_data_t*
obslua.obs_data_array_item = function(array, idx) end

--- size_t obs_data_array_push_back(obs_data_array_t *array, obs_data_t *obj)
--- @param array obs_data_array_t*
--- @param obj obs_data_t*
--- @return size_t
obslua.obs_data_array_push_back = function(array, obj) end

--- obs_data_array_push_back_array not documented
obslua.obs_data_array_push_back_array = function() end

--- void obs_data_array_release(obs_data_array_t *array)
--- @param array obs_data_array_t*
obslua.obs_data_array_release = function(array) end

--- void obs_data_clear(obs_data_t *data)
--- Clears all user data in the data object.
--- Set Functions
--- @param data obs_data_t*
obslua.obs_data_clear = function(data) end

--- obs_data_t* obs_data_create()
--- :return: A new reference to a data object.
--- @return obs_data_t*
obslua.obs_data_create = function() end

--- obs_data_t* obs_data_create_from_json(const char *json_string)
--- Creates a data object from a Json string.
--- :param json_string: Json string
--- :return:            A new reference to a data object
--- @param json_string char*
--- @return obs_data_t*
obslua.obs_data_create_from_json = function(json_string) end

--- obs_data_t* obs_data_create_from_json_file(const char *json_file)
--- Creates a data object from a Json file.
--- :param json_file: Json file path
--- :return:          A new reference to a data object
--- @param json_file char*
--- @return obs_data_t*
obslua.obs_data_create_from_json_file = function(json_file) end

--- obs_data_t* obs_data_create_from_json_file_safe(const char *json_file, const char *backup_ext)
--- Creates a data object from a Json file, with a backup file in case
--- the original is corrupted or fails to load.
--- :param json_file:  Json file path
--- :param backup_ext: Backup file extension
--- :return:           A new reference to a data object
--- @param json_file char*
--- @param backup_ext char*
--- @return obs_data_t*
obslua.obs_data_create_from_json_file_safe = function(json_file, backup_ext) end

--- void obs_data_erase(obs_data_t *data, const char *name)
--- Erases the user data for item *name* within the data object.
--- @param data obs_data_t*
--- @param name char*
obslua.obs_data_erase = function(data, name) end

--- obs_data_first not documented
obslua.obs_data_first = function() end

--- obs_data_array_t* obs_data_get_array(obs_data_t *data, const char *name)
--- :return: An incremented reference to a data array object.
--- .. _obs_data_default_funcs:
--- Default Value Functions
--- Default values are used to determine what value will be given if a value
--- is not set.
--- @param data obs_data_t*
--- @param name char*
--- @return obs_data_array_t*
obslua.obs_data_get_array = function(data, name) end

--- obs_data_get_autoselect_array not documented
obslua.obs_data_get_autoselect_array = function() end

--- obs_data_get_autoselect_bool not documented
obslua.obs_data_get_autoselect_bool = function() end

--- obs_data_get_autoselect_double not documented
obslua.obs_data_get_autoselect_double = function() end

--- obs_data_get_autoselect_frames_per_second not documented
obslua.obs_data_get_autoselect_frames_per_second = function() end

--- obs_data_get_autoselect_int not documented
obslua.obs_data_get_autoselect_int = function() end

--- obs_data_get_autoselect_obj not documented
obslua.obs_data_get_autoselect_obj = function() end

--- obs_data_get_autoselect_quat not documented
obslua.obs_data_get_autoselect_quat = function() end

--- obs_data_get_autoselect_string not documented
obslua.obs_data_get_autoselect_string = function() end

--- obs_data_get_autoselect_vec2 not documented
obslua.obs_data_get_autoselect_vec2 = function() end

--- obs_data_get_autoselect_vec3 not documented
obslua.obs_data_get_autoselect_vec3 = function() end

--- obs_data_get_autoselect_vec4 not documented
obslua.obs_data_get_autoselect_vec4 = function() end

--- bool obs_data_get_bool(obs_data_t *data, const char *name)
--- @param data obs_data_t*
--- @param name char*
--- @return bool
obslua.obs_data_get_bool = function(data, name) end

--- obs_data_get_default_array not documented
obslua.obs_data_get_default_array = function() end

--- obs_data_get_default_bool not documented
obslua.obs_data_get_default_bool = function() end

--- obs_data_get_default_double not documented
obslua.obs_data_get_default_double = function() end

--- obs_data_get_default_frames_per_second not documented
obslua.obs_data_get_default_frames_per_second = function() end

--- obs_data_get_default_int not documented
obslua.obs_data_get_default_int = function() end

--- obs_data_get_default_obj not documented
obslua.obs_data_get_default_obj = function() end

--- obs_data_get_default_quat not documented
obslua.obs_data_get_default_quat = function() end

--- obs_data_get_default_string not documented
obslua.obs_data_get_default_string = function() end

--- obs_data_get_default_vec2 not documented
obslua.obs_data_get_default_vec2 = function() end

--- obs_data_get_default_vec3 not documented
obslua.obs_data_get_default_vec3 = function() end

--- obs_data_get_default_vec4 not documented
obslua.obs_data_get_default_vec4 = function() end

--- double obs_data_get_double(obs_data_t *data, const char *name)
--- @param data obs_data_t*
--- @param name char*
--- @return double
obslua.obs_data_get_double = function(data, name) end

--- obs_data_get_frames_per_second not documented
obslua.obs_data_get_frames_per_second = function() end

--- obs_data_get_int not documented
obslua.obs_data_get_int = function() end

--- obs_data_get_json not documented
obslua.obs_data_get_json = function() end

--- obs_data_t* obs_data_get_obj(obs_data_t *data, const char *name)
--- :return: An incremented reference to a data object.
--- @param data obs_data_t*
--- @param name char*
--- @return obs_data_t*
obslua.obs_data_get_obj = function(data, name) end

--- obs_data_get_quat not documented
obslua.obs_data_get_quat = function() end

--- obs_data_get_string not documented
obslua.obs_data_get_string = function() end

--- obs_data_get_vec2 not documented
obslua.obs_data_get_vec2 = function() end

--- obs_data_get_vec3 not documented
obslua.obs_data_get_vec3 = function() end

--- obs_data_get_vec4 not documented
obslua.obs_data_get_vec4 = function() end

--- obs_data_has_autoselect_value not documented
obslua.obs_data_has_autoselect_value = function() end

--- obs_data_has_default_value not documented
obslua.obs_data_has_default_value = function() end

--- obs_data_has_user_value not documented
obslua.obs_data_has_user_value = function() end

--- obs_data_item_byname not documented
obslua.obs_data_item_byname = function() end

--- obs_data_item_get_array not documented
obslua.obs_data_item_get_array = function() end

--- obs_data_item_get_autoselect_array not documented
obslua.obs_data_item_get_autoselect_array = function() end

--- obs_data_item_get_autoselect_bool not documented
obslua.obs_data_item_get_autoselect_bool = function() end

--- obs_data_item_get_autoselect_double not documented
obslua.obs_data_item_get_autoselect_double = function() end

--- obs_data_item_get_autoselect_frames_per_second not documented
obslua.obs_data_item_get_autoselect_frames_per_second = function() end

--- obs_data_item_get_autoselect_int not documented
obslua.obs_data_item_get_autoselect_int = function() end

--- obs_data_item_get_autoselect_obj not documented
obslua.obs_data_item_get_autoselect_obj = function() end

--- obs_data_item_get_autoselect_string not documented
obslua.obs_data_item_get_autoselect_string = function() end

--- obs_data_item_get_bool not documented
obslua.obs_data_item_get_bool = function() end

--- obs_data_item_get_default_array not documented
obslua.obs_data_item_get_default_array = function() end

--- obs_data_item_get_default_bool not documented
obslua.obs_data_item_get_default_bool = function() end

--- obs_data_item_get_default_double not documented
obslua.obs_data_item_get_default_double = function() end

--- obs_data_item_get_default_frames_per_second not documented
obslua.obs_data_item_get_default_frames_per_second = function() end

--- obs_data_item_get_default_int not documented
obslua.obs_data_item_get_default_int = function() end

--- obs_data_item_get_default_obj not documented
obslua.obs_data_item_get_default_obj = function() end

--- obs_data_item_get_default_string not documented
obslua.obs_data_item_get_default_string = function() end

--- obs_data_item_get_double not documented
obslua.obs_data_item_get_double = function() end

--- obs_data_item_get_frames_per_second not documented
obslua.obs_data_item_get_frames_per_second = function() end

--- obs_data_item_get_int not documented
obslua.obs_data_item_get_int = function() end

--- obs_data_item_get_name not documented
obslua.obs_data_item_get_name = function() end

--- obs_data_item_get_obj not documented
obslua.obs_data_item_get_obj = function() end

--- obs_data_item_get_string not documented
obslua.obs_data_item_get_string = function() end

--- obs_data_item_gettype not documented
obslua.obs_data_item_gettype = function() end

--- obs_data_item_has_autoselect_value not documented
obslua.obs_data_item_has_autoselect_value = function() end

--- obs_data_item_has_default_value not documented
obslua.obs_data_item_has_default_value = function() end

--- obs_data_item_has_user_value not documented
obslua.obs_data_item_has_user_value = function() end

--- obs_data_item_next not documented
obslua.obs_data_item_next = function() end

--- obs_data_item_numtype not documented
obslua.obs_data_item_numtype = function() end

--- obs_data_item_release not documented
obslua.obs_data_item_release = function() end

--- obs_data_item_remove not documented
obslua.obs_data_item_remove = function() end

--- obs_data_item_set_array not documented
obslua.obs_data_item_set_array = function() end

--- obs_data_item_set_autoselect_array not documented
obslua.obs_data_item_set_autoselect_array = function() end

--- obs_data_item_set_autoselect_bool not documented
obslua.obs_data_item_set_autoselect_bool = function() end

--- obs_data_item_set_autoselect_double not documented
obslua.obs_data_item_set_autoselect_double = function() end

--- obs_data_item_set_autoselect_frames_per_second not documented
obslua.obs_data_item_set_autoselect_frames_per_second = function() end

--- obs_data_item_set_autoselect_int not documented
obslua.obs_data_item_set_autoselect_int = function() end

--- obs_data_item_set_autoselect_obj not documented
obslua.obs_data_item_set_autoselect_obj = function() end

--- obs_data_item_set_autoselect_string not documented
obslua.obs_data_item_set_autoselect_string = function() end

--- obs_data_item_set_bool not documented
obslua.obs_data_item_set_bool = function() end

--- obs_data_item_set_default_array not documented
obslua.obs_data_item_set_default_array = function() end

--- obs_data_item_set_default_bool not documented
obslua.obs_data_item_set_default_bool = function() end

--- obs_data_item_set_default_double not documented
obslua.obs_data_item_set_default_double = function() end

--- obs_data_item_set_default_frames_per_second not documented
obslua.obs_data_item_set_default_frames_per_second = function() end

--- obs_data_item_set_default_int not documented
obslua.obs_data_item_set_default_int = function() end

--- obs_data_item_set_default_obj not documented
obslua.obs_data_item_set_default_obj = function() end

--- obs_data_item_set_default_string not documented
obslua.obs_data_item_set_default_string = function() end

--- obs_data_item_set_double not documented
obslua.obs_data_item_set_double = function() end

--- obs_data_item_set_frames_per_second not documented
obslua.obs_data_item_set_frames_per_second = function() end

--- obs_data_item_set_int not documented
obslua.obs_data_item_set_int = function() end

--- obs_data_item_set_obj not documented
obslua.obs_data_item_set_obj = function() end

--- obs_data_item_set_string not documented
obslua.obs_data_item_set_string = function() end

--- obs_data_item_unset_autoselect_value not documented
obslua.obs_data_item_unset_autoselect_value = function() end

--- obs_data_item_unset_default_value not documented
obslua.obs_data_item_unset_default_value = function() end

--- obs_data_item_unset_user_value not documented
obslua.obs_data_item_unset_user_value = function() end

--- obs_data_newref not documented
obslua.obs_data_newref = function() end

--- obs_data_release not documented
obslua.obs_data_release = function() end

--- bool obs_data_save_json(obs_data_t *data, const char *file)
--- Saves the data to a file as Json text.
--- :param file: The file to save to
--- :return:     *true* if successful, *false* otherwise
--- @param data obs_data_t*
--- @param file char*
--- @return bool
obslua.obs_data_save_json = function(data, file) end

--- bool obs_data_save_json_safe(obs_data_t *data, const char *file, const char *temp_ext, const char *backup_ext)
--- Saves the data to a file as Json text, and if overwriting an old
--- file, backs up that old file to help prevent potential file
--- corruption.
--- :param file:       The file to save to
--- :param backup_ext: The backup extension to use for the overwritten
---                    file if it exists
--- :return:           *true* if successful, *false* otherwise
--- @param data obs_data_t*
--- @param file char*
--- @param temp_ext char*
--- @param backup_ext char*
--- @return bool
obslua.obs_data_save_json_safe = function(data, file, temp_ext, backup_ext) end

--- void obs_data_set_array(obs_data_t *data, const char *name, obs_data_array_t *array)
--- .. _obs_data_get_funcs:
--- Get Functions
--- @param data obs_data_t*
--- @param name char*
--- @param array obs_data_array_t*
obslua.obs_data_set_array = function(data, name, array) end

--- void obs_data_set_autoselect_bool(obs_data_t *data, const char *name, bool val)
---            bool obs_data_get_autoselect_bool(obs_data_t *data, const char *name)
--- @param data obs_data_t*
--- @param name char*
--- @param val bool
obslua.obs_data_set_autoselect_bool = function(data, name, val) end

--- void obs_data_set_autoselect_double(obs_data_t *data, const char *name, double val)
---            double obs_data_get_autoselect_double(obs_data_t *data, const char *name)
--- @param data obs_data_t*
--- @param name char*
--- @param val double
obslua.obs_data_set_autoselect_double = function(data, name, val) end

--- obs_data_set_autoselect_frames_per_second not documented
obslua.obs_data_set_autoselect_frames_per_second = function() end

--- void obs_data_set_autoselect_int(obs_data_t *data, const char *name, long long val)
---            long long obs_data_get_autoselect_int(obs_data_t *data, const char *name)
--- @param data obs_data_t*
--- @param name char*
--- @param val longlong
obslua.obs_data_set_autoselect_int = function(data, name, val) end

--- void obs_data_set_autoselect_obj(obs_data_t *data, const char *name, obs_data_t *obj)
---            obs_data_t *obs_data_get_autoselect_obj(obs_data_t *data, const char *name)
--- :return: An incremented reference to a data object.
--- Array Functions
--- @param data obs_data_t*
--- @param name char*
--- @param obj obs_data_t*
obslua.obs_data_set_autoselect_obj = function(data, name, obj) end

--- obs_data_set_autoselect_quat not documented
obslua.obs_data_set_autoselect_quat = function() end

--- void obs_data_set_autoselect_string(obs_data_t *data, const char *name, const char *val)
---            const char *obs_data_get_autoselect_string(obs_data_t *data, const char *name)
--- @param data obs_data_t*
--- @param name char*
--- @param val char*
obslua.obs_data_set_autoselect_string = function(data, name, val) end

--- obs_data_set_autoselect_vec2 not documented
obslua.obs_data_set_autoselect_vec2 = function() end

--- obs_data_set_autoselect_vec3 not documented
obslua.obs_data_set_autoselect_vec3 = function() end

--- obs_data_set_autoselect_vec4 not documented
obslua.obs_data_set_autoselect_vec4 = function() end

--- void obs_data_set_bool(obs_data_t *data, const char *name, bool val)
--- @param data obs_data_t*
--- @param name char*
--- @param val bool
obslua.obs_data_set_bool = function(data, name, val) end

--- void obs_data_set_default_bool(obs_data_t *data, const char *name, bool val)
---            bool obs_data_get_default_bool(obs_data_t *data, const char *name)
--- @param data obs_data_t*
--- @param name char*
--- @param val bool
obslua.obs_data_set_default_bool = function(data, name, val) end

--- void obs_data_set_default_double(obs_data_t *data, const char *name, double val)
---            double obs_data_get_default_double(obs_data_t *data, const char *name)
--- @param data obs_data_t*
--- @param name char*
--- @param val double
obslua.obs_data_set_default_double = function(data, name, val) end

--- obs_data_set_default_frames_per_second not documented
obslua.obs_data_set_default_frames_per_second = function() end

--- void obs_data_set_default_int(obs_data_t *data, const char *name, long long val)
---            long long obs_data_get_default_int(obs_data_t *data, const char *name)
--- @param data obs_data_t*
--- @param name char*
--- @param val longlong
obslua.obs_data_set_default_int = function(data, name, val) end

--- void obs_data_set_default_obj(obs_data_t *data, const char *name, obs_data_t *obj)
---            obs_data_t *obs_data_get_default_obj(obs_data_t *data, const char *name)
--- :return: An incremented reference to a data object.
--- Autoselect Functions
--- Autoselect values are optionally used to determine what values should be
--- used to ensure functionality if the currently set values are
--- inappropriate or invalid.
--- @param data obs_data_t*
--- @param name char*
--- @param obj obs_data_t*
obslua.obs_data_set_default_obj = function(data, name, obj) end

--- obs_data_set_default_quat not documented
obslua.obs_data_set_default_quat = function() end

--- void obs_data_set_default_string(obs_data_t *data, const char *name, const char *val)
---            const char *obs_data_get_default_string(obs_data_t *data, const char *name)
--- @param data obs_data_t*
--- @param name char*
--- @param val char*
obslua.obs_data_set_default_string = function(data, name, val) end

--- obs_data_set_default_vec2 not documented
obslua.obs_data_set_default_vec2 = function() end

--- obs_data_set_default_vec3 not documented
obslua.obs_data_set_default_vec3 = function() end

--- obs_data_set_default_vec4 not documented
obslua.obs_data_set_default_vec4 = function() end

--- void obs_data_set_double(obs_data_t *data, const char *name, double val)
--- @param data obs_data_t*
--- @param name char*
--- @param val double
obslua.obs_data_set_double = function(data, name, val) end

--- obs_data_set_frames_per_second not documented
obslua.obs_data_set_frames_per_second = function() end

--- void obs_data_set_int(obs_data_t *data, const char *name, long long val)
--- @param data obs_data_t*
--- @param name char*
--- @param val longlong
obslua.obs_data_set_int = function(data, name, val) end

--- void obs_data_set_obj(obs_data_t *data, const char *name, obs_data_t *obj)
--- @param data obs_data_t*
--- @param name char*
--- @param obj obs_data_t*
obslua.obs_data_set_obj = function(data, name, obj) end

--- obs_data_set_quat not documented
obslua.obs_data_set_quat = function() end

--- void obs_data_set_string(obs_data_t *data, const char *name, const char *val)
--- @param data obs_data_t*
--- @param name char*
--- @param val char*
obslua.obs_data_set_string = function(data, name, val) end

--- obs_data_set_vec2 not documented
obslua.obs_data_set_vec2 = function() end

--- obs_data_set_vec3 not documented
obslua.obs_data_set_vec3 = function() end

--- obs_data_set_vec4 not documented
obslua.obs_data_set_vec4 = function() end

--- obs_data_unset_autoselect_value not documented
obslua.obs_data_unset_autoselect_value = function() end

--- obs_data_unset_default_value not documented
obslua.obs_data_unset_default_value = function() end

--- obs_data_unset_user_value not documented
obslua.obs_data_unset_user_value = function() end

--- obs_display_add_draw_callback not documented
obslua.obs_display_add_draw_callback = function() end

--- obs_display_t* obs_display_create(const struct gs_init_data *graphics_data)
--- Adds a new window display linked to the main render pipeline.  This creates
--- a new swap chain which updates every frame.
--- *(Important note: do not use more than one display widget within the
--- hierarchy of the same base window; this will cause presentation
--- stalls on Macs.)*
--- :param  graphics_data: The swap chain initialization data
--- :return:               The new display context, or NULL if failed
--- Relevant data types used with this function:
--- .. code:: cpp
--- enum gs_color_format {
---         GS_RGBA,
---         GS_BGRX,
---         GS_BGRA,
---         GS_RGBA16F,
---         GS_RGBA32F,
--- enum gs_zstencil_format {
---         GS_ZS_NONE,
---         GS_Z16,
---         GS_Z24_S8,
---         GS_Z32F,
---         GS_Z32F_S8X24
--- struct gs_window {
--- #if defined(_WIN32)
---         void                    *hwnd;
--- #elif defined(__APPLE__)
---         __unsafe_unretained id  view;
--- #elif defined(__linux__) || defined(__FreeBSD__)
---         uint32_t                id;
---         void                    *display;
--- #endif
--- struct gs_init_data {
---         struct gs_window        window;
---         uint32_t                cx, cy;
---         uint32_t                num_backbuffers;
---         enum gs_color_format    format;
---         enum gs_zstencil_format zsformat;
---         uint32_t                adapter;
--- @param graphics_data gs_init_data*
--- @return obs_display_t*
obslua.obs_display_create = function(graphics_data) end

--- void obs_display_destroy(obs_display_t *display)
--- Destroys a display context.
--- @param display obs_display_t*
obslua.obs_display_destroy = function(display) end

--- bool obs_display_enabled(obs_display_t *display)
--- :return: *true* if the display is enabled, *false* otherwise
--- @param display obs_display_t*
--- @return bool
obslua.obs_display_enabled = function(display) end

--- obs_display_remove_draw_callback not documented
obslua.obs_display_remove_draw_callback = function() end

--- void obs_display_resize(obs_display_t *display, uint32_t cx, uint32_t cy)
--- Changes the size of a display context.
--- @param display obs_display_t*
--- @param cx uint32_t
--- @param cy uint32_t
obslua.obs_display_resize = function(display, cx, cy) end

--- void obs_display_set_background_color(obs_display_t *display, uint32_t color)
--- Sets the background (clear) color for the display context.
--- @param display obs_display_t*
--- @param color uint32_t
obslua.obs_display_set_background_color = function(display, color) end

--- void obs_display_set_enabled(obs_display_t *display, bool enable)
--- Enables/disables a display context.
--- @param display obs_display_t*
--- @param enable bool
obslua.obs_display_set_enabled = function(display, enable) end

--- obs_display_size not documented
obslua.obs_display_size = function() end

--- bool obs_encoder_active(const obs_encoder_t *encoder)
--- :return: *true* if the encoder is active, *false* otherwise
--- Functions used by encoders
--- @param encoder obs_encoder_t*
--- @return bool
obslua.obs_encoder_active = function(encoder) end

--- void obs_encoder_addref(obs_encoder_t *encoder)
---            void obs_encoder_release(obs_encoder_t *encoder)
--- Adds/releases a reference to an encoder.  When the last reference is
--- released, the encoder is destroyed.
--- @param encoder obs_encoder_t*
obslua.obs_encoder_addref = function(encoder) end

--- obs_encoder_audio not documented
obslua.obs_encoder_audio = function() end

--- obs_encoder_create_rerouted not documented
obslua.obs_encoder_create_rerouted = function() end

--- obs_data_t* obs_encoder_defaults(const char *id)
---            obs_data_t *obs_encoder_get_defaults(const obs_encoder_t *encoder)
--- :return: An incremented reference to the encoder's default settings
--- @param id char*
--- @return obs_data_t*
obslua.obs_encoder_defaults = function(id) end

--- obs_encoder_get_caps not documented
obslua.obs_encoder_get_caps = function() end

--- obs_encoder_get_codec not documented
obslua.obs_encoder_get_codec = function() end

--- obs_encoder_get_defaults not documented
obslua.obs_encoder_get_defaults = function() end

--- obs_encoder_get_display_name not documented
obslua.obs_encoder_get_display_name = function() end

--- bool obs_encoder_get_extra_data(const obs_encoder_t *encoder, uint8_t **extra_data, size_t *size)
--- Gets extra data (headers) associated with this encoder.
--- :return: *true* if successful, *false* if no extra data associated
---          with this encoder
--- @param encoder obs_encoder_t*
--- @param extra_data uint8_t**
--- @param size size_t*
--- @return bool
obslua.obs_encoder_get_extra_data = function(encoder, extra_data, size) end

--- obs_encoder_get_height not documented
obslua.obs_encoder_get_height = function() end

--- obs_encoder_get_id not documented
obslua.obs_encoder_get_id = function() end

--- obs_encoder_get_last_error not documented
obslua.obs_encoder_get_last_error = function() end

--- obs_encoder_get_name not documented
obslua.obs_encoder_get_name = function() end

--- obs_encoder_get_preferred_video_format not documented
obslua.obs_encoder_get_preferred_video_format = function() end

--- obs_encoder_get_ref not documented
obslua.obs_encoder_get_ref = function() end

--- uint32_t obs_encoder_get_sample_rate(const obs_encoder_t *encoder)
--- :return: The sample rate of an audio encoder's audio data
--- @param encoder obs_encoder_t*
--- @return uint32_t
obslua.obs_encoder_get_sample_rate = function(encoder) end

--- obs_data_t* obs_encoder_get_settings(const obs_encoder_t *encoder)
--- :return: An incremented reference to the encoder's settings
--- @param encoder obs_encoder_t*
--- @return obs_data_t*
obslua.obs_encoder_get_settings = function(encoder) end

--- obs_encoder_get_type not documented
obslua.obs_encoder_get_type = function() end

--- obs_encoder_get_type_data not documented
obslua.obs_encoder_get_type_data = function() end

--- obs_weak_encoder_t* obs_encoder_get_weak_encoder(obs_encoder_t *encoder)
---            obs_encoder_t *obs_weak_encoder_get_encoder(obs_weak_encoder_t *weak)
--- These functions are used to get a weak reference from a strong encoder
--- reference, or a strong encoder reference from a weak reference.  If
--- the encoder is destroyed, *obs_weak_encoder_get_encoder* will return
--- *NULL*.
--- @param encoder obs_encoder_t*
--- @return obs_weak_encoder_t*
obslua.obs_encoder_get_weak_encoder = function(encoder) end

--- uint32_t obs_encoder_get_width(const obs_encoder_t *encoder)
---            uint32_t obs_encoder_get_height(const obs_encoder_t *encoder)
--- :return: The width/height of a video encoder's encoded image
--- @param encoder obs_encoder_t*
--- @return uint32_t
obslua.obs_encoder_get_width = function(encoder) end

--- void obs_encoder_packet_ref(struct encoder_packet *dst, struct encoder_packet *src)
---            void obs_encoder_packet_release(struct encoder_packet *packet)
--- Adds or releases a reference to an encoder packet.
--- .. _libobs/obs-encoder.h: https://github.com/jp9000/obs-studio/blob/master/libobs/obs-encoder.h
--- @param dst encoder_packet*
--- @param src encoder_packet*
obslua.obs_encoder_packet_ref = function(dst, src) end

--- obs_encoder_packet_release not documented
obslua.obs_encoder_packet_release = function() end

--- obs_encoder_paused not documented
obslua.obs_encoder_paused = function() end

--- obs_properties_t* obs_encoder_properties(const obs_encoder_t *encoder)
---            obs_properties_t *obs_get_encoder_properties(const char *id)
--- Use these functions to get the properties of an encoder or encoder
--- type.  Properties are optionally used (if desired) to automatically
--- generate user interface widgets to allow users to update settings.
--- :return: The properties list for a specific existing encoder.  Free
---          with :c:func:`obs_properties_destroy()`
--- @param encoder obs_encoder_t*
--- @return obs_properties_t*
obslua.obs_encoder_properties = function(encoder) end

--- obs_encoder_release not documented
obslua.obs_encoder_release = function() end

--- bool obs_encoder_scaling_enabled(const obs_encoder_t *encoder)
--- :return: *true* if pre-encode (CPU) scaling enabled, *false*
---          otherwise.
--- @param encoder obs_encoder_t*
--- @return bool
obslua.obs_encoder_scaling_enabled = function(encoder) end

--- obs_encoder_set_audio not documented
obslua.obs_encoder_set_audio = function() end

--- obs_encoder_set_last_error not documented
obslua.obs_encoder_set_last_error = function() end

--- void obs_encoder_set_name(obs_encoder_t *encoder, const char *name)
--- Sets the name of an encoder.  If the encoder is not private and the
--- name is not unique, it will automatically be given a unique name.
--- @param encoder obs_encoder_t*
--- @param name char*
obslua.obs_encoder_set_name = function(encoder, name) end

--- void obs_encoder_set_preferred_video_format(obs_encoder_t *encoder, enum video_format format)
---            enum video_format obs_encoder_get_preferred_video_format(const obs_encoder_t *encoder)
--- Sets the preferred video format for a video encoder.  If the encoder can use
--- the format specified, it will force a conversion to that format if the
--- obs output format does not match the preferred format.
--- If the format is set to VIDEO_FORMAT_NONE, will revert to the default
--- functionality of converting only when absolutely necessary.
--- @param encoder obs_encoder_t*
--- @param format video_format
obslua.obs_encoder_set_preferred_video_format = function(encoder, format) end

--- void obs_encoder_set_scaled_size(obs_encoder_t *encoder, uint32_t width, uint32_t height)
--- Sets the scaled resolution for a video encoder.  Set width and height to 0
--- to disable scaling.  If the encoder is active, this function will trigger
--- a warning, and do nothing.
--- @param encoder obs_encoder_t*
--- @param width uint32_t
--- @param height uint32_t
obslua.obs_encoder_set_scaled_size = function(encoder, width, height) end

--- void obs_encoder_set_video(obs_encoder_t *encoder, video_t *video)
---            void obs_encoder_set_audio(obs_encoder_t *encoder, audio_t *audio)
--- Sets the video/audio handler to use with this video/audio encoder.
--- This is used to capture the raw video/audio data.
--- @param encoder obs_encoder_t*
--- @param video video_t*
obslua.obs_encoder_set_video = function(encoder, video) end

--- void obs_encoder_update(obs_encoder_t *encoder, obs_data_t *settings)
--- Updates the settings for this encoder context.
--- @param encoder obs_encoder_t*
--- @param settings obs_data_t*
obslua.obs_encoder_update = function(encoder, settings) end

--- video_t* obs_encoder_video(const obs_encoder_t *encoder)
---            audio_t *obs_encoder_audio(const obs_encoder_t *encoder)
--- :return: The video/audio handler associated with this encoder, or
---          *NULL* if none or not a matching encoder type
--- @param encoder obs_encoder_t*
--- @return video_t*
obslua.obs_encoder_video = function(encoder) end

--- void obs_enter_graphics(void)
--- Helper function for entering the OBS graphics context.
obslua.obs_enter_graphics = function() end

--- void obs_enum_audio_monitoring_devices(obs_enum_audio_device_cb cb, void *data)
--- Enumerates audio devices which can be used for audio monitoring.
--- Relevant data types used with this function:
--- .. code:: cpp
--- typedef bool (*obs_enum_audio_device_cb)(void *data, const char *name, const char *id);
--- @param cb obs_enum_audio_device_cb
--- @param data void*
obslua.obs_enum_audio_monitoring_devices = function(cb, data) end

--- bool obs_enum_encoder_types(size_t idx, const char **id)
--- Enumerates all available encoder types.
--- @param idx size_t
--- @param id char**
--- @return bool
obslua.obs_enum_encoder_types = function(idx, id) end

--- obs_enum_encoders not documented
obslua.obs_enum_encoders = function() end

--- bool obs_enum_filter_types(size_t idx, const char **id)
--- Enumerates all available filter source types.
--- Filters are sources that are used to modify the video/audio output of
--- other sources.
--- @param idx size_t
--- @param id char**
--- @return bool
obslua.obs_enum_filter_types = function(idx, id) end

--- obs_enum_hotkey_bindings not documented
obslua.obs_enum_hotkey_bindings = function() end

--- obs_enum_hotkeys not documented
obslua.obs_enum_hotkeys = function() end

--- bool obs_enum_input_types(size_t idx, const char **id)
--- Enumerates all available inputs source types.
--- Inputs are general source inputs (such as capture sources, device sources,
--- etc).
--- @param idx size_t
--- @param id char**
--- @return bool
obslua.obs_enum_input_types = function(idx, id) end

--- obs_enum_input_types2 not documented
obslua.obs_enum_input_types2 = function() end

--- void obs_enum_modules(obs_enum_module_callback_t callback, void *param)
--- Enumerates all loaded modules.
--- Relevant data types used with this function:
--- .. code:: cpp
--- typedef void (*obs_enum_module_callback_t)(void *param, obs_module_t *module);
--- @param callback obs_enum_module_callback_t
--- @param param void*
obslua.obs_enum_modules = function(callback, param) end

--- bool obs_enum_output_types(size_t idx, const char **id)
--- Enumerates all available output types.
--- @param idx size_t
--- @param id char**
--- @return bool
obslua.obs_enum_output_types = function(idx, id) end

--- obs_enum_outputs not documented
obslua.obs_enum_outputs = function() end

--- obs_enum_scenes not documented
obslua.obs_enum_scenes = function() end

--- bool obs_enum_service_types(size_t idx, const char **id)
--- Enumerates all available service types.
--- @param idx size_t
--- @param id char**
--- @return bool
obslua.obs_enum_service_types = function(idx, id) end

--- obs_enum_services not documented
obslua.obs_enum_services = function() end

--- bool obs_enum_source_types(size_t idx, const char **id)
--- Enumerates all source types (inputs, filters, transitions, etc).
--- @param idx size_t
--- @param id char**
--- @return bool
obslua.obs_enum_source_types = function(idx, id) end

--- obs_enum_sources not documented
obslua.obs_enum_sources = function() end

--- bool obs_enum_transition_types(size_t idx, const char **id)
--- Enumerates all available transition source types.
--- Transitions are sources used to transition between two or more other
--- sources.
--- @param idx size_t
--- @param id char**
--- @return bool
obslua.obs_enum_transition_types = function(idx, id) end

--- obs_source_t* obs_filter_get_parent(const obs_source_t *filter)
--- If the source is a filter, returns the parent source of the filter.
--- The parent source is the source being filtered.
--- Only guaranteed to be valid inside of the video_render, filter_audio,
--- filter_video, and filter_remove callbacks.
--- @param filter obs_source_t*
--- @return obs_source_t*
obslua.obs_filter_get_parent = function(filter) end

--- obs_source_t* obs_filter_get_target(const obs_source_t *filter)
--- If the source is a filter, returns the target source of the filter.
--- The target source is the next source in the filter chain.
--- Only guaranteed to be valid inside of the video_render, filter_audio,
--- filter_video, and filter_remove callbacks.
--- @param filter obs_source_t*
--- @return obs_source_t*
obslua.obs_filter_get_target = function(filter) end

--- obs_find_data_file not documented
obslua.obs_find_data_file = function() end

--- char* obs_find_module_file(obs_module_t *module, const char *file)
--- Returns the location of a plugin module data file.
--- Note:   Modules should use obs_module_file function defined in obs-module.h
---         as a more elegant means of getting their files without having to
---         specify the module parameter.
--- :param  module: The module associated with the file to locate
--- :param  file:   The file to locate
--- :return:        Path string, or NULL if not found.  Use bfree to free string
--- @param module obs_module_t*
--- @param file char*
--- @return char*
obslua.obs_find_module_file = function(module, file) end

--- void obs_frontend_add_event_callback(obs_frontend_event_cb callback, void *private_data)
--- Adds a callback that will be called when a frontend event occurs.
--- See :c:type:`obs_frontend_event` on what sort of events can be
--- triggered.
--- :param callback:     Callback to use when a frontend event occurs.
--- :param private_data: Private data associated with the callback.
--- @param callback obs_frontend_event_cb
--- @param private_data void*
obslua.obs_frontend_add_event_callback = function(callback, private_data) end

--- void obs_frontend_add_save_callback(obs_frontend_save_cb callback, void *private_data)
--- Adds a callback that will be called when the current scene collection
--- is being saved/loaded.
--- :param callback:     Callback to use when saving/loading a scene
---                      collection.
--- :param private_data: Private data associated with the callback.
--- @param callback obs_frontend_save_cb
--- @param private_data void*
obslua.obs_frontend_add_save_callback = function(callback, private_data) end

--- obs_frontend_defer_save_begin not documented
obslua.obs_frontend_defer_save_begin = function() end

--- obs_frontend_defer_save_end not documented
obslua.obs_frontend_defer_save_end = function() end

--- obs_source_t* obs_frontend_get_current_preview_scene(void)
--- :return: A new reference to the current preview scene if studio mode
---          is active, or the current scene if studio mode is not
---          active.
--- @return obs_source_t*
obslua.obs_frontend_get_current_preview_scene = function() end

--- char* obs_frontend_get_current_profile(void)
--- :return: A new pointer to the current profile name.  Free with
---          :c:func:`bfree()`.
--- @return char*
obslua.obs_frontend_get_current_profile = function() end

--- obs_source_t* obs_frontend_get_current_scene(void)
--- :return: A new reference to the currently active scene.
--- @return obs_source_t*
obslua.obs_frontend_get_current_scene = function() end

--- char* obs_frontend_get_current_scene_collection(void)
--- :return: A new pointer to the current scene collection name.  Free
---          with :c:func:`bfree()`.
--- @return char*
obslua.obs_frontend_get_current_scene_collection = function() end

--- obs_source_t* obs_frontend_get_current_transition(void)
--- :return: A new reference to the currently active transition.
--- @return obs_source_t*
obslua.obs_frontend_get_current_transition = function() end

--- obs_frontend_get_global_config not documented
obslua.obs_frontend_get_global_config = function() end

--- obs_frontend_get_profile_config not documented
obslua.obs_frontend_get_profile_config = function() end

--- obs_frontend_get_profiles not documented
obslua.obs_frontend_get_profiles = function() end

--- obs_output_t* obs_frontend_get_recording_output(void)
--- :return: A new reference to the current srecording output.
--- @return obs_output_t*
obslua.obs_frontend_get_recording_output = function() end

--- obs_output_t* obs_frontend_get_replay_buffer_output(void)
--- :return: A new reference to the current replay buffer output.
--- @return obs_output_t*
obslua.obs_frontend_get_replay_buffer_output = function() end

--- obs_frontend_get_scene_collections not documented
obslua.obs_frontend_get_scene_collections = function() end

--- obs_frontend_get_scene_names not documented
obslua.obs_frontend_get_scene_names = function() end

--- void obs_frontend_get_scenes(struct obs_frontend_source_list *sources)
--- :param sources: Pointer to a :c:type:`obs_frontend_source_list`
---                 structure to receive the list of
---                 reference-incremented scenes.  Release with
---                 :c:func:`obs_frontend_source_list_free`.
--- @param sources obs_frontend_source_list*
obslua.obs_frontend_get_scenes = function(sources) end

--- obs_output_t* obs_frontend_get_streaming_output(void)
--- :return: A new reference to the current streaming output.
--- @return obs_output_t*
obslua.obs_frontend_get_streaming_output = function() end

--- obs_service_t* obs_frontend_get_streaming_service(void)
--- :return: A new reference to the current streaming service object.
--- @return obs_service_t*
obslua.obs_frontend_get_streaming_service = function() end

--- void obs_frontend_get_transitions(struct obs_frontend_source_list *sources)
--- :param sources: Pointer to a :c:type:`obs_frontend_source_list`
---                 structure to receive the list of
---                 reference-incremented transitions.  Release with
---                 :c:func:`obs_frontend_source_list_free`.
--- @param sources obs_frontend_source_list*
obslua.obs_frontend_get_transitions = function(sources) end

--- obs_frontend_open_projector not documented
obslua.obs_frontend_open_projector = function() end

--- obs_frontend_preview_enabled not documented
obslua.obs_frontend_preview_enabled = function() end

--- bool obs_frontend_preview_program_mode_active(void)
--- :return: *true* if studio mode is active, *false* otherwise.
--- @return bool
obslua.obs_frontend_preview_program_mode_active = function() end

--- void obs_frontend_preview_program_trigger_transition(void)
--- Triggers a preview-to-program transition if studio mode is active.
obslua.obs_frontend_preview_program_trigger_transition = function() end

--- bool obs_frontend_recording_active(void)
--- :return: *true* if recording active, *false* otherwise.
--- @return bool
obslua.obs_frontend_recording_active = function() end

--- void obs_frontend_recording_pause(bool pause)
--- :pause: *true* to pause recording, *false* to unpause.
--- @param pause bool
obslua.obs_frontend_recording_pause = function(pause) end

--- bool obs_frontend_recording_paused(void)
--- :return: *true* if recording paused, *false* otherwise.
--- @return bool
obslua.obs_frontend_recording_paused = function() end

--- void obs_frontend_recording_start(void)
--- Starts recording.
obslua.obs_frontend_recording_start = function() end

--- void obs_frontend_recording_stop(void)
--- Stops recording.
obslua.obs_frontend_recording_stop = function() end

--- void obs_frontend_remove_event_callback(obs_frontend_event_cb callback, void *private_data)
--- Removes an event callback.
--- :param callback:     Callback to remove.
--- :param private_data: Private data associated with the callback.
--- @param callback obs_frontend_event_cb
--- @param private_data void*
obslua.obs_frontend_remove_event_callback = function(callback, private_data) end

--- void obs_frontend_remove_save_callback(obs_frontend_save_cb callback, void *private_data)
--- Removes a save/load callback.
--- :param callback:     Callback to remove.
--- :param private_data: Private data associated with the callback.
--- @param callback obs_frontend_save_cb
--- @param private_data void*
obslua.obs_frontend_remove_save_callback = function(callback, private_data) end

--- bool obs_frontend_replay_buffer_active(void)
--- :return: *true* if replay buffer active, *false* otherwise.
--- @return bool
obslua.obs_frontend_replay_buffer_active = function() end

--- void obs_frontend_replay_buffer_save(void)
--- Saves a replay if the replay buffer is active.
obslua.obs_frontend_replay_buffer_save = function() end

--- void obs_frontend_replay_buffer_start(void)
--- Starts replay buffer.
obslua.obs_frontend_replay_buffer_start = function() end

--- void obs_frontend_replay_buffer_stop(void)
--- Stops replay buffer.
obslua.obs_frontend_replay_buffer_stop = function() end

--- void obs_frontend_save(void)
--- Saves the current scene collection.
obslua.obs_frontend_save = function() end

--- void obs_frontend_save_streaming_service(void)
--- Saves the current streaming service data.
obslua.obs_frontend_save_streaming_service = function() end

--- void obs_frontend_set_current_preview_scene(obs_source_t *scene)
--- Sets the current preview scene in studio mode, or the currently
--- active scene if not in studio mode.
--- :param scene: The scene to set as the current preview.
--- @param scene obs_source_t*
obslua.obs_frontend_set_current_preview_scene = function(scene) end

--- void obs_frontend_set_current_profile(const char *profile)
--- :param profile: Name of the profile to activate.
--- @param profile char*
obslua.obs_frontend_set_current_profile = function(profile) end

--- void obs_frontend_set_current_scene(obs_source_t *scene)
--- :param scene: The scene to set as the current scene.
--- @param scene obs_source_t*
obslua.obs_frontend_set_current_scene = function(scene) end

--- void obs_frontend_set_current_scene_collection(const char *collection)
--- :param profile: Name of the scene collection to activate.
--- @param collection char*
obslua.obs_frontend_set_current_scene_collection = function(collection) end

--- void obs_frontend_set_current_transition(obs_source_t *transition)
--- :param transition: The transition to set as the current transition.
--- @param transition obs_source_t*
obslua.obs_frontend_set_current_transition = function(transition) end

--- obs_frontend_set_preview_enabled not documented
obslua.obs_frontend_set_preview_enabled = function() end

--- void obs_frontend_set_preview_program_mode(bool enable)
--- Activates/deactivates studio mode.
--- :param enable: *true* to activate studio mode, *false* to deactivate
---                studio mode.
--- @param enable bool
obslua.obs_frontend_set_preview_program_mode = function(enable) end

--- void obs_frontend_set_streaming_service(obs_service_t *service)
--- Sets the current streaming service to stream with.
--- :param service: The streaming service to set.
--- @param service obs_service_t*
obslua.obs_frontend_set_streaming_service = function(service) end

--- bool obs_frontend_streaming_active(void)
--- :return: *true* if streaming active, *false* otherwise.
--- @return bool
obslua.obs_frontend_streaming_active = function() end

--- void obs_frontend_streaming_start(void)
--- Starts streaming.
obslua.obs_frontend_streaming_start = function() end

--- void obs_frontend_streaming_stop(void)
--- Stops streaming.
obslua.obs_frontend_streaming_stop = function() end

--- void* obs_frontend_take_screenshot(void)
--- Takes a screenshot of the main OBS output.
--- @return void*
obslua.obs_frontend_take_screenshot = function() end

--- void* obs_frontend_take_source_screenshot(obs_source_t *source)
--- Takes a screenshot of the specified source.
--- :param source: The source to take screenshot of.
--- @param source obs_source_t*
--- @return void*
obslua.obs_frontend_take_source_screenshot = function(source) end

--- obs_get_active_fps not documented
obslua.obs_get_active_fps = function() end

--- audio_t* obs_get_audio(void)
--- :return: The main audio output handler for this OBS context
--- @return audio_t*
obslua.obs_get_audio = function() end

--- bool obs_get_audio_info(struct obs_audio_info *oai)
--- Gets the current audio settings.
--- :return: *false* if no audio
--- Libobs Objects
--- @param oai obs_audio_info*
--- @return bool
obslua.obs_get_audio_info = function(oai) end

--- void obs_get_audio_monitoring_device(const char **name, const char **id)
--- Gets the current audio device for audio monitoring.
--- @param name char**
--- @param id char**
obslua.obs_get_audio_monitoring_device = function(name, id) end

--- obs_get_average_frame_time_ns not documented
obslua.obs_get_average_frame_time_ns = function() end

--- gs_effect_t* obs_get_base_effect(enum obs_base_effect effect)
--- Returns a commoinly used base effect.
--- :param effect: | Can be one of the following values:
---                | OBS_EFFECT_DEFAULT             - RGB/YUV
---                | OBS_EFFECT_DEFAULT_RECT        - RGB/YUV (using texture_rect)
---                | OBS_EFFECT_OPAQUE              - RGB/YUV (alpha set to 1.0)
---                | OBS_EFFECT_SOLID               - RGB/YUV (solid color only)
---                | OBS_EFFECT_BICUBIC             - Bicubic downscale
---                | OBS_EFFECT_LANCZOS             - Lanczos downscale
---                | OBS_EFFECT_BILINEAR_LOWRES     - Bilinear low resolution downscale
---                | OBS_EFFECT_PREMULTIPLIED_ALPHA - Premultiplied alpha
--- @param effect obs_base_effect
--- @return gs_effect_t*
obslua.obs_get_base_effect = function(effect) end

--- obs_get_cmdline_args not documented
obslua.obs_get_cmdline_args = function() end

--- obs_encoder_t* obs_get_encoder_by_name(const char *name)
--- Gets an encoder by its name.
--- Increments the encoder reference counter, use
--- :c:func:`obs_encoder_release()` to release it when complete.
--- @param name char*
--- @return obs_encoder_t*
obslua.obs_get_encoder_by_name = function(name) end

--- obs_get_encoder_caps not documented
obslua.obs_get_encoder_caps = function() end

--- obs_get_encoder_codec not documented
obslua.obs_get_encoder_codec = function() end

--- obs_get_encoder_properties not documented
obslua.obs_get_encoder_properties = function() end

--- obs_get_encoder_type not documented
obslua.obs_get_encoder_type = function() end

--- obs_get_frame_interval_ns not documented
obslua.obs_get_frame_interval_ns = function() end

--- obs_get_lagged_frames not documented
obslua.obs_get_lagged_frames = function() end

--- obs_get_latest_input_type_id not documented
obslua.obs_get_latest_input_type_id = function() end

--- obs_get_locale not documented
obslua.obs_get_locale = function() end

--- obs_get_main_texture not documented
obslua.obs_get_main_texture = function() end

--- float obs_get_master_volume(void)
--- :return: The master user volume
--- @return float
obslua.obs_get_master_volume = function() end

--- obs_get_module not documented
obslua.obs_get_module = function() end

--- void obs_get_module_author(obs_module_t *module)
--- :return: The module author(s)
--- @param module obs_module_t*
obslua.obs_get_module_author = function(module) end

--- obs_get_module_binary_path not documented
obslua.obs_get_module_binary_path = function() end

--- obs_get_module_data_path not documented
obslua.obs_get_module_data_path = function() end

--- obs_get_module_description not documented
obslua.obs_get_module_description = function() end

--- obs_get_module_file_name not documented
obslua.obs_get_module_file_name = function() end

--- obs_get_module_name not documented
obslua.obs_get_module_name = function() end

--- obs_output_t* obs_get_output_by_name(const char *name)
--- Gets an output by its name.
--- Increments the output reference counter, use
--- :c:func:`obs_output_release()` to release it when complete.
--- @param name char*
--- @return obs_output_t*
obslua.obs_get_output_by_name = function(name) end

--- obs_get_output_flags not documented
obslua.obs_get_output_flags = function() end

--- obs_get_output_properties not documented
obslua.obs_get_output_properties = function() end

--- obs_source_t* obs_get_output_source(uint32_t channel)
--- Gets the primary output source for a channel and increments the reference
--- counter for that source.  Use :c:func:`obs_source_release()` to release.
--- @param channel uint32_t
--- @return obs_source_t*
obslua.obs_get_output_source = function(channel) end

--- obs_get_private_data not documented
obslua.obs_get_private_data = function() end

--- proc_handler_t* obs_get_proc_handler(void)
--- :return: The primary obs procedure handler
--- .. _core_signal_handler_reference:
--- Core OBS Signals
--- **source_create** (ptr source)
--- Called when a source has been created.
--- **source_destroy** (ptr source)
--- Called when a source has been destroyed.
--- **source_remove** (ptr source)
--- Called when a source has been removed (:c:func:`obs_source_remove()`
--- has been called on the source).
--- **source_save** (ptr source)
--- Called when a source is being saved.
--- **source_load** (ptr source)
--- Called when a source is being loaded.
--- **source_activate** (ptr source)
--- Called when a source has been activated in the main view (visible on
--- stream/recording).
--- **source_deactivate** (ptr source)
--- Called when a source has been deactivated from the main view (no
--- longer visible on stream/recording).
--- **source_show** (ptr source)
--- Called when a source is visible on any display and/or on the main
--- view.
--- **source_hide** (ptr source)
--- Called when a source is no longer visible on any display and/or on
--- the main view.
--- **source_rename** (ptr source, string new_name, string prev_name)
--- Called when a source has been renamed.
--- **source_volume** (ptr source, in out float volume)
--- Called when a source's volume has changed.
--- **source_transition_start** (ptr source)
--- Called when a transition has started its transition.
--- **source_transition_video_stop** (ptr source)
--- Called when a transition has stopped its video transitioning.
--- **source_transition_stop** (ptr source)
--- Called when a transition has stopped its transition.
--- **channel_change** (int channel, in out ptr source, ptr prev_source)
--- Called when :c:func:`obs_set_output_source()` has been called.
--- **master_volume** (in out float volume)
--- Called when the master volume has changed.
--- **hotkey_layout_change** ()
--- Called when the hotkey layout has changed.
--- **hotkey_register** (ptr hotkey)
--- Called when a hotkey has been registered.
--- **hotkey_unregister** (ptr hotkey)
--- Called when a hotkey has been unregistered.
--- **hotkey_bindings_changed** (ptr hotkey)
--- Called when a hotkey's bindings has changed.
--- .. _display_reference:
--- Displays
--- @return proc_handler_t*
obslua.obs_get_proc_handler = function() end

--- profiler_name_store_t* obs_get_profiler_name_store(void)
--- :return: The profiler name store (see util/profiler.h) used by OBS,
---          which is either a name store passed to obs_startup, an
---          internal name store, or NULL in case obs_initialized()
---          returns false.
--- @return profiler_name_store_t*
obslua.obs_get_profiler_name_store = function() end

--- obs_service_t* obs_get_service_by_name(const char *name)
--- Gets an service by its name.
--- Increments the service reference counter, use
--- :c:func:`obs_service_release()` to release it when complete.
--- @param name char*
--- @return obs_service_t*
obslua.obs_get_service_by_name = function(name) end

--- obs_get_service_properties not documented
obslua.obs_get_service_properties = function() end

--- signal_handler_t* obs_get_signal_handler(void)
--- :return: The primary obs signal handler
--- See :ref:`core_signal_handler_reference` for more information on
--- core signals.
--- @return signal_handler_t*
obslua.obs_get_signal_handler = function() end

--- obs_source_t* obs_get_source_by_name(const char *name)
--- Gets a source by its name.
--- Increments the source reference counter, use
--- :c:func:`obs_source_release()` to release it when complete.
--- @param name char*
--- @return obs_source_t*
obslua.obs_get_source_by_name = function(name) end

--- obs_data_t* obs_get_source_defaults(const char *id)
--- Calls :c:member:`obs_source_info.get_defaults` to get the defaults
--- settings of the source type.
--- :return: The default settings for a source type
--- @param id char*
--- @return obs_data_t*
obslua.obs_get_source_defaults = function(id) end

--- obs_get_source_output_flags not documented
obslua.obs_get_source_output_flags = function() end

--- obs_get_source_properties not documented
obslua.obs_get_source_properties = function() end

--- obs_get_total_frames not documented
obslua.obs_get_total_frames = function() end

--- uint32_t obs_get_version(void)
--- :return: The current core version
--- @return uint32_t
obslua.obs_get_version = function() end

--- obs_get_version_string not documented
obslua.obs_get_version_string = function() end

--- video_t* obs_get_video(void)
--- :return: The main video output handler for this OBS context
--- @return video_t*
obslua.obs_get_video = function() end

--- obs_get_video_frame_time not documented
obslua.obs_get_video_frame_time = function() end

--- bool obs_get_video_info(struct obs_video_info *ovi)
--- Gets the current video settings.
--- :return: *false* if no video
--- @param ovi obs_video_info*
--- @return bool
obslua.obs_get_video_info = function(ovi) end

--- obs_scene_t* obs_group_from_source(const obs_source_t *source)
--- :return: The group context, or *NULL* if not a group.  Does not
---          increase the reference
--- @param source obs_source_t*
--- @return obs_scene_t*
obslua.obs_group_from_source = function(source) end

--- obs_hotkey_binding_get_hotkey not documented
obslua.obs_hotkey_binding_get_hotkey = function() end

--- obs_hotkey_binding_get_hotkey_id not documented
obslua.obs_hotkey_binding_get_hotkey_id = function() end

--- obs_hotkey_binding_get_key_combination not documented
obslua.obs_hotkey_binding_get_key_combination = function() end

--- obs_hotkey_enable_background_press not documented
obslua.obs_hotkey_enable_background_press = function() end

--- obs_hotkey_enable_callback_rerouting not documented
obslua.obs_hotkey_enable_callback_rerouting = function() end

--- obs_hotkey_enable_strict_modifiers not documented
obslua.obs_hotkey_enable_strict_modifiers = function() end

--- obs_hotkey_get_description not documented
obslua.obs_hotkey_get_description = function() end

--- obs_hotkey_get_id not documented
obslua.obs_hotkey_get_id = function() end

--- obs_hotkey_get_name not documented
obslua.obs_hotkey_get_name = function() end

--- obs_hotkey_get_pair_partner_id not documented
obslua.obs_hotkey_get_pair_partner_id = function() end

--- obs_hotkey_get_registerer not documented
obslua.obs_hotkey_get_registerer = function() end

--- obs_hotkey_get_registerer_type not documented
obslua.obs_hotkey_get_registerer_type = function() end

--- obs_hotkey_inject_event not documented
obslua.obs_hotkey_inject_event = function() end

--- obs_hotkey_load not documented
obslua.obs_hotkey_load = function() end

--- obs_hotkey_load_bindings not documented
obslua.obs_hotkey_load_bindings = function() end

--- obs_hotkey_pair_load not documented
obslua.obs_hotkey_pair_load = function() end

--- obs_hotkey_pair_save not documented
obslua.obs_hotkey_pair_save = function() end

--- obs_hotkey_pair_set_descriptions not documented
obslua.obs_hotkey_pair_set_descriptions = function() end

--- obs_hotkey_pair_set_names not documented
obslua.obs_hotkey_pair_set_names = function() end

--- obs_hotkey_pair_unregister not documented
obslua.obs_hotkey_pair_unregister = function() end

--- obs_hotkey_register_frontend not documented
obslua.obs_hotkey_register_frontend = function() end

--- obs_hotkey_save not documented
obslua.obs_hotkey_save = function() end

--- obs_hotkey_set_callback_routing_func not documented
obslua.obs_hotkey_set_callback_routing_func = function() end

--- obs_hotkey_set_description not documented
obslua.obs_hotkey_set_description = function() end

--- obs_hotkey_set_name not documented
obslua.obs_hotkey_set_name = function() end

--- obs_hotkey_trigger_routed_callback not documented
obslua.obs_hotkey_trigger_routed_callback = function() end

--- obs_hotkey_unregister not documented
obslua.obs_hotkey_unregister = function() end

--- obs_hotkey_update_atomic not documented
obslua.obs_hotkey_update_atomic = function() end

--- obs_hotkeys_load_encoder not documented
obslua.obs_hotkeys_load_encoder = function() end

--- obs_hotkeys_load_output not documented
obslua.obs_hotkeys_load_output = function() end

--- obs_hotkeys_load_service not documented
obslua.obs_hotkeys_load_service = function() end

--- obs_hotkeys_load_source not documented
obslua.obs_hotkeys_load_source = function() end

--- obs_hotkeys_save_encoder not documented
obslua.obs_hotkeys_save_encoder = function() end

--- obs_hotkeys_save_output not documented
obslua.obs_hotkeys_save_output = function() end

--- obs_hotkeys_save_service not documented
obslua.obs_hotkeys_save_service = function() end

--- obs_hotkeys_save_source not documented
obslua.obs_hotkeys_save_source = function() end

--- obs_hotkeys_set_audio_hotkeys_translations not documented
obslua.obs_hotkeys_set_audio_hotkeys_translations = function() end

--- obs_hotkeys_set_sceneitem_hotkeys_translations not documented
obslua.obs_hotkeys_set_sceneitem_hotkeys_translations = function() end

--- bool obs_init_module(obs_module_t *module)
--- Initializes the module, which calls its obs_module_load export.
--- :return: *true* if the module was loaded successfully
--- @param module obs_module_t*
--- @return bool
obslua.obs_init_module = function(module) end

--- bool obs_initialized(void)
--- :return: true if the main OBS context has been initialized
--- @return bool
obslua.obs_initialized = function() end

--- obs_is_source_configurable not documented
obslua.obs_is_source_configurable = function() end

--- obs_key_combination_is_empty not documented
obslua.obs_key_combination_is_empty = function() end

--- obs_key_combination_to_str not documented
obslua.obs_key_combination_to_str = function() end

--- obs_key_from_name not documented
obslua.obs_key_from_name = function() end

--- obs_key_from_virtual_key not documented
obslua.obs_key_from_virtual_key = function() end

--- obs_key_to_name not documented
obslua.obs_key_to_name = function() end

--- obs_key_to_str not documented
obslua.obs_key_to_str = function() end

--- obs_key_to_virtual_key not documented
obslua.obs_key_to_virtual_key = function() end

--- void obs_leave_graphics(void)
--- Helper function for leaving the OBS graphics context.
obslua.obs_leave_graphics = function() end

--- void obs_load_all_modules(void)
--- Automatically loads all modules from module paths (convenience function).
obslua.obs_load_all_modules = function() end

--- obs_source_t* obs_load_source(obs_data_t *data)
--- :return: A source created from saved data
--- @param data obs_data_t*
--- @return obs_source_t*
obslua.obs_load_source = function(data) end

--- void obs_load_sources(obs_data_array_t *array, obs_load_source_cb cb, void *private_data)
--- Helper function to load active sources from a data array.
--- Relevant data types used with this function:
--- .. code:: cpp
--- typedef void (*obs_load_source_cb)(void *private_data, obs_source_t *source);
--- @param array obs_data_array_t*
--- @param cb obs_load_source_cb
--- @param private_data void*
obslua.obs_load_sources = function(array, cb, private_data) end

--- void obs_log_loaded_modules(void)
--- Logs loaded modules.
obslua.obs_log_loaded_modules = function() end

--- char* obs_module_get_config_path(obs_module_t *module, const char *file)
--- Returns the path of a plugin module config file (whether it exists or not).
--- Note:   Modules should use obs_module_config_path function defined in
---         obs-module.h as a more elegant means of getting their files without
---         having to specify the module parameter.
--- :param  module: The module associated with the path
--- :param  file:   The file to get a path to
--- :return:        Path string, or NULL if not found.  Use bfree to free string
--- @param module obs_module_t*
--- @param file char*
--- @return char*
obslua.obs_module_get_config_path = function(module, file) end

--- obs_module_get_locale_string not documented
obslua.obs_module_get_locale_string = function() end

--- obs_module_get_locale_text not documented
obslua.obs_module_get_locale_text = function() end

--- obs_module_load_locale not documented
obslua.obs_module_load_locale = function() end

--- obs_nv12_tex_active not documented
obslua.obs_nv12_tex_active = function() end

--- obs_obj_get_data not documented
obslua.obs_obj_get_data = function() end

--- obs_obj_get_id not documented
obslua.obs_obj_get_id = function() end

--- obs_obj_get_type not documented
obslua.obs_obj_get_type = function() end

--- obs_obj_invalid not documented
obslua.obs_obj_invalid = function() end

--- int obs_open_module(obs_module_t **module, const char *path, const char *data_path)
--- Opens a plugin module directly from a specific path.
--- If the module already exists then the function will return successful, and
--- the module parameter will be given the pointer to the existing
--- module.
--- This does not initialize the module, it only loads the module image.  To
--- initialize the module, call :c:func:`obs_init_module()`.
--- :param  module:    The pointer to the created module
--- :param  path:      Specifies the path to the module library file.  If the
---                    extension is not specified, it will use the extension
---                    appropriate to the operating system
--- :param  data_path: Specifies the path to the directory where the module's
---                    data files are stored (or *NULL* if none)
--- :returns:          | MODULE_SUCCESS          - Successful
---                    | MODULE_ERROR            - A generic error occurred
---                    | MODULE_FILE_NOT_FOUND   - The module was not found
---                    | MODULE_MISSING_EXPORTS  - Required exports are missing
---                    | MODULE_INCOMPATIBLE_VER - Incompatible version
--- @param module obs_module_t**
--- @param path char*
--- @param data_path char*
--- @return int
obslua.obs_open_module = function(module, path, data_path) end

--- bool obs_output_active(const obs_output_t *output)
--- :return: *true* if the output is currently active, *false* otherwise
--- @param output obs_output_t*
--- @return bool
obslua.obs_output_active = function(output) end

--- void obs_output_addref(obs_output_t *output)
---            void obs_output_release(obs_output_t *output)
--- Adds/releases a reference to an output.  When the last reference is
--- released, the output is destroyed.
--- @param output obs_output_t*
obslua.obs_output_addref = function(output) end

--- obs_output_audio not documented
obslua.obs_output_audio = function() end

--- bool obs_output_begin_data_capture(obs_output_t *output, uint32_t flags)
--- Begins data capture from raw media or encoders.  This is typically
--- when the output actually activates (starts) internally.  Video/audio
--- data will start being sent to the callbacks of the output.
--- :param flags: Set to 0 to initialize both audio/video, otherwise a
---               bitwise OR combination of OBS_OUTPUT_VIDEO and/or
---               OBS_OUTPUT_AUDIO
--- :return:      *true* if successful, *false* otherwise.  Typically the
---               return value does not need to be checked if
---               :c:func:`obs_output_can_begin_data_capture()` was
---               called
--- @param output obs_output_t*
--- @param flags uint32_t
--- @return bool
obslua.obs_output_begin_data_capture = function(output, flags) end

--- bool obs_output_can_begin_data_capture(const obs_output_t *output, uint32_t flags)
--- Determines whether video/audio capture (encoded or raw) is able to
--- start.  Call this before initializing any output data to ensure that
--- the output can start.
--- :param flags: Set to 0 to initialize both audio/video, otherwise a
---               bitwise OR combination of OBS_OUTPUT_VIDEO and/or
---               OBS_OUTPUT_AUDIO
--- :return:      *true* if data capture can begin
--- @param output obs_output_t*
--- @param flags uint32_t
--- @return bool
obslua.obs_output_can_begin_data_capture = function(output, flags) end

--- bool obs_output_can_pause(const obs_output_t *output)
--- :return: *true* if the output can be paused, *false* otherwise
--- @param output obs_output_t*
--- @return bool
obslua.obs_output_can_pause = function(output) end

--- obs_output_t* obs_output_create(const char *id, const char *name, obs_data_t *settings, obs_data_t *hotkey_data)
--- Creates an output with the specified settings.
--- The "output" context is used for anything related to outputting the
--- final video/audio mix (E.g. streaming or recording).  Use
--- obs_output_release to release it.
--- :param   id:             The output type string identifier
--- :param   name:           The desired name of the output.  If this is
---                          not unique, it will be made to be unique
--- :param   settings:       The settings for the output, or *NULL* if
---                          none
--- :param   hotkey_data:    Saved hotkey data for the output, or *NULL*
---                          if none
--- :return:                 A reference to the newly created output, or
---                          *NULL* if failed
--- @param id char*
--- @param name char*
--- @param settings obs_data_t*
--- @param hotkey_data obs_data_t*
--- @return obs_output_t*
obslua.obs_output_create = function(id, name, settings, hotkey_data) end

--- obs_data_t* obs_output_defaults(const char *id)
--- :return: An incremented reference to the output's default settings
--- @param id char*
--- @return obs_data_t*
obslua.obs_output_defaults = function(id) end

--- void obs_output_end_data_capture(obs_output_t *output)
--- Ends data capture of an output.  This is typically when the output
--- actually intentionally deactivates (stops).  Video/audio data will
--- stop being sent to the callbacks of the output.  The output will
--- trigger the "stop" signal with the OBS_OUTPUT_SUCCESS code to
--- indicate that the output has stopped successfully.  See
--- :ref:`output_signal_handler_reference` for more information on output
--- signals.
--- @param output obs_output_t*
obslua.obs_output_end_data_capture = function(output) end

--- void obs_output_force_stop(obs_output_t *output)
--- Attempts to get the output to stop immediately without waiting for
--- data to send.
--- @param output obs_output_t*
obslua.obs_output_force_stop = function(output) end

--- uint32_t obs_output_get_active_delay(const obs_output_t *output)
--- If delay is active, gets the currently active delay value, in
--- seconds.  The active delay can increase if the
--- OBS_OUTPUT_DELAY_PRESERVE flag was set when setting a delay.
--- @param output obs_output_t*
--- @return uint32_t
obslua.obs_output_get_active_delay = function(output) end

--- obs_output_get_audio_encoder not documented
obslua.obs_output_get_audio_encoder = function() end

--- float obs_output_get_congestion(obs_output_t *output)
--- :return: The congestion value.  This value is used to visualize the
---          current congestion of a network output.  For example, if
---          there is no congestion, the value will be 0.0f, if it's
---          fully congested, the value will be 1.0f
--- @param output obs_output_t*
--- @return float
obslua.obs_output_get_congestion = function(output) end

--- int obs_output_get_connect_time_ms(obs_output_t *output)
--- :return: How long the output took to connect to a server, in
---          milliseconds
--- @param output obs_output_t*
--- @return int
obslua.obs_output_get_connect_time_ms = function(output) end

--- uint32_t obs_output_get_delay(const obs_output_t *output)
--- Gets the currently set delay value, in seconds.
--- @param output obs_output_t*
--- @return uint32_t
obslua.obs_output_get_delay = function(output) end

--- obs_output_get_display_name not documented
obslua.obs_output_get_display_name = function() end

--- uint32_t obs_output_get_flags(const obs_output_t *output)
---            uint32_t obs_get_output_flags(const char *id)
--- :return: The output capability flags
--- Functions used by outputs
--- @param output obs_output_t*
--- @return uint32_t
obslua.obs_output_get_flags = function(output) end

--- int obs_output_get_frames_dropped(const obs_output_t *output)
--- :return: Number of frames that were dropped due to network congestion
--- @param output obs_output_t*
--- @return int
obslua.obs_output_get_frames_dropped = function(output) end

--- obs_output_get_height not documented
obslua.obs_output_get_height = function() end

--- obs_output_get_id not documented
obslua.obs_output_get_id = function() end

--- obs_output_get_last_error not documented
obslua.obs_output_get_last_error = function() end

--- obs_output_get_mixer not documented
obslua.obs_output_get_mixer = function() end

--- obs_output_get_mixers not documented
obslua.obs_output_get_mixers = function() end

--- obs_output_get_name not documented
obslua.obs_output_get_name = function() end

--- uint64_t obs_output_get_pause_offset(obs_output_t *output)
--- Returns the current pause offset of the output.  Used with raw
--- outputs to calculate system timestamps when using calculated
--- timestamps (see FFmpeg output for an example).
--- .. _libobs/obs-output.h: https://github.com/jp9000/obs-studio/blob/master/libobs/obs-output.h
--- @param output obs_output_t*
--- @return uint64_t
obslua.obs_output_get_pause_offset = function(output) end

--- proc_handler_t* obs_output_get_proc_handler(const obs_output_t *output)
--- :return: The procedure handler of the output
--- @param output obs_output_t*
--- @return proc_handler_t*
obslua.obs_output_get_proc_handler = function(output) end

--- obs_output_get_ref not documented
obslua.obs_output_get_ref = function() end

--- obs_output_get_service not documented
obslua.obs_output_get_service = function() end

--- obs_data_t* obs_output_get_settings(const obs_output_t *output)
--- :return: An incremented reference to the output's settings
--- @param output obs_output_t*
--- @return obs_data_t*
obslua.obs_output_get_settings = function(output) end

--- signal_handler_t* obs_output_get_signal_handler(const obs_output_t *output)
--- :return: The signal handler of the output
--- @param output obs_output_t*
--- @return signal_handler_t*
obslua.obs_output_get_signal_handler = function(output) end

--- obs_output_get_supported_audio_codecs not documented
obslua.obs_output_get_supported_audio_codecs = function() end

--- obs_output_get_supported_video_codecs not documented
obslua.obs_output_get_supported_video_codecs = function() end

--- uint64_t obs_output_get_total_bytes(const obs_output_t *output)
--- :return: Total bytes sent/processed
--- @param output obs_output_t*
--- @return uint64_t
obslua.obs_output_get_total_bytes = function(output) end

--- int obs_output_get_total_frames(const obs_output_t *output)
--- :return: Total frames sent/processed
--- @param output obs_output_t*
--- @return int
obslua.obs_output_get_total_frames = function(output) end

--- obs_output_get_type_data not documented
obslua.obs_output_get_type_data = function() end

--- obs_encoder_t* obs_output_get_video_encoder(const obs_output_t *output)
---            obs_encoder_t *obs_output_get_audio_encoder(const obs_output_t *output, size_t idx)
--- Gets the video/audio encoders for an encoded output.
--- :param idx:     The audio encoder index if the output supports
---                 multiple audio streams at once
--- :return:        The video/audio encoder.  The reference is not
---                 incremented
--- @param output obs_output_t*
--- @return obs_encoder_t*
obslua.obs_output_get_video_encoder = function(output) end

--- obs_weak_output_t* obs_output_get_weak_output(obs_output_t *output)
---            obs_output_t *obs_weak_output_get_output(obs_weak_output_t *weak)
--- These functions are used to get a weak reference from a strong output
--- reference, or a strong output reference from a weak reference.  If
--- the output is destroyed, *obs_weak_output_get_output* will return
--- *NULL*.
--- @param output obs_output_t*
--- @return obs_weak_output_t*
obslua.obs_output_get_weak_output = function(output) end

--- uint32_t obs_output_get_width(const obs_output_t *output)
---            uint32_t obs_output_get_height(const obs_output_t *output)
--- :return: The width/height of the output
--- @param output obs_output_t*
--- @return uint32_t
obslua.obs_output_get_width = function(output) end

--- bool obs_output_initialize_encoders(obs_output_t *output, uint32_t flags)
--- Initializes any encoders/services associated with the output.  This
--- must be called for encoded outputs before calling
--- :c:func:`obs_output_begin_data_capture()`.
--- :param flags: Set to 0 to initialize both audio/video, otherwise a
---               bitwise OR combination of OBS_OUTPUT_VIDEO and/or
---               OBS_OUTPUT_AUDIO
--- :return:      *true* if successful, *false* otherwise
--- @param output obs_output_t*
--- @param flags uint32_t
--- @return bool
obslua.obs_output_initialize_encoders = function(output, flags) end

--- obs_output_output_caption_text1 not documented
obslua.obs_output_output_caption_text1 = function() end

--- obs_output_output_caption_text2 not documented
obslua.obs_output_output_caption_text2 = function() end

--- bool obs_output_pause(obs_output_t *output, bool pause)
--- Pause an output (if supported by the output).
--- :return: *true* if the output was paused successfully, *false*
---          otherwise
--- @param output obs_output_t*
--- @param pause bool
--- @return bool
obslua.obs_output_pause = function(output, pause) end

--- bool obs_output_paused(const obs_output_t *output)
--- :return: *true* if the output is paused, *false* otherwise
--- @param output obs_output_t*
--- @return bool
obslua.obs_output_paused = function(output) end

--- obs_properties_t* obs_output_properties(const obs_output_t *output)
---            obs_properties_t *obs_get_output_properties(const char *id)
--- Use these functions to get the properties of an output or output
--- type.  Properties are optionally used (if desired) to automatically
--- generate user interface widgets to allow users to update settings.
--- :return: The properties list for a specific existing output.  Free
---          with :c:func:`obs_properties_destroy()`
--- @param output obs_output_t*
--- @return obs_properties_t*
obslua.obs_output_properties = function(output) end

--- bool obs_output_reconnecting(const obs_output_t *output)
--- :return: *true* if the output is currently reconnecting to a server,
---          *false* otherwise
--- @param output obs_output_t*
--- @return bool
obslua.obs_output_reconnecting = function(output) end

--- obs_output_release not documented
obslua.obs_output_release = function() end

--- void obs_output_set_audio_conversion(obs_output_t *output, const struct audio_convert_info *conversion)
--- Optionally sets the audio conversion information.  Only used by raw
--- outputs.
--- Relevant data types used with this function:
--- .. code:: cpp
--- enum audio_format {
---         AUDIO_FORMAT_UNKNOWN,
---         AUDIO_FORMAT_U8BIT,
---         AUDIO_FORMAT_16BIT,
---         AUDIO_FORMAT_32BIT,
---         AUDIO_FORMAT_FLOAT,
---         AUDIO_FORMAT_U8BIT_PLANAR,
---         AUDIO_FORMAT_16BIT_PLANAR,
---         AUDIO_FORMAT_32BIT_PLANAR,
---         AUDIO_FORMAT_FLOAT_PLANAR,
--- enum speaker_layout {
---         SPEAKERS_UNKNOWN,
---         SPEAKERS_MONO,
---         SPEAKERS_STEREO,
---         SPEAKERS_2POINT1,
---         SPEAKERS_QUAD,
---         SPEAKERS_4POINT1,
---         SPEAKERS_5POINT1,
---         SPEAKERS_5POINT1_SURROUND,
---         SPEAKERS_7POINT1,
---         SPEAKERS_7POINT1_SURROUND,
---         SPEAKERS_SURROUND,
--- struct audio_convert_info {
---         uint32_t            samples_per_sec;
---         enum audio_format   format;
---         enum speaker_layout speakers;
--- @param output obs_output_t*
--- @param conversion audio_convert_info*
obslua.obs_output_set_audio_conversion = function(output, conversion) end

--- obs_output_set_audio_encoder not documented
obslua.obs_output_set_audio_encoder = function() end

--- void obs_output_set_delay(obs_output_t *output, uint32_t delay_sec, uint32_t flags)
--- Sets the current output delay, in seconds (if the output supports delay)
--- If delay is currently active, it will set the delay value, but will not
--- affect the current delay, it will only affect the next time the output is
--- activated.
--- :param delay_sec: Amount to delay the output, in seconds
--- :param flags:      | Can be 0 or a combination of one of the following values:
---                    | OBS_OUTPUT_DELAY_PRESERVE - On reconnection, start where it left of on reconnection.  Note however that this option will consume extra memory to continually increase delay while waiting to reconnect
--- @param output obs_output_t*
--- @param delay_sec uint32_t
--- @param flags uint32_t
obslua.obs_output_set_delay = function(output, delay_sec, flags) end

--- void obs_output_set_last_error(obs_output_t *output, const char *message)
---            const char *obs_output_get_last_error(obs_output_t *output)
--- Sets/gets the translated error message that is presented to a user in
--- case of disconnection, inability to connect, etc.
--- @param output obs_output_t*
--- @param message char*
obslua.obs_output_set_last_error = function(output, message) end

--- void obs_output_set_media(obs_output_t *output, video_t *video, audio_t *audio)
--- Sets the current video/audio handlers for the output (typically
--- :c:func:`obs_get_video()` and :c:func:`obs_get_audio()`).  Only used
--- with raw outputs so they can catch the raw video/audio frames.
--- @param output obs_output_t*
--- @param video video_t*
--- @param audio audio_t*
obslua.obs_output_set_media = function(output, video, audio) end

--- void obs_output_set_mixer(obs_output_t *output, size_t mixer_idx)
---            size_t obs_output_get_mixer(const obs_output_t *output)
--- Sets/gets the current audio mixer for non-encoded outputs.  For
--- multi-track outputs, this would be the equivalent of setting the mask
--- only for the specified mixer index.
--- @param output obs_output_t*
--- @param mixer_idx size_t
obslua.obs_output_set_mixer = function(output, mixer_idx) end

--- void obs_output_set_mixers(obs_output_t *output, size_t mixers)
---            size_t obs_output_get_mixers(const obs_output_t *output)
--- Sets/gets the current audio mixers (via mask) for non-encoded
--- multi-track outputs.  If used with single-track outputs, the
--- single-track output will use either the first set mixer track in the
--- bitmask, or the first track if none is set in the bitmask.
--- @param output obs_output_t*
--- @param mixers size_t
obslua.obs_output_set_mixers = function(output, mixers) end

--- void obs_output_set_preferred_size(obs_output_t *output, uint32_t width, uint32_t height)
--- Sets the preferred scaled resolution for this output.  Set width and height
--- to 0 to disable scaling.
--- If this output uses an encoder, it will call obs_encoder_set_scaled_size on
--- the encoder before the stream is started.  If the encoder is already active,
--- then this function will trigger a warning and do nothing.
--- @param output obs_output_t*
--- @param width uint32_t
--- @param height uint32_t
obslua.obs_output_set_preferred_size = function(output, width, height) end

--- void obs_output_set_reconnect_settings(obs_output_t *output, int retry_count, int retry_sec)
--- Sets the auto-reconnect settings for outputs that support it.  The
--- retry time will double on each retry to prevent overloading services.
--- :param retry_count: Maximum retry count.  Set to 0 to disable
---                     reconnecting
--- :param retry_sec:   Starting retry wait duration, in seconds
--- @param output obs_output_t*
--- @param retry_count int
--- @param retry_sec int
obslua.obs_output_set_reconnect_settings = function(output, retry_count, retry_sec) end

--- void obs_output_set_service(obs_output_t *output, obs_service_t *service)
---            obs_service_t *obs_output_get_service(const obs_output_t *output)
--- Sets/gets the service for outputs that require services (such as RTMP
--- outputs).  *obs_output_get_service* does not return an incremented
--- reference.
--- @param output obs_output_t*
--- @param service obs_service_t*
obslua.obs_output_set_service = function(output, service) end

--- void obs_output_set_video_conversion(obs_output_t *output, const struct video_scale_info *conversion)
--- Optionally sets the video conversion information.  Only used by raw
--- outputs.
--- Relevant data types used with this function:
--- .. code:: cpp
--- enum video_format {
---         VIDEO_FORMAT_NONE,
---         /* planar 420 format */
---         VIDEO_FORMAT_I420, /* three-plane */
---         VIDEO_FORMAT_NV12, /* two-plane, luma and packed chroma */
---         /* packed 422 formats */
---         VIDEO_FORMAT_YVYU,
---         VIDEO_FORMAT_YUY2, /* YUYV */
---         VIDEO_FORMAT_UYVY,
---         /* packed uncompressed formats */
---         VIDEO_FORMAT_RGBA,
---         VIDEO_FORMAT_BGRA,
---         VIDEO_FORMAT_BGRX,
---         VIDEO_FORMAT_Y800, /* grayscale */
---         /* planar 4:4:4 */
---         VIDEO_FORMAT_I444,
--- enum video_colorspace {
---         VIDEO_CS_DEFAULT,
---         VIDEO_CS_601,
---         VIDEO_CS_709,
---         VIDEO_CS_SRGB,
--- enum video_range_type {
---         VIDEO_RANGE_DEFAULT,
---         VIDEO_RANGE_PARTIAL,
---         VIDEO_RANGE_FULL
--- struct video_scale_info {
---         enum video_format     format;
---         uint32_t              width;
---         uint32_t              height;
---         enum video_range_type range;
---         enum video_colorspace colorspace;
--- @param output obs_output_t*
--- @param conversion video_scale_info*
obslua.obs_output_set_video_conversion = function(output, conversion) end

--- void obs_output_set_video_encoder(obs_output_t *output, obs_encoder_t *encoder)
---            void obs_output_set_audio_encoder(obs_output_t *output, obs_encoder_t *encoder, size_t idx)
--- Sets the video/audio encoders for an encoded output.
--- :param encoder: The video/audio encoder
--- :param idx:     The audio encoder index if the output supports
---                 multiple audio streams at once
--- @param output obs_output_t*
--- @param encoder obs_encoder_t*
obslua.obs_output_set_video_encoder = function(output, encoder) end

--- void obs_output_signal_stop(obs_output_t *output, int code)
--- Ends data capture of an output with an output code, indicating that
--- the output stopped unexpectedly.  This is typically used if for
--- example the server was disconnected for some reason, or if there was
--- an error saving to file.  The output will trigger the "stop" signal
--- with the the desired code to indicate that the output has stopped
--- successfully.  See :ref:`output_signal_handler_reference` for more
--- information on output signals.
--- :c:func:`obs_output_set_last_error()` may be used in conjunction with
--- these error codes to optionally relay more detailed error information
--- to the user
--- :param code: | Can be one of the following values:
---              | OBS_OUTPUT_SUCCESS        - Successfully stopped
---              | OBS_OUTPUT_BAD_PATH       - The specified path was invalid
---              | OBS_OUTPUT_CONNECT_FAILED - Failed to connect to a server
---              | OBS_OUTPUT_INVALID_STREAM - Invalid stream path
---              | OBS_OUTPUT_ERROR          - Generic error
---              | OBS_OUTPUT_DISCONNECTED   - Unexpectedly disconnected
---              | OBS_OUTPUT_UNSUPPORTED    - The settings, video/audio format, or codecs are unsupported by this output
---              | OBS_OUTPUT_NO_SPACE       - Ran out of disk space
--- @param output obs_output_t*
--- @param code int
obslua.obs_output_signal_stop = function(output, code) end

--- bool obs_output_start(obs_output_t *output)
--- Starts the output.
--- :return: *true* if output successfully started, *false* otherwise.  If
---          the output failed to start,
---          :c:func:`obs_output_get_last_error()` may contain a specific
---          error string related to the reason
--- @param output obs_output_t*
--- @return bool
obslua.obs_output_start = function(output) end

--- void obs_output_stop(obs_output_t *output)
--- Requests the output to stop.  The output will wait until all data is
--- sent up until the time the call was made, then when the output has
--- successfully stopped, it will send the "stop" signal.  See
--- :ref:`output_signal_handler_reference` for more information on output
--- signals.
--- @param output obs_output_t*
obslua.obs_output_stop = function(output) end

--- void obs_output_update(obs_output_t *output, obs_data_t *settings)
--- Updates the settings for this output context.
--- @param output obs_output_t*
--- @param settings obs_data_t*
obslua.obs_output_update = function(output, settings) end

--- void obs_post_load_modules(void)
--- Notifies modules that all modules have been loaded.
obslua.obs_post_load_modules = function() end

--- obs_property_t* obs_properties_add_bool(obs_properties_t *props, const char *name, const char *description)
--- Adds a boolean property.
--- :param    name:        Setting identifier string
--- :param    description: Localized name shown to user
--- :return:               The property
--- @param props obs_properties_t*
--- @param name char*
--- @param description char*
--- @return obs_property_t*
obslua.obs_properties_add_bool = function(props, name, description) end

--- obs_property_t* obs_properties_add_button(obs_properties_t *props, const char *name, const char *text, obs_property_clicked_t callback)
--- Adds a button property.  This property does not actually store any
--- settings; it's used to implement a button in user interface if the
--- properties are used to generate user interface.
--- :param    name:        Setting identifier string
--- :param    description: Localized name shown to user
--- :return:               The property
--- Relevant data types used with this function:
--- .. code:: cpp
--- typedef bool (*obs_property_clicked_t)(obs_properties_t *props,
---                 obs_property_t *property, void *data);
--- @param props obs_properties_t*
--- @param name char*
--- @param text char*
--- @param callback obs_property_clicked_t
--- @return obs_property_t*
obslua.obs_properties_add_button = function(props, name, text, callback) end

--- obs_properties_add_button2 not documented
obslua.obs_properties_add_button2 = function() end

--- obs_property_t* obs_properties_add_color(obs_properties_t *props, const char *name, const char *description)
--- Adds a color property.
--- :param    name:        Setting identifier string
--- :param    description: Localized name shown to user
--- :return:               The property
--- @param props obs_properties_t*
--- @param name char*
--- @param description char*
--- @return obs_property_t*
obslua.obs_properties_add_color = function(props, name, description) end

--- obs_property_t* obs_properties_add_editable_list(obs_properties_t *props, const char *name, const char *description, enum obs_editable_list_type type, const char *filter, const char *default_path)
--- Adds a list in which the user can add/insert/remove items.
--- :param    name:         Setting identifier string
--- :param    description:  Localized name shown to user
--- :param    type:         Can be one of the following values:
---                         - **OBS_EDITABLE_LIST_TYPE_STRINGS** - An
---                           editable list of strings.
---                         - **OBS_EDITABLE_LIST_TYPE_FILES** - An
---                           editable list of files.
---                         - **OBS_EDITABLE_LIST_TYPE_FILES_AND_URLS** -
---                           An editable list of files and URLs.
--- :param    filter:       File filter to use if a file list
--- :param    default_path: Default path if a file list
--- :return:                The property
--- @param props obs_properties_t*
--- @param name char*
--- @param description char*
--- @param type obs_editable_list_type
--- @param filter char*
--- @param default_path char*
--- @return obs_property_t*
obslua.obs_properties_add_editable_list = function(props, name, description, type, filter, default_path) end

--- obs_property_t* obs_properties_add_float(obs_properties_t *props, const char *name, const char *description, double min, double max, double step)
--- :param    name:        Setting identifier string
--- :param    description: Localized name shown to user
--- :param    min:         Minimum value
--- :param    max:         Maximum value
--- :param    step:        Step value
--- :return:               The property
--- @param props obs_properties_t*
--- @param name char*
--- @param description char*
--- @param min double
--- @param max double
--- @param step double
--- @return obs_property_t*
obslua.obs_properties_add_float = function(props, name, description, min, max, step) end

--- obs_property_t* obs_properties_add_float_slider(obs_properties_t *props, const char *name, const char *description, double min, double max, double step)
--- :param    name:        Setting identifier string
--- :param    description: Localized name shown to user
--- :param    min:         Minimum value
--- :param    max:         Maximum value
--- :param    step:        Step value
--- :return:               The property
--- @param props obs_properties_t*
--- @param name char*
--- @param description char*
--- @param min double
--- @param max double
--- @param step double
--- @return obs_property_t*
obslua.obs_properties_add_float_slider = function(props, name, description, min, max, step) end

--- obs_property_t* obs_properties_add_font(obs_properties_t *props, const char *name, const char *description)
--- Adds a font property.
--- :param    name:        Setting identifier string
--- :param    description: Localized name shown to user
--- :return:               The property
--- @param props obs_properties_t*
--- @param name char*
--- @param description char*
--- @return obs_property_t*
obslua.obs_properties_add_font = function(props, name, description) end

--- obs_property_t* obs_properties_add_frame_rate(obs_properties_t *props, const char *name, const char *description)
--- Adds a frame rate property.
--- :param    name:        Setting identifier string
--- :param    description: Localized name shown to user
--- :return:               The property
--- Important Related Functions:
--- - :c:func:`obs_property_frame_rate_option_add`
--- - :c:func:`obs_property_frame_rate_fps_range_add`
--- - :c:func:`obs_property_frame_rate_option_insert`
--- - :c:func:`obs_property_frame_rate_fps_range_insert`
--- @param props obs_properties_t*
--- @param name char*
--- @param description char*
--- @return obs_property_t*
obslua.obs_properties_add_frame_rate = function(props, name, description) end

--- obs_property_t* obs_properties_add_group(obs_properties_t *props, const char *name, const char *description, enum obs_group_type type, obs_properties_t *group)
--- Adds a property group.
--- :param    name:        Setting identifier string
--- :param    description: Localized name shown to user
--- :param    type:        Can be one of the following values:
---                        - **OBS_GROUP_NORMAL** - A normal group with just a name and content.
---                        - **OBS_GROUP_CHECKABLE** - A checkable group with a checkbox, name and content.
--- :param    group:       Group to add
--- :return:               The property
--- Important Related Functions:
--- - :c:func:`obs_property_group_type`
--- - :c:func:`obs_property_group_content`
--- - :c:func:`obs_properties_get_parent`
--- Property Enumeration Functions
--- @param props obs_properties_t*
--- @param name char*
--- @param description char*
--- @param type obs_group_type
--- @param group obs_properties_t*
--- @return obs_property_t*
obslua.obs_properties_add_group = function(props, name, description, type, group) end

--- obs_property_t* obs_properties_add_int(obs_properties_t *props, const char *name, const char *description, int min, int max, int step)
--- Adds an integer property.
--- :param    name:        Setting identifier string
--- :param    description: Localized name shown to user
--- :param    min:         Minimum value
--- :param    max:         Maximum value
--- :param    step:        Step value
--- :return:               The property
--- @param props obs_properties_t*
--- @param name char*
--- @param description char*
--- @param min int
--- @param max int
--- @param step int
--- @return obs_property_t*
obslua.obs_properties_add_int = function(props, name, description, min, max, step) end

--- obs_property_t* obs_properties_add_int_slider(obs_properties_t *props, const char *name, const char *description, int min, int max, int step)
--- :param    name:        Setting identifier string
--- :param    description: Localized name shown to user
--- :param    min:         Minimum value
--- :param    max:         Maximum value
--- :param    step:        Step value
--- :return:               The property
--- @param props obs_properties_t*
--- @param name char*
--- @param description char*
--- @param min int
--- @param max int
--- @param step int
--- @return obs_property_t*
obslua.obs_properties_add_int_slider = function(props, name, description, min, max, step) end

--- obs_property_t* obs_properties_add_list(obs_properties_t *props, const char *name, const char *description, enum obs_combo_type type, enum obs_combo_format format)
--- Adds an integer/string/floating point item list.  This would be
--- implemented as a combo box in user interface.
--- :param    name:        Setting identifier string
--- :param    description: Localized name shown to user
--- :param    type:        Can be one of the following values:
---                        - **OBS_COMBO_TYPE_EDITABLE** - Can be edited.
---                          Only used with string lists.
---                        - **OBS_COMBO_TYPE_LIST** - Not editable.
--- :param    format:      Can be one of the following values:
---                        - **OBS_COMBO_FORMAT_INT** - Integer list
---                        - **OBS_COMBO_FORMAT_FLOAT** - Floating point
---                          list
---                        - **OBS_COMBO_FORMAT_STRING** - String list
--- :return:               The property
--- Important Related Functions:
--- - :c:func:`obs_property_list_add_string`
--- - :c:func:`obs_property_list_add_int`
--- - :c:func:`obs_property_list_add_float`
--- - :c:func:`obs_property_list_insert_string`
--- - :c:func:`obs_property_list_insert_int`
--- - :c:func:`obs_property_list_insert_float`
--- - :c:func:`obs_property_list_item_remove`
--- - :c:func:`obs_property_list_clear`
--- @param props obs_properties_t*
--- @param name char*
--- @param description char*
--- @param type obs_combo_type
--- @param format obs_combo_format
--- @return obs_property_t*
obslua.obs_properties_add_list = function(props, name, description, type, format) end

--- obs_property_t* obs_properties_add_path(obs_properties_t *props, const char *name, const char *description, enum obs_path_type type, const char *filter, const char *default_path)
--- Adds a 'path' property.  Can be a directory or a file.
--- If target is a file path, the filters should be this format, separated by
--- double semi-colens, and extensions separated by space::
---   "Example types 1 and 2 (*.ex1 *.ex2);;Example type 3 (*.ex3)"
--- :param    name:         Setting identifier string
--- :param    description:  Localized name shown to user
--- :param    type:         Can be one of the following values:
---                         - **OBS_PATH_FILE** - File (for reading)
---                         - **OBS_PATH_FILE_SAVE** - File (for writing)
---                         - **OBS_PATH_DIRECTORY** - Directory
--- :param    filter:       If type is a file path, then describes the file filter
---                         that the user can browse.  Items are separated via
---                         double semi-colens.  If multiple file types in a
---                         filter, separate with space.
--- :param    default_path: The default path to start in, or *NULL*
--- :return:                The property
--- @param props obs_properties_t*
--- @param name char*
--- @param description char*
--- @param type obs_path_type
--- @param filter char*
--- @param default_path char*
--- @return obs_property_t*
obslua.obs_properties_add_path = function(props, name, description, type, filter, default_path) end

--- obs_property_t* obs_properties_add_text(obs_properties_t *props, const char *name, const char *description, enum obs_text_type type)
--- :param    name:        Setting identifier string
--- :param    description: Localized name shown to user
--- :param    type:        Can be one of the following values:
---                        - **OBS_TEXT_DEFAULT** - Single line of text
---                        - **OBS_TEXT_PASSWORD** - Single line of text (passworded)
---                        - **OBS_TEXT_MULTILINE** - Multi-line text
--- :return:               The property
--- @param props obs_properties_t*
--- @param name char*
--- @param description char*
--- @param type obs_text_type
--- @return obs_property_t*
obslua.obs_properties_add_text = function(props, name, description, type) end

--- void obs_properties_apply_settings(obs_properties_t *props, obs_data_t *settings)
--- Applies settings to the properties by calling all the necessary
--- modification callbacks
--- @param props obs_properties_t*
--- @param settings obs_data_t*
obslua.obs_properties_apply_settings = function(props, settings) end

--- obs_properties_t* obs_properties_create(void)
--- :return: A new properties object.
--- @return obs_properties_t*
obslua.obs_properties_create = function() end

--- obs_properties_create_param not documented
obslua.obs_properties_create_param = function() end

--- void obs_properties_destroy(obs_properties_t *props)
--- @param props obs_properties_t*
obslua.obs_properties_destroy = function(props) end

--- obs_property_t* obs_properties_first(obs_properties_t *props)
--- :return: The first property in the properties object.
--- @param props obs_properties_t*
--- @return obs_property_t*
obslua.obs_properties_first = function(props) end

--- obs_property_t* obs_properties_get(obs_properties_t *props, const char *property)
--- :param property: The name of the property to get
--- :return:         A specific property or *NULL* if not found
--- @param props obs_properties_t*
--- @param property char*
--- @return obs_property_t*
obslua.obs_properties_get = function(props, property) end

--- obs_properties_get_flags not documented
obslua.obs_properties_get_flags = function() end

--- obs_properties_get_param not documented
obslua.obs_properties_get_param = function() end

--- obs_properties_t* obs_properties_get_parent(obs_properties_t *props)
--- Property Object Functions
--- @param props obs_properties_t*
--- @return obs_properties_t*
obslua.obs_properties_get_parent = function(props) end

--- obs_properties_remove_by_name not documented
obslua.obs_properties_remove_by_name = function() end

--- void obs_properties_set_flags(obs_properties_t *props, uint32_t flags)
---            uint32_t obs_properties_get_flags(obs_properties_t *props)
--- :param flags: 0 or a bitwise OR combination of one of the following
---               values:
---               - OBS_PROPERTIES_DEFER_UPDATE - A hint that tells the
---                 front-end to defers updating the settings until the
---                 user has finished editing all properties rather than
---                 immediately updating any settings
--- @param props obs_properties_t*
--- @param flags uint32_t
obslua.obs_properties_set_flags = function(props, flags) end

--- obs_properties_set_param not documented
obslua.obs_properties_set_param = function() end

--- bool obs_property_button_clicked(obs_property_t *p, void *obj)
--- @param p obs_property_t*
--- @param obj void*
--- @return bool
obslua.obs_property_button_clicked = function(p, obj) end

--- obs_property_description not documented
obslua.obs_property_description = function() end

--- obs_property_editable_list_default_path not documented
obslua.obs_property_editable_list_default_path = function() end

--- obs_property_editable_list_filter not documented
obslua.obs_property_editable_list_filter = function() end

--- obs_property_editable_list_type not documented
obslua.obs_property_editable_list_type = function() end

--- bool obs_property_enabled(obs_property_t *p)
--- @param p obs_property_t*
--- @return bool
obslua.obs_property_enabled = function(p) end

--- double obs_property_float_max(obs_property_t *p)
--- @param p obs_property_t*
--- @return double
obslua.obs_property_float_max = function(p) end

--- double obs_property_float_min(obs_property_t *p)
--- @param p obs_property_t*
--- @return double
obslua.obs_property_float_min = function(p) end

--- void obs_property_float_set_limits(obs_property_t *p, double min, double max, double step)
--- @param p obs_property_t*
--- @param min double
--- @param max double
--- @param step double
obslua.obs_property_float_set_limits = function(p, min, max, step) end

--- obs_property_float_set_suffix not documented
obslua.obs_property_float_set_suffix = function() end

--- double obs_property_float_step(obs_property_t *p)
--- @param p obs_property_t*
--- @return double
obslua.obs_property_float_step = function(p) end

--- obs_property_float_suffix not documented
obslua.obs_property_float_suffix = function() end

--- obs_property_float_type not documented
obslua.obs_property_float_type = function() end

--- void obs_property_frame_rate_clear(obs_property_t *p)
--- @param p obs_property_t*
obslua.obs_property_frame_rate_clear = function(p) end

--- size_t obs_property_frame_rate_fps_range_add(obs_property_t *p, struct media_frames_per_second min, struct media_frames_per_second max)
--- @param p obs_property_t*
--- @param min media_frames_per_second
--- @param max media_frames_per_second
--- @return size_t
obslua.obs_property_frame_rate_fps_range_add = function(p, min, max) end

--- void obs_property_frame_rate_fps_range_insert(obs_property_t *p, size_t idx, struct media_frames_per_second min, struct media_frames_per_second max)
--- @param p obs_property_t*
--- @param idx size_t
--- @param min media_frames_per_second
--- @param max media_frames_per_second
obslua.obs_property_frame_rate_fps_range_insert = function(p, idx, min, max) end

--- obs_property_frame_rate_fps_range_max not documented
obslua.obs_property_frame_rate_fps_range_max = function() end

--- obs_property_frame_rate_fps_range_min not documented
obslua.obs_property_frame_rate_fps_range_min = function() end

--- void obs_property_frame_rate_fps_ranges_clear(obs_property_t *p)
--- @param p obs_property_t*
obslua.obs_property_frame_rate_fps_ranges_clear = function(p) end

--- size_t obs_property_frame_rate_fps_ranges_count(obs_property_t *p)
--- @param p obs_property_t*
--- @return size_t
obslua.obs_property_frame_rate_fps_ranges_count = function(p) end

--- size_t obs_property_frame_rate_option_add(obs_property_t *p, const char *name, const char *description)
--- @param p obs_property_t*
--- @param name char*
--- @param description char*
--- @return size_t
obslua.obs_property_frame_rate_option_add = function(p, name, description) end

--- obs_property_frame_rate_option_description not documented
obslua.obs_property_frame_rate_option_description = function() end

--- void obs_property_frame_rate_option_insert(obs_property_t *p, size_t idx, const char *name, const char *description)
--- @param p obs_property_t*
--- @param idx size_t
--- @param name char*
--- @param description char*
obslua.obs_property_frame_rate_option_insert = function(p, idx, name, description) end

--- obs_property_frame_rate_option_name not documented
obslua.obs_property_frame_rate_option_name = function() end

--- void obs_property_frame_rate_options_clear(obs_property_t *p)
--- @param p obs_property_t*
obslua.obs_property_frame_rate_options_clear = function(p) end

--- size_t obs_property_frame_rate_options_count(obs_property_t *p)
--- @param p obs_property_t*
--- @return size_t
obslua.obs_property_frame_rate_options_count = function(p) end

--- obs_property_get_type not documented
obslua.obs_property_get_type = function() end

--- obs_properties_t* obs_property_group_content(obs_property_t *p)
--- Property Modification Functions
--- @param p obs_property_t*
--- @return obs_properties_t*
obslua.obs_property_group_content = function(p) end

--- obs_property_group_type not documented
obslua.obs_property_group_type = function() end

--- int obs_property_int_max(obs_property_t *p)
--- @param p obs_property_t*
--- @return int
obslua.obs_property_int_max = function(p) end

--- int obs_property_int_min(obs_property_t *p)
--- @param p obs_property_t*
--- @return int
obslua.obs_property_int_min = function(p) end

--- void obs_property_int_set_limits(obs_property_t *p, int min, int max, int step)
--- @param p obs_property_t*
--- @param min int
--- @param max int
--- @param step int
obslua.obs_property_int_set_limits = function(p, min, max, step) end

--- obs_property_int_set_suffix not documented
obslua.obs_property_int_set_suffix = function() end

--- int obs_property_int_step(obs_property_t *p)
--- @param p obs_property_t*
--- @return int
obslua.obs_property_int_step = function(p) end

--- obs_property_int_suffix not documented
obslua.obs_property_int_suffix = function() end

--- obs_property_int_type not documented
obslua.obs_property_int_type = function() end

--- size_t obs_property_list_add_float(obs_property_t *p, const char *name, double val)
--- Adds a floating point to a floating point list.
--- @param p obs_property_t*
--- @param name char*
--- @param val double
--- @return size_t
obslua.obs_property_list_add_float = function(p, name, val) end

--- size_t obs_property_list_add_int(obs_property_t *p, const char *name, long long val)
--- Adds an integer to a integer list.
--- @param p obs_property_t*
--- @param name char*
--- @param val longlong
--- @return size_t
obslua.obs_property_list_add_int = function(p, name, val) end

--- size_t obs_property_list_add_string(obs_property_t *p, const char *name, const char *val)
--- Adds a string to a string list.
--- @param p obs_property_t*
--- @param name char*
--- @param val char*
--- @return size_t
obslua.obs_property_list_add_string = function(p, name, val) end

--- void obs_property_list_clear(obs_property_t *p)
--- @param p obs_property_t*
obslua.obs_property_list_clear = function(p) end

--- obs_property_list_format not documented
obslua.obs_property_list_format = function() end

--- void obs_property_list_insert_float(obs_property_t *p, size_t idx, const char *name, double val)
--- Inserts a floating point in to a floating point list.
--- @param p obs_property_t*
--- @param idx size_t
--- @param name char*
--- @param val double
obslua.obs_property_list_insert_float = function(p, idx, name, val) end

--- void obs_property_list_insert_int(obs_property_t *p, size_t idx, const char *name, long long val)
--- Inserts an integer in to an integer list.
--- @param p obs_property_t*
--- @param idx size_t
--- @param name char*
--- @param val longlong
obslua.obs_property_list_insert_int = function(p, idx, name, val) end

--- void obs_property_list_insert_string(obs_property_t *p, size_t idx, const char *name, const char *val)
--- Inserts a string in to a string list.
--- @param p obs_property_t*
--- @param idx size_t
--- @param name char*
--- @param val char*
obslua.obs_property_list_insert_string = function(p, idx, name, val) end

--- size_t obs_property_list_item_count(obs_property_t *p)
--- @param p obs_property_t*
--- @return size_t
obslua.obs_property_list_item_count = function(p) end

--- void obs_property_list_item_disable(obs_property_t *p, size_t idx, bool disabled)
--- @param p obs_property_t*
--- @param idx size_t
--- @param disabled bool
obslua.obs_property_list_item_disable = function(p, idx, disabled) end

--- bool obs_property_list_item_disabled(obs_property_t *p, size_t idx)
--- @param p obs_property_t*
--- @param idx size_t
--- @return bool
obslua.obs_property_list_item_disabled = function(p, idx) end

--- double obs_property_list_item_float(obs_property_t *p, size_t idx)
--- @param p obs_property_t*
--- @param idx size_t
--- @return double
obslua.obs_property_list_item_float = function(p, idx) end

--- obs_property_list_item_int not documented
obslua.obs_property_list_item_int = function() end

--- obs_property_list_item_name not documented
obslua.obs_property_list_item_name = function() end

--- void obs_property_list_item_remove(obs_property_t *p, size_t idx)
--- @param p obs_property_t*
--- @param idx size_t
obslua.obs_property_list_item_remove = function(p, idx) end

--- obs_property_list_item_string not documented
obslua.obs_property_list_item_string = function() end

--- obs_property_list_type not documented
obslua.obs_property_list_type = function() end

--- obs_property_long_description not documented
obslua.obs_property_long_description = function() end

--- bool obs_property_modified(obs_property_t *p, obs_data_t *settings)
--- @param p obs_property_t*
--- @param settings obs_data_t*
--- @return bool
obslua.obs_property_modified = function(p, settings) end

--- obs_property_name not documented
obslua.obs_property_name = function() end

--- bool obs_property_next(obs_property_t **p)
--- :param p: Pointer to the pointer of the next property
--- :return: *true* if successful, *false* if no more properties
--- @param p obs_property_t**
--- @return bool
obslua.obs_property_next = function(p) end

--- obs_property_path_default_path not documented
obslua.obs_property_path_default_path = function() end

--- obs_property_path_filter not documented
obslua.obs_property_path_filter = function() end

--- obs_property_path_type not documented
obslua.obs_property_path_type = function() end

--- void obs_property_set_description(obs_property_t *p, const char *description)
--- Sets the displayed localized name of the property, shown to the user.
--- @param p obs_property_t*
--- @param description char*
obslua.obs_property_set_description = function(p, description) end

--- void obs_property_set_enabled(obs_property_t *p, bool enabled)
--- @param p obs_property_t*
--- @param enabled bool
obslua.obs_property_set_enabled = function(p, enabled) end

--- void obs_property_set_long_description(obs_property_t *p, const char *long_description)
--- Sets the localized long description of the property, usually shown to
--- a user via tooltip.
--- @param p obs_property_t*
--- @param long_description char*
obslua.obs_property_set_long_description = function(p, long_description) end

--- void obs_property_set_modified_callback(obs_property_t *p, obs_property_modified_t modified)
---            void obs_property_set_modified_callback2(obs_property_t *p, obs_property_modified2_t modified2, void *priv)
--- Allows the ability to change the properties depending on what
--- settings are used by the user.
--- Relevant data types used with these functions:
--- .. code:: cpp
--- typedef bool (*obs_property_modified_t)(obs_properties_t *props,
---                 obs_property_t *property, obs_data_t *settings);
--- typedef bool (*obs_property_modified2_t)(void *priv,
---                 obs_properties_t *props, obs_property_t *property,
---                 obs_data_t *settings);
--- @param p obs_property_t*
--- @param modified obs_property_modified_t
obslua.obs_property_set_modified_callback = function(p, modified) end

--- obs_property_set_modified_callback2 not documented
obslua.obs_property_set_modified_callback2 = function() end

--- void obs_property_set_visible(obs_property_t *p, bool visible)
--- @param p obs_property_t*
--- @param visible bool
obslua.obs_property_set_visible = function(p, visible) end

--- obs_property_text_monospace not documented
obslua.obs_property_text_monospace = function() end

--- obs_property_text_set_monospace not documented
obslua.obs_property_text_set_monospace = function() end

--- obs_property_text_type not documented
obslua.obs_property_text_type = function() end

--- bool obs_property_visible(obs_property_t *p)
--- @param p obs_property_t*
--- @return bool
obslua.obs_property_visible = function(p) end

--- obs_queue_task not documented
obslua.obs_queue_task = function() end

--- void obs_register_source(struct obs_source_info *info)
--- Registers a source type.  Typically used in
--- :c:func:`obs_module_load()` or in the program's initialization phase.
--- @param info obs_source_info*
obslua.obs_register_source = function(info) end

--- obs_remove_data_path not documented
obslua.obs_remove_data_path = function() end

--- obs_remove_main_render_callback not documented
obslua.obs_remove_main_render_callback = function() end

--- obs_remove_raw_video_callback not documented
obslua.obs_remove_raw_video_callback = function() end

--- obs_remove_tick_callback not documented
obslua.obs_remove_tick_callback = function() end

--- void obs_render_main_texture(void)
--- Renders the main output texture.  Useful for rendering a preview pane
--- of the main output.
obslua.obs_render_main_texture = function() end

--- obs_render_main_texture_src_color_only not documented
obslua.obs_render_main_texture_src_color_only = function() end

--- bool obs_reset_audio(const struct obs_audio_info *oai)
--- Sets base audio output format/channels/samples/etc.
--- Note: Cannot reset base audio if an output is currently active.
--- :return: *true* if successful, *false* otherwise
--- Relevant data types used with this function:
--- .. code:: cpp
--- struct obs_audio_info {
---         uint32_t            samples_per_sec;
---         enum speaker_layout speakers;
--- @param oai obs_audio_info*
--- @return bool
obslua.obs_reset_audio = function(oai) end

--- int obs_reset_video(struct obs_video_info *ovi)
--- Sets base video output base resolution/fps/format.
--- Note: This data cannot be changed if an output is currently active.
--- Note: The graphics module cannot be changed without fully destroying
--- the OBS context.
--- :param   ovi: Pointer to an obs_video_info structure containing the
---               specification of the graphics subsystem,
--- :return:      | OBS_VIDEO_SUCCESS          - Success
---               | OBS_VIDEO_NOT_SUPPORTED    - The adapter lacks capabilities
---               | OBS_VIDEO_INVALID_PARAM    - A parameter is invalid
---               | OBS_VIDEO_CURRENTLY_ACTIVE - Video is currently active
---               | OBS_VIDEO_MODULE_NOT_FOUND - The graphics module is not found
---               | OBS_VIDEO_FAIL             - Generic failure
--- Relevant data types used with this function:
--- .. code:: cpp
--- struct obs_video_info {
---          * Graphics module to use (usually "libobs-opengl" or "libobs-d3d11")
---         const char          *graphics_module;
---         uint32_t            fps_num;       /**< Output FPS numerator */
---         uint32_t            fps_den;       /**< Output FPS denominator */
---         uint32_t            base_width;    /**< Base compositing width */
---         uint32_t            base_height;   /**< Base compositing height */
---         uint32_t            output_width;  /**< Output width */
---         uint32_t            output_height; /**< Output height */
---         enum video_format   output_format; /**< Output format */
---         /** Video adapter index to use (NOTE: avoid for optimus laptops) */
---         uint32_t            adapter;
---         /** Use shaders to convert to different color formats */
---         bool                gpu_conversion;
---         enum video_colorspace colorspace;  /**< YUV type (if YUV) */
---         enum video_range_type range;       /**< YUV range (if YUV) */
---         enum obs_scale_type scale_type;    /**< How to scale if scaling */
--- @param ovi obs_video_info*
--- @return int
obslua.obs_reset_video = function(ovi) end

--- obs_data_t* obs_save_source(obs_source_t *source)
--- :return: A new reference to a source's saved data
--- @param source obs_source_t*
--- @return obs_data_t*
obslua.obs_save_source = function(source) end

--- obs_data_array_t* obs_save_sources(void)
--- :return: A data array with the saved data of all active sources
--- @return obs_data_array_t*
obslua.obs_save_sources = function() end

--- obs_data_array_t* obs_save_sources_filtered(obs_save_source_filter_cb cb, void *data)
--- :return: A data array with the saved data of all active sources,
---          filtered by the *cb* function
--- Relevant data types used with this function:
--- .. code:: cpp
--- typedef bool (*obs_save_source_filter_cb)(void *data, obs_source_t *source);
--- Video, Audio, and Graphics
--- @param cb obs_save_source_filter_cb
--- @param data void*
--- @return obs_data_array_t*
obslua.obs_save_sources_filtered = function(cb, data) end

--- obs_sceneitem_t* obs_scene_add(obs_scene_t *scene, obs_source_t *source)
--- :return: A new scene item for a source within a scene.  Does not
---          increment the reference
--- @param scene obs_scene_t*
--- @param source obs_source_t*
--- @return obs_sceneitem_t*
obslua.obs_scene_add = function(scene, source) end

--- obs_sceneitem_t* obs_scene_add_group(obs_scene_t *scene, const char *name)
--- Adds a group with the specified name.  Does not signal the scene with
--- the *refresh* signal.
--- :param scene: Scene to add the group to
--- :param name:  Name of the group
--- :return:      The new group's scene item
--- @param scene obs_scene_t*
--- @param name char*
--- @return obs_sceneitem_t*
obslua.obs_scene_add_group = function(scene, name) end

--- obs_sceneitem_t* obs_scene_add_group2(obs_scene_t *scene, const char *name, bool signal)
--- Adds a group with the specified name.
--- :param scene:  Scene to add the group to
--- :param name:   Name of the group
--- :param signal: If *true*, signals the scene with the *refresh*
---                signal
--- :return:       The new group's scene item
--- @param scene obs_scene_t*
--- @param name char*
--- @param signal bool
--- @return obs_sceneitem_t*
obslua.obs_scene_add_group2 = function(scene, name, signal) end

--- void obs_scene_addref(obs_scene_t *scene)
---            void obs_scene_release(obs_scene_t *scene)
--- Adds/releases a reference to a scene.
--- @param scene obs_scene_t*
obslua.obs_scene_addref = function(scene) end

--- obs_scene_atomic_update not documented
obslua.obs_scene_atomic_update = function() end

--- obs_scene_t* obs_scene_create(const char *name)
--- :param name: Name of the scene source.  If it's not unique, it will
---              be made unique
--- :return:     A reference to a scene
--- @param name char*
--- @return obs_scene_t*
obslua.obs_scene_create = function(name) end

--- obs_scene_t* obs_scene_create_private(const char *name)
--- :param name: Name of the scene source.  Does not have to be unique,
---              or can be *NULL*
--- :return:     A reference to a private scene
--- @param name char*
--- @return obs_scene_t*
obslua.obs_scene_create_private = function(name) end

--- obs_scene_t* obs_scene_duplicate(obs_scene_t *scene, const char *name, enum obs_scene_duplicate_type type)
--- Duplicates a scene.  When a scene is duplicated, its sources can be
--- just referenced, or fully duplicated.
--- :param name: Name of the new scene source
--- :param type:  | Type of duplication:
---               | OBS_SCENE_DUP_REFS         - Duplicates the scene, but scene items are only duplicated with references
---               | OBS_SCENE_DUP_COPY         - Duplicates the scene, and scene items are also fully duplicated when possible
---               | OBS_SCENE_DUP_PRIVATE_REFS - Duplicates with references, but the scene is a private source
---               | OBS_SCENE_DUP_PRIVATE_COPY - Fully duplicates scene items when possible, but the scene and duplicates sources are private sources
--- :return:     A reference to a new scene
--- @param scene obs_scene_t*
--- @param name char*
--- @param type obs_scene_duplicate_type
--- @return obs_scene_t*
obslua.obs_scene_duplicate = function(scene, name, type) end

--- obs_scene_enum_items not documented
obslua.obs_scene_enum_items = function() end

--- obs_sceneitem_t* obs_scene_find_sceneitem_by_id(obs_scene_t *scene, int64_t id)
--- :param id: The unique numeric identifier of the scene item
--- :return:   The scene item if found, otherwise *NULL* if not found
--- @param scene obs_scene_t*
--- @param id int64_t
--- @return obs_sceneitem_t*
obslua.obs_scene_find_sceneitem_by_id = function(scene, id) end

--- obs_sceneitem_t* obs_scene_find_source(obs_scene_t *scene, const char *name)
--- :param name: The name of the source to find
--- :return:     The scene item if found, otherwise *NULL* if not found
--- @param scene obs_scene_t*
--- @param name char*
--- @return obs_sceneitem_t*
obslua.obs_scene_find_source = function(scene, name) end

--- obs_sceneitem_t* obs_scene_find_source_recursive(obs_scene_t *scene, const char *name)
--- Same as obs_scene_find_source, but also searches groups within the
--- scene.
--- :param name: The name of the source to find
--- :return:     The scene item if found, otherwise *NULL* if not found
--- @param scene obs_scene_t*
--- @param name char*
--- @return obs_sceneitem_t*
obslua.obs_scene_find_source_recursive = function(scene, name) end

--- obs_scene_t* obs_scene_from_source(const obs_source_t *source)
--- :return: The scene context, or *NULL* if not a scene.  Does not
---          increase the reference
--- @param source obs_source_t*
--- @return obs_scene_t*
obslua.obs_scene_from_source = function(source) end

--- obs_sceneitem_t* obs_scene_get_group(obs_scene_t *scene, const char *name)
--- Finds a group within a scene by its name.
--- :param scene: Scene to find the group within
--- :param name:  The name of the group to find
--- :return:      The group scene item, or *NULL* if not found
--- @param scene obs_scene_t*
--- @param name char*
--- @return obs_sceneitem_t*
obslua.obs_scene_get_group = function(scene, name) end

--- obs_source_t* obs_scene_get_source(const obs_scene_t *scene)
--- :return: The scene's source.  Does not increment the reference
--- @param scene obs_scene_t*
--- @return obs_source_t*
obslua.obs_scene_get_source = function(scene) end

--- obs_sceneitem_t* obs_scene_insert_group(obs_scene_t *scene, const char *name, obs_sceneitem_t **items, size_t count)
--- Creates a group out of the specified scene items.  The group will be
--- inserted at the top scene item.  Does not signal the scene with the
--- *refresh* signal.
--- :param scene: Scene to add the group to
--- :param name:  Name of the group
--- :param items: Array of scene items to put in a group
--- :param count: Number of scene items in the array
--- :return:      The new group's scene item
--- @param scene obs_scene_t*
--- @param name char*
--- @param items obs_sceneitem_t**
--- @param count size_t
--- @return obs_sceneitem_t*
obslua.obs_scene_insert_group = function(scene, name, items, count) end

--- obs_sceneitem_t* obs_scene_insert_group2(obs_scene_t *scene, const char *name, obs_sceneitem_t **items, size_t count, bool signal)
--- Creates a group out of the specified scene items.  The group will be
--- inserted at the top scene item.  Does not signal a refresh.
--- :param scene: Scene to add the group to
--- :param name:  Name of the group
--- :param items: Array of scene items to put in a group
--- :param count: Number of scene items in the array
--- :param signal: If *true*, signals the scene with the *refresh*
---                signal
--- :return:      The new group's scene item
--- @param scene obs_scene_t*
--- @param name char*
--- @param items obs_sceneitem_t**
--- @param count size_t
--- @param signal bool
--- @return obs_sceneitem_t*
obslua.obs_scene_insert_group2 = function(scene, name, items, count, signal) end

--- obs_scene_is_group not documented
obslua.obs_scene_is_group = function() end

--- obs_scene_release not documented
obslua.obs_scene_release = function() end

--- bool obs_scene_reorder_items(obs_scene_t *scene, obs_sceneitem_t * const *item_order, size_t item_order_size)
--- Reorders items within a scene.
--- @param scene obs_scene_t*
--- @param item_order obs_sceneitem_t*const*
--- @param item_order_size size_t
--- @return bool
obslua.obs_scene_reorder_items = function(scene, item_order, item_order_size) end

--- bool obs_scene_reorder_items2(obs_scene_t *scene, struct obs_sceneitem_order_info *item_order, size_t item_order_size)
--- Reorders items within a scene with groups and group sub-items.
--- .. _scene_item_reference:
--- Scene Item Functions
--- @param scene obs_scene_t*
--- @param item_order obs_sceneitem_order_info*
--- @param item_order_size size_t
--- @return bool
obslua.obs_scene_reorder_items2 = function(scene, item_order, item_order_size) end

--- void obs_sceneitem_addref(obs_sceneitem_t *item)
---            void obs_sceneitem_release(obs_sceneitem_t *item)
--- Adds/releases a reference to a scene item.
--- @param item obs_sceneitem_t*
obslua.obs_sceneitem_addref = function(item) end

--- void obs_sceneitem_defer_group_resize_begin(obs_sceneitem_t *item)
--- @param item obs_sceneitem_t*
obslua.obs_sceneitem_defer_group_resize_begin = function(item) end

--- void obs_sceneitem_defer_group_resize_end(obs_sceneitem_t *item)
--- Allows the ability to call any one of the transform functions on
--- scene items within a group without updating the internal matrices of
--- the group until obs_sceneitem_defer_group_resize_end has been called.
--- This is necessary if the user is resizing items while they are within
--- a group, as the group's transform will automatically update its
--- transform every frame otherwise.
--- @param item obs_sceneitem_t*
obslua.obs_sceneitem_defer_group_resize_end = function(item) end

--- void obs_sceneitem_defer_update_begin(obs_sceneitem_t *item)
---            void obs_sceneitem_defer_update_end(obs_sceneitem_t *item)
--- Allows the ability to call any one of the transform functions without
--- updating the internal matrices until obs_sceneitem_defer_update_end
--- has been called.
--- @param item obs_sceneitem_t*
obslua.obs_sceneitem_defer_update_begin = function(item) end

--- obs_sceneitem_defer_update_end not documented
obslua.obs_sceneitem_defer_update_end = function() end

--- obs_sceneitem_force_update_transform not documented
obslua.obs_sceneitem_force_update_transform = function() end

--- obs_sceneitem_get_alignment not documented
obslua.obs_sceneitem_get_alignment = function() end

--- obs_sceneitem_get_bounds not documented
obslua.obs_sceneitem_get_bounds = function() end

--- obs_sceneitem_get_bounds_alignment not documented
obslua.obs_sceneitem_get_bounds_alignment = function() end

--- obs_sceneitem_get_bounds_type not documented
obslua.obs_sceneitem_get_bounds_type = function() end

--- obs_sceneitem_get_box_scale not documented
obslua.obs_sceneitem_get_box_scale = function() end

--- void obs_sceneitem_get_box_transform(const obs_sceneitem_t *item, struct matrix4 *transform)
--- Gets the transform matrix of the scene item used for the bounding box
--- or edges of the scene item.
--- @param item obs_sceneitem_t*
--- @param transform matrix4*
obslua.obs_sceneitem_get_box_transform = function(item, transform) end

--- obs_sceneitem_get_crop not documented
obslua.obs_sceneitem_get_crop = function() end

--- void obs_sceneitem_get_draw_transform(const obs_sceneitem_t *item, struct matrix4 *transform)
--- Gets the transform matrix of the scene item used for drawing the
--- source.
--- @param item obs_sceneitem_t*
--- @param transform matrix4*
obslua.obs_sceneitem_get_draw_transform = function(item, transform) end

--- obs_sceneitem_t* obs_sceneitem_get_group(obs_sceneitem_t *item)
--- Returns the parent group of a scene item.
--- :param item: Scene item to get the group of
--- :return:     The parent group of the scene item, or *NULL* if not in
---              a group
--- @param item obs_sceneitem_t*
--- @return obs_sceneitem_t*
obslua.obs_sceneitem_get_group = function(item) end

--- int64_t obs_sceneitem_get_id(const obs_sceneitem_t *item)
--- :return: The unique numeric identifier of the scene item.
--- @param item obs_sceneitem_t*
--- @return int64_t
obslua.obs_sceneitem_get_id = function(item) end

--- obs_sceneitem_get_info not documented
obslua.obs_sceneitem_get_info = function() end

--- obs_sceneitem_get_pos not documented
obslua.obs_sceneitem_get_pos = function() end

--- obs_data_t* obs_sceneitem_get_private_settings(obs_sceneitem_t *item)
--- :return: An incremented reference to the private settings of the
---          scene item.  Allows the front-end to set custom information
---          which is saved with the scene item
--- .. _scene_item_group_reference:
--- Scene Item Group Functions
--- @param item obs_sceneitem_t*
--- @return obs_data_t*
obslua.obs_sceneitem_get_private_settings = function(item) end

--- obs_sceneitem_get_rot not documented
obslua.obs_sceneitem_get_rot = function() end

--- obs_sceneitem_get_scale not documented
obslua.obs_sceneitem_get_scale = function() end

--- obs_sceneitem_get_scale_filter not documented
obslua.obs_sceneitem_get_scale_filter = function() end

--- obs_scene_t* obs_sceneitem_get_scene(const obs_sceneitem_t *item)
--- :return: The scene associated with the scene item.  Does not
---          increment the reference
--- @param item obs_sceneitem_t*
--- @return obs_scene_t*
obslua.obs_sceneitem_get_scene = function(item) end

--- obs_source_t* obs_sceneitem_get_source(const obs_sceneitem_t *item)
--- :return: The source associated with the scene item.  Does not
---          increment the reference
--- @param item obs_sceneitem_t*
--- @return obs_source_t*
obslua.obs_sceneitem_get_source = function(item) end

--- void obs_sceneitem_group_add_item(obs_sceneitem_t *group, obs_sceneitem_t *item)
--- Adds a scene item to a group.
--- @param group obs_sceneitem_t*
--- @param item obs_sceneitem_t*
obslua.obs_sceneitem_group_add_item = function(group, item) end

--- obs_sceneitem_group_enum_items not documented
obslua.obs_sceneitem_group_enum_items = function() end

--- obs_scene_t* obs_sceneitem_group_get_scene(const obs_sceneitem_t *group)
--- :param group: Group scene item
--- :return:      Scene of the group, or *NULL* if not a group
--- @param group obs_sceneitem_t*
--- @return obs_scene_t*
obslua.obs_sceneitem_group_get_scene = function(group) end

--- void obs_sceneitem_group_remove_item(obs_sceneitem_t *item)
--- Removes a scene item from a group.  The item will be placed before
--- the group in the main scene.
--- @param item obs_sceneitem_t*
obslua.obs_sceneitem_group_remove_item = function(item) end

--- void obs_sceneitem_group_ungroup(obs_sceneitem_t *group)
--- Ungroups the specified group.  Scene items within the group will be
--- placed where the group was.  Does not signal the scene with the
--- *refresh* signal.
--- @param group obs_sceneitem_t*
obslua.obs_sceneitem_group_ungroup = function(group) end

--- void obs_sceneitem_group_ungroup2(obs_sceneitem_t *group, bool signal)
--- Ungroups the specified group.  Scene items within the group will be
--- placed where the group was.
--- :param group: Group scene item
--- :param signal: If *true*, signals the scene with the *refresh*
---                signal
--- @param group obs_sceneitem_t*
--- @param signal bool
obslua.obs_sceneitem_group_ungroup2 = function(group, signal) end

--- bool obs_sceneitem_is_group(obs_sceneitem_t *item)
--- :param item: Scene item
--- :return:     *true* if scene item is a group, *false* otherwise
--- @param item obs_sceneitem_t*
--- @return bool
obslua.obs_sceneitem_is_group = function(item) end

--- obs_sceneitem_locked not documented
obslua.obs_sceneitem_locked = function() end

--- obs_sceneitem_release not documented
obslua.obs_sceneitem_release = function() end

--- void obs_sceneitem_remove(obs_sceneitem_t *item)
--- Removes the scene item from the scene.
--- @param item obs_sceneitem_t*
obslua.obs_sceneitem_remove = function(item) end

--- obs_sceneitem_select not documented
obslua.obs_sceneitem_select = function() end

--- obs_sceneitem_selected not documented
obslua.obs_sceneitem_selected = function() end

--- void obs_sceneitem_set_alignment(obs_sceneitem_t *item, uint32_t alignment)
---            uint32_t obs_sceneitem_get_alignment(const obs_sceneitem_t *item)
--- Sets/gets the alignment of the scene item relative to its position.
--- :param alignment: | Can be any bitwise OR combination of:
---                   | OBS_ALIGN_CENTER
---                   | OBS_ALIGN_LEFT
---                   | OBS_ALIGN_RIGHT
---                   | OBS_ALIGN_TOP
---                   | OBS_ALIGN_BOTTOM
--- @param item obs_sceneitem_t*
--- @param alignment uint32_t
obslua.obs_sceneitem_set_alignment = function(item, alignment) end

--- void obs_sceneitem_set_bounds(obs_sceneitem_t *item, const struct vec2 *bounds)
---            void obs_sceneitem_get_bounds(const obs_sceneitem_t *item, struct vec2 *bounds)
--- Sets/gets the bounding box width/height of the scene item.
--- @param item obs_sceneitem_t*
--- @param bounds vec2*
obslua.obs_sceneitem_set_bounds = function(item, bounds) end

--- void obs_sceneitem_set_bounds_alignment(obs_sceneitem_t *item, uint32_t alignment)
---            uint32_t obs_sceneitem_get_bounds_alignment(const obs_sceneitem_t *item)
--- Sets/gets the alignment of the source within the bounding box.
--- :param alignment: | Can be any bitwise OR combination of:
---                   | OBS_ALIGN_CENTER
---                   | OBS_ALIGN_LEFT
---                   | OBS_ALIGN_RIGHT
---                   | OBS_ALIGN_TOP
---                   | OBS_ALIGN_BOTTOM
--- @param item obs_sceneitem_t*
--- @param alignment uint32_t
obslua.obs_sceneitem_set_bounds_alignment = function(item, alignment) end

--- void obs_sceneitem_set_bounds_type(obs_sceneitem_t *item, enum obs_bounds_type type)
---            enum obs_bounds_type obs_sceneitem_get_bounds_type(const obs_sceneitem_t *item)
--- Sets/gets the bounding box type of a scene item.  Bounding boxes are
--- used to stretch/position the source relative to a specific bounding
--- box of a specific size.
--- :param type: | Can be one of the following values:
---              | OBS_BOUNDS_NONE            - No bounding box
---              | OBS_BOUNDS_STRETCH         - Stretch to the bounding box without preserving aspect ratio
---              | OBS_BOUNDS_SCALE_INNER     - Scales with aspect ratio to inner bounding box rectangle
---              | OBS_BOUNDS_SCALE_OUTER     - Scales with aspect ratio to outer bounding box rectangle
---              | OBS_BOUNDS_SCALE_TO_WIDTH  - Scales with aspect ratio to the bounding box width
---              | OBS_BOUNDS_SCALE_TO_HEIGHT - Scales with aspect ratio to the bounding box height
---              | OBS_BOUNDS_MAX_ONLY        - Scales with aspect ratio, but only to the size of the source maximum
--- @param item obs_sceneitem_t*
--- @param type obs_bounds_type
obslua.obs_sceneitem_set_bounds_type = function(item, type) end

--- void obs_sceneitem_set_crop(obs_sceneitem_t *item, const struct obs_sceneitem_crop *crop)
---            void obs_sceneitem_get_crop(const obs_sceneitem_t *item, struct obs_sceneitem_crop *crop)
--- Sets/gets the cropping of the scene item.
--- @param item obs_sceneitem_t*
--- @param crop obs_sceneitem_crop*
obslua.obs_sceneitem_set_crop = function(item, crop) end

--- void obs_sceneitem_set_info(obs_sceneitem_t *item, const struct obs_transform_info *info)
---            void obs_sceneitem_get_info(const obs_sceneitem_t *item, struct obs_transform_info *info)
--- Sets/gets the transform information of the scene item.
--- @param item obs_sceneitem_t*
--- @param info obs_transform_info*
obslua.obs_sceneitem_set_info = function(item, info) end

--- bool obs_sceneitem_set_locked(obs_sceneitem_t *item, bool locked)
---            bool obs_sceneitem_locked(const obs_sceneitem_t *item)
--- Sets/gets the locked/unlocked state of the scene item.
--- @param item obs_sceneitem_t*
--- @param locked bool
--- @return bool
obslua.obs_sceneitem_set_locked = function(item, locked) end

--- void obs_sceneitem_set_order(obs_sceneitem_t *item, enum obs_order_movement movement)
--- Changes the scene item's order relative to the other scene items
--- within the scene.
--- :param movement: | Can be one of the following:
---                  | OBS_ORDER_MOVE_UP
---                  | OBS_ORDER_MOVE_DOWN
---                  | OBS_ORDER_MOVE_TOP
---                  | OBS_ORDER_MOVE_BOTTOM
--- @param item obs_sceneitem_t*
--- @param movement obs_order_movement
obslua.obs_sceneitem_set_order = function(item, movement) end

--- void obs_sceneitem_set_order_position(obs_sceneitem_t *item, int position)
--- Changes the scene item's order index.
--- @param item obs_sceneitem_t*
--- @param position int
obslua.obs_sceneitem_set_order_position = function(item, position) end

--- void obs_sceneitem_set_pos(obs_sceneitem_t *item, const struct vec2 *pos)
---            void obs_sceneitem_get_pos(const obs_sceneitem_t *item, struct vec2 *pos)
--- Sets/gets the position of a scene item.
--- @param item obs_sceneitem_t*
--- @param pos vec2*
obslua.obs_sceneitem_set_pos = function(item, pos) end

--- void obs_sceneitem_set_rot(obs_sceneitem_t *item, float rot_deg)
---            float obs_sceneitem_get_rot(const obs_sceneitem_t *item)
--- Sets/gets the rotation of a scene item.
--- @param item obs_sceneitem_t*
--- @param rot_deg float
obslua.obs_sceneitem_set_rot = function(item, rot_deg) end

--- void obs_sceneitem_set_scale(obs_sceneitem_t *item, const struct vec2 *scale)
---            void obs_sceneitem_get_scale(const obs_sceneitem_t *item, struct vec2 *scale)
--- Sets/gets the scaling of the scene item.
--- @param item obs_sceneitem_t*
--- @param scale vec2*
obslua.obs_sceneitem_set_scale = function(item, scale) end

--- void obs_sceneitem_set_scale_filter(obs_sceneitem_t *item, enum obs_scale_type filter)
---            enum obs_scale_type obs_sceneitem_get_scale_filter( obs_sceneitem_t *item)
--- Sets/gets the scale filter used for the scene item.
--- :param filter: | Can be one of the following values:
---                | OBS_SCALE_DISABLE
---                | OBS_SCALE_POINT
---                | OBS_SCALE_BICUBIC
---                | OBS_SCALE_BILINEAR
---                | OBS_SCALE_LANCZOS
--- @param item obs_sceneitem_t*
--- @param filter obs_scale_type
obslua.obs_sceneitem_set_scale_filter = function(item, filter) end

--- bool obs_sceneitem_set_visible(obs_sceneitem_t *item, bool visible)
---            bool obs_sceneitem_visible(const obs_sceneitem_t *item)
--- Sets/gets the visibility state of the scene item.
--- @param item obs_sceneitem_t*
--- @param visible bool
--- @return bool
obslua.obs_sceneitem_set_visible = function(item, visible) end

--- obs_sceneitem_visible not documented
obslua.obs_sceneitem_visible = function() end

--- void obs_service_addref(obs_service_t *service)
---            void obs_service_release(obs_service_t *service)
--- Adds/releases a reference to a service.  When the last reference is
--- released, the service is destroyed.
--- @param service obs_service_t*
obslua.obs_service_addref = function(service) end

--- void obs_service_apply_encoder_settings(obs_service_t *service, obs_data_t *video_encoder_settings, obs_data_t *audio_encoder_settings)
--- Applies service-specific video encoder settings.
--- :param  video_encoder_settings: Video encoder settings.  Can be *NULL*
--- :param  audio_encoder_settings: Audio encoder settings.  Can be *NULL*
--- .. _libobs/obs-service.h: https://github.com/jp9000/obs-studio/blob/master/libobs/obs-service.h
--- @param service obs_service_t*
--- @param video_encoder_settings obs_data_t*
--- @param audio_encoder_settings obs_data_t*
obslua.obs_service_apply_encoder_settings = function(service, video_encoder_settings, audio_encoder_settings) end

--- obs_service_t* obs_service_create(const char *id, const char *name, obs_data_t *settings, obs_data_t *hotkey_data)
--- Creates a service with the specified settings.
--- The "service" context is used for encoding video/audio data.  Use
--- obs_service_release to release it.
--- :param   id:             The service type string identifier
--- :param   name:           The desired name of the service.  If this is
---                          not unique, it will be made to be unique
--- :param   settings:       The settings for the service, or *NULL* if
---                          none
--- :param   hotkey_data:    Saved hotkey data for the service, or *NULL*
---                          if none
--- :return:                 A reference to the newly created service, or
---                          *NULL* if failed
--- @param id char*
--- @param name char*
--- @param settings obs_data_t*
--- @param hotkey_data obs_data_t*
--- @return obs_service_t*
obslua.obs_service_create = function(id, name, settings, hotkey_data) end

--- obs_service_create_private not documented
obslua.obs_service_create_private = function() end

--- obs_data_t* obs_service_defaults(const char *id)
--- :return: An incremented reference to the service's default settings
--- @param id char*
--- @return obs_data_t*
obslua.obs_service_defaults = function(id) end

--- obs_service_get_display_name not documented
obslua.obs_service_get_display_name = function() end

--- obs_service_get_id not documented
obslua.obs_service_get_id = function() end

--- obs_service_get_key not documented
obslua.obs_service_get_key = function() end

--- obs_service_get_name not documented
obslua.obs_service_get_name = function() end

--- obs_service_get_output_type not documented
obslua.obs_service_get_output_type = function() end

--- obs_service_get_password not documented
obslua.obs_service_get_password = function() end

--- obs_service_get_ref not documented
obslua.obs_service_get_ref = function() end

--- obs_data_t* obs_service_get_settings(const obs_service_t *service)
--- :return: An incremented reference to the service's settings
--- @param service obs_service_t*
--- @return obs_data_t*
obslua.obs_service_get_settings = function(service) end

--- obs_service_get_type not documented
obslua.obs_service_get_type = function() end

--- obs_service_get_type_data not documented
obslua.obs_service_get_type_data = function() end

--- obs_service_get_url not documented
obslua.obs_service_get_url = function() end

--- obs_service_get_username not documented
obslua.obs_service_get_username = function() end

--- obs_weak_service_t* obs_service_get_weak_service(obs_service_t *service)
---            obs_service_t *obs_weak_service_get_service(obs_weak_service_t *weak)
--- These functions are used to get a weak reference from a strong service
--- reference, or a strong service reference from a weak reference.  If
--- the service is destroyed, *obs_weak_service_get_service* will return
--- *NULL*.
--- @param service obs_service_t*
--- @return obs_weak_service_t*
obslua.obs_service_get_weak_service = function(service) end

--- obs_properties_t* obs_service_properties(const obs_service_t *service)
---            obs_properties_t *obs_get_service_properties(const char *id)
--- Use these functions to get the properties of a service or service
--- type.  Properties are optionally used (if desired) to automatically
--- generate user interface widgets to allow users to update settings.
--- :return: The properties list for a specific existing service.  Free
---          with :c:func:`obs_properties_destroy()`
--- @param service obs_service_t*
--- @return obs_properties_t*
obslua.obs_service_properties = function(service) end

--- obs_service_release not documented
obslua.obs_service_release = function() end

--- void obs_service_update(obs_service_t *service, obs_data_t *settings)
--- Updates the settings for this service context.
--- @param service obs_service_t*
--- @param settings obs_data_t*
obslua.obs_service_update = function(service, settings) end

--- bool obs_set_audio_monitoring_device(const char *name, const char *id)
--- Sets the current audio device for audio monitoring.
--- @param name char*
--- @param id char*
--- @return bool
obslua.obs_set_audio_monitoring_device = function(name, id) end

--- obs_set_cmdline_args not documented
obslua.obs_set_cmdline_args = function() end

--- void obs_set_locale(const char *locale)
--- Sets a new locale to use for modules.  This will call
--- obs_module_set_locale for each module with the new locale.
--- :param  locale: The locale to use for modules
--- @param locale char*
obslua.obs_set_locale = function(locale) end

--- void obs_set_master_volume(float volume)
--- Sets the master user volume.
--- @param volume float
obslua.obs_set_master_volume = function(volume) end

--- void obs_set_output_source(uint32_t channel, obs_source_t *source)
--- Sets the primary output source for a channel.
--- @param channel uint32_t
--- @param source obs_source_t*
obslua.obs_set_output_source = function(channel, source) end

--- obs_set_private_data not documented
obslua.obs_set_private_data = function() end

--- obs_set_ui_task_handler not documented
obslua.obs_set_ui_task_handler = function() end

--- void obs_shutdown(void)
--- Releases all data associated with OBS and terminates the OBS context.
obslua.obs_shutdown = function() end

--- bool obs_source_active(const obs_source_t *source)
--- :return: *true* if active, *false* if not.  A source is only
---          considered active if it's being shown on the final mix
--- @param source obs_source_t*
--- @return bool
obslua.obs_source_active = function(source) end

--- bool obs_source_add_active_child(obs_source_t *parent, obs_source_t *child)
--- Adds an active child source.  Must be called by parent sources on child
--- sources when the child is added and active.  This ensures that the source is
--- properly activated if the parent is active.
--- :return: *true* if source can be added, *false* if it causes recursion
--- @param parent obs_source_t*
--- @param child obs_source_t*
--- @return bool
obslua.obs_source_add_active_child = function(parent, child) end

--- void obs_source_add_audio_capture_callback(obs_source_t *source, obs_source_audio_capture_t callback, void *param)
---            void obs_source_remove_audio_capture_callback(obs_source_t *source, obs_source_audio_capture_t callback, void *param)
--- Adds/removes an audio capture callback for a source.  This allows the
--- ability to get the raw audio data of a source as it comes in.
--- Relevant data types used with this function:
--- .. code:: cpp
--- typedef void (*obs_source_audio_capture_t)(void *param, obs_source_t *source,
---                 const struct audio_data *audio_data, bool muted);
--- @param source obs_source_t*
--- @param callback obs_source_audio_capture_t
--- @param param void*
obslua.obs_source_add_audio_capture_callback = function(source, callback, param) end

--- void obs_source_addref(obs_source_t *source)
---            void obs_source_release(obs_source_t *source)
--- Adds/releases a reference to a source.  When the last reference is
--- released, the source is destroyed.
--- @param source obs_source_t*
obslua.obs_source_addref = function(source) end

--- obs_source_async_decoupled not documented
obslua.obs_source_async_decoupled = function() end

--- obs_source_async_unbuffered not documented
obslua.obs_source_async_unbuffered = function() end

--- obs_source_audio_active not documented
obslua.obs_source_audio_active = function() end

--- obs_source_audio_pending not documented
obslua.obs_source_audio_pending = function() end

--- bool obs_source_configurable(const obs_source_t *source)
---            bool obs_is_source_configurable(const char *id)
--- :return: *true* if the the source has custom properties, *false*
---          otherwise
--- @param source obs_source_t*
--- @return bool
obslua.obs_source_configurable = function(source) end

--- void obs_source_copy_filters(obs_source_t *dst, obs_source_t *src)
--- Copies filters from the source to the destination.  If filters by the
--- same name already exist in the destination source, the newer filters
--- will be given unique names.
--- @param dst obs_source_t*
--- @param src obs_source_t*
obslua.obs_source_copy_filters = function(dst, src) end

--- obs_source_t* obs_source_create(const char *id, const char *name, obs_data_t *settings, obs_data_t *hotkey_data)
--- Creates a source of the specified type with the specified settings.
--- The "source" context is used for anything related to presenting
--- or modifying video/audio.  Use obs_source_release to release it.
--- :param   id:             The source type string identifier
--- :param   name:           The desired name of the source.  If this is
---                          not unique, it will be made to be unique
--- :param   settings:       The settings for the source, or *NULL* if
---                          none
--- :param   hotkey_data:    Saved hotkey data for the source, or *NULL*
---                          if none
--- :return:                 A reference to the newly created source, or
---                          *NULL* if failed
--- @param id char*
--- @param name char*
--- @param settings obs_data_t*
--- @param hotkey_data obs_data_t*
--- @return obs_source_t*
obslua.obs_source_create = function(id, name, settings, hotkey_data) end

--- obs_source_t* obs_source_create_private(const char *id, const char *name, obs_data_t *settings)
--- Creates a 'private' source which is not enumerated by
--- :c:func:`obs_enum_sources()`, and is not saved by
--- :c:func:`obs_save_sources()`.
--- Author's Note: The existence of this function is a result of design
--- flaw: the front-end should control saving/loading of sources, and
--- functions like :c:func:`obs_enum_sources()` and
--- :c:func:`obs_save_sources()` should not exist in the back-end.
--- :param   id:             The source type string identifier
--- :param   name:           The desired name of the source.  For private
---                          sources, this does not have to be unique,
---                          and can additionally be *NULL* if desired
--- :param   settings:       The settings for the source, or *NULL* if
---                          none
--- :return:                 A reference to the newly created source, or
---                          *NULL* if failed
--- @param id char*
--- @param name char*
--- @param settings obs_data_t*
--- @return obs_source_t*
obslua.obs_source_create_private = function(id, name, settings) end

--- obs_source_dec_active not documented
obslua.obs_source_dec_active = function() end

--- obs_source_dec_showing not documented
obslua.obs_source_dec_showing = function() end

--- void obs_source_default_render(obs_source_t *source)
--- Can be used by filters to directly render a non-async parent source
--- without any filter processing.
--- @param source obs_source_t*
obslua.obs_source_default_render = function(source) end

--- void obs_source_draw(gs_texture_t *image, int x, int y, uint32_t cx, uint32_t cy, bool flip)
--- Helper function to draw sprites for a source (synchronous video).
--- :param  image:  The sprite texture to draw.  Assigns to the 'image' variable
---                 of the current effect.
--- :param  x:      X position of the sprite.
--- :param  y:      Y position of the sprite.
--- :param  cx:     Width of the sprite.  If 0, uses the texture width.
--- :param  cy:     Height of the sprite.  If 0, uses the texture height.
--- :param  flip:   Specifies whether to flip the image vertically.
--- @param image gs_texture_t*
--- @param x int
--- @param y int
--- @param cx uint32_t
--- @param cy uint32_t
--- @param flip bool
obslua.obs_source_draw = function(image, x, y, cx, cy, flip) end

--- void obs_source_draw_set_color_matrix(const struct matrix4 *color_matrix, const struct vec3 *color_range_min, const struct vec3 *color_range_max)
--- Helper function to set the color matrix information when drawing the
--- source.
--- :param  color_matrix:    The color matrix.  Assigns to the 'color_matrix'
---                          effect variable.
--- :param  color_range_min: The minimum color range.  Assigns to the
---                          'color_range_min' effect variable.  If NULL,
---                          {0.0f, 0.0f, 0.0f} is used.
--- :param  color_range_max: The maximum color range.  Assigns to the
---                          'color_range_max' effect variable.  If NULL,
---                          {1.0f, 1.0f, 1.0f} is used.
--- @param color_matrix matrix4*
--- @param color_range_min vec3*
--- @param color_range_max vec3*
obslua.obs_source_draw_set_color_matrix = function(color_matrix, color_range_min, color_range_max) end

--- obs_source_t* obs_source_duplicate(obs_source_t *source, const char *desired_name, bool create_private)
--- Duplicates a source.  If the source has the
--- OBS_SOURCE_DO_NOT_DUPLICATE output flag set, this only returns a
--- new reference to the same source.
--- :param source:         The source to duplicate
--- :param desired_name:   The desired name of the new source.  If this is
---                        not a private source and the name is not unique,
---                        it will be made to be unique
--- :param create_private: If *true*, the new source will be a private
---                        source if fully duplicated
--- :return:               A new source reference
--- @param source obs_source_t*
--- @param desired_name char*
--- @param create_private bool
--- @return obs_source_t*
obslua.obs_source_duplicate = function(source, desired_name, create_private) end

--- obs_source_enable_push_to_mute not documented
obslua.obs_source_enable_push_to_mute = function() end

--- obs_source_enable_push_to_talk not documented
obslua.obs_source_enable_push_to_talk = function() end

--- bool obs_source_enabled(const obs_source_t *source)
---            void obs_source_set_enabled(obs_source_t *source, bool enabled)
--- Enables/disables a source, or returns the enabled state.
--- @param source obs_source_t*
--- @return bool
obslua.obs_source_enabled = function(source) end

--- void obs_source_enum_active_sources(obs_source_t *source, obs_source_enum_proc_t enum_callback, void *param)
---            void obs_source_enum_active_tree(obs_source_t *source, obs_source_enum_proc_t enum_callback, void *param)
--- Enumerates active child sources or source tree used by this source.
--- Relevant data types used with this function:
--- .. code:: cpp
--- typedef void (*obs_source_enum_proc_t)(obs_source_t *parent,
---                 obs_source_t *child, void *param);
--- @param source obs_source_t*
--- @param enum_callback obs_source_enum_proc_t
--- @param param void*
obslua.obs_source_enum_active_sources = function(source, enum_callback, param) end

--- obs_source_enum_active_tree not documented
obslua.obs_source_enum_active_tree = function() end

--- void obs_source_enum_filters(obs_source_t *source, obs_source_enum_proc_t callback, void *param)
--- Enumerates active filters on a source.
--- Relevant data types used with this function:
--- .. code:: cpp
--- typedef void (*obs_source_enum_proc_t)(obs_source_t *parent,
---                 obs_source_t *child, void *param);
--- @param source obs_source_t*
--- @param callback obs_source_enum_proc_t
--- @param param void*
obslua.obs_source_enum_filters = function(source, callback, param) end

--- void obs_source_filter_add(obs_source_t *source, obs_source_t *filter)
---            void obs_source_filter_remove(obs_source_t *source, obs_source_t *filter)
--- Adds/removes a filter to/from a source.
--- @param source obs_source_t*
--- @param filter obs_source_t*
obslua.obs_source_filter_add = function(source, filter) end

--- obs_source_filter_remove not documented
obslua.obs_source_filter_remove = function() end

--- void obs_source_filter_set_order(obs_source_t *source, obs_source_t *filter, enum obs_order_movement movement)
--- Modifies the order of a specific filter.
--- :param movement: | Can be one of the following:
---                  | OBS_ORDER_MOVE_UP
---                  | OBS_ORDER_MOVE_DOWN
---                  | OBS_ORDER_MOVE_TOP
---                  | OBS_ORDER_MOVE_BOTTOM
--- Functions used by filters
--- @param source obs_source_t*
--- @param filter obs_source_t*
--- @param movement obs_order_movement
obslua.obs_source_filter_set_order = function(source, filter, movement) end

--- obs_source_frame_copy not documented
obslua.obs_source_frame_copy = function() end

--- obs_source_frame_create not documented
obslua.obs_source_frame_create = function() end

--- obs_source_frame_destroy not documented
obslua.obs_source_frame_destroy = function() end

--- obs_source_frame_free not documented
obslua.obs_source_frame_free = function() end

--- obs_source_frame_init not documented
obslua.obs_source_frame_init = function() end

--- obs_source_get_audio_mix not documented
obslua.obs_source_get_audio_mix = function() end

--- obs_source_get_audio_mixers not documented
obslua.obs_source_get_audio_mixers = function() end

--- obs_source_get_audio_timestamp not documented
obslua.obs_source_get_audio_timestamp = function() end

--- obs_source_get_balance_value not documented
obslua.obs_source_get_balance_value = function() end

--- obs_source_get_base_height not documented
obslua.obs_source_get_base_height = function() end

--- obs_source_get_base_width not documented
obslua.obs_source_get_base_width = function() end

--- obs_source_get_deinterlace_field_order not documented
obslua.obs_source_get_deinterlace_field_order = function() end

--- obs_source_get_deinterlace_mode not documented
obslua.obs_source_get_deinterlace_mode = function() end

--- obs_source_get_display_name not documented
obslua.obs_source_get_display_name = function() end

--- obs_source_t* obs_source_get_filter_by_name(obs_source_t *source, const char *name)
--- :return: The desired filter, or *NULL* if not found.  The reference
---          of the filter is incremented
--- @param source obs_source_t*
--- @param name char*
--- @return obs_source_t*
obslua.obs_source_get_filter_by_name = function(source, name) end

--- obs_source_get_flags not documented
obslua.obs_source_get_flags = function() end

--- obs_source_get_frame not documented
obslua.obs_source_get_frame = function() end

--- obs_source_get_height not documented
obslua.obs_source_get_height = function() end

--- obs_source_get_icon_type not documented
obslua.obs_source_get_icon_type = function() end

--- obs_source_get_id not documented
obslua.obs_source_get_id = function() end

--- obs_source_get_last_obs_version not documented
obslua.obs_source_get_last_obs_version = function() end

--- obs_source_get_monitoring_type not documented
obslua.obs_source_get_monitoring_type = function() end

--- obs_source_get_name not documented
obslua.obs_source_get_name = function() end

--- uint32_t obs_source_get_output_flags(const obs_source_t *source)
---            uint32_t obs_get_source_output_flags(const char *id)
--- :return: Capability flags of a source
--- Author's Note: "Output flags" is poor wording in retrospect; this
--- should have been named "Capability flags", and the OBS_SOURCE_*
--- macros should really be OBS_SOURCE_CAP_* macros instead.
--- See :c:member:`obs_source_info.output_flags` for more information.
--- @param source obs_source_t*
--- @return uint32_t
obslua.obs_source_get_output_flags = function(source) end

--- obs_data_t* obs_source_get_private_settings(obs_source_t *item)
--- Gets private front-end settings data.  This data is saved/loaded
--- automatically.  Returns an incremented reference.
--- @param item obs_source_t*
--- @return obs_data_t*
obslua.obs_source_get_private_settings = function(item) end

--- proc_handler_t* obs_source_get_proc_handler(const obs_source_t *source)
--- :return: The procedure handler for a source
--- @param source obs_source_t*
--- @return proc_handler_t*
obslua.obs_source_get_proc_handler = function(source) end

--- uint64_t obs_source_get_push_to_mute_delay(const obs_source_t *source)
---            void obs_source_set_push_to_mute_delay(obs_source_t *source, uint64_t delay)
--- Sets/gets the push-to-mute delay.
--- @param source obs_source_t*
--- @return uint64_t
obslua.obs_source_get_push_to_mute_delay = function(source) end

--- uint64_t obs_source_get_push_to_talk_delay(const obs_source_t *source)
---            void obs_source_set_push_to_talk_delay(obs_source_t *source, uint64_t delay)
--- Sets/gets the push-to-talk delay.
--- @param source obs_source_t*
--- @return uint64_t
obslua.obs_source_get_push_to_talk_delay = function(source) end

--- obs_source_get_ref not documented
obslua.obs_source_get_ref = function() end

--- obs_data_t* obs_source_get_settings(const obs_source_t *source)
--- :return: The settings string for a source.  The reference counter of the
---          returned settings data is incremented, so
---          :c:func:`obs_data_release()` must be called when the
---          settings are no longer used
--- @param source obs_source_t*
--- @return obs_data_t*
obslua.obs_source_get_settings = function(source) end

---  :return: The source's signal handler
-- See the :ref:`source_signal_handler_reference` for more information
-- on signals that are available for sources.
-- @param source obs_source_t*
-- @return signal_handler_t*
obslua.obs_source_get_signal_handler = function(source) end

--- obs_source_get_speaker_layout not documented
obslua.obs_source_get_speaker_layout = function() end

--- obs_source_get_sync_offset not documented
obslua.obs_source_get_sync_offset = function() end

--- obs_source_get_type not documented
obslua.obs_source_get_type = function() end

--- obs_source_get_type_data not documented
obslua.obs_source_get_type_data = function() end

--- obs_source_get_unversioned_id not documented
obslua.obs_source_get_unversioned_id = function() end

--- obs_source_get_volume not documented
obslua.obs_source_get_volume = function() end

--- obs_weak_source_t* obs_source_get_weak_source(obs_source_t *source)
---            obs_source_t *obs_weak_source_get_source(obs_weak_source_t *weak)
--- These functions are used to get a weak reference from a strong source
--- reference, or a strong source reference from a weak reference.  If
--- the source is destroyed, *obs_weak_source_get_source* will return
--- *NULL*.
--- @param source obs_source_t*
--- @return obs_weak_source_t*
obslua.obs_source_get_weak_source = function(source) end

--- uint32_t obs_source_get_width(obs_source_t *source)
---            uint32_t obs_source_get_height(obs_source_t *source)
--- Calls the :c:member:`obs_source_info.get_width` or
--- :c:member:`obs_source_info.get_height` of the source to get its width
--- and/or height.
--- Author's Note: These functions should be consolidated in to a single
--- function/callback rather than having a function for both width and
--- height.
--- :return: The width or height of the source
--- @param source obs_source_t*
--- @return uint32_t
obslua.obs_source_get_width = function(source) end

--- obs_source_inc_active not documented
obslua.obs_source_inc_active = function() end

--- void obs_source_inc_showing(obs_source_t *source)
---            void obs_source_dec_showing(obs_source_t *source)
--- Increments/decrements a source's "showing" state.  Typically used
--- when drawing a source on a display manually.
--- @param source obs_source_t*
obslua.obs_source_inc_showing = function(source) end

--- obs_source_is_group not documented
obslua.obs_source_is_group = function() end

--- obs_source_load not documented
obslua.obs_source_load = function() end

--- obs_source_media_ended not documented
obslua.obs_source_media_ended = function() end

--- obs_source_media_get_duration not documented
obslua.obs_source_media_get_duration = function() end

--- obs_source_media_get_state not documented
obslua.obs_source_media_get_state = function() end

--- obs_source_media_get_time not documented
obslua.obs_source_media_get_time = function() end

--- obs_source_media_next not documented
obslua.obs_source_media_next = function() end

--- obs_source_media_play_pause not documented
obslua.obs_source_media_play_pause = function() end

--- obs_source_media_previous not documented
obslua.obs_source_media_previous = function() end

--- obs_source_media_restart not documented
obslua.obs_source_media_restart = function() end

--- obs_source_media_set_time not documented
obslua.obs_source_media_set_time = function() end

--- obs_source_media_started not documented
obslua.obs_source_media_started = function() end

--- obs_source_media_stop not documented
obslua.obs_source_media_stop = function() end

--- bool obs_source_muted(const obs_source_t *source)
---            void obs_source_set_muted(obs_source_t *source, bool muted)
--- Sets/gets whether the source's audio is muted.
--- @param source obs_source_t*
--- @return bool
obslua.obs_source_muted = function(source) end

--- void obs_source_output_audio(obs_source_t *source, const struct obs_source_audio *audio)
--- Outputs audio data.
--- @param source obs_source_t*
--- @param audio obs_source_audio*
obslua.obs_source_output_audio = function(source, audio) end

--- void obs_source_output_video(obs_source_t *source, const struct obs_source_frame *frame)
--- Outputs asynchronous video data.  Set to NULL to deactivate the texture.
--- Relevant data types used with this function:
--- .. code:: cpp
--- enum video_format {
---         VIDEO_FORMAT_NONE,
---         /* planar 420 format */
---         VIDEO_FORMAT_I420, /* three-plane */
---         VIDEO_FORMAT_NV12, /* two-plane, luma and packed chroma */
---         /* packed 422 formats */
---         VIDEO_FORMAT_YVYU,
---         VIDEO_FORMAT_YUY2, /* YUYV */
---         VIDEO_FORMAT_UYVY,
---         /* packed uncompressed formats */
---         VIDEO_FORMAT_RGBA,
---         VIDEO_FORMAT_BGRA,
---         VIDEO_FORMAT_BGRX,
---         VIDEO_FORMAT_Y800, /* grayscale */
---         /* planar 4:4:4 */
---         VIDEO_FORMAT_I444,
--- struct obs_source_frame {
---         uint8_t             *data[MAX_AV_PLANES];
---         uint32_t            linesize[MAX_AV_PLANES];
---         uint32_t            width;
---         uint32_t            height;
---         uint64_t            timestamp;
---         enum video_format   format;
---         float               color_matrix[16];
---         bool                full_range;
---         float               color_range_min[3];
---         float               color_range_max[3];
---         bool                flip;
--- @param source obs_source_t*
--- @param frame obs_source_frame*
obslua.obs_source_output_video = function(source, frame) end

--- obs_source_output_video2 not documented
obslua.obs_source_output_video2 = function() end

--- void obs_source_preload_video(obs_source_t *source, const struct obs_source_frame *frame)
--- Preloads a video frame to ensure a frame is ready for playback as
--- soon as video playback starts.
--- @param source obs_source_t*
--- @param frame obs_source_frame*
obslua.obs_source_preload_video = function(source, frame) end

--- obs_source_preload_video2 not documented
obslua.obs_source_preload_video2 = function() end

--- bool obs_source_process_filter_begin(obs_source_t *filter, enum gs_color_format format, enum obs_allow_direct_render allow_direct)
--- Default RGB filter handler for generic effect filters.  Processes the
--- filter chain and renders them to texture if needed, then the filter is
--- drawn with.
--- After calling this, set your parameters for the effect, then call
--- obs_source_process_filter_end to draw the filter.
--- :return: *true* if filtering should continue, *false* if the filter
---          is bypassed for whatever reason
--- @param filter obs_source_t*
--- @param format gs_color_format
--- @param allow_direct obs_allow_direct_render
--- @return bool
obslua.obs_source_process_filter_begin = function(filter, format, allow_direct) end

--- void obs_source_process_filter_end(obs_source_t *filter, gs_effect_t *effect, uint32_t width, uint32_t height)
--- Draws the filter using the effect's "Draw" technique.
--- Before calling this function, first call obs_source_process_filter_begin and
--- then set the effect parameters, and then call this function to finalize the
--- filter.
--- @param filter obs_source_t*
--- @param effect gs_effect_t*
--- @param width uint32_t
--- @param height uint32_t
obslua.obs_source_process_filter_end = function(filter, effect, width, height) end

--- void obs_source_process_filter_tech_end(obs_source_t *filter, gs_effect_t *effect, uint32_t width, uint32_t height, const char *tech_name)
--- Draws the filter with a specific technique in the effect.
--- Before calling this function, first call obs_source_process_filter_begin and
--- then set the effect parameters, and then call this function to finalize the
--- filter.
--- @param filter obs_source_t*
--- @param effect gs_effect_t*
--- @param width uint32_t
--- @param height uint32_t
--- @param tech_name char*
obslua.obs_source_process_filter_tech_end = function(filter, effect, width, height, tech_name) end

--- obs_properties_t* obs_source_properties(const obs_source_t *source)
---            obs_properties_t *obs_get_source_properties(const char *id)
--- Use these functions to get the properties of a source or source type.
--- Properties are optionally used (if desired) to automatically generate
--- user interface widgets to allow users to update settings.
--- :return: The properties list for a specific existing source.  Free with
---          :c:func:`obs_properties_destroy()`
--- @param source obs_source_t*
--- @return obs_properties_t*
obslua.obs_source_properties = function(source) end

--- bool obs_source_push_to_mute_enabled(const obs_source_t *source)
---            void obs_source_enable_push_to_mute(obs_source_t *source, bool enabled)
--- Sets/gets whether push-to-mute is enabled.
--- @param source obs_source_t*
--- @return bool
obslua.obs_source_push_to_mute_enabled = function(source) end

--- bool obs_source_push_to_talk_enabled(const obs_source_t *source)
---            void obs_source_enable_push_to_talk(obs_source_t *source, bool enabled)
--- Sets/gets whether push-to-talk is enabled.
--- @param source obs_source_t*
--- @return bool
obslua.obs_source_push_to_talk_enabled = function(source) end

--- obs_source_release not documented
obslua.obs_source_release = function() end

--- obs_source_release_frame not documented
obslua.obs_source_release_frame = function() end

--- void obs_source_remove(obs_source_t *source)
--- Notifies all reference holders of the source (via
--- :c:func:`obs_source_removed()`) that the source should be released.
--- @param source obs_source_t*
obslua.obs_source_remove = function(source) end

--- void obs_source_remove_active_child(obs_source_t *parent, obs_source_t *child)
--- Removes an active child source.  Must be called by parent sources on child
--- sources when the child is removed or inactive.  This ensures that the source
--- is properly deactivated if the parent is no longer active.
--- Filters
--- @param parent obs_source_t*
--- @param child obs_source_t*
obslua.obs_source_remove_active_child = function(parent, child) end

--- obs_source_remove_audio_capture_callback not documented
obslua.obs_source_remove_audio_capture_callback = function() end

--- bool obs_source_removed(const obs_source_t *source)
--- :return: *true* if the source should be released
--- @param source obs_source_t*
--- @return bool
obslua.obs_source_removed = function(source) end

--- obs_source_save not documented
obslua.obs_source_save = function() end

--- void obs_source_send_focus(obs_source_t *source, bool focus)
--- Used for interacting with sources:  sends a got-focus or lost-focus
--- event to a source.
--- @param source obs_source_t*
--- @param focus bool
obslua.obs_source_send_focus = function(source, focus) end

--- void obs_source_send_key_click(obs_source_t *source, const struct obs_key_event *event, bool key_up)
--- Used for interacting with sources:  sends a key up/down event to a
--- source.
--- Functions used by sources
--- @param source obs_source_t*
--- @param event obs_key_event*
--- @param key_up bool
obslua.obs_source_send_key_click = function(source, event, key_up) end

--- void obs_source_send_mouse_click(obs_source_t *source, const struct obs_mouse_event *event, int32_t type, bool mouse_up, uint32_t click_count)
--- Used for interacting with sources: sends a mouse down/up event to a
--- source.
--- @param source obs_source_t*
--- @param event obs_mouse_event*
--- @param type int32_t
--- @param mouse_up bool
--- @param click_count uint32_t
obslua.obs_source_send_mouse_click = function(source, event, type, mouse_up, click_count) end

--- void obs_source_send_mouse_move(obs_source_t *source, const struct obs_mouse_event *event, bool mouse_leave)
--- Used for interacting with sources: sends a mouse move event to a
--- source.
--- @param source obs_source_t*
--- @param event obs_mouse_event*
--- @param mouse_leave bool
obslua.obs_source_send_mouse_move = function(source, event, mouse_leave) end

--- void obs_source_send_mouse_wheel(obs_source_t *source, const struct obs_mouse_event *event, int x_delta, int y_delta)
--- Used for interacting with sources:  sends a mouse wheel event to a
--- source.
--- @param source obs_source_t*
--- @param event obs_mouse_event*
--- @param x_delta int
--- @param y_delta int
obslua.obs_source_send_mouse_wheel = function(source, event, x_delta, y_delta) end

--- obs_source_set_async_decoupled not documented
obslua.obs_source_set_async_decoupled = function() end

--- void obs_source_set_async_rotation(obs_source_t *source, long rotation)
--- Allows the ability to set rotation (0, 90, 180, -90, 270) for an
--- async video source.  The rotation will be automatically applied to
--- the source.
--- @param source obs_source_t*
--- @param rotation long
obslua.obs_source_set_async_rotation = function(source, rotation) end

--- obs_source_set_async_unbuffered not documented
obslua.obs_source_set_async_unbuffered = function() end

--- obs_source_set_audio_active not documented
obslua.obs_source_set_audio_active = function() end

--- void obs_source_set_audio_mixers(obs_source_t *source, uint32_t mixers)
---            uint32_t obs_source_get_audio_mixers(const obs_source_t *source)
--- Sets/gets the audio mixer channels that a source outputs to
--- (depending on what bits are set).  Audio mixers allow filtering
--- specific using multiple audio encoders to mix different sources
--- together depending on what mixer channel they're set to.
--- For example, to output to mixer 1 and 3, you would perform a bitwise
--- OR on bits 0 and 2:  (1<<0) | (1<<2), or 0x5.
--- @param source obs_source_t*
--- @param mixers uint32_t
obslua.obs_source_set_audio_mixers = function(source, mixers) end

--- obs_source_set_balance_value not documented
obslua.obs_source_set_balance_value = function() end

--- obs_source_set_default_flags not documented
obslua.obs_source_set_default_flags = function() end

--- void obs_source_set_deinterlace_field_order(obs_source_t *source, enum obs_deinterlace_field_order order)
---            enum obs_deinterlace_field_order obs_source_get_deinterlace_field_order(const obs_source_t *source)
--- Sets/gets the deinterlace field order.
--- :param order: | OBS_DEINTERLACE_FIELD_ORDER_TOP - Start from top
---               | OBS_DEINTERLACE_FIELD_ORDER_BOTTOM - Start from bottom
--- @param source obs_source_t*
--- @param order obs_deinterlace_field_order
obslua.obs_source_set_deinterlace_field_order = function(source, order) end

--- void obs_source_set_deinterlace_mode(obs_source_t *source, enum obs_deinterlace_mode mode)
---            enum obs_deinterlace_mode obs_source_get_deinterlace_mode(const obs_source_t *source)
--- Sets/gets the deinterlace mode.
--- :param mode:   | OBS_DEINTERLACE_MODE_DISABLE    - Disables deinterlacing
---                | OBS_DEINTERLACE_MODE_DISCARD    - Discard
---                | OBS_DEINTERLACE_MODE_RETRO      - Retro
---                | OBS_DEINTERLACE_MODE_BLEND      - Blend
---                | OBS_DEINTERLACE_MODE_BLEND_2X   - Blend 2x
---                | OBS_DEINTERLACE_MODE_LINEAR     - Linear
---                | OBS_DEINTERLACE_MODE_LINEAR_2X  - Linear 2x
---                | OBS_DEINTERLACE_MODE_YADIF      - Yadif
---                | OBS_DEINTERLACE_MODE_YADIF_2X   - Yadif 2x
--- @param source obs_source_t*
--- @param mode obs_deinterlace_mode
obslua.obs_source_set_deinterlace_mode = function(source, mode) end

--- obs_source_set_enabled not documented
obslua.obs_source_set_enabled = function() end

--- void obs_source_set_flags(obs_source_t *source, uint32_t flags)
---            uint32_t obs_source_get_flags(const obs_source_t *source)
--- :param flags: OBS_SOURCE_FLAG_FORCE_MONO Forces audio to mono
--- @param source obs_source_t*
--- @param flags uint32_t
obslua.obs_source_set_flags = function(source, flags) end

--- obs_source_set_monitoring_type not documented
obslua.obs_source_set_monitoring_type = function() end

--- obs_source_set_muted not documented
obslua.obs_source_set_muted = function() end

--- void obs_source_set_name(obs_source_t *source, const char *name)
--- Sets the name of a source.  If the source is not private and the name
--- is not unique, it will automatically be given a unique name.
--- @param source obs_source_t*
--- @param name char*
obslua.obs_source_set_name = function(source, name) end

--- obs_source_set_push_to_mute_delay not documented
obslua.obs_source_set_push_to_mute_delay = function() end

--- obs_source_set_push_to_talk_delay not documented
obslua.obs_source_set_push_to_talk_delay = function() end

--- void obs_source_set_sync_offset(obs_source_t *source, int64_t offset)
---            int64_t obs_source_get_sync_offset(const obs_source_t *source)
--- Sets/gets the audio sync offset (in nanoseconds) for a source.
--- @param source obs_source_t*
--- @param offset int64_t
obslua.obs_source_set_sync_offset = function(source, offset) end

--- obs_source_set_video_frame not documented
obslua.obs_source_set_video_frame = function() end

--- obs_source_set_video_frame2 not documented
obslua.obs_source_set_video_frame2 = function() end

--- void obs_source_set_volume(obs_source_t *source, float volume)
---            float obs_source_get_volume(const obs_source_t *source)
--- Sets/gets the user volume for a source that has audio output.
--- @param source obs_source_t*
--- @param volume float
obslua.obs_source_set_volume = function(source, volume) end

--- void obs_source_show_preloaded_video(obs_source_t *source)
--- Shows any preloaded video frame.
--- @param source obs_source_t*
obslua.obs_source_show_preloaded_video = function(source) end

--- bool obs_source_showing(const obs_source_t *source)
--- :return: *true* if showing, *false* if not.  A source is considered
---          showing if it's being displayed anywhere at all, whether on
---          a display context or on the final output
--- @param source obs_source_t*
--- @return bool
obslua.obs_source_showing = function(source) end

--- void obs_source_skip_video_filter(obs_source_t *filter)
--- Skips the filter if the filter is invalid and cannot be rendered.
--- .. _transitions:
--- Transitions
--- @param filter obs_source_t*
obslua.obs_source_skip_video_filter = function(filter) end

--- void obs_source_update(obs_source_t *source, obs_data_t *settings)
--- Updates the settings for a source and calls the
--- :c:member:`obs_source_info.update` callback of the source.  If the
--- source is a video source, the :c:member:`obs_source_info.update` will
--- be not be called immediately; instead, it will be deferred to the
--- video thread to prevent threading issues.
--- @param source obs_source_t*
--- @param settings obs_data_t*
obslua.obs_source_update = function(source, settings) end

--- void obs_source_update_properties(obs_source_t *source)
--- Signal an update to any currently used properties.
--- @param source obs_source_t*
obslua.obs_source_update_properties = function(source) end

--- void obs_source_video_render(obs_source_t *source)
--- Renders a video source.  This will call the
--- :c:member:`obs_source_info.video_render` callback of the source.
--- @param source obs_source_t*
obslua.obs_source_video_render = function(source) end

--- bool obs_startup(const char *locale, const char *module_config_path, profiler_name_store_t *store)
--- Initializes the OBS core context.
--- :param  locale:             The locale to use for modules
---                             (E.G. "en-US")
--- :param  module_config_path: Path to module config storage directory
---                             (or *NULL* if none)
--- :param  store:              The profiler name store for OBS to use or NULL
--- :return:                    *false* if already initialized or failed
---                             to initialize
--- @param locale char*
--- @param module_config_path char*
--- @param store profiler_name_store_t*
--- @return bool
obslua.obs_startup = function(locale, module_config_path, store) end

--- obs_transition_audio_render not documented
obslua.obs_transition_audio_render = function() end

--- void obs_transition_clear(obs_source_t *transition)
--- Clears the transition.
--- @param transition obs_source_t*
obslua.obs_transition_clear = function(transition) end

--- void obs_transition_enable_fixed(obs_source_t *transition, bool enable, uint32_t duration_ms)
---            bool obs_transition_fixed(obs_source_t *transition)
--- Sets/gets whether the transition uses a fixed duration.  Useful for
--- certain types of transitions such as stingers.  If this is set, the 
--- *duration_ms* parameter of :c:func:`obs_transition_start()` has no
--- effect.
--- @param transition obs_source_t*
--- @param enable bool
--- @param duration_ms uint32_t
obslua.obs_transition_enable_fixed = function(transition, enable, duration_ms) end

--- obs_transition_fixed not documented
obslua.obs_transition_fixed = function() end

--- obs_transition_force_stop not documented
obslua.obs_transition_force_stop = function() end

--- obs_source_t* obs_transition_get_active_source(obs_source_t *transition)
--- :return: An incremented reference to the currently active source of
---          the transition
--- @param transition obs_source_t*
--- @return obs_source_t*
obslua.obs_transition_get_active_source = function(transition) end

--- obs_transition_get_alignment not documented
obslua.obs_transition_get_alignment = function() end

--- obs_transition_get_scale_type not documented
obslua.obs_transition_get_scale_type = function() end

--- obs_transition_get_size not documented
obslua.obs_transition_get_size = function() end

--- obs_source_t* obs_transition_get_source(obs_source_t *transition, enum obs_transition_target target)
--- :param target: | OBS_TRANSITION_SOURCE_A - Source being transitioned from, or the current source if not transitioning
---                | OBS_TRANSITION_SOURCE_B - Source being transitioned to
--- :return:       An incremented reference to the source or destination
---                sources of the transition
--- @param transition obs_source_t*
--- @param target obs_transition_target
--- @return obs_source_t*
obslua.obs_transition_get_source = function(transition, target) end

--- float obs_transition_get_time(obs_source_t *transition)
--- :return: The current transition time value (0.0f..1.0f)
--- @param transition obs_source_t*
--- @return float
obslua.obs_transition_get_time = function(transition) end

--- obs_transition_set not documented
obslua.obs_transition_set = function() end

--- void obs_transition_set_alignment(obs_source_t *transition, uint32_t alignment)
---            uint32_t obs_transition_get_alignment(const obs_source_t *transition)
--- Sets/gets the alignment used to draw the two sources within
--- transition the transition.
--- :param alignment: | Can be any bitwise OR combination of:
---                   | OBS_ALIGN_CENTER
---                   | OBS_ALIGN_LEFT
---                   | OBS_ALIGN_RIGHT
---                   | OBS_ALIGN_TOP
---                   | OBS_ALIGN_BOTTOM
--- Functions used by transitions
--- @param transition obs_source_t*
--- @param alignment uint32_t
obslua.obs_transition_set_alignment = function(transition, alignment) end

--- obs_transition_set_manual_time not documented
obslua.obs_transition_set_manual_time = function() end

--- obs_transition_set_manual_torque not documented
obslua.obs_transition_set_manual_torque = function() end

--- void obs_transition_set_scale_type(obs_source_t *transition, enum obs_transition_scale_type type)
---            enum obs_transition_scale_type obs_transition_get_scale_type( const obs_source_t *transition)
--- Sets/gets the scale type for sources within the transition.
--- :param type: | OBS_TRANSITION_SCALE_MAX_ONLY - Scale to aspect ratio, but only to the maximum size of each source
---              | OBS_TRANSITION_SCALE_ASPECT   - Always scale the sources, but keep aspect ratio
---              | OBS_TRANSITION_SCALE_STRETCH  - Scale and stretch the sources to the size of the transition
--- @param transition obs_source_t*
--- @param type obs_transition_scale_type
obslua.obs_transition_set_scale_type = function(transition, type) end

--- void obs_transition_set_size(obs_source_t *transition, uint32_t cx, uint32_t cy)
---            void obs_transition_get_size(const obs_source_t *transition, uint32_t *cx, uint32_t *cy)
--- Sets/gets the dimensions of the transition.
--- @param transition obs_source_t*
--- @param cx uint32_t
--- @param cy uint32_t
obslua.obs_transition_set_size = function(transition, cx, cy) end

--- bool obs_transition_start(obs_source_t *transition, enum obs_transition_mode mode, uint32_t duration_ms, obs_source_t *dest)
--- Starts the transition with the desired destination source.
--- :param mode:        Currently only OBS_TRANSITION_MODE_AUTO
--- :param duration_ms: Duration in milliseconds.  If the transition has
---                     a fixed duration set by
---                     :c:func:`obs_transition_enable_fixed`, this
---                     parameter will have no effect
--- :param dest:        The destination source to transition to
--- @param transition obs_source_t*
--- @param mode obs_transition_mode
--- @param duration_ms uint32_t
--- @param dest obs_source_t*
--- @return bool
obslua.obs_transition_start = function(transition, mode, duration_ms, dest) end

--- void obs_transition_swap_begin(obs_source_t *tr_dest, obs_source_t *tr_source)
---            void obs_transition_swap_end(obs_source_t *tr_dest, obs_source_t *tr_source)
--- Swaps two transitions.  Call obs_transition_swap_begin, swap the
--- source, then call obs_transition_swap_end when complete.  This allows
--- the ability to seamlessly swap two different transitions without it
--- affecting the output.
--- For example, if a transition is assigned to output channel 0, you'd
--- call obs_transition_swap_begin, then you'd call obs_set_output_source
--- with the new transition, then call
--- :c:func:`obs_transition_swap_begin()`.
--- .. _libobs/obs-source.h: https://github.com/jp9000/obs-studio/blob/master/libobs/obs-source.h
--- @param tr_dest obs_source_t*
--- @param tr_source obs_source_t*
obslua.obs_transition_swap_begin = function(tr_dest, tr_source) end

--- obs_transition_swap_end not documented
obslua.obs_transition_swap_end = function() end

--- void obs_transition_video_render(obs_source_t *transition, obs_transition_video_render_callback_t callback)
--- Helper function used for rendering transitions.  This function will
--- render two distinct textures for source A and source B of the
--- transition, allowing the ability to blend them together with a pixel
--- shader in a desired manner.
--- The *a* and *b* parameters of *callback* are automatically rendered
--- textures of source A and source B, *t* is the time value
--- (0.0f..1.0f), *cx* and *cy* are the current dimensions of the
--- transition, and *data* is the implementation's private data.
--- Relevant data types used with this function:
--- .. code:: cpp
--- typedef void (*obs_transition_video_render_callback_t)(void *data,
---                 gs_texture_t *a, gs_texture_t *b, float t,
---                 uint32_t cx, uint32_t cy);
--- @param transition obs_source_t*
--- @param callback obs_transition_video_render_callback_t
obslua.obs_transition_video_render = function(transition, callback) end

--- obs_transition_video_render_direct not documented
obslua.obs_transition_video_render_direct = function() end

--- obs_video_active not documented
obslua.obs_video_active = function() end

--- obs_encoder_t* obs_video_encoder_create(const char *id, const char *name, obs_data_t *settings, obs_data_t *hotkey_data)
--- Creates a video encoder with the specified settings.
--- The "encoder" context is used for encoding video/audio data.  Use
--- obs_encoder_release to release it.
--- :param   id:             The encoder type string identifier
--- :param   name:           The desired name of the encoder.  If this is
---                          not unique, it will be made to be unique
--- :param   settings:       The settings for the encoder, or *NULL* if
---                          none
--- :param   hotkey_data:    Saved hotkey data for the encoder, or *NULL*
---                          if none
--- :return:                 A reference to the newly created encoder, or
---                          *NULL* if failed
--- @param id char*
--- @param name char*
--- @param settings obs_data_t*
--- @param hotkey_data obs_data_t*
--- @return obs_encoder_t*
obslua.obs_video_encoder_create = function(id, name, settings, hotkey_data) end

--- obs_view_create not documented
obslua.obs_view_create = function() end

--- obs_view_destroy not documented
obslua.obs_view_destroy = function() end

--- obs_view_get_source not documented
obslua.obs_view_get_source = function() end

--- obs_view_render not documented
obslua.obs_view_render = function() end

--- obs_view_set_source not documented
obslua.obs_view_set_source = function() end

--- void obs_weak_encoder_addref(obs_weak_encoder_t *weak)
---            void obs_weak_encoder_release(obs_weak_encoder_t *weak)
--- Adds/releases a weak reference to an encoder.
--- @param weak obs_weak_encoder_t*
obslua.obs_weak_encoder_addref = function(weak) end

--- obs_weak_encoder_get_encoder not documented
obslua.obs_weak_encoder_get_encoder = function() end

--- obs_weak_encoder_references_encoder not documented
obslua.obs_weak_encoder_references_encoder = function() end

--- obs_weak_encoder_release not documented
obslua.obs_weak_encoder_release = function() end

--- void obs_weak_output_addref(obs_weak_output_t *weak)
---            void obs_weak_output_release(obs_weak_output_t *weak)
--- Adds/releases a weak reference to an output.
--- @param weak obs_weak_output_t*
obslua.obs_weak_output_addref = function(weak) end

--- obs_weak_output_get_output not documented
obslua.obs_weak_output_get_output = function() end

--- obs_weak_output_references_output not documented
obslua.obs_weak_output_references_output = function() end

--- obs_weak_output_release not documented
obslua.obs_weak_output_release = function() end

--- void obs_weak_service_addref(obs_weak_service_t *weak)
---            void obs_weak_service_release(obs_weak_service_t *weak)
--- Adds/releases a weak reference to a service.
--- @param weak obs_weak_service_t*
obslua.obs_weak_service_addref = function(weak) end

--- obs_weak_service_get_service not documented
obslua.obs_weak_service_get_service = function() end

--- obs_weak_service_references_service not documented
obslua.obs_weak_service_references_service = function() end

--- obs_weak_service_release not documented
obslua.obs_weak_service_release = function() end

--- void obs_weak_source_addref(obs_weak_source_t *weak)
---            void obs_weak_source_release(obs_weak_source_t *weak)
--- Adds/releases a weak reference to a source.
--- @param weak obs_weak_source_t*
obslua.obs_weak_source_addref = function(weak) end

--- obs_weak_source_get_source not documented
obslua.obs_weak_source_get_source = function() end

--- obs_weak_source_references_source not documented
obslua.obs_weak_source_references_source = function() end

--- obs_weak_source_release not documented
obslua.obs_weak_source_release = function() end

--- void os_breakpoint(void)
--- Triggers a debugger breakpoint (or crashes the program if no debugger
--- present).
obslua.os_breakpoint = function() end

--- int os_chdir(const char *path)
--- Changes the current working directory.
--- @param path char*
--- @return int
obslua.os_chdir = function(path) end

--- void os_closedir(os_dir_t *dir)
--- Closes a directory object.
--- .. type:: struct os_globent
--- A glob entry.
--- .. member:: char *os_globent.path
--- The full path to the glob entry.
--- .. member:: bool os_globent.directory
--- *true* if the glob entry is a directory, *false* otherwise.
--- .. type:: struct os_glob_info
--- A glob object.
--- .. member:: size_t             os_glob_info.gl_pathc
--- Number of glob entries.
--- .. member:: struct os_globent *os_glob_info.gl_pathv
--- Array of glob entries.
--- .. type:: typedef struct os_glob_info os_glob_t
--- @param dir os_dir_t*
obslua.os_closedir = function(dir) end

--- int os_copyfile(const char *file_in, const char *file_out)
--- Copies a file.
--- @param file_in char*
--- @param file_out char*
--- @return int
obslua.os_copyfile = function(file_in, file_out) end

--- void os_cpu_usage_info_destroy(os_cpu_usage_info_t *info)
--- Destroys a CPU usage information object.
--- Sleep/Time Functions
--- @param info os_cpu_usage_info_t*
obslua.os_cpu_usage_info_destroy = function(info) end

--- double os_cpu_usage_info_query(os_cpu_usage_info_t *info)
--- Queries the current CPU usage.
--- @param info os_cpu_usage_info_t*
--- @return double
obslua.os_cpu_usage_info_query = function(info) end

--- os_cpu_usage_info_t* os_cpu_usage_info_start(void)
--- Creates a CPU usage information object.
--- @return os_cpu_usage_info_t*
obslua.os_cpu_usage_info_start = function() end

--- void os_dlclose(void *module)
--- Closes a dynamic library.
--- CPU Usage Functions
--- @param module void*
obslua.os_dlclose = function(module) end

--- void* os_dlopen(const char *path)
--- Opens a dynamic library.
--- @param path char*
--- @return void*
obslua.os_dlopen = function(path) end

--- void* os_dlsym(void *module, const char *func)
--- Returns a symbol from a dynamic library.
--- @param module void*
--- @param func char*
--- @return void*
obslua.os_dlsym = function(module, func) end

--- int os_dtostr(double value, char *dst, size_t size)
--- Converts a double to a string.
--- Dynamic Link Library Functions
--- These functions are roughly equivalent to dlopen/dlsym/dlclose.
--- @param value double
--- @param dst char*
--- @param size size_t
--- @return int
obslua.os_dtostr = function(value, dst, size) end

--- os_end_high_performance not documented
obslua.os_end_high_performance = function() end

--- int64_t os_fgetsize(FILE *file)
--- Returns a file's size.
--- @param file FILE*
--- @return int64_t
obslua.os_fgetsize = function(file) end

--- bool os_file_exists(const char *path)
--- Returns true if a file/directory exists, false otherwise.
--- @param path char*
--- @return bool
obslua.os_file_exists = function(path) end

--- FILE* os_fopen(const char *path, const char *mode)
--- Opens a file with a UTF8 string path.
--- @param path char*
--- @param mode char*
--- @return FILE*
obslua.os_fopen = function(path, mode) end

--- os_fread_mbs not documented
obslua.os_fread_mbs = function() end

--- size_t os_fread_utf8(FILE *file, char **pstr)
--- Reads a UTF8 encoded file and allocates a pointer to the UTF8 string.
--- @param file FILE*
--- @param pstr char**
--- @return size_t
obslua.os_fread_utf8 = function(file, pstr) end

--- int os_fseeki64(FILE *file, int64_t offset, int origin)
--- Equivalent to fseek.
--- @param file FILE*
--- @param offset int64_t
--- @param origin int
--- @return int
obslua.os_fseeki64 = function(file, offset, origin) end

--- int64_t os_ftelli64(FILE *file)
--- Gets the current file position.
--- @param file FILE*
--- @return int64_t
obslua.os_ftelli64 = function(file) end

--- char* os_generate_formatted_filename(const char *extension, bool space, const char *format)
--- Returns a new bmalloc-allocated filename generated from specific
--- formatting.
--- Sleep-Inhibition Functions
--- These functions/types are used to inhibit the computer from going to
--- sleep.
--- .. type:: struct os_inhibit_info
--- .. type:: typedef struct os_inhibit_info os_inhibit_t
--- @param extension char*
--- @param space bool
--- @param format char*
--- @return char*
obslua.os_generate_formatted_filename = function(extension, space, format) end

--- size_t os_get_abs_path(const char *path, char *abspath, size_t size)
---            char *os_get_abs_path_ptr(const char *path)
--- Converts a relative path to an absolute path.
--- @param path char*
--- @param abspath char*
--- @param size size_t
--- @return size_t
obslua.os_get_abs_path = function(path, abspath, size) end

--- os_get_abs_path_ptr not documented
obslua.os_get_abs_path_ptr = function() end

--- int os_get_config_path(char *dst, size_t size, const char *name)
---            char *os_get_config_path_ptr(const char *name)
--- Gets the user-specific application configuration data path.
--- @param dst char*
--- @param size size_t
--- @param name char*
--- @return int
obslua.os_get_config_path = function(dst, size, name) end

--- os_get_config_path_ptr not documented
obslua.os_get_config_path_ptr = function() end

--- os_get_executable_path_ptr not documented
obslua.os_get_executable_path_ptr = function() end

--- int64_t os_get_file_size(const char *path)
--- Gets a file's size.
--- @param path char*
--- @return int64_t
obslua.os_get_file_size = function(path) end

--- os_get_free_disk_space not documented
obslua.os_get_free_disk_space = function() end

--- int64_t os_get_free_space(const char *path)
--- Gets free space of a specific file path.
--- String Conversion Functions
--- @param path char*
--- @return int64_t
obslua.os_get_free_space = function(path) end

--- int os_get_logical_cores(void)
--- Returns the number of logical cores available.
--- @return int
obslua.os_get_logical_cores = function() end

--- os_get_path_extension not documented
obslua.os_get_path_extension = function() end

--- int os_get_physical_cores(void)
--- Returns the number of physical cores available.
--- @return int
obslua.os_get_physical_cores = function() end

--- bool os_get_proc_memory_usage(os_proc_memory_usage_t *usage)
--- Gets memory usage of the current process.
--- @param usage os_proc_memory_usage_t*
--- @return bool
obslua.os_get_proc_memory_usage = function(usage) end

--- uint64_t os_get_proc_resident_size(void)
--- Returns the resident memory size of the current process.
--- @return uint64_t
obslua.os_get_proc_resident_size = function() end

--- uint64_t os_get_proc_virtual_size(void)
--- Returns the virtual memory size of the current process.
--- @return uint64_t
obslua.os_get_proc_virtual_size = function() end

--- int os_get_program_data_path(char *dst, size_t size, const char *name)
---            char *os_get_program_data_path_ptr(const char *name)
--- Gets the application configuration data path.
--- @param dst char*
--- @param size size_t
--- @param name char*
--- @return int
obslua.os_get_program_data_path = function(dst, size, name) end

--- os_get_program_data_path_ptr not documented
obslua.os_get_program_data_path_ptr = function() end

--- uint64_t os_get_sys_free_size(void)
--- Returns the amount of memory available.
--- .. type:: struct os_proc_memory_usage
--- Memory usage structure.
--- .. member:: uint64_t os_proc_memory_usage.resident_size
--- Resident size.
--- .. member:: uint64_t os_proc_memory_usage.virtual_size
--- Virtual size.
--- .. type:: typedef struct os_proc_memory_usage os_proc_memory_usage_t
--- @return uint64_t
obslua.os_get_sys_free_size = function() end

--- char* os_getcwd(char *path, size_t size)
--- Returns a new bmalloc-allocated path to the current working
--- directory.
--- @param path char*
--- @param size size_t
--- @return char*
obslua.os_getcwd = function(path, size) end

--- uint64_t os_gettime_ns(void)
--- Gets the current high-precision system time, in nanoseconds.
--- Other Path/File Functions
--- @return uint64_t
obslua.os_gettime_ns = function() end

--- int os_glob(const char *pattern, int flags, os_glob_t **pglob)
--- Enumerates files based upon a glob string.
--- @param pattern char*
--- @param flags int
--- @param pglob os_glob_t**
--- @return int
obslua.os_glob = function(pattern, flags, pglob) end

--- void os_globfree(os_glob_t *pglob)
--- Frees a glob object.
--- @param pglob os_glob_t*
obslua.os_globfree = function(pglob) end

--- os_inhibit_t* os_inhibit_sleep_create(const char *reason)
--- Creates a sleep inhibition object.
--- @param reason char*
--- @return os_inhibit_t*
obslua.os_inhibit_sleep_create = function(reason) end

--- void os_inhibit_sleep_destroy(os_inhibit_t *info)
--- Destroys a sleep inhibition object.  If the sleep inhibition object
--- was active, it will be deactivated.
--- Other Functions
--- @param info os_inhibit_t*
obslua.os_inhibit_sleep_destroy = function(info) end

--- bool os_inhibit_sleep_set_active(os_inhibit_t *info, bool active)
--- Activates/deactivates a sleep inhibition object.
--- @param info os_inhibit_t*
--- @param active bool
--- @return bool
obslua.os_inhibit_sleep_set_active = function(info, active) end

--- os_mbs_to_utf8_ptr not documented
obslua.os_mbs_to_utf8_ptr = function() end

--- os_mbs_to_wcs not documented
obslua.os_mbs_to_wcs = function() end

--- os_mbs_to_wcs_ptr not documented
obslua.os_mbs_to_wcs_ptr = function() end

--- int os_mkdir(const char *path)
--- Creates a directory.
--- @param path char*
--- @return int
obslua.os_mkdir = function(path) end

--- int os_mkdirs(const char *path)
--- Creates a full directory path if it doesn't exist.
--- @param path char*
--- @return int
obslua.os_mkdirs = function(path) end

--- os_dir_t* os_opendir(const char *path)
--- Opens a directory object to enumerate files within the directory.
--- @param path char*
--- @return os_dir_t*
obslua.os_opendir = function(path) end

--- os_quick_read_mbs_file not documented
obslua.os_quick_read_mbs_file = function() end

--- char* os_quick_read_utf8_file(const char *path)
--- Reads a UTF8 encoded file and returns an allocated pointer to the
--- string.
--- @param path char*
--- @return char*
obslua.os_quick_read_utf8_file = function(path) end

--- os_quick_write_mbs_file not documented
obslua.os_quick_write_mbs_file = function() end

--- bool os_quick_write_utf8_file(const char *path, const char *str, size_t len, bool marker)
--- Writes a UTF8 encoded file.
--- @param path char*
--- @param str char*
--- @param len size_t
--- @param marker bool
--- @return bool
obslua.os_quick_write_utf8_file = function(path, str, len, marker) end

--- bool os_quick_write_utf8_file_safe(const char *path, const char *str, size_t len, bool marker, const char *temp_ext, const char *backup_ext)
--- Writes a UTF8 encoded file with overwrite corruption prevention.
--- @param path char*
--- @param str char*
--- @param len size_t
--- @param marker bool
--- @param temp_ext char*
--- @param backup_ext char*
--- @return bool
obslua.os_quick_write_utf8_file_safe = function(path, str, len, marker, temp_ext, backup_ext) end

--- os_readdir not documented
obslua.os_readdir = function() end

--- int os_rename(const char *old_path, const char *new_path)
--- Renames a file.
--- @param old_path char*
--- @param new_path char*
--- @return int
obslua.os_rename = function(old_path, new_path) end

--- os_request_high_performance not documented
obslua.os_request_high_performance = function() end

--- int os_rmdir(const char *path)
--- Deletes a directory.
--- @param path char*
--- @return int
obslua.os_rmdir = function(path) end

--- int os_safe_replace(const char *target_path, const char *from_path, const char *backup_path)
--- Safely replaces a file.
--- @param target_path char*
--- @param from_path char*
--- @param backup_path char*
--- @return int
obslua.os_safe_replace = function(target_path, from_path, backup_path) end

--- void os_sleep_ms(uint32_t duration)
--- Sleeps for a specific number of milliseconds.
--- @param duration uint32_t
obslua.os_sleep_ms = function(duration) end

--- bool os_sleepto_ns(uint64_t time_target)
--- Sleeps to a specific time with high precision, in nanoseconds.
--- @param time_target uint64_t
--- @return bool
obslua.os_sleepto_ns = function(time_target) end

--- double os_strtod(const char *str)
--- Converts a string to a double.
--- @param str char*
--- @return double
obslua.os_strtod = function(str) end

--- int os_unlink(const char *path)
--- Deletes a file.
--- @param path char*
--- @return int
obslua.os_unlink = function(path) end

--- os_utf8_to_mbs_ptr not documented
obslua.os_utf8_to_mbs_ptr = function() end

--- size_t os_utf8_to_wcs(const char *str, size_t len, wchar_t *dst, size_t dst_size)
--- Converts a UTF8 string to a wide string.
--- @param str char*
--- @param len size_t
--- @param dst wchar_t*
--- @param dst_size size_t
--- @return size_t
obslua.os_utf8_to_wcs = function(str, len, dst, dst_size) end

--- size_t os_utf8_to_wcs_ptr(const char *str, size_t len, wchar_t **pstr)
--- Gets an bmalloc-allocated wide string converted from a UTF8 string.
--- @param str char*
--- @param len size_t
--- @param pstr wchar_t**
--- @return size_t
obslua.os_utf8_to_wcs_ptr = function(str, len, pstr) end

--- os_wcs_to_mbs not documented
obslua.os_wcs_to_mbs = function() end

--- os_wcs_to_mbs_ptr not documented
obslua.os_wcs_to_mbs_ptr = function() end

--- size_t os_wcs_to_utf8(const wchar_t *str, size_t len, char *dst, size_t dst_size)
--- Converts a wide string to a UTF8 string.
--- @param str wchar_t*
--- @param len size_t
--- @param dst char*
--- @param dst_size size_t
--- @return size_t
obslua.os_wcs_to_utf8 = function(str, len, dst, dst_size) end

--- size_t os_wcs_to_utf8_ptr(const wchar_t *str, size_t len, char **pstr)
--- Gets an bmalloc-allocated UTF8 string converted from a wide string.
--- Number/String Conversion Functions
--- @param str wchar_t*
--- @param len size_t
--- @param pstr char**
--- @return size_t
obslua.os_wcs_to_utf8_ptr = function(str, len, pstr) end

--- FILE* os_wfopen(const wchar_t *path, const char *mode)
--- Opens a file with a wide string path.
--- @param path wchar_t*
--- @param mode char*
--- @return FILE*
obslua.os_wfopen = function(path, mode) end

--- void proc_handler_add(proc_handler_t *handler, const char *decl_string, proc_handler_proc_t proc, void *data)
--- Adds a procedure to a procedure handler.
--- :param handler:     Procedure handler object
--- :param decl_string: Procedure declaration string
--- :param proc:        Procedure callback
--- :param data:        Private data to pass to the callback
--- @param handler proc_handler_t*
--- @param decl_string char*
--- @param proc proc_handler_proc_t
--- @param data void*
obslua.proc_handler_add = function(handler, decl_string, proc, data) end

--- bool proc_handler_call(proc_handler_t *handler, const char *name, calldata_t *params)
--- Calls a procedure within the procedure handler.
--- :param handler: Procedure handler object
--- :param name:    Name of procedure to call
--- :param params:  Calldata structure to pass to the procedure
--- @param handler proc_handler_t*
--- @param name char*
--- @param params calldata_t*
--- @return bool
obslua.proc_handler_call = function(handler, name, params) end

--- proc_handler_t* proc_handler_create(void)
--- Creates a new procedure handler.
--- :return: A new procedure handler object
--- @return proc_handler_t*
obslua.proc_handler_create = function() end

--- void proc_handler_destroy(proc_handler_t *handler)
--- Destroys a procedure handler object.
--- :param handler: Procedure handler object
--- @param handler proc_handler_t*
obslua.proc_handler_destroy = function(handler) end

--- void quat_add(struct quat *dst, const struct quat *v1, const struct quat *v2)
--- Adds two quaternions
--- :param dst: Destination
--- :param v1:  Quaternion 1
--- :param v2:  Quaternion 2
--- @param dst quat*
--- @param v1 quat*
--- @param v2 quat*
obslua.quat_add = function(dst, v1, v2) end

--- void quat_addf(struct quat *dst, const struct quat *v, float f)
--- Adds a floating point to all components
--- :param dst: Destination
--- :param dst: Quaternion
--- :param f:   Floating point
--- @param dst quat*
--- @param v quat*
--- @param f float
obslua.quat_addf = function(dst, v, f) end

--- quat_close not documented
obslua.quat_close = function() end

--- void quat_copy(struct quat *dst, const struct quat *v)
--- Copies a quaternion
--- :param dst: Destination
--- :param v:   Quaternion to copy
--- @param dst quat*
--- @param v quat*
obslua.quat_copy = function(dst, v) end

--- float quat_dist(const struct quat *v1, const struct quat *v2)
--- Gets the distance between two quaternions
--- :param v1: Quaternion 1
--- :param v2: Quaternion 2
--- :return:   Distance between the two quaternions
--- @param v1 quat*
--- @param v2 quat*
--- @return float
obslua.quat_dist = function(v1, v2) end

--- quat_divf not documented
obslua.quat_divf = function() end

--- float quat_dot(const struct quat *v1, const struct quat *v2)
--- Performs a dot product between two quaternions
--- :param v1: Quaternion 1
--- :param v2: Quaternion 2
--- :return:   Result of the dot product
--- @param v1 quat*
--- @param v2 quat*
--- @return float
obslua.quat_dot = function(v1, v2) end

--- quat_exp not documented
obslua.quat_exp = function() end

--- void quat_from_axisang(struct quat *dst, const struct axisang *aa)
--- Converts an axis angle to a quaternion
--- :param dst: Destination quaternion
--- :param aa:  Axis angle
--- @param dst quat*
--- @param aa axisang*
obslua.quat_from_axisang = function(dst, aa) end

--- quat_from_matrix3 not documented
obslua.quat_from_matrix3 = function() end

--- void quat_from_matrix4(struct quat *dst, const struct matrix4 *m)
--- Converts the rotational properties of a matrix to a quaternion
--- :param dst: Destination quaternion
--- :param m:   Matrix to convert
--- @param dst quat*
--- @param m matrix4*
obslua.quat_from_matrix4 = function(dst, m) end

--- void quat_get_dir(struct vec3 *dst, const struct quat *q)
--- Converts a quaternion to a directional vector
--- :param dst: Destination 3-component vector
--- :param q:   Quaternion
--- @param dst vec3*
--- @param q quat*
obslua.quat_get_dir = function(dst, q) end

--- void quat_get_tangent(struct quat *dst, const struct quat *prev, const struct quat *q, const struct quat *next)
--- Gets a tangent value for the center of three rotational values
--- :param dst:  Destination quaternion
--- :param prev: Previous rotation
--- :param q:    Rotation to get tangent for
--- :param next: Next rotation
--- @param dst quat*
--- @param prev quat*
--- @param q quat*
--- @param next quat*
obslua.quat_get_tangent = function(dst, prev, q, next) end

--- void quat_identity(struct quat *dst)
--- Sets a quaternion to {0.0f, 0.0f, 0.0f, 1.0f}.
--- :param dst: Destination
--- @param dst quat*
obslua.quat_identity = function(dst) end

--- void quat_interpolate(struct quat *dst, const struct quat *q1, const struct quat *q2, float t)
--- Linearly interpolates two quaternions
--- :param dst: Destination quaternion
--- :param q1:  Quaternion 1
--- :param q2:  Quaternion 2
--- :param t:   Time value (0.0f..1.0f)
--- @param dst quat*
--- @param q1 quat*
--- @param q2 quat*
--- @param t float
obslua.quat_interpolate = function(dst, q1, q2, t) end

--- void quat_interpolate_cubic(struct quat *dst, const struct quat *q1, const struct quat *q2, const struct quat *m1, const struct quat *m2, float t)
--- Performs cubic interpolation between two quaternions
--- :param dst: Destination quaternion
--- :param q1:  Quaternion 1
--- :param q2:  Quaternion 2
--- :param m1:  Tangent 1
--- :param m2:  Tangent 2
--- :param t:   Time value (0.0f..1.0f)
--- @param dst quat*
--- @param q1 quat*
--- @param q2 quat*
--- @param m1 quat*
--- @param m2 quat*
--- @param t float
obslua.quat_interpolate_cubic = function(dst, q1, q2, m1, m2, t) end

--- void quat_inv(struct quat *dst, const struct quat *v)
--- Inverts a quaternion
--- :param dst: Destination
--- :param v:   Quaternion to invert
--- @param dst quat*
--- @param v quat*
obslua.quat_inv = function(dst, v) end

--- float quat_len(const struct quat *v)
--- Gets the length of a quaternion
--- :param v: Quaternion
--- :return:  The quaternion's length
--- @param v quat*
--- @return float
obslua.quat_len = function(v) end

--- quat_log not documented
obslua.quat_log = function() end

--- void quat_mul(struct quat *dst, const struct quat *v1, const struct quat *v2)
--- Multiplies two quaternions
--- :param dst: Destination
--- :param v1:  Quaternion 1
--- :param v2:  Quaternion 2
--- @param dst quat*
--- @param v1 quat*
--- @param v2 quat*
obslua.quat_mul = function(dst, v1, v2) end

--- void quat_mulf(struct quat *dst, const struct quat *v, float f)
--- Multiplies a floating point with all components
--- :param dst: Destination
--- :param dst: Quaternion
--- :param f:   Floating point
--- @param dst quat*
--- @param v quat*
--- @param f float
obslua.quat_mulf = function(dst, v, f) end

--- quat_neg not documented
obslua.quat_neg = function() end

--- quat_norm not documented
obslua.quat_norm = function() end

--- void quat_set(struct quat *dst, float x, float y)
--- Sets the individual components of a quaternion.
--- :param dst: Destination
--- :param x:   X component
--- :param y:   Y component
--- :param y:   Z component
--- :param w:   W component
--- @param dst quat*
--- @param x float
--- @param y float
obslua.quat_set = function(dst, x, y) end

--- void quat_set_look_dir(struct quat *dst, const struct vec3 *dir)
--- Creates a quaternion from a specific "look" direction
--- :param dst: Destination quaternion
--- :param dir: 3-component vector representing the look direction
--- @param dst quat*
--- @param dir vec3*
obslua.quat_set_look_dir = function(dst, dir) end

--- void quat_sub(struct quat *dst, const struct quat *v1, const struct quat *v2)
--- Subtracts two quaternions
--- :param dst: Destination
--- :param v1:  Quaternion being subtracted from
--- :param v2:  Quaternion being subtracted
--- @param dst quat*
--- @param v1 quat*
--- @param v2 quat*
obslua.quat_sub = function(dst, v1, v2) end

--- void quat_subf(struct quat *dst, const struct quat *v, float f)
--- Subtracts a floating point from all components
--- :param dst: Destination
--- :param v:   Quaternion being subtracted from
--- :param f:   Floating point being subtracted
--- @param dst quat*
--- @param v quat*
--- @param f float
obslua.quat_subf = function(dst, v, f) end

--- remove_current_callback not documented
obslua.remove_current_callback = function() end

--- sceneitem_list_release not documented
obslua.sceneitem_list_release = function() end

--- script_log not documented
obslua.script_log = function() end

--- bool signal_handler_add(signal_handler_t *handler, const char *signal_decl)
--- Adds a signal to a signal handler.
--- :param handler:     Signal handler object
--- :param signal_decl: Signal declaration string
--- @param handler signal_handler_t*
--- @param signal_decl char*
--- @return bool
obslua.signal_handler_add = function(handler, signal_decl) end

--- bool signal_handler_add_array(signal_handler_t *handler, const char **signal_decls)
--- Adds multiple signals to a signal handler.
--- :param handler:      Signal handler object
--- :param signal_decls: An array of signal declaration strings,
---                      terminated by *NULL*
--- @param handler signal_handler_t*
--- @param signal_decls char**
--- @return bool
obslua.signal_handler_add_array = function(handler, signal_decls) end

--- void signal_handler_connect(signal_handler_t *handler, const char *signal, signal_callback_t callback, void *data)
--- Connect a callback to a signal on a signal handler.
--- :param handler:  Signal handler object
--- :param callback: Signal callback
--- :param data:     Private data passed the callback
--- @param handler signal_handler_t*
--- @param signal char*
--- @param callback signal_callback_t
--- @param data void*
obslua.signal_handler_connect = function(handler, signal, callback, data) end

--- signal_handler_connect_global not documented
obslua.signal_handler_connect_global = function() end

--- void signal_handler_connect_ref(signal_handler_t *handler, const char *signal, signal_callback_t callback, void *data)
--- Connect a callback to a signal on a signal handler, and increments
--- the handler's internal reference counter, preventing it from being
--- destroyed until the signal has been disconnected.
--- :param handler:  Signal handler object
--- :param callback: Signal callback
--- :param data:     Private data passed the callback
--- @param handler signal_handler_t*
--- @param signal char*
--- @param callback signal_callback_t
--- @param data void*
obslua.signal_handler_connect_ref = function(handler, signal, callback, data) end

--- signal_handler_t* signal_handler_create(void)
--- Creates a new signal handler object.
--- :return: A new signal handler object
--- @return signal_handler_t*
obslua.signal_handler_create = function() end

--- void signal_handler_destroy(signal_handler_t *handler)
--- Destroys a signal handler.
--- :param handler: Signal handler object
--- @param handler signal_handler_t*
obslua.signal_handler_destroy = function(handler) end

--- void signal_handler_disconnect(signal_handler_t *handler, const char *signal, signal_callback_t callback, void *data)
--- Disconnects a callback from a signal on a signal handler.
--- :param handler:  Signal handler object
--- :param callback: Signal callback
--- :param data:     Private data passed the callback
--- @param handler signal_handler_t*
--- @param signal char*
--- @param callback signal_callback_t
--- @param data void*
obslua.signal_handler_disconnect = function(handler, signal, callback, data) end

--- signal_handler_disconnect_global not documented
obslua.signal_handler_disconnect_global = function() end

--- void signal_handler_signal(signal_handler_t *handler, const char *signal, calldata_t *params)
--- Triggers a signal, calling all connected callbacks.
--- :param handler: Signal handler object
--- :param signal:  Name of signal to trigger
--- :param params:  Parameters to pass to the signal
--- Procedure Handlers
--- Procedure handlers are used to call functions without having to have
--- direct access to declarations or callback pointers.
--- .. code:: cpp
--- #include <callback/proc.h>
--- .. type:: proc_handler_t
--- .. type:: typedef void (*proc_handler_proc_t)(void *data, calldata_t *cd)
--- Procedure handler callback.
--- :param data: Private data passed to this callback
--- :param cd:   Calldata object
--- @param handler signal_handler_t*
--- @param signal char*
--- @param params calldata_t*
obslua.signal_handler_signal = function(handler, signal, params) end

--- source_list_release not documented
obslua.source_list_release = function() end

--- timer_add not documented
obslua.timer_add = function() end

--- timer_remove not documented
obslua.timer_remove = function() end

--- void vec2_abs(struct vec2 *dst, const struct vec2 *v)
--- Gets the absolute values of each component
--- :param dst: Destination
--- :param v:   Vector
--- @param dst vec2*
--- @param v vec2*
obslua.vec2_abs = function(dst, v) end

--- void vec2_add(struct vec2 *dst, const struct vec2 *v1, const struct vec2 *v2)
--- Adds two vectors
--- :param dst: Destination
--- :param v1:  Vector 1
--- :param v2:  Vector 2
--- @param dst vec2*
--- @param v1 vec2*
--- @param v2 vec2*
obslua.vec2_add = function(dst, v1, v2) end

--- void vec2_addf(struct vec2 *dst, const struct vec2 *v, float f)
--- Adds a floating point to all components
--- :param dst: Destination
--- :param dst: Vector
--- :param f:   Floating point
--- @param dst vec2*
--- @param v vec2*
--- @param f float
obslua.vec2_addf = function(dst, v, f) end

--- void vec2_ceil(struct vec2 *dst, const struct vec2 *v)
--- Gets the ceiling values of each component
--- :param dst: Destination
--- :param v:   Vector
--- @param dst vec2*
--- @param v vec2*
obslua.vec2_ceil = function(dst, v) end

--- int vec2_close(const struct vec2 *v1, const struct vec2 *v2, float epsilon)
--- Compares two vectors
--- :param v1:      Vector 1
--- :param v2:      Vector 2
--- :param epsilon: Maximum precision for comparison
--- @param v1 vec2*
--- @param v2 vec2*
--- @param epsilon float
--- @return int
obslua.vec2_close = function(v1, v2, epsilon) end

--- void vec2_copy(struct vec2 *dst, const struct vec2 *v)
--- Copies a vector
--- :param dst: Destination
--- :param v:   Vector to copy
--- @param dst vec2*
--- @param v vec2*
obslua.vec2_copy = function(dst, v) end

--- float vec2_dist(const struct vec2 *v1, const struct vec2 *v2)
--- Gets the distance between two vectors
--- :param v1: Vector 1
--- :param v2: Vector 2
--- :return:   Distance between the two vectors
--- @param v1 vec2*
--- @param v2 vec2*
--- @return float
obslua.vec2_dist = function(v1, v2) end

--- void vec2_div(struct vec2 *dst, const struct vec2 *v1, const struct vec2 *v2)
--- Divides two vectors
--- :param dst: Destination
--- :param v1:  Dividend
--- :param v2:  Divisor
--- @param dst vec2*
--- @param v1 vec2*
--- @param v2 vec2*
obslua.vec2_div = function(dst, v1, v2) end

--- void vec2_divf(struct vec2 *dst, const struct vec2 *v, float f)
--- Divides a floating point from all components
--- :param dst: Destination
--- :param v:   Vector (dividend)
--- :param f:   Floating point (divisor)
--- @param dst vec2*
--- @param v vec2*
--- @param f float
obslua.vec2_divf = function(dst, v, f) end

--- float vec2_dot(const struct vec2 *v1, const struct vec2 *v2)
--- Performs a dot product between two vectors
--- :param v1: Vector 1
--- :param v2: Vector 2
--- :return:   Result of the dot product
--- @param v1 vec2*
--- @param v2 vec2*
--- @return float
obslua.vec2_dot = function(v1, v2) end

--- void vec2_floor(struct vec2 *dst, const struct vec2 *v)
--- Gets the floor values of each component
--- :param dst: Destination
--- :param v:   Vector
--- @param dst vec2*
--- @param v vec2*
obslua.vec2_floor = function(dst, v) end

--- float vec2_len(const struct vec2 *v)
--- Gets the length of a vector
--- :param v: Vector
--- :return:  The vector's length
--- @param v vec2*
--- @return float
obslua.vec2_len = function(v) end

--- void vec2_max(struct vec2 *dst, const struct vec2 *v, const struct vec2 *max_v)
--- Gets the maximum values between two vectors
--- :param dst:   Destination
--- :param v:     Vector 1
--- :param max_v: Vector 2
--- @param dst vec2*
--- @param v vec2*
--- @param max_v vec2*
obslua.vec2_max = function(dst, v, max_v) end

--- void vec2_maxf(struct vec2 *dst, const struct vec2 *v, float val)
--- Gets the maximum values between a vector's components and a floating point
--- :param dst: Destination
--- :param v:   Vector
--- :param val: Floating point
--- @param dst vec2*
--- @param v vec2*
--- @param val float
obslua.vec2_maxf = function(dst, v, val) end

--- void vec2_min(struct vec2 *dst, const struct vec2 *v, const struct vec2 *min_v)
--- Gets the minimum values between two vectors
--- :param dst:   Destination
--- :param v:     Vector 1
--- :param min_v: Vector 2
--- @param dst vec2*
--- @param v vec2*
--- @param min_v vec2*
obslua.vec2_min = function(dst, v, min_v) end

--- void vec2_minf(struct vec2 *dst, const struct vec2 *v, float val)
--- Gets the minimum values between a vector's components and a floating point
--- :param dst: Destination
--- :param v:   Vector
--- :param val: Floating point
--- @param dst vec2*
--- @param v vec2*
--- @param val float
obslua.vec2_minf = function(dst, v, val) end

--- void vec2_mul(struct vec2 *dst, const struct vec2 *v1, const struct vec2 *v2)
--- Multiplies two vectors
--- :param dst: Destination
--- :param v1:  Vector 1
--- :param v2:  Vector 2
--- @param dst vec2*
--- @param v1 vec2*
--- @param v2 vec2*
obslua.vec2_mul = function(dst, v1, v2) end

--- void vec2_mulf(struct vec2 *dst, const struct vec2 *v, float f)
--- Multiplies a floating point with all components
--- :param dst: Destination
--- :param dst: Vector
--- :param f:   Floating point
--- @param dst vec2*
--- @param v vec2*
--- @param f float
obslua.vec2_mulf = function(dst, v, f) end

--- void vec2_neg(struct vec2 *dst, const struct vec2 *v)
--- Negates a vector
--- :param dst: Destination
--- :param v:   Vector to negate
--- @param dst vec2*
--- @param v vec2*
obslua.vec2_neg = function(dst, v) end

--- void vec2_norm(struct vec2 *dst, const struct vec2 *v)
--- Normalizes a vector
--- :param dst: Destination
--- :param v:   Vector to normalize
--- @param dst vec2*
--- @param v vec2*
obslua.vec2_norm = function(dst, v) end

--- void vec2_set(struct vec2 *dst, float x, float y)
--- Sets the individual components of a 2-component vector.
--- :param dst: Destination
--- :param x:   X component
--- :param y:   Y component
--- @param dst vec2*
--- @param x float
--- @param y float
obslua.vec2_set = function(dst, x, y) end

--- void vec2_sub(struct vec2 *dst, const struct vec2 *v1, const struct vec2 *v2)
--- Subtracts two vectors
--- :param dst: Destination
--- :param v1:  Vector being subtracted from
--- :param v2:  Vector being subtracted
--- @param dst vec2*
--- @param v1 vec2*
--- @param v2 vec2*
obslua.vec2_sub = function(dst, v1, v2) end

--- void vec2_subf(struct vec2 *dst, const struct vec2 *v, float f)
--- Subtracts a floating point from all components
--- :param dst: Destination
--- :param v:   Vector being subtracted from
--- :param f:   Floating point being subtracted
--- @param dst vec2*
--- @param v vec2*
--- @param f float
obslua.vec2_subf = function(dst, v, f) end

--- void vec2_zero(struct vec2 *dst)
--- Zeroes a vector
--- :param dst: Destination
--- @param dst vec2*
obslua.vec2_zero = function(dst) end

--- void vec3_abs(struct vec3 *dst, const struct vec3 *v)
--- Gets the absolute values of each component
--- :param dst: Destination
--- :param v:   Vector
--- @param dst vec3*
--- @param v vec3*
obslua.vec3_abs = function(dst, v) end

--- void vec3_add(struct vec3 *dst, const struct vec3 *v1, const struct vec3 *v2)
--- Adds two vectors
--- :param dst: Destination
--- :param v1:  Vector 1
--- :param v2:  Vector 2
--- @param dst vec3*
--- @param v1 vec3*
--- @param v2 vec3*
obslua.vec3_add = function(dst, v1, v2) end

--- void vec3_addf(struct vec3 *dst, const struct vec3 *v, float f)
--- Adds a floating point to all components
--- :param dst: Destination
--- :param dst: Vector
--- :param f:   Floating point
--- @param dst vec3*
--- @param v vec3*
--- @param f float
obslua.vec3_addf = function(dst, v, f) end

--- void vec3_ceil(struct vec3 *dst, const struct vec3 *v)
--- Gets the ceiling values of each component
--- :param dst: Destination
--- :param v:   Vector
--- @param dst vec3*
--- @param v vec3*
obslua.vec3_ceil = function(dst, v) end

--- int vec3_close(const struct vec3 *v1, const struct vec3 *v2, float epsilon)
--- Compares two vectors
--- :param v1:      Vector 1
--- :param v2:      Vector 2
--- :param epsilon: Maximum precision for comparison
--- @param v1 vec3*
--- @param v2 vec3*
--- @param epsilon float
--- @return int
obslua.vec3_close = function(v1, v2, epsilon) end

--- void vec3_copy(struct vec3 *dst, const struct vec3 *v)
--- Copies a vector
--- :param dst: Destination
--- :param v:   Vector to copy
--- @param dst vec3*
--- @param v vec3*
obslua.vec3_copy = function(dst, v) end

--- void vec3_cross(struct vec3 *dst, const struct vec3 *v1, const struct vec3 *v2)
--- Performs a cross product between two vectors
--- :param dst: Destination
--- :param v1:  Vector 1
--- :param v2:  Vector 2
--- @param dst vec3*
--- @param v1 vec3*
--- @param v2 vec3*
obslua.vec3_cross = function(dst, v1, v2) end

--- float vec3_dist(const struct vec3 *v1, const struct vec3 *v2)
--- Gets the distance between two vectors
--- :param v1: Vector 1
--- :param v2: Vector 2
--- :return:   Distance between the two vectors
--- @param v1 vec3*
--- @param v2 vec3*
--- @return float
obslua.vec3_dist = function(v1, v2) end

--- void vec3_div(struct vec3 *dst, const struct vec3 *v1, const struct vec3 *v2)
--- Divides two vectors
--- :param dst: Destination
--- :param v1:  Dividend
--- :param v2:  Divisor
--- @param dst vec3*
--- @param v1 vec3*
--- @param v2 vec3*
obslua.vec3_div = function(dst, v1, v2) end

--- void vec3_divf(struct vec3 *dst, const struct vec3 *v, float f)
--- Divides a floating point from all components
--- :param dst: Destination
--- :param v:   Vector (dividend)
--- :param f:   Floating point (divisor)
--- @param dst vec3*
--- @param v vec3*
--- @param f float
obslua.vec3_divf = function(dst, v, f) end

--- float vec3_dot(const struct vec3 *v1, const struct vec3 *v2)
--- Performs a dot product between two vectors
--- :param v1: Vector 1
--- :param v2: Vector 2
--- :return:   Result of the dot product
--- @param v1 vec3*
--- @param v2 vec3*
--- @return float
obslua.vec3_dot = function(v1, v2) end

--- void vec3_floor(struct vec3 *dst, const struct vec3 *v)
--- Gets the floor values of each component
--- :param dst: Destination
--- :param v:   Vector
--- @param dst vec3*
--- @param v vec3*
obslua.vec3_floor = function(dst, v) end

--- void vec3_from_vec4(struct vec3 *dst, const struct vec4 *v)
--- Creates a 3-component vector from a 4-component vector
--- :param dst: 3-component vector destination
--- :param v:   4-component vector
--- @param dst vec3*
--- @param v vec4*
obslua.vec3_from_vec4 = function(dst, v) end

--- float vec3_len(const struct vec3 *v)
--- Gets the length of a vector
--- :param v: Vector
--- :return:  The vector's length
--- @param v vec3*
--- @return float
obslua.vec3_len = function(v) end

--- void vec3_max(struct vec3 *dst, const struct vec3 *v, const struct vec3 *max_v)
--- Gets the maximum values between two vectors
--- :param dst:   Destination
--- :param v:     Vector 1
--- :param max_v: Vector 2
--- @param dst vec3*
--- @param v vec3*
--- @param max_v vec3*
obslua.vec3_max = function(dst, v, max_v) end

--- void vec3_maxf(struct vec3 *dst, const struct vec3 *v, float val)
--- Gets the maximum values between a vector's components and a floating point
--- :param dst: Destination
--- :param v:   Vector
--- :param val: Floating point
--- @param dst vec3*
--- @param v vec3*
--- @param val float
obslua.vec3_maxf = function(dst, v, val) end

--- void vec3_min(struct vec3 *dst, const struct vec3 *v, const struct vec3 *min_v)
--- Gets the minimum values between two vectors
--- :param dst:   Destination
--- :param v:     Vector 1
--- :param min_v: Vector 2
--- @param dst vec3*
--- @param v vec3*
--- @param min_v vec3*
obslua.vec3_min = function(dst, v, min_v) end

--- void vec3_minf(struct vec3 *dst, const struct vec3 *v, float val)
--- Gets the minimum values between a vector's components and a floating point
--- :param dst: Destination
--- :param v:   Vector
--- :param val: Floating point
--- @param dst vec3*
--- @param v vec3*
--- @param val float
obslua.vec3_minf = function(dst, v, val) end

--- vec3_mirror not documented
obslua.vec3_mirror = function() end

--- vec3_mirrorv not documented
obslua.vec3_mirrorv = function() end

--- void vec3_mul(struct vec3 *dst, const struct vec3 *v1, const struct vec3 *v2)
--- Multiplies two vectors
--- :param dst: Destination
--- :param v1:  Vector 1
--- :param v2:  Vector 2
--- @param dst vec3*
--- @param v1 vec3*
--- @param v2 vec3*
obslua.vec3_mul = function(dst, v1, v2) end

--- void vec3_mulf(struct vec3 *dst, const struct vec3 *v, float f)
--- Multiplies a floating point with all components
--- :param dst: Destination
--- :param dst: Vector
--- :param f:   Floating point
--- @param dst vec3*
--- @param v vec3*
--- @param f float
obslua.vec3_mulf = function(dst, v, f) end

--- void vec3_neg(struct vec3 *dst, const struct vec3 *v)
--- Negates a vector
--- :param dst: Destination
--- :param v:   Vector to negate
--- @param dst vec3*
--- @param v vec3*
obslua.vec3_neg = function(dst, v) end

--- void vec3_norm(struct vec3 *dst, const struct vec3 *v)
--- Normalizes a vector
--- :param dst: Destination
--- :param v:   Vector to normalize
--- @param dst vec3*
--- @param v vec3*
obslua.vec3_norm = function(dst, v) end

--- vec3_plane_dist not documented
obslua.vec3_plane_dist = function() end

--- void vec3_rand(struct vec3 *dst, int positive_only)
--- Generates a random vector
--- :param dst:           Destination
--- :param positive_only: *true* if positive only, *false* otherwise
--- @param dst vec3*
--- @param positive_only int
obslua.vec3_rand = function(dst, positive_only) end

--- void vec3_rotate(struct vec3 *dst, const struct vec3 *v, const struct matrix3 *m)
--- Rotates a vector
--- :param dst: Destination
--- :param v:   Vector
--- :param m:   Matrix
--- @param dst vec3*
--- @param v vec3*
--- @param m matrix3*
obslua.vec3_rotate = function(dst, v, m) end

--- void vec3_set(struct vec3 *dst, float x, float y)
--- Sets the individual components of a 3-component vector.
--- :param dst: Destination
--- :param x:   X component
--- :param y:   Y component
--- :param y:   Z component
--- @param dst vec3*
--- @param x float
--- @param y float
obslua.vec3_set = function(dst, x, y) end

--- void vec3_sub(struct vec3 *dst, const struct vec3 *v1, const struct vec3 *v2)
--- Subtracts two vectors
--- :param dst: Destination
--- :param v1:  Vector being subtracted from
--- :param v2:  Vector being subtracted
--- @param dst vec3*
--- @param v1 vec3*
--- @param v2 vec3*
obslua.vec3_sub = function(dst, v1, v2) end

--- void vec3_subf(struct vec3 *dst, const struct vec3 *v, float f)
--- Subtracts a floating point from all components
--- :param dst: Destination
--- :param v:   Vector being subtracted from
--- :param f:   Floating point being subtracted
--- @param dst vec3*
--- @param v vec3*
--- @param f float
obslua.vec3_subf = function(dst, v, f) end

--- void vec3_transform(struct vec3 *dst, const struct vec3 *v, const struct matrix4 *m)
--- Transforms a vector
--- :param dst: Destination
--- :param v:   Vector
--- :param m:   Matrix
--- @param dst vec3*
--- @param v vec3*
--- @param m matrix4*
obslua.vec3_transform = function(dst, v, m) end

--- vec3_transform3x4 not documented
obslua.vec3_transform3x4 = function() end

--- void vec3_zero(struct vec3 *dst)
--- Zeroes a vector
--- :param dst: Destination
--- @param dst vec3*
obslua.vec3_zero = function(dst) end

--- void vec4_abs(struct vec4 *dst, const struct vec4 *v)
--- Gets the absolute values of each component
--- :param dst: Destination
--- :param v:   Vector
--- @param dst vec4*
--- @param v vec4*
obslua.vec4_abs = function(dst, v) end

--- void vec4_add(struct vec4 *dst, const struct vec4 *v1, const struct vec4 *v2)
--- Adds two vectors
--- :param dst: Destination
--- :param v1:  Vector 1
--- :param v2:  Vector 2
--- @param dst vec4*
--- @param v1 vec4*
--- @param v2 vec4*
obslua.vec4_add = function(dst, v1, v2) end

--- void vec4_addf(struct vec4 *dst, const struct vec4 *v, float f)
--- Adds a floating point to all components
--- :param dst: Destination
--- :param dst: Vector
--- :param f:   Floating point
--- @param dst vec4*
--- @param v vec4*
--- @param f float
obslua.vec4_addf = function(dst, v, f) end

--- void vec4_ceil(struct vec4 *dst, const struct vec4 *v)
--- Gets the ceiling values of each component
--- :param dst: Destination
--- :param v:   Vector
--- @param dst vec4*
--- @param v vec4*
obslua.vec4_ceil = function(dst, v) end

--- int vec4_close(const struct vec4 *v1, const struct vec4 *v2, float epsilon)
--- Compares two vectors
--- :param v1:      Vector 1
--- :param v2:      Vector 2
--- :param epsilon: Maximum precision for comparison
--- @param v1 vec4*
--- @param v2 vec4*
--- @param epsilon float
--- @return int
obslua.vec4_close = function(v1, v2, epsilon) end

--- void vec4_copy(struct vec4 *dst, const struct vec4 *v)
--- Copies a vector
--- :param dst: Destination
--- :param v:   Vector to copy
--- @param dst vec4*
--- @param v vec4*
obslua.vec4_copy = function(dst, v) end

--- float vec4_dist(const struct vec4 *v1, const struct vec4 *v2)
--- Gets the distance between two vectors
--- :param v1: Vector 1
--- :param v2: Vector 2
--- :return:   Distance between the two vectors
--- @param v1 vec4*
--- @param v2 vec4*
--- @return float
obslua.vec4_dist = function(v1, v2) end

--- void vec4_div(struct vec4 *dst, const struct vec4 *v1, const struct vec4 *v2)
--- Divides two vectors
--- :param dst: Destination
--- :param v1:  Dividend
--- :param v2:  Divisor
--- @param dst vec4*
--- @param v1 vec4*
--- @param v2 vec4*
obslua.vec4_div = function(dst, v1, v2) end

--- void vec4_divf(struct vec4 *dst, const struct vec4 *v, float f)
--- Divides a floating point from all components
--- :param dst: Destination
--- :param v:   Vector (dividend)
--- :param f:   Floating point (divisor)
--- @param dst vec4*
--- @param v vec4*
--- @param f float
obslua.vec4_divf = function(dst, v, f) end

--- float vec4_dot(const struct vec4 *v1, const struct vec4 *v2)
--- Performs a dot product between two vectors
--- :param v1: Vector 1
--- :param v2: Vector 2
--- :return:   Result of the dot product
--- @param v1 vec4*
--- @param v2 vec4*
--- @return float
obslua.vec4_dot = function(v1, v2) end

--- void vec4_floor(struct vec4 *dst, const struct vec4 *v)
--- Gets the floor values of each component
--- :param dst: Destination
--- :param v:   Vector
--- @param dst vec4*
--- @param v vec4*
obslua.vec4_floor = function(dst, v) end

--- vec4_from_bgra not documented
obslua.vec4_from_bgra = function() end

--- vec4_from_rgba not documented
obslua.vec4_from_rgba = function() end

--- void vec4_from_vec3(struct vec4 *dst, const struct vec3 *v)
--- Creates a 4-component vector from a 3-component vector
--- :param dst: 4-component vector destination
--- :param v:   3-component vector
--- @param dst vec4*
--- @param v vec3*
obslua.vec4_from_vec3 = function(dst, v) end

--- float vec4_len(const struct vec4 *v)
--- Gets the length of a vector
--- :param v: Vector
--- :return:  The vector's length
--- @param v vec4*
--- @return float
obslua.vec4_len = function(v) end

--- void vec4_max(struct vec4 *dst, const struct vec4 *v, const struct vec4 *max_v)
--- Gets the maximum values between two vectors
--- :param dst:   Destination
--- :param v:     Vector 1
--- :param max_v: Vector 2
--- @param dst vec4*
--- @param v vec4*
--- @param max_v vec4*
obslua.vec4_max = function(dst, v, max_v) end

--- void vec4_maxf(struct vec4 *dst, const struct vec4 *v, float val)
--- Gets the maximum values between a vector's components and a floating point
--- :param dst: Destination
--- :param v:   Vector
--- :param val: Floating point
--- @param dst vec4*
--- @param v vec4*
--- @param val float
obslua.vec4_maxf = function(dst, v, val) end

--- void vec4_min(struct vec4 *dst, const struct vec4 *v, const struct vec4 *min_v)
--- Gets the minimum values between two vectors
--- :param dst:   Destination
--- :param v:     Vector 1
--- :param min_v: Vector 2
--- @param dst vec4*
--- @param v vec4*
--- @param min_v vec4*
obslua.vec4_min = function(dst, v, min_v) end

--- void vec4_minf(struct vec4 *dst, const struct vec4 *v, float val)
--- Gets the minimum values between a vector's components and a floating point
--- :param dst: Destination
--- :param v:   Vector
--- :param val: Floating point
--- @param dst vec4*
--- @param v vec4*
--- @param val float
obslua.vec4_minf = function(dst, v, val) end

--- void vec4_mul(struct vec4 *dst, const struct vec4 *v1, const struct vec4 *v2)
--- Multiplies two vectors
--- :param dst: Destination
--- :param v1:  Vector 1
--- :param v2:  Vector 2
--- @param dst vec4*
--- @param v1 vec4*
--- @param v2 vec4*
obslua.vec4_mul = function(dst, v1, v2) end

--- void vec4_mulf(struct vec4 *dst, const struct vec4 *v, float f)
--- Multiplies a floating point with all components
--- :param dst: Destination
--- :param dst: Vector
--- :param f:   Floating point
--- @param dst vec4*
--- @param v vec4*
--- @param f float
obslua.vec4_mulf = function(dst, v, f) end

--- void vec4_neg(struct vec4 *dst, const struct vec4 *v)
--- Negates a vector
--- :param dst: Destination
--- :param v:   Vector to negate
--- @param dst vec4*
--- @param v vec4*
obslua.vec4_neg = function(dst, v) end

--- void vec4_norm(struct vec4 *dst, const struct vec4 *v)
--- Normalizes a vector
--- :param dst: Destination
--- :param v:   Vector to normalize
--- @param dst vec4*
--- @param v vec4*
obslua.vec4_norm = function(dst, v) end

--- void vec4_set(struct vec4 *dst, float x, float y, float z, float w)
--- Sets the individual components of a 4-component vector.
--- :param dst: Destination
--- :param x:   X component
--- :param y:   Y component
--- :param z:   Z component
--- :param w:   W component
--- @param dst vec4*
--- @param x float
--- @param y float
--- @param z float
--- @param w float
obslua.vec4_set = function(dst, x, y, z, w) end

--- void vec4_sub(struct vec4 *dst, const struct vec4 *v1, const struct vec4 *v2)
--- Subtracts two vectors
--- :param dst: Destination
--- :param v1:  Vector being subtracted from
--- :param v2:  Vector being subtracted
--- @param dst vec4*
--- @param v1 vec4*
--- @param v2 vec4*
obslua.vec4_sub = function(dst, v1, v2) end

--- void vec4_subf(struct vec4 *dst, const struct vec4 *v, float f)
--- Subtracts a floating point from all components
--- :param dst: Destination
--- :param v:   Vector being subtracted from
--- :param f:   Floating point being subtracted
--- @param dst vec4*
--- @param v vec4*
--- @param f float
obslua.vec4_subf = function(dst, v, f) end

--- vec4_to_bgra not documented
obslua.vec4_to_bgra = function() end

--- vec4_to_rgba not documented
obslua.vec4_to_rgba = function() end

--- void vec4_transform(struct vec4 *dst, const struct vec4 *v, const struct matrix4 *m)
--- Transforms a vector
--- :param dst: Destination
--- :param v:   Vector
--- :param m:   Matrix
--- @param dst vec4*
--- @param v vec4*
--- @param m matrix4*
obslua.vec4_transform = function(dst, v, m) end

--- void vec4_zero(struct vec4 *dst)
--- Zeroes a vector
--- :param dst: Destination
--- @param dst vec4*
obslua.vec4_zero = function(dst) end

