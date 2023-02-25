import obspython as obs
import math, time
import cv2
import numpy as np
import io
import PIL.Image as Image
import dlib


#cascade = cv2.CascadeClassifier("D:/bfxdev/OBS/haarcascade_frontalface_default.xml")
#SRC = cv2.imread('D:/bfxdev/media/bonnasse1.png')
#gray = cv2.cvtColor(SRC, cv2.COLOR_BGR2GRAY)
#faces = cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))

# Description displayed in the Scripts dialog window
def script_description():
  return """<center><h2>Mustache</h2></center>
            <p>Add a mustache to a source</p>"""

# Global variables to restore the scene item after shake
shaken_sceneitem = None     # Reference to the modified scene item
shaken_sceneitem_angle = 0  # Initial rotation angle, used as well for oscillations
shaken_scene_handler = None # Signal handler of the scene kept to restore

# Global variables holding the values of data settings / properties
source_name = ""           # Name of the source to shake
frequency = 2              # Frequency of oscillations in Hertz
amplitude = 10             # Angular amplitude of oscillations in degrees

# Callback for item_remove signal
def on_shaken_sceneitem_removed(calldata):
  restore_sceneitem_after_shake()

# Saves the original rotation angle of the given sceneitem and connects item_remove signal
def save_sceneitem_for_shake(sceneitem):
  global shaken_sceneitem, shaken_sceneitem_angle
  shaken_sceneitem = sceneitem
  shaken_sceneitem_angle = obs.obs_sceneitem_get_rot(sceneitem)

  # Handles scene item deletion
  global shaken_scene_handler
  scene_as_source = obs.obs_scene_get_source(obs.obs_sceneitem_get_scene(sceneitem))
  shaken_scene_handler = obs.obs_source_get_signal_handler(scene_as_source)
  obs.signal_handler_connect(shaken_scene_handler, "item_remove", on_shaken_sceneitem_removed)

# Restores the original rotation angle on the scene item and disconnects item_remove signal
def restore_sceneitem_after_shake():
  global shaken_sceneitem, shaken_sceneitem_angle
  if shaken_sceneitem:
    obs.obs_sceneitem_set_rot(shaken_sceneitem, shaken_sceneitem_angle)

    obs.signal_handler_disconnect(shaken_scene_handler, "item_remove", on_shaken_sceneitem_removed)

    shaken_sceneitem = None

# Retrieves the scene item of the given source name in the current scene or None if not found
def get_sceneitem_from_source_name_in_current_scene(name):
  result_sceneitem = None
  current_scene_as_source = obs.obs_frontend_get_current_scene()
  if current_scene_as_source:
    current_scene = obs.obs_scene_from_source(current_scene_as_source)
    result_sceneitem = obs.obs_scene_find_source_recursive(current_scene, name)
    obs.obs_source_release(current_scene_as_source)
  return result_sceneitem


# Called to set default values of data settings
def script_defaults(settings):
  obs.obs_data_set_default_string(settings, "source_name", "")
  obs.obs_data_set_default_double(settings, "frequency", 2)
  obs.obs_data_set_default_int(settings, "amplitude", 10)

# Fills the given list property object with the names of all sources plus an empty one
def populate_list_property_with_source_names(list_property):
  sources = obs.obs_enum_sources()
  obs.obs_property_list_clear(list_property)
  obs.obs_property_list_add_string(list_property, "", "")
  for source in sources:
    name = obs.obs_source_get_name(source)
    obs.obs_property_list_add_string(list_property, name, name)
  obs.source_list_release(sources)

# Called to display the properties GUI
def script_properties():
  props = obs.obs_properties_create()

  # Drop-down list of sources
  list_property = obs.obs_properties_add_list(props, "source_name", "Source name",
                    obs.OBS_COMBO_TYPE_LIST, obs.OBS_COMBO_FORMAT_STRING)
  populate_list_property_with_source_names(list_property)
  # obs.obs_properties_add_text(props, "source_name", "Source name", obs.OBS_TEXT_DEFAULT)

  # Button to refresh the drop-down list
  obs.obs_properties_add_button(props, "button", "Refresh list of sources",
    lambda props,prop: True if populate_list_property_with_source_names(list_property) else True)

  obs.obs_properties_add_float_slider(props, "frequency", "Shake frequency", 0.1, 20, 0.1)
  obs.obs_properties_add_int_slider(props, "amplitude", "Shake amplitude", 0, 90, 1)
  return props

# Called after change of settings including once after script load
def script_update(settings):
  global source_name, frequency, amplitude
  restore_sceneitem_after_shake()
  source_name = obs.obs_data_get_string(settings, "source_name")
  frequency = obs.obs_data_get_double(settings, "frequency")
  amplitude = obs.obs_data_get_int(settings, "amplitude")

# Global animation activity flag
is_active = False

  

# Callback for the hotkey
def on_shake_hotkey(pressed):
  global is_active
  is_active = pressed

# Identifier of the hotkey set by OBS
hotkey_id = obs.OBS_INVALID_HOTKEY_ID

# Called before data settings are saved
def script_save(settings):
  restore_sceneitem_after_shake()
  obs.obs_save_sources()

  # Hotkey save
  hotkey_save_array = obs.obs_hotkey_save(hotkey_id)
  obs.obs_data_set_array(settings, "shake_hotkey", hotkey_save_array)
  obs.obs_data_array_release(hotkey_save_array)


# Called at script load
def script_load(settings):
  global hotkey_id
  hotkey_id = obs.obs_hotkey_register_frontend(script_path(), "Source Shake", on_shake_hotkey)
  hotkey_save_array = obs.obs_data_get_array(settings, "shake_hotkey")
  obs.obs_hotkey_load(hotkey_id, hotkey_save_array)
  obs.obs_data_array_release(hotkey_save_array)

# Called at script unload
def script_unload():
  restore_sceneitem_after_shake()

  global render_texture
  if render_texture:
    obs.gs_texrender_destroy(render_texture)

counter = 0
stage_surface = None
render_texture = None

detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor("D:\\bfxdev\\OBS\\shape_predictor_68_face_landmarks.dat")


# Called every frame
def script_tick(seconds):

  source = obs.obs_get_source_by_name(source_name)
  if source:
    obs.obs_enter_graphics()

    source_width = obs.obs_source_get_base_width(source)
    source_height = obs.obs_source_get_base_height(source)

    global stage_surface, render_texture
    if stage_surface is None:

      render_texture = obs.gs_texrender_create(obs.GS_RGBA, obs.GS_ZS_NONE)
      stage_surface = obs.gs_stagesurface_create(source_width, source_height, obs.GS_RGBA)

      obs.gs_texrender_reset(render_texture)

      if obs.gs_texrender_begin(render_texture, source_width, source_height):

        clear_color = obs.vec4()
        obs.vec4_zero(clear_color)
        obs.gs_clear(obs.GS_CLEAR_COLOR, clear_color, 0, 0)

        obs.gs_ortho(0, source_width, 0, source_height, -100, 100)

        obs.gs_blend_state_push()
        obs.gs_blend_function(obs.GS_BLEND_ONE, obs.GS_BLEND_ZERO)

        obs.obs_source_inc_showing(source)
        obs.obs_source_video_render(source)
        obs.obs_source_dec_showing(source)

        obs.gs_blend_state_pop()

        obs.gs_texrender_end(render_texture)

        obs.gs_stage_texture(stage_surface, obs.gs_texrender_get_texture(render_texture))

    else:

      res,data,linesize = obs.gs_stagesurface_map(stage_surface)

      if res:

        bitmap = bytearray(source_width*source_height*4)
        for y in range(source_height):
          bitmap[y*source_width*4 : (y+1)*source_width*4] = data[y*linesize : y*linesize + source_width*4]

        obs.gs_stagesurface_unmap(stage_surface)
        
        image = Image.frombuffer("RGBA", (source_width,source_height), bitmap)
        cv_image = cv2.cvtColor(np.asarray(image), cv2.COLOR_RGB2GRAY)

        faces = detector(cv_image)

        for face in faces:
            x1 = face.left() # left point
            y1 = face.top() # top point
            x2 = face.right() # right point
            y2 = face.bottom() # bottom point
            # Draw a rectangle
            # cv2.rectangle(img=img, pt1=(x1, y1), pt2=(x2, y2), color=(0, 255, 0), thickness=4)

            landmarks = predictor(image=cv_image, box=face)
            for i in range(67):
              x = landmarks.part(i).x
              y = landmarks.part(i).y
              cv2.circle(img=cv_image, center=(x, y), radius=2, color=(0, 255, 0), thickness=-1)

        global counter
        counter = counter - 1
        if counter <= 0:
          counter = 100

          print("width:", obs.gs_stagesurface_get_width(stage_surface))
          print("height:", obs.gs_stagesurface_get_height(stage_surface))
          print("linesize:", linesize)
          print("data:", data)
          print("data.hex():", data.hex())
          #print("len(data):", len(data))
          print("type(data):", type(data))
          print("bitmap.hex():", bitmap.hex())
          print("cv_image:", cv_image)
          print("faces:", faces)
          cv2.imshow(winname="Face", mat=cv_image)

      obs.gs_stagesurface_destroy(stage_surface)
      stage_surface = None
      obs.gs_texrender_destroy(render_texture)
      render_texture = None

    obs.obs_leave_graphics()
    obs.obs_source_release(source)
