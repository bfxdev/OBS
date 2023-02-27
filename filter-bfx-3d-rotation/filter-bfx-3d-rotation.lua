-------------------------------------------------=--------------------------------------------------
--                                                                                                --
--                                    BFX 3D Rotation Filter                                      --
--                                                                                                --
--                                     v1.0 - bfxdev - 2023                                       --
--                                                                                                --
--  Changelog:                                                                                    --
--   - 2023-02 v1.0: First version                                                                -- 
--                                                                                                --
-------------------------------------------------=--------------------------------------------------

-- Module obslua renamed by convention for commonality with Python code
obs = obslua

--------------------------------- GENERAL INFORMATION ON THE FILTER --------------------------------

-- Returns the description to be displayed in the Scripts window
-- See https://obsproject.com/docs/scripting.html#script_description
-- See https://doc.qt.io/qt-5/richtext-html-subset.html
function script_description()

  local alien="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABMAAAAVCAYAAACkCdXRAAAAAXNSR0IArs4c6QAAAARnQU1BAACxj"..
  "wv8YQUAAAAJcEhZcwAADsIAAA7CARUoSoAAAADwSURBVDhPtZQxDsIwDEUDYoSBHWhHbsPC2tOxsnAbxhbYGWBEAn0rBid20lDBk1BS17z+hBT3"..
  "S0Z+TFItq6efuu7cZfuTN1ky26/d9XCh2mR3pzElNYsQQSJhIYDUEqqCJWL6hGM/EjlRzKOZBvsJ3uZSkUwHZMIgWQnzzcLPNGTkVLftkYqMlTT"..
  "uwXI5nUrWnlr6gPiLfC17JOYy61XtZx+BFMv7EiXjRuvJsmYJSYb14slyj6zmuCb3C9cq2TfnLCY4wSVnLfcWmD/AUIJkIJeu791UMmAJB/1rMB"..
  "BihJRFkABLBJIyhqUgJfkDzr0Amw2KoGT2/LMAAAAASUVORK5CYII="

  local logo="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGAAAABgCAYAAADimHc4AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjw"..
  "v8YQUAAAAJcEhZcwAADsIAAA7CARUoSoAAABVVSURBVHhe7d0HjF3F1QfwgVACgWCq6b2EFiD03qsAUUIJYEQRVSCBANERHYRoAgyiV4uW8IEQo"..
  "iZA6C30bsD0XhN68fd+s3t2Z6/v22Kv17u2/9LRzJ07d8o5Z86cKW93ktR/MahBS7eS+JoNgnlbqQ4jWgnub9BXDXqmlcT7HfqTADB5iwZhdDC+"..
  "NxGCIJibG9QvBdLXoMkHNOjpBo3sY1KnupuNpvEaNP3/GlTHmHFB2qJN4z12adBbDapjQn8gbdPG8Q79nfFVGm8EsVaDBhLjq6Tt+jDgwKPpTzZ"..
  "+TElf9GlAwGT2ZYPqOjKQSZ/69URNQy5vUF3jxyfSx343GvjS48KXH1ekr/1m/WDFOj6anK5In3t7td5jcNXqGjch0ThzVycyv536XAgTmT8q9Z"..
  "kQJjK/OY11IZh06iqeSO001iZmbteE6O30lPCo111UC48Jyc8fU8KrXl2sTQgr3N4mPOsV2P+oq2AidU1d7h11dSZsGNmS7Xd7HwMEzp3naw1rM"..
  "Wlr2Az9cuNpAAHvOjVFnY0ABxH3tkR7B5NM0l5dGW+GkSON4nZUnwcQ1m7QfS3RjuiMC0zPaLlTJXMnnXTSTL/++mv67bffWlN7DmVONtlkOa6s"..
  "UhgDQDDuKjFFo6CZAKzoejyLY/Tvfve79PPPP7emdMTUU0+dmSjfVFNNlaaffvo05ZRT5mdMDMH98MMP6dtvv03//e9/24T25Zfc63pEvfKifiq"..
  "QXRt0RUu0Hc0E0G3t13n0yy+/tKa0YLrppstpG264Ydp8883TDDPMkP7yl7+kKaaYIn333Xfpj3/8YxbATz/9lPMFAwnhf//7X/r666+zEP7whz"..
  "/kd6+88kr6+OOP06BBg9KwYcPSfffdlxlN2PJWEaMlhNIPUDsK6gTQLe2vMh7jVltttczkTTfdNK2wwgqZyYHPP/883X333ZlZ77zzTvrkk0/S7"..
  "LPPnhn1wgsvpFdffTWXh1nSMH6WWWZJc845Zx4l0gYPHpxmm2229M0336SVV165rQ2PPvpoevHFF9Pbb7+dnnzyyTR8+PDWWltAgEBg41gYo4yC"..
  "OgF0qv0YrUPB+D/96U9p1VVXTfvtt19aeun2bZA333wzPfbYY+nWW29N7733Xtb6zz77LGv3HHPMkbbccsvM4Ouuuy5rOsJMCEax9WHOpHlW7+S"..
  "TT54FQ0iEPO+88+aRZkTNPPPM6auvvkqXXnppFvpTTz3VQSAEGeUL+xijjIKqACwc3ACoBcZjAtDA3XbbLW2zzTbZ3MCHH36Y7rrrrnTTTTflOC"..
  "2nvb4LoS244ILp7LPPzlq8ww47ZBOEKZhfxxACR9W47+RHyv3++++zmZtnnnmyUAjEKNReCvD444+nm2++OT3//PP5e1Cn8qJPfYQtG+RuakZVA"..
  "E2v6AXzadnRRx+d9t9//8w4wOhrrrkm/eMf/8h2Wjqiqb4pNe68885La6+9dtp3330zQ5RHy4P5EUIZD4QQqqR96lCWOgnFfDP33HOntdZaK627"..
  "7rp5xL3++uvp4YcfThdffHH69NNPW0tt6V+0cywD8wkhoxQAs8P8dEB0UMNo1QUXXJDmm699FDEx5557bh7mTEIwXf5guu+ZHhopL827/fbb06G"..
  "HHpq1FbPkC4ZXwzpEuyIe2iwMAgIxOrRrxhlnTFtssUVaZpll0mKLLZbnHaPxzjvvzHmhjwSBgfkafcvs1AKT70Yt0XboiMbsvvvu6YYbbsga6x"..
  "mTTzrppHT66adn5k477bS54ZhZMj+YiBGYvdFGG2XzwRSNGDEi22juaflNXbxK1Xyl0MXjWfu5vASg3oceeigz/IEHHsjzxS677JIOOuig7F298"..
  "cYb2UlQXoxu8bGAtxv0qEgpgAsaNGtLtAUxrPfaa6900UUX5TTPQHu5g+y/fBjsnQZXSbo8H3zwQfaSjCCTrnnkrbfeyi4m6HR19JRhSdW0urxl"..
  "3OjwTNhMk4n6n//8Z56zmNBtt902HXvssXmUUAzmSX6CE/Yy8PlCkTBB9iw6rHQwDDNoLHMBnqWffPLJ6ZJLLsmTXmeMR/EOeEKLL754Ov/887N"..
  "m+vb3v/99uvLKK9NVV12VPvroo7bFWjAO4vsIS5RmqI60l+b/+OOP2SHAfGlCJI8RLG2NNdZIe+65Z1pkkUXSv/71r3T44YfnOQOCH72I6Rv0VY"..
  "yA7RvUNvlqlM4zNyZWWqETtOHBBx9Mp5xySpvZKJki3ozk1WHuqXXAOuuskxlttbvSSiulVVZZJefhy8fkGHYcoq4Iy3Lr0hGmGWnmnh133DGbQ"..
  "MzWDqttCsHk6AvhaNvf//739MQTT6Stt946HXLIIXndwYOSF5Sp7F7Aqw16JkaAhVfbgXJI+7DDDsvMZtfDPPBe7r333mzzaXC106hkRjWubNsK"..
  "yy23XNaw+eefP0+SmEDA7PAjjzySrr766iwM79SLaZhEOUB5gUgTBnkfc9Pll1+ell9++axE+kGwzB5XmYbfc889Oa4e32mjtnI6zHPadsQRR+Q"..
  "JG4IXZRtGAxZku4YAHKHlVVQ0XmjCYqcxGnP40DvvvHNbxc0YXVI1D8IAmjfrrLNm7Ve2iZKgjTqLLNrKqyKMZ599Nr3//vvZ02JKlAXaGIh2R3"..
  "yaaabJQj7ggAPyYtEi0HxD+OohTPXLQ1DSCcXk/NJLL2V3mvC5rvvss0+m5557LisgvkAo6mjC79WW0YMO9h9zMGn99ddPt912W2aOSlTGHJl8Y"..
  "5+nZGzEyzQIplffYRKNNLQjTahcRAjICOEy8udpM8ZoV2isvKA8momxa665ZqaZZpopT7LyYzDTxuT5Rn79iHKZmgUWWCCtuOKKWfjPPPNMXi/Y"..
  "JlEnRTzrrLPSQgstlE444YR03HHH5frxh4KOJqYngA77/iHVI488Mp144oltEpZ+zjnnpDPPPDN3rDQ/VQbXpZXPZRwjPEOkAxuN1C/dvhEGMQs"..
  "WcrTXKMJQZVAczIiJlraz4bSZYEI48uhL1Ksf4qBu75ZaaqncR0KUxz4Tj4nCcFltu9hzMq+89tprbTwbDaxtEjb5tvn/GqMhFiykHgzRQRph44"..
  "tpCKZB5ClRTWv2LFQWEkc6o76w+4iZMEmafyz+uI6EYIMOY2LkxORqpDIZtBzzMQnUE0LVV+8IpayLN8bcMTW2MWj9sssumz22G2+8MY8Orvkee"..
  "+yRzTLTFUpQ7WcXeJabUXvkGPs7JTC+OxVoTFCgs+cyLNNDIJiFSUwD2x6bbZhgLSKPiRJjhbysl19+OcdpeAgYRZlRrm9QCBARhrrMSwTARba/"..
  "5d3GG2+c1wkbbLBB+uKLL9Itt9yShR3lEUIPMEju+AV6RnTepAfxDOwlRqioRJVxUKaV78o4lOkBnYh8KDoVTMQgdptdtxI/+OCDM1NM4BgRGi4"..
  "OEUKZ1oxCIEIjR13cWe4pC6Ae72wmMnGnnnpquvDCC7PAeyiENZvm5A6CAoM5Sy65ZBaCIR+VlIyDZs/CZlRleB3JEwSlINhjXorFk2dmiQ3HpP"..
  "i+DnXMD1J+EGGAEUEQJmZmzqTODJkjLOCGDh2a8/km2tkVGMZjG9RmhjRWAzR+u+22y0MepDFLhqR9/uo80BMoq4oqo+K5WVqkK4ttxhAC4Daap"..
  "NlxGhtaWf22jqAuHs/qwljzRqysbatzlTkHDqSWWGKJvJiLvHV9LUEALauLVsSHXC8+sq2DsgMEcscdd7SlyR9hFdHwKiK97r20anqZVoZIW7XF"..
  "aNCGf//73/lgiK0W1w+aG+0MAt+WaZHe7DniEPUSvjpMxOr885//nNvCa5K3ji8FBsUI6ICQnIY7uSobwB20qUa7CEMjOkP5bYloXPV9XV4o89U"..
  "xTlnmJ5qJGbYSrH6NCh4URlWFgKKsunKhWQjiyjTKrKjNFxaWq6++evbS8EiaPM1QK4CArQBS5e6VjV944YXzitGRn2HYWQWdodqZeI54TyiUBq"..
  "PffffdbC650jbWTJwmbIyK8uVH8Vwtq5pWR/GtevHhP//5T953oqTWEBaATGG0rQ5NBeAjS3ELna222qo1tX0uMNFZZUJUEI1qhrLhUHYiwmYUi"..
  "Hj1fZC2mL+YASdhzp9pJG+Fp0RAweDOykGRrysC8wJ+MUdugRCIBd0VV1zRZq7r0OkIAAsN3o/tAAXFkHKgolAjQWXQlRDinbCMl2Eg8pTUFUPi"..
  "fQjB6BXnEdla4b05BdPOWJhVy6ijar2BiEdI6JwUcyfBzzXXXPnZyCCgOnPdqQBUrLEKYFNpfunasbG2AwzxGN7dFUIVUWZQoJoeVH0Xz9oM5gO"..
  "ayC01L2COsw0j9/77788CqDK2JKi+L5+jnngGTI7tbtvtYD/LQo7wI18JpcSf+BoFofGW5bvuumuHEYDgqKOOSkOGDMmCUEF3NUsHSmr2rnwu35"..
  "cMLJ+FlMTmmiNHbY7Fo1WxkStPfFdXfvmupLJfES+hXibu6aefzuYIj5wA/u1vf8vvlVnBiE4FAAr1oUtVNqHAcwhBI+wMWpCQvo7ShGgois6Un"..
  "YJIq6Nm74LRzZ7DE3Lw7pxXG4PhvDruof0i+aIOYTVeUqCMlwhegDJsUfCCIv8mm2ySw8hTYAR1dRDT5TVEBXOrrATtgyg8ChS3CHFyZgMLA2gC"..
  "YcT7auPL57p4fFOlZu8AU2ke+3vMMcdkRQDtYIpsrzhgkl9/oMr06jPUvWuWjqyczTm8ITAHXXvttXnR5n2BPAL8EbtOERL2sb2XAw88MKerON4"..
  "h27OurdjD5/Z5T/ugbGDZ4Lq4sIyX76vPEXIEaDam20p3QSu2zGm+PE63mEp5q98HRdklRXr0I8KgKtTJcoDQ6nzRRRfNz8oqcL+nbv31QIUGHM"..
  "05GaLpCgxNFzrb5XrxwTEkJsDoRLNOVkm+8ptqPIjWC+2QmmDPOOOMPAFSAMLnOJgACcXoNBL0pawn4mVapFdDqIYQcWVrE60vQQlq8BUBOBrrF"..
  "qLhGkPTeRkWGjqK+d4JTX4Ycdppp2VzYMHm23JuqHayjFfzBKlHGQQqVJdhTcus2J398v2l2U5G7h3tvffe+S5Q7JaWZXZWf0lQjUcYcd8adUxP"..
  "mJ94Ryg1yIfyo1xJ6QpRKQbY+3BUF26XNIg8mO8aoEtdGEMDpWMaZoAQ+TbiSL7yvW9os1FFGDTexWDupZEHvpHXoYmrj1ajvolNOe8iX6AuXg1"..
  "BvEwvCTDZBOycwoWG4AXBUFYHSdod5qmBfCQJbYfyPUEUZsJ1qcm+fKRplM56BqdTDlFoooZhiIZFY6IT8vsutCnsuPeEx4202WaT0GG7m9EmPS"..
  "MxLnkxNcgOqf0qZQYzoqw6lOl1cWE1Hs/q0FYmzz1Zl8/0TTqFMTKtlzy39rntUB46XEvpCYoCs3cUkzCEIABDgUm47LLL8g8sNIxtDJNCkMyES"..
  "QtjDWOdcgGMKVOXCVQ+Nt4GGOLy8XCcYcTkb7tc/lLrmyHaGCifq/F4LuPqE+eGU0TOSKn99tQcabIG8rW2p8O1lG79KKMZFKoiDMcsB9duT9NY"..
  "CEEEgUMUmuKcWcNCCJFHvNw8Q4RhYmdSStKhEAymy6vOrhgfkL9E+RzxuhCpD3hXruub7EHd2qAflJLTgkchmAbyjzWiph7PA3UoR4ONKKtkG3k"..
  "q1qCoPBoNzIb5wYhw6M6cYLyGi/umaHRbx5Fyy7LLOkYXyg1EvC5NvdrIzFEKzHc2bB7QDiSPUWFn1HaO56J9+Wpie8mjOQ9UoRKIiqwCrRvWW2"..
  "+9/FwySd7okAnaKpXtdsJkV9G7mCtQyeigQBkv0Sy9RMngQB3ThdFmymGn2HrDaLdXBurzXjvlZZLsFIgXzM/2X6Ss2R+yPqslOuaoVJi23377v"..
  "JXBawmEmdDgclS41eAOqqNPxLNQFu1iqiKvb6sEwbB47g7iG/Cd5ypJN2/ReKaWctkji99LxHf6pY3XX3992mmnnbKw4vtWWMnmk8hSALU/0BgT"..
  "qDQEEY3TaLcJNttss7Y5wvsQlvwo4HDFROuCLC/ChGZYK08+HSUY5iDgXdHZtni0oRqHiAuD5AlPLJhqd9M2A7cyVrfaHvmRfO6bOlOnPFVlbKD"..
  "tBxqlAGCs/RVxjYr5AewS/vWvf82NDK8JSmH4JhgD7K3RYa4wiXM5eUBWwbEgkz+EGN+HQCMMYFaEMRoRjQ2G88p4Yw7b2XKbfLHKjXaqQ1x+cN"..
  "3enVTtqmF+058oQac/0usNaKQGRed1xiLKbqr7+VavgWAM6GR0MOA9DXM9xGTumiABuYjLKyEUXlJsDTMdysBgzzwnodHDbeUSIwxn2x29xlojP"..
  "DKoMLRNsFzh448/Pq93tLuG+dDpj/RgtP9EQU+gcZgaDAadNVlb2VphO1EqIW90yPdVgZTAeKbKqCEIu7jst3QCYLbUj+GEzhwSAqGUzA4QVBBE"..
  "+4ESuLLo92/uCEET5o/yM9U6WBOopU+o0YmRDUbmsEwfPHjwyCFDhowcNmzYyEanRjbscKPvHdEQSE5vMDWTeIO5Ixsdb80xevC9cpQXZdaVO3z"..
  "48JFDhw4d2TBPbe1uMH6UvhQ0ymK3bgRAn4yCKkKraE6jf62pKW8nsL1Wky7K2orw3GSHMUMZCJSl3LJMKNPEIyy1uwrzDg/NWbiJ1hUdkB9FnT"..
  "Wo1f5mAhijlXFvIBhRFQYwE8yV/SC2mhvo0oCQOYm1w5igofnZhLHrblTYy/JDEYdS1iiBbjA+0KM/1gHjZBTUITqJqYRRzhsBE6n7S44hjRg7p"..
  "TbGuI3S3GnFJFvlyjIhe++HHpiNuLue7ScJbZGYzHlaJZqN1E7QLdtfhR9uKL3fUaPz2daaO5B4Xb468q2wp99EXfF9D6npf+HobATAWFsX9DZo"..
  "JIp4IDS0GgbKb8rvIPJ2w7x0hg5+fxVdCcAmHVNU+yOOgQzM7qb5GBOM8R/t86HJY7xDHzAf8K5bZ+5dgUekxROp+9SrXiQTNPFPF3efev1PFwO"..
  "X1KFNXYUTqZ3waKy57w5s6iqdSO00xodaXaFP94oGGI2y1zO2MFEIo1KfMT8wUQjt1OfMD0wUwjhkfsCkMyF6R/o81ifc7oLbNSGtE/S1X+wUl7"..
  "DwmBBWzPrYr/fG7J6OjyZJnwbEzjDQEFvZdR0ZiKQv/Vrrm8FBhO3suk4NBNL2pocpAwlctYEkCG0d5+7l2EB/F8R4y/gq4gZeHRPGBQ2Yo9feB"..
  "l/arexxsYZQp7rHqT/f1ZlwX4KXQQv9DTsrzN5eZbqTj/wu2kF5rxwVjin6kwCqIJAQhHj8cUEa20xr3b/J174bwGhMDsb3C4Z3REr/D6OnYw/6"..
  "hHAQAAAAAElFTkSuQmCC"


  local description = [[
  <center><img src=']] .. logo .. [['/></center>
  <center><h2> BFX 3D Rotation </h2></center>
  <center>Version 1.0 - <a href="https://github.com/bfxdev/OBS">bfxdev</a> - February 2023</center>
  <p>This Lua script adds a filter named <b>BFX 3D Rotation</b> that can be added to a source to
  display it, and optionally animate it, like a 3D object in space.</p>
  <p>Because the script relies on a perspective projection, the rendered picture may exceed the
  boundaries of the source transform, use the parameters to adapt to your needs.</p>]]

  return description
end

-- Called on script startup
-- See https://obsproject.com/docs/scripting.html#script_load
function script_load(settings)
  obs.obs_register_source(source_info)
end

-- Definition of the global variable containing the source_info structure
-- See https://obsproject.com/docs/reference-sources.html
source_info = {}
source_info.id = 'filter-bfx-3d-rotation'       -- Unique string identifier of the source type
source_info.type = obs.OBS_SOURCE_TYPE_FILTER   -- Either INPUT or FILTER or TRANSITION
source_info.output_flags = obs.OBS_SOURCE_VIDEO -- Combination of VIDEO/AUDIO/ASYNC/etc

-- Returns the name displayed in the list of filters
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.get_name
source_info.get_name = function()
  return "BFX 3D Rotation"
end

-- Creates the implementation data for the source, including shader compilation
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.create
source_info.create = function(settings, source)

  -- Initializes the custom data table
  local data = {}
  data.this_source = source   -- Keeps a reference to the present filter as a source object
  data.width = 1              -- Dummy width value during the initialization phase
  data.height = 1             -- Dummy height value during the initialization phase

  -- Compiles effect file
  obs.obs_enter_graphics()
  data.effect_compilation_failed = false
  --local effect_file_path = script_path() .. 'filter-bfx-3d-rotation.effect.hlsl'
  --data.effect = obs.gs_effect_create_from_file(effect_file_path, nil)
  data.effect = obs.gs_effect_create(EFFECT, 'filter-bfx-3d-rotation', nil)

  -- Replaces the effect with an annoying solid PINK color if the compilation failed
  -- This part should not be modified, it shows an example of an effect file embedded in Lua
  if data.effect == nil then
    data.effect_compilation_failed = true
    print("Effect compilation failed")     -- Logs the error in scripts log and OBS log
    local FALLBACK_EFFECT=[[uniform float4x4 ViewProj; uniform texture2d image;
      struct ShaderData { float4 pos : POSITION; float2 uv  : TEXCOORD0; };
      ShaderData vertex_shader(ShaderData vtx)
      { vtx.pos = mul(float4(vtx.pos.xyz, 1.0), ViewProj); return vtx; }
      float4 pixel_shader(ShaderData pix) : TARGET
      { return float4(1.0,0.0, 0.5, 1.0); }
      technique Draw {
        pass {
          vertex_shader = vertex_shader(vtx);
          pixel_shader  = pixel_shader(pix);
        }
      } ]]
    data.effect = obs.gs_effect_create(FALLBACK_EFFECT, 'fallback_effect', nil)

    -- Deactivates filter if the fallback cannot be compiled as well (should not happen)
    if data.effect == nil then
      print("Fallback effect compilation failed")
      source_info.destroy(data)
      return nil
    end
  end

  obs.obs_leave_graphics()

  -- Retrieves the shader uniform variables after successful shader compilation
  -- This must be done before the first rendering is performed
  if not data.effect_compilation_failed then
    data.params = {}
    data.params.target_resolution = obs.gs_effect_get_param_by_name(data.effect,"target_resolution")

    data.params.perspective_level = obs.gs_effect_get_param_by_name(data.effect,"perspective_level")
    data.params.perspective_centered = obs.gs_effect_get_param_by_name(data.effect,
                                                                        "perspective_centered")
  end

  -- Initializes counters
  data.delta_rotation_x    = 0.0
  data.delta_rotation_y    = 0.0
  data.delta_rotation_axis = 0.0
  data.delta_axis          = 0.0

  -- Calls update to initialize the rest of the properties-managed settings
  source_info.update(data, settings)

  return data
end

-- Destroys and releases resources linked to the custom data and the effect
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.destroy
source_info.destroy = function(data)
  if data.effect ~= nil then
    obs.obs_enter_graphics()
    obs.gs_effect_destroy(data.effect)
    data.effect = nil
    obs.obs_leave_graphics()
  end
end


-- Sets the default settings for this source
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.get_defaults
-- See https://obsproject.com/docs/reference-settings.html
source_info.get_defaults = function(settings)

  obs.obs_data_set_default_int(settings,    "control_mode", 1)
  obs.obs_data_set_default_double(settings, "rotation_x_angle", 0.0)
  obs.obs_data_set_default_double(settings, "rotation_y_angle", 0.0)
  obs.obs_data_set_default_double(settings, "rotation_axis_angle", 0.0)
  obs.obs_data_set_default_double(settings, "axis_angle", 0.0)
  obs.obs_data_set_default_double(settings, "scale", 1.0)
  obs.obs_data_set_default_double(settings, "perspective_level", 0.2)
  obs.obs_data_set_default_bool(settings,   "perspective_centered", false)
  obs.obs_data_set_default_bool(settings,   "animation_activated", true)
  obs.obs_data_set_default_double(settings, "rotation_x_speed", 0.0)
  obs.obs_data_set_default_double(settings, "rotation_y_speed", 0.0)
  obs.obs_data_set_default_double(settings, "rotation_axis_speed", 0.0)
  obs.obs_data_set_default_double(settings, "axis_speed", 0.0)

end


-- Adapts the visibility of displayed properties depnding on control mode
function set_visibility(props, property, settings)

  local mode = obs.obs_data_get_int(settings, "control_mode")

  obs.obs_property_set_visible(obs.obs_properties_get(props, "rotation_x_angle"), mode~=3)
  obs.obs_property_set_visible(obs.obs_properties_get(props, "rotation_y_angle"), mode~=3)
  obs.obs_property_set_visible(obs.obs_properties_get(props, "rotation_x_speed"), mode~=3)
  obs.obs_property_set_visible(obs.obs_properties_get(props, "rotation_y_speed"), mode~=3)
  obs.obs_property_set_visible(obs.obs_properties_get(props, "rotation_axis_angle"), mode==3)
  obs.obs_property_set_visible(obs.obs_properties_get(props, "axis_angle"), mode==3)
  obs.obs_property_set_visible(obs.obs_properties_get(props, "rotation_axis_speed"), mode==3)
  obs.obs_property_set_visible(obs.obs_properties_get(props, "axis_speed"), mode==3)

  return true
end

-- Creates a set of properties to be displayed in the filter GUI
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.get_properties
-- See https://obsproject.com/docs/reference-properties.html
source_info.get_properties = function(data)

  -- Creates the data structure to be returned
  local props = obs.obs_properties_create()

  -- Short info
  local description = [[To avoid clipping:<ul><li>Move the filter at the end of the list</li>
  <li>Set "Scale Filtering" to "Disable" in the source settings</li></ul>]]
  obs.obs_properties_add_text(props, "dummy", description, obs.OBS_TEXT_INFO)

  -- Control Mode
  lprop = obs.obs_properties_add_list(props, "control_mode", "Control Mode",
                                      obs.OBS_COMBO_TYPE_LIST, obs.OBS_COMBO_FORMAT_INT)
  obs.obs_property_list_add_int(lprop, "Rotation around X then Y", 1)
  obs.obs_property_list_add_int(lprop, "Rotation around Y then X", 2)
  obs.obs_property_list_add_int(lprop, "Rotation around axis in XY plane", 3)
  obs.obs_property_set_modified_callback(lprop, set_visibility)

  -- Main rotation parameters
  obs.obs_properties_add_float_slider(props, "rotation_x_angle", "Rotation X",   -180, 180,     1)
  obs.obs_properties_add_float_slider(props, "rotation_y_angle", "Rotation Y",   -180, 180,     1)
  obs.obs_properties_add_float_slider(props, "rotation_axis_angle", "Rotation Angle",   -180, 180,     1)
  obs.obs_properties_add_float_slider(props, "axis_angle",     "Axis Angle",          0, 360,     1)
  obs.obs_properties_add_float_slider(props, "scale",          "Scale",         0.1, 4.0, 0.001)
  obs.obs_properties_add_float_slider(props, "perspective_level",    "Perspective level", 0.0, 1.0,  0.01)
  obs.obs_properties_add_bool(props, "perspective_centered", "Vanishing point centered on source")

  -- Animation parameters
  local group1 = obs.obs_properties_create()
  obs.obs_properties_add_group(props, "animation_activated", "Animation",
                               obs.OBS_GROUP_CHECKABLE, group1)
  obs.obs_properties_add_float_slider(group1, "rotation_x_speed", "Rotation X Speed", -5, 5, 0.01)
  obs.obs_properties_add_float_slider(group1, "rotation_y_speed", "Rotation Y Speed", -5, 5, 0.01)
  obs.obs_properties_add_float_slider(group1, "rotation_axis_speed", "Rotation Speed", -5, 5, 0.01)
  obs.obs_properties_add_float_slider(group1, "axis_speed",     "Axis Speed",     -5, 5, 0.01)

  return props
end


-- Updates the internal data for this source upon settings change
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.update
source_info.update = function(data, settings)

  data.control_mode = obs.obs_data_get_int(settings, "control_mode")
  data.rotation_x_angle     = 2*math.pi*obs.obs_data_get_double(settings, "rotation_x_angle")/360
  data.rotation_y_angle     = 2*math.pi*obs.obs_data_get_double(settings, "rotation_y_angle")/360
  data.rotation_axis_angle  = 2*math.pi*obs.obs_data_get_double(settings, "rotation_axis_angle")/360
  data.axis_angle           = 2*math.pi*obs.obs_data_get_double(settings, "axis_angle")/360

  data.scale                = obs.obs_data_get_double(settings, "scale")
  data.perspective_level    = obs.obs_data_get_double(settings, "perspective_level")
  data.perspective_centered = obs.obs_data_get_bool(settings, "perspective_centered")

  data.animation_activated  = obs.obs_data_get_bool(settings, "animation_activated")
  data.rotation_x_speed     = 2*math.pi*obs.obs_data_get_double(settings, "rotation_x_speed")
  data.rotation_y_speed     = 2*math.pi*obs.obs_data_get_double(settings, "rotation_y_speed")
  data.rotation_axis_speed  = 2*math.pi*obs.obs_data_get_double(settings, "rotation_axis_speed")
  data.axis_speed           = 2*math.pi*obs.obs_data_get_double(settings, "axis_speed")

end

-- Called each video frame with the elapsed time
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.video_tick
source_info.video_tick = function(data, seconds)

  -- Updates animation counters
  if data.animation_activated then
    data.delta_rotation_x    = data.delta_rotation_x    + seconds*data.rotation_x_speed
    data.delta_rotation_y    = data.delta_rotation_y    + seconds*data.rotation_y_speed
    data.delta_rotation_axis = data.delta_rotation_axis + seconds*data.rotation_axis_speed
    data.delta_axis          = data.delta_axis          + seconds*data.axis_speed

  -- Resets the counters if animation is not activated
  else
    data.delta_rotation_x    = 0.0
    data.delta_rotation_y    = 0.0
    data.delta_rotation_axis = 0.0
    data.delta_axis          = 0.0
  end

  -- Resets the counters if the related speed is zero
  if math.abs(data.rotation_x_speed) < 0.01 then data.delta_rotation_x=0.0 end
  if math.abs(data.rotation_y_speed) < 0.01 then data.delta_rotation_y=0.0 end
  if math.abs(data.rotation_axis_speed) < 0.01 then data.delta_rotation_axis=0.0 end
  if math.abs(data.axis_speed) < 0.01 then data.delta_axis=0.0 end

end

-- Called when rendering the source with the graphics subsystem
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.video_render
source_info.video_render = function(data)

  -- Determines the target source resolution, taking potential re-scaling into account in the filter
  -- chain. Values of width and height need to be kept to be returned by get_width and get_height.
  local target = obs.obs_filter_get_target(data.this_source)
  data.width = obs.obs_source_get_base_width(target)
  data.height = obs.obs_source_get_base_height(target)

  -- Begins the rendering
  -- See https://obsproject.com/docs/reference-sources.html#c.obs_source_process_filter_begin
  -- See https://github.com/obsproject/obs-studio/blob/master/libobs/obs-source.c#L4310
  obs.obs_source_process_filter_begin(data.this_source, obs.GS_RGBA, obs.OBS_NO_DIRECT_RENDERING)

  -- Sets shader data for the draw if the shader compilation was successful
  if not data.effect_compilation_failed then

    -- Saves the current matrix
    obs.gs_matrix_push()

    -- Sets common uniform variables in the shader
    local target_resolution = obs.vec2()
    obs.vec2_set(target_resolution, data.width, data.height)
    obs.gs_effect_set_vec2(data.params.target_resolution, target_resolution)

    -- Sets other custom parameters
    obs.gs_effect_set_float(data.params.perspective_level, data.perspective_level)
    obs.gs_effect_set_bool(data.params.perspective_centered, data.perspective_centered)

    -- Rotates and scales around the center of the source
    -- Perspective is managed in the shader (with real final pixel coordinates)
    obs.gs_matrix_translate3f(data.width/2.0, data.height/2.0, 0.0)
    if data.control_mode == 1 then
      obs.gs_matrix_rotaa4f(1.0, 0.0, 0.0, data.rotation_x_angle + data.delta_rotation_x)
      obs.gs_matrix_rotaa4f(0.0, 1.0, 0.0, data.rotation_y_angle + data.delta_rotation_y)
    elseif data.control_mode == 2 then
      obs.gs_matrix_rotaa4f(0.0, 1.0, 0.0, data.rotation_y_angle + data.delta_rotation_y)
      obs.gs_matrix_rotaa4f(1.0, 0.0, 0.0, data.rotation_x_angle + data.delta_rotation_x)
    else
      obs.gs_matrix_rotaa4f(math.cos(data.axis_angle + data.delta_axis),
                            math.sin(data.axis_angle + data.delta_axis), 0.0,
                            data.rotation_axis_angle + data.delta_rotation_axis)
    end
    obs.gs_matrix_scale3f(data.scale, data.scale, data.scale)
    obs.gs_matrix_translate3f(-data.width/2.0, -data.height/2.0, 0.0)

  end
  -- Completes the filter processing i.e. starts the draw through the effect shaders
  obs.obs_source_process_filter_end(data.this_source, data.effect, data.width, data.height)

  -- Restores context
  obs.gs_matrix_pop()
end

-- Returns the width of the source
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.get_width
source_info.get_width = function(data)
  return data.width
end

-- Returns the height of the source
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.get_height
source_info.get_height = function(data)
  return data.height
end

EFFECT = [[
// OBS-specific syntax adaptation to HLSL standard to avoid errors reported by the code editor
// See https://obsproject.com/docs/graphics.html#rendering-graphics
#define SamplerState sampler_state
#define Texture2D texture2d
#define SV_Position POSITION
#define SV_Target TARGET

// Constants
#define PI 3.141592653589793238
#define EPSILON 0.00000001

// Mandatory - Set by OBS: View-projection matrix to adapt raw coordinates according to transform
uniform float4x4 ViewProj;

// Mandatory - Set by OBS: Texture with the source picture transformed by previous filters in chain
uniform Texture2D image;

// Pixel resolution of the source after scaling filter if any
uniform float2 target_resolution;

// Factor to increase perspective effect
uniform float  perspective_level    = 0.0;

// True if the perspective needs to be centered on the source (otherwise center of the viewport)
uniform bool   perspective_centered = true;

// Interpolation method and wrap mode for sampling a texture
// See https://docs.microsoft.com/en-us/windows/win32/api/d3d11/ns-d3d11-d3d11_sampler_desc
// See https://obsproject.com/docs/graphics.html#effect-sampler-states
SamplerState linear_clamp
{
  Filter    = Linear;     // Anisotropy / Point / Linear
  AddressU  = Clamp;      // Wrap / Clamp / Mirror / Border / MirrorOnce
  AddressV  = Clamp;      // Wrap / Clamp / Mirror / Border / MirrorOnce
};

// Sampler state with infinite repetition of the image if zoomed out
SamplerState anisotropy_clamp
{
  Filter    = Anisotropy;
  AddressU  = Clamp;
  AddressV  = Clamp;
};

// Common data structure used for vertices sent as input to the vertex shader
// /!\ This structure cannot be changed as vertex data is sent by OBS
// OBS renders sources as rectangles from (0,0,0,0) to (width,height,0,0)
struct VertexData
{
  float4 pos : POSITION;
  float2 uv  : TEXCOORD0;
};

// Data structure used to transmit data produced by the vertex shader to the pixel shader
// /!\ The member with "POSITION" semantics is mandatory, even if not used in the pixel shader
// An instance of the structure is produced for each vertex then the values are interpolated by
// the GPU, according to the interpolation semantics, to be used as input for each pixel
// See https://learn.microsoft.com/en-us/windows/win32/direct3dhlsl/dx-graphics-hlsl-semantics
// See https://obsproject.com/docs/graphics.html#effect-vertex-pixel-semantics
struct PixelData
{
  float4 screen_position : POSITION;
  float2 uv              : TEXCOORD0;
};

// Vertex shader implementing the 3D rotation
PixelData vertex_shader_perspective(VertexData input_vertex_data)
{
  PixelData result;

  // Computes the position of the current vertex on screen
  result.screen_position = mul(float4(input_vertex_data.pos.xyz, 1.0), ViewProj);

  // Adds to w, normally equal to 1.0, the Z value after rotation to introduce perspective
  // Before the vertex is given to the Pixel Shader, x and x coordinates will be divided by w
  result.screen_position.w += result.screen_position.z*perspective_level;

  // As OBS sets [-100,100] as zFar / zNear interval, the Z value must be adapted to avoid
  // clipping in the Z direction
  // See https://github.com/obsproject/obs-studio/blob/master/libobs/obs-source.c#L4430
  result.screen_position.z = 1e-1;

  // Determines the center of the source on screen (just use the projection matrix)
  float4 source_center = float4(target_resolution/2.0, 0.0, 1.0);
  source_center = mul(source_center, ViewProj);

  // Adjusts x and y such the it looks like the vanishing point is at the center of the source
  if (perspective_centered)
    result.screen_position.xy += (result.screen_position.w-1.0)*source_center.xy;

  // Passes UV texture coordinates through
  result.uv = input_vertex_data.uv;

  return result;
}

// Pixel shader pass-through
float4 pixel_shader_standard(PixelData input_pixel_data) : TARGET
{
  float4 source_pixel = image.Sample(anisotropy_clamp, input_pixel_data.uv);
  return source_pixel;
}

technique Draw
{
  pass
  {
    vertex_shader = vertex_shader_perspective(input_vertex_data);
    pixel_shader  = pixel_shader_standard(input_pixel_data);
  }
}
]]
