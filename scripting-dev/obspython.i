%module(threads="1") obspython
%nothread;
%{
#define SWIG_FILE_WITH_INIT
#define DEPRECATED_START
#define DEPRECATED_END
#include <graphics/graphics.h>
#include <graphics/vec4.h>
#include <graphics/vec3.h>
#include <graphics/vec2.h>
#include <graphics/matrix4.h>
#include <graphics/matrix3.h>
#include <graphics/quat.h>
#include <obs.h>
#include <obs-hotkey.h>
#include <obs-source.h>
#include <obs-data.h>
#include <obs-properties.h>
#include <obs-interaction.h>
#include <callback/calldata.h>
#include <callback/decl.h>
#include <callback/proc.h>
#include <callback/signal.h>
#include <util/bmem.h>
#include <util/base.h>
#include "obs-scripting-config.h"
#include <util/platform.h>

#if UI_ENABLED
#include "obs-frontend-api.h"
#endif

%}

#define DEPRECATED_START
#define DEPRECATED_END
#define EXPORT

%rename(blog) wrap_blog;
%inline %{
static inline void wrap_blog(int log_level, const char *message)
{
        blog(log_level, "%s", message);
}
%}

%include "stdint.i"

/* Used to free when using %newobject functions.  E.G.:
 * %newobject obs_module_get_config_path; */
%typemap(newfree) char * "bfree($1);";




///////////////////////////////////////////////

// Defines a temporary variable to hold the value and assigns its address to the argument
%typemap(arginit, noblock=1) uint32_t *OUTREF {
  // OUTREF typemap(arginit) for $1_type $1_name
  $*1_type temp$argnum = 0;
  $1 = &temp$argnum;
}

%typemap(argout, noblock=1) uint32_t *OUTREF {
  // OUTREF typemap(out) for OBS see obspython.i
  $result = SWIG_Python_AppendOutput($result, SWIG_From_unsigned_SS_int((temp$argnum)));
}

%typemap(out) uint32_t *OUTREF "// typemap(out)";
%typemap(in, numinputs=0) uint32_t *OUTREF "// typemap(in)";
%typemap(typecheck) uint32_t *OUTREF "// typemap(typecheck)";
%typemap(check) uint32_t *OUTREF "// typemap(check)";
%typemap(default) uint32_t *OUTREF "// typemap(default)";

void gs_get_size(uint32_t *OUTREF, uint32_t *OUTREF);

%typemap(arginit) uint8_t **OUTREF = uint32_t *OUTREF;
%typemap(in) uint8_t **OUTREF = uint32_t *OUTREF;


%typemap(argout, noblock=1) uint8_t **OUTREF {
  // OUTREF typemap(out) for OBS see obspython.i
  int size = gs_stagesurface_get_height(arg1)*(*arg3);
  $result = SWIG_Python_AppendOutput($result, PyByteArray_FromStringAndSize((const char *)temp$argnum, size));
}


bool gs_stagesurface_map(gs_stagesurf_t *stagesurf, uint8_t **OUTREF, uint32_t *OUTREF);

/* No added value: %feature("autodoc", "0"); */

/* Code generated with void gs_get_size(uint32_t *INOUT, uint32_t *INOUT);

SWIGINTERN PyObject *_wrap_gs_get_size(PyObject *SWIGUNUSEDPARM(self), PyObject *args) {
  PyObject *resultobj = 0;
  uint32_t *arg1 = (uint32_t *) 0 ;
  uint32_t *arg2 = (uint32_t *) 0 ;
  uint32_t temp1 ;
  int res1 = 0 ;
  uint32_t temp2 ;
  int res2 = 0 ;
  PyObject * obj0 = 0 ;
  PyObject * obj1 = 0 ;
  
  if (!PyArg_ParseTuple(args,(char *)"OO:gs_get_size",&obj0,&obj1)) SWIG_fail;
  if (!(SWIG_IsOK((res1 = SWIG_ConvertPtr(obj0,SWIG_as_voidptrptr(&arg1),SWIGTYPE_p_unsigned_int,0))))) {
    unsigned int val; 
    int ecode = SWIG_AsVal_unsigned_SS_int(obj0, &val);
    if (!SWIG_IsOK(ecode)) {
      SWIG_exception_fail(SWIG_ArgError(ecode), "in method '" "gs_get_size" "', argument " "1"" of type '" "uint32_t""'");
    }
    temp1 = (uint32_t)(val);
    arg1 = &temp1;
    res1 = SWIG_AddTmpMask(ecode);
  }
  if (!(SWIG_IsOK((res2 = SWIG_ConvertPtr(obj1,SWIG_as_voidptrptr(&arg2),SWIGTYPE_p_unsigned_int,0))))) {
    unsigned int val; 
    int ecode = SWIG_AsVal_unsigned_SS_int(obj1, &val);
    if (!SWIG_IsOK(ecode)) {
      SWIG_exception_fail(SWIG_ArgError(ecode), "in method '" "gs_get_size" "', argument " "2"" of type '" "uint32_t""'");
    }
    temp2 = (uint32_t)(val);
    arg2 = &temp2;
    res2 = SWIG_AddTmpMask(ecode);
  }
  gs_get_size(arg1,arg2);
  resultobj = SWIG_Py_Void();
  if (SWIG_IsTmpObj(res1)) {
    resultobj = SWIG_Python_AppendOutput(resultobj, SWIG_From_unsigned_SS_int((*arg1)));
  } else {
    int new_flags = SWIG_IsNewObj(res1) ? (SWIG_POINTER_OWN |  0 ) :  0 ;
    resultobj = SWIG_Python_AppendOutput(resultobj, SWIG_NewPointerObj((void*)(arg1), SWIGTYPE_p_unsigned_int, new_flags));
  }
  if (SWIG_IsTmpObj(res2)) {
    resultobj = SWIG_Python_AppendOutput(resultobj, SWIG_From_unsigned_SS_int((*arg2)));
  } else {
    int new_flags = SWIG_IsNewObj(res2) ? (SWIG_POINTER_OWN |  0 ) :  0 ;
    resultobj = SWIG_Python_AppendOutput(resultobj, SWIG_NewPointerObj((void*)(arg2), SWIGTYPE_p_unsigned_int, new_flags));
  }
  return resultobj;
fail:
  return NULL;
}
/*

/* Code generated with void gs_get_size(uint32_t *OUTPUT, uint32_t *OUTPUT);
SWIGINTERN PyObject *_wrap_gs_get_size(PyObject *SWIGUNUSEDPARM(self), PyObject *args) {
  PyObject *resultobj = 0;
  uint32_t *arg1 = (uint32_t *) 0 ;
  uint32_t *arg2 = (uint32_t *) 0 ;
  uint32_t temp1 ;
  int res1 = SWIG_TMPOBJ ;
  uint32_t temp2 ;
  int res2 = SWIG_TMPOBJ ;
  
  arg1 = &temp1;
  arg2 = &temp2;
  if (!PyArg_ParseTuple(args,(char *)":gs_get_size")) SWIG_fail;
  gs_get_size(arg1,arg2);
  resultobj = SWIG_Py_Void();
  if (SWIG_IsTmpObj(res1)) {
    resultobj = SWIG_Python_AppendOutput(resultobj, SWIG_From_unsigned_SS_int((*arg1)));
  } else {
    int new_flags = SWIG_IsNewObj(res1) ? (SWIG_POINTER_OWN |  0 ) :  0 ;
    resultobj = SWIG_Python_AppendOutput(resultobj, SWIG_NewPointerObj((void*)(arg1), SWIGTYPE_p_unsigned_int, new_flags));
  }
  if (SWIG_IsTmpObj(res2)) {
    resultobj = SWIG_Python_AppendOutput(resultobj, SWIG_From_unsigned_SS_int((*arg2)));
  } else {
    int new_flags = SWIG_IsNewObj(res2) ? (SWIG_POINTER_OWN |  0 ) :  0 ;
    resultobj = SWIG_Python_AppendOutput(resultobj, SWIG_NewPointerObj((void*)(arg2), SWIGTYPE_p_unsigned_int, new_flags));
  }
  return resultobj;
fail:
  return NULL;
} */

/* Code generated with no extra definition
SWIGINTERN PyObject *_wrap_gs_get_size(PyObject *SWIGUNUSEDPARM(self), PyObject *args) {
  PyObject *resultobj = 0;
  uint32_t *arg1 = (uint32_t *) 0 ;
  uint32_t *arg2 = (uint32_t *) 0 ;
  void *argp1 = 0 ;
  int res1 = 0 ;
  void *argp2 = 0 ;
  int res2 = 0 ;
  PyObject * obj0 = 0 ;
  PyObject * obj1 = 0 ;
  
  if (!PyArg_ParseTuple(args,(char *)"OO:gs_get_size",&obj0,&obj1)) SWIG_fail;
  res1 = SWIG_ConvertPtr(obj0, &argp1,SWIGTYPE_p_unsigned_int, 0 |  0 );
  if (!SWIG_IsOK(res1)) {
    SWIG_exception_fail(SWIG_ArgError(res1), "in method '" "gs_get_size" "', argument " "1"" of type '" "uint32_t *""'"); 
  }
  arg1 = (uint32_t *)(argp1);
  res2 = SWIG_ConvertPtr(obj1, &argp2,SWIGTYPE_p_unsigned_int, 0 |  0 );
  if (!SWIG_IsOK(res2)) {
    SWIG_exception_fail(SWIG_ArgError(res2), "in method '" "gs_get_size" "', argument " "2"" of type '" "uint32_t *""'"); 
  }
  arg2 = (uint32_t *)(argp2);
  gs_get_size(arg1,arg2);
  resultobj = SWIG_Py_Void();
  return resultobj;
fail:
  return NULL;
}*/


// Can be imported, unclear if necessary
// %include "pybuffer.i"


// Not necessary, already included somewhere
// %include "typemaps.i"

// Does not work, unclear why, it should be the same as redefining arguments in functions
// %apply uint32_t *INOUT { uint32_t *cx};
// %apply uint32_t *INOUT { uint32_t *cy};

// Works only with variables passed as arguments, crashes with None or no argument
// void gs_get_size(uint32_t *INOUT, uint32_t *INOUT);

// Works only with no variable passed as argument, crashes with arguments or None
// void gs_get_size(uint32_t *OUTPUT, uint32_t *OUTPUT);





///////////////////////////////////////////////////////////////////////



%ignore blog;
%ignore blogva;
%ignore bcrash;
%ignore obs_source_info;
%ignore obs_register_source_s(const struct obs_source_info *info, size_t size);
%ignore obs_output_set_video(obs_output_t *output, video_t *video);
%ignore obs_output_video(const obs_output_t *output);
%ignore obs_add_tick_callback;
%ignore obs_remove_tick_callback;
%ignore obs_add_main_render_callback;
%ignore obs_remove_main_render_callback;
%ignore obs_enum_sources;
%ignore obs_properties_add_button;
%ignore obs_property_set_modified_callback;
%ignore signal_handler_connect;
%ignore signal_handler_disconnect;
%ignore signal_handler_connect_global;
%ignore signal_handler_disconnect_global;
%ignore signal_handler_remove_current;
%ignore obs_hotkey_register_frontend;
%ignore obs_hotkey_register_encoder;
%ignore obs_hotkey_register_output;
%ignore obs_hotkey_register_service;
%ignore obs_hotkey_register_source;
%ignore obs_hotkey_pair_register_frontend;
%ignore obs_hotkey_pair_register_encoder;
%ignore obs_hotkey_pair_register_output;
%ignore obs_hotkey_pair_register_service;
%ignore obs_hotkey_pair_register_source;

%include "graphics/graphics.h"
%include "graphics/vec4.h"
%include "graphics/vec3.h"
%include "graphics/vec2.h"
%include "graphics/matrix4.h"
%include "graphics/matrix3.h"
%include "graphics/quat.h"
%include "obs-scripting-config.h"
%include "obs-data.h"
%include "obs-source.h"
%include "obs-properties.h"
%include "obs-interaction.h"
%include "obs-hotkey.h"
%include "obs.h"
%include "callback/calldata.h"
%include "callback/proc.h"
%include "callback/signal.h"
%include "util/bmem.h"
%include "util/base.h"
%include "util/platform.h"

#if UI_ENABLED
%include "obs-frontend-api.h"
#endif

/* declare these manually because mutex + GIL = deadlocks */
%thread;
void obs_enter_graphics(void); //Should only block on entering mutex
%nothread;
%include "obs.h"
