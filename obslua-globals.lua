-- Definition of globals to reproduce the Lua scripting environment in OBS - bfxdev 2020

-- Use it for IntelliSense with this line at the beginning of your script (without comment):
--    if _G['obslua']==nil then dofile('obslua-globals.lua') end

-- Main obslua module
obslua = {}

-- Global: DESTINATION_FILENAME = "obslua-globals.lua"
-- Global: _VERSION = "Lua 5.1"
-- Global: assert = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#2,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: bit = {rol=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#71,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},rshift=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#69,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},ror=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#72,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},bswap=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#67,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},bxor=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#75,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},bor=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#74,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},arshift=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#70,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},bnot=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#66,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},tobit=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#65,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},lshift=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#68,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},tohex=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#76,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},band=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#73,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}}
-- Global: collectgarbage = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#27,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: coroutine = {yield=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#33,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},wrap=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#36,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},status=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#30,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},resume=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#34,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},running=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#31,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},create=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#32,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}}
-- Global: debug = {traceback=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#146,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},setlocal=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#138,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},getupvalue=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#139,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},setupvalue=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#140,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},upvalueid=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#141,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},getlocal=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#137,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},getregistry=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#131,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},getinfo=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#136,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},sethook=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#143,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},setmetatable=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#133,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},upvaluejoin=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#142,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},gethook=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#144,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},debug=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#145,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},getmetatable=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#132,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},setfenv=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#135,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},getfenv=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#134,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}}
-- Global: dofile = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#25,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: error = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d420f18,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: gcinfo = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#26,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: generate = function() end -- {linedefined=109,currentline=-1,func=function: 0x3d424870,isvararg=false,namewhat=,lastlinedefined=150,source=@D:/bfxdev/OBS/obslua-get-globals.lua,nups=1,what=Lua,nparams=0,short_src=D:/bfxdev/OBS/obslua-get-globals.lua}
-- Global: getfenv = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#10,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: getmetatable = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: io = {input=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#116,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},stdin=file (0x7ffa1228f490),tmpfile=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#111,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},read=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#113,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},output=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#117,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},open=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#109,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},close=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#112,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},write=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#114,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},popen=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#110,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},flush=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#115,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},type=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#119,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},lines=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#118,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},stdout=file (0x7ffa1228f4e8),stderr=file (0x7ffa1228f540)}
-- Global: ipairs = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#7,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=1,what=C,nparams=0,short_src=[C]}
-- Global: jit = {arch="x64",version="LuaJIT 2.0.5",version_num=20005,status=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#150,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},on=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#147,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},os="Windows",off=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#148,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},flush=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#149,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},attach=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#151,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},util={funcbc=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#153,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},funck=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#154,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},funcinfo=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#152,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},traceinfo=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#156,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},tracek=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#158,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},tracesnap=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#159,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},traceir=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#157,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},tracemc=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#160,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},ircalladdr=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#162,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},traceexitstub=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#161,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},funcuvname=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#155,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}},opt={start=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#163,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}}}
-- Global: load = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#23,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: loadfile = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#22,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: loadstring = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#24,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: math = {ceil=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#39,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},tan=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#45,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},huge=inf,log10=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#41,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},randomseed=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#64,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=1,what=C,nparams=0,short_src=[C]},cos=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#44,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},sinh=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#49,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},random=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#63,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=1,what=C,nparams=0,short_src=[C]},mod=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#59,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},pi=3.1415926535898,max=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#62,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},atan2=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#57,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},ldexp=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#60,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},floor=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},sqrt=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#40,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},deg=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#54,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=1,what=C,nparams=0,short_src=[C]},atan=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},fmod=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#59,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},acos=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#47,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},pow=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#58,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},abs=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#37,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},min=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#61,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},log=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#56,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},frexp=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#52,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},sin=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#43,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},tanh=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#51,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},exp=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#42,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},modf=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#53,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},cosh=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#50,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},asin=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#46,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},rad=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#55,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=1,what=C,nparams=0,short_src=[C]}}
-- Global: module = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3d3e30,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: newproxy = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#28,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=1,what=C,nparams=0,short_src=[C]}
-- Global: next = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#4,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: os = {execute=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#120,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},rename=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#122,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},setlocale=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#130,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},getenv=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#124,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},difftime=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#129,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},remove=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#121,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},date=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#127,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},exit=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#125,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},time=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#128,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},clock=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#126,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},tmpname=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#123,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}}
-- Global: pairs = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#5,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=1,what=C,nparams=0,short_src=[C]}
-- Global: pcall = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#20,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: print = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d420d30,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: rawequal = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#14,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: rawget = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#12,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: rawset = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#13,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: require = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3d3e78,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: script_defaults = function() end -- {linedefined=34,currentline=-1,func=function: 0x3d4257b8,isvararg=false,namewhat=,lastlinedefined=39,source=@D:/bfxdev/OBS/obslua-get-globals.lua,nups=0,what=Lua,nparams=1,short_src=D:/bfxdev/OBS/obslua-get-globals.lua}
-- Global: script_description = function() end -- {linedefined=15,currentline=-1,func=function: 0x3d425798,isvararg=false,namewhat=,lastlinedefined=31,source=@D:/bfxdev/OBS/obslua-get-globals.lua,nups=0,what=Lua,nparams=0,short_src=D:/bfxdev/OBS/obslua-get-globals.lua}
-- Global: script_properties = function() end -- {linedefined=47,currentline=-1,func=function: 0x3d4247e8,isvararg=false,namewhat=,lastlinedefined=65,source=@D:/bfxdev/OBS/obslua-get-globals.lua,nups=0,what=Lua,nparams=0,short_src=D:/bfxdev/OBS/obslua-get-globals.lua}
-- Global: script_settings = userdata: 0x3d4256d8
-- Global: script_update = function() end -- {linedefined=42,currentline=-1,func=function: 0x3d4257d8,isvararg=false,namewhat=,lastlinedefined=44,source=@D:/bfxdev/OBS/obslua-get-globals.lua,nups=0,what=Lua,nparams=1,short_src=D:/bfxdev/OBS/obslua-get-globals.lua}
-- Global: select = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#16,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: setfenv = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#11,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: setmetatable = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#9,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: string = {find=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#86,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},lower=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#83,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},format=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#91,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},rep=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#81,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},gsub=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#90,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},len=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#77,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},gmatch=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#89,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},dump=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#85,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},match=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#87,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},reverse=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#82,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},byte=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#78,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},char=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#79,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},upper=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#84,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},gfind=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#89,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},sub=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#80,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}}
-- Global: swig_equals = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3db4e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: swig_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3db490,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: table = {foreach=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#93,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},sort=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#99,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},remove=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#97,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},foreachi=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#92,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},maxn=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#95,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},getn=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#94,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},concat=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]},insert=function() end -- {linedefined=-1,currentline=-1,func=function: builtin#96,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}}
-- Global: tonumber = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#17,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: tostring = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#18,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=3,what=C,nparams=0,short_src=[C]}
-- Global: type = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#3,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=14,what=C,nparams=0,short_src=[C]}
-- Global: unpack = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#15,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
-- Global: xpcall = function() end -- {linedefined=-1,currentline=-1,func=function: builtin#21,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
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
obslua.base_get_alignment = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4069b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.base_get_log_handler = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406c28,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.base_set_allocator = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4068a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.base_set_crash_handler = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406cd8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.base_set_log_handler = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406c80,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.bfree = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406960,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.blog = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3de7b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.bmalloc = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4068c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.bmemdup = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406a50,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.bnum_allocs = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406a08,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.brealloc = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406918,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.bstrdup = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406b80,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.bstrdup_n = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406ae8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.bwstrdup = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406bd0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.bwstrdup_n = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406b38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.bzalloc = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406a98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata = {}
obslua.calldata_bool = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406270,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_clear = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405dc8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405f70,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405fc8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_float = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406220,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_free = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405e70,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_get_bool = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4060d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_get_data = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405ec8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_get_float = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406078,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_get_int = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406020,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_get_ptr = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406128,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_get_string = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406180,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_init = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405d78,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_init_fixed = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405e20,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_int = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4061d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_ptr = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4062c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_sceneitem = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4216d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_set_bool = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406418,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_set_data = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405f20,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_set_float = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4063c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_set_int = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406368,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_set_ptr = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406470,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_set_string = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4064c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_source = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421678,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.calldata_string = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406310,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_begin_frame = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5670,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_begin_scene = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e56c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_blend_function = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5b38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_blend_function_separate = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5b98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_blend_state_pop = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4a40,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_blend_state_push = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e49e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_clear = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e57e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_color = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4120,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_color4v = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e42b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_copy_texture = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5570,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_copy_texture_region = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e55c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e38b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_create_texture_file_data = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e45e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_cubetexture_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4ce0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_cubetexture_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0638,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_cubetexture_get_color_format = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e06f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_cubetexture_get_size = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0690,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_cubetexture_set_image = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4940,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_debug_marker_begin = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1288,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_debug_marker_begin_format = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e12e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_debug_marker_end = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1340,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_depth_function = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5bf0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3900,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_device_loss = {}
obslua.gs_display_mode = {}
obslua.gs_draw = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e56e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_draw_cube_backdrop = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e46e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_draw_sprite = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4630,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_draw_sprite_subregion = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4690,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4458,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_create_from_file = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4400,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3de8b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_get_current_technique = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3de970,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_get_default_val = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3488,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_get_default_val_size = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3428,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_get_num_params = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dec50,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_get_param_by_idx = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3decb0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_get_param_by_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ded10,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_get_technique = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3de910,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_get_val = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e33c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_get_val_size = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3370,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_get_viewproj_matrix = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3def38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_get_world_matrix = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3def98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_loop = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dee80,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_set_bool = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3deff0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_set_color = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3540,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_set_default = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3318,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_set_float = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df048,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_set_int = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e30b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_set_matrix4 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3108,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_set_next_sampler = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e34e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_set_texture = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3268,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_set_val = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e32c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_set_vec2 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3160,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_set_vec3 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e31b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_set_vec4 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3210,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_effect_update_params = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3deed8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_enable_blending = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5988,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_enable_color = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5ae0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_enable_depth_test = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e59e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_enable_stencil_test = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5a38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_enable_stencil_write = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5a90,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_end_scene = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5738,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_enter_context = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3958,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_enum_adapters = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3860,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_flush = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5880,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_frustum = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0218,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_get_context = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3a00,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_get_cull_mode = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5930,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_get_device_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e37b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_get_device_obj = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3a58,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_get_device_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3808,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_get_effect = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e43a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_get_format_bpp = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1398,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_get_height = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4c30,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_get_input = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4350,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_get_pixel_shader = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e53b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_get_render_target = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5410,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_get_size = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4b90,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_get_texture_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e50a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_get_total_levels = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1448,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_get_vertex_shader = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5360,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_get_viewport = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0120,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_get_width = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4be0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_get_zstencil_target = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5468,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_image_file = {}
obslua.gs_image_file2 = {}
obslua.gs_image_file2_free = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee3d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_image_file2_init = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee378,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_image_file2_init_texture = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee430,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_image_file2_tick = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee488,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_image_file2_update_texture = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee4e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_image_file_free = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee208,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_image_file_init = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee1b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_image_file_init_texture = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee268,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_image_file_tick = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee2c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_image_file_update_texture = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee320,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_indexbuffer_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4fa0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_indexbuffer_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0d60,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_indexbuffer_flush = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0db8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_indexbuffer_flush_direct = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0e18,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_indexbuffer_get_data = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0e70,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_indexbuffer_get_num_indices = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0ed0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_indexbuffer_get_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0f28,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_init_data = {}
obslua.gs_is_compressed_format = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e13f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_leave_context = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e39b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_load_default_samplerstate = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5308,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_load_indexbuffer = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5150,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_load_pixelshader = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e52a8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_load_samplerstate = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e51f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_load_swapchain = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5790,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_load_texture = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e51a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_load_vertexbuffer = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e50f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_load_vertexshader = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5250,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_matrix_get = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3c48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_matrix_identity = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3b50,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_matrix_mul = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3c98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_matrix_pop = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3af8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_matrix_push = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3aa8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_matrix_rotaa = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3d40,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_matrix_rotaa4f = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3e40,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_matrix_rotquat = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3cf0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_matrix_scale = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3de8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_matrix_scale3f = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3ef0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_matrix_set = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3bf8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_matrix_translate = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3d98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_matrix_translate3f = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3e98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_matrix_transpose = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3ba8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_monitor_info = {}
obslua.gs_normal3f = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e40d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_normal3v = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4260,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_nv12_available = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1230,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_ortho = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e01c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_param_get_annotation_by_idx = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dedd0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_param_get_annotation_by_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dee30,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_param_get_num_annotations = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ded70,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_perspective = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4990,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_pixelshader_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4ef0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_pixelshader_create_from_file = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4520,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_present = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5830,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_projection_pop = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e02c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_projection_push = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0270,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_rect = {}
obslua.gs_render_save = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3fe0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_render_start = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3f40,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_render_stop = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3f90,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_reset_blend_state = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4a98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_reset_viewport = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4740,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_resize = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4b40,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_sampler_info = {}
obslua.gs_samplerstate_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4e40,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_samplerstate_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0b98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_set_2d_mode = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4790,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_set_3d_mode = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e47e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_set_cube_render_target = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5520,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_set_cull_mode = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e58d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_set_render_target = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e54c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_set_scissor_rect = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0178,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_set_viewport = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e00d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_stage_texture = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5620,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_stagesurface_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4de8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_stagesurface_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0910,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_stagesurface_get_color_format = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0a38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_stagesurface_get_height = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e09d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_stagesurface_get_width = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0970,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_stagesurface_map = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0a90,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_stagesurface_unmap = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0ae8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_stencil_function = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5c48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_stencil_op = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5c98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_swapchain_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4af0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_swapchain_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0320,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_technique_begin = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3de9c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_technique_begin_pass = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dea78,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_technique_begin_pass_by_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dead8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_technique_end = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dea20,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_technique_end_pass = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3deb30,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_technique_get_pass_by_idx = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3deb90,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_technique_get_pass_by_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3debf0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_texcoord = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4170,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_texcoord2v = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4300,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_texrender_begin = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3648,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_texrender_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3598,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_texrender_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e35f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_texrender_end = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e36a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_texrender_get_texture = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3758,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_texrender_reset = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e36f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_texture_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4c88,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_texture_create_from_file = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4580,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_texture_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0378,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_texture_get_color_format = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0488,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_texture_get_height = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0428,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_texture_get_obj = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e05e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_texture_get_width = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e03d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_texture_is_rect = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0588,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_texture_map = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e04d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_texture_set_image = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e48e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_texture_unmap = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0530,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_timer_begin = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0fd0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_timer_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4ff0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_timer_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0f80,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_timer_end = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1020,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_timer_get_data = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1078,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_timer_range_begin = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1128,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_timer_range_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5048,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_timer_range_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e10d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_timer_range_end = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1180,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_timer_range_get_data = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e11d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_tvertarray = {}
obslua.gs_vb_data = {}
obslua.gs_vbdata_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3de808,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_vbdata_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3de860,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_vertex2f = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4030,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_vertex2v = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e41c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_vertex3f = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4080,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_vertex3v = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4210,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_vertexbuffer_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4f48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_vertexbuffer_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0bf0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_vertexbuffer_flush = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0c48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_vertexbuffer_flush_direct = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0ca8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_vertexbuffer_get_data = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0d08,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_vertexshader_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4e98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_vertexshader_create_from_file = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e44c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_viewport_pop = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4888,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_viewport_push = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4838,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_voltexture_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4d38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_voltexture_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0748,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_voltexture_get_color_format = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e08b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_voltexture_get_depth = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0858,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_voltexture_get_height = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0800,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_voltexture_get_width = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e07a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_window = {}
obslua.gs_zstencil_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e4d90,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.gs_zstencil_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0b40,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix3 = {}
obslua.matrix3_copy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df2f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix3_from_axisang = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df3f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix3_from_matrix4 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df450,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix3_from_quat = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df3a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix3_identity = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df348,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix3_inv = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df698,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix3_mirror = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df6e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix3_mirrorv = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df738,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix3_mul = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df4a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix3_rotate = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df548,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix3_rotate_aa = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df5a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix3_rotate_aa4f = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df7e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix3_scale = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df5f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix3_scale3f = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df838,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix3_translate = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df4f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix3_translate3f = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df790,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix3_transpose = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df648,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4 = {}
obslua.matrix4_copy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2fd0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4_determinant = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ebdf8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4_from_axisang = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ebd50,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4_from_matrix3 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3080,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4_from_quat = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ebcf8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4_identity = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e3028,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4_inv = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ebff0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4_mul = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ebda0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4_rotate = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ebef8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4_rotate_aa = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ebf50,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4_rotate_aa4f = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df250,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4_rotate_aa_i = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df150,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4_rotate_i = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df0f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4_scale = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ebfa0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4_scale3f = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df2a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4_scale_i = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df1a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4_translate3f = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df1f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4_translate3v = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ebe50,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4_translate3v_i = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ec0a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4_translate4v = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ebea8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4_translate4v_i = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df0a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.matrix4_transpose = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ec048,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_add_data_path = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f5070,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_add_main_render_callback = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421730,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_add_module_path = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e65c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_add_raw_video_callback = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7808,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_add_tick_callback = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4217e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_apply_private_data = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7b40,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_audio_data = {}
obslua.obs_audio_encoder_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404230,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_audio_info = {}
obslua.obs_cmdline_args = {}
obslua.obs_data_addref = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee6b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_apply = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee860,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_array_addref = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef610,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_array_count = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef6c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_array_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef5b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_array_erase = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef888,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_array_insert = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef7d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_array_item = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef718,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_array_push_back = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef778,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_array_push_back_array = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef830,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_array_release = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef668,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_clear = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee900,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee538,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_create_from_json = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee598,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_create_from_json_file = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee5f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_create_from_json_file_safe = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee660,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_erase = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee8b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_first = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3efd68,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_array = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef0e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_autoselect_array = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef560,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_autoselect_bool = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef4a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_autoselect_double = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef440,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_autoselect_frames_per_second = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1898,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_autoselect_int = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef3e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_autoselect_obj = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef500,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_autoselect_quat = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3daf48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_autoselect_string = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef380,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_autoselect_vec2 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1530,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_autoselect_vec3 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1590,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_autoselect_vec4 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f15f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_bool = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef030,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_default_array = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef320,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_default_bool = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef260,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_default_double = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef200,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_default_frames_per_second = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1828,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_default_int = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef1a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_default_obj = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef2c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_default_quat = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f14d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_default_string = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef140,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_default_vec2 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f13b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_default_vec3 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1410,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_default_vec4 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1470,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_double = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eefd8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_frames_per_second = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f17c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_int = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eef80,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_json = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee760,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_obj = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef088,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_quat = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1350,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_string = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eef28,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_vec2 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1248,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_vec3 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f12a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_get_vec4 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f12f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_has_autoselect_value = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef9a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_has_default_value = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef940,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_has_user_value = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ef8e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_byname = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3efdc0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_array = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f08d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_autoselect_array = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0d90,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_autoselect_bool = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0cc0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_autoselect_double = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0c58,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_autoselect_frames_per_second = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1b28,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_autoselect_int = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0bf0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_autoselect_obj = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0d28,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_autoselect_string = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0b88,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_bool = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0820,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_default_array = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0b20,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_default_bool = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0a60,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_default_double = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0a00,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_default_frames_per_second = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1ab8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_default_int = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0998,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_default_obj = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0ac0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_default_string = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0938,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_double = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f07c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_frames_per_second = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1a48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_int = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0768,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3effd0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_obj = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0878,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_get_string = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0710,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_gettype = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eff20,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_has_autoselect_value = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3efac8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_has_default_value = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3efa60,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_has_user_value = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3efa00,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_next = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3efe18,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_numtype = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eff78,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_release = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3efe70,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_remove = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3efec8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_set_array = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f01f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_set_autoselect_array = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f06b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_set_autoselect_bool = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f05e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_set_autoselect_double = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0578,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_set_autoselect_frames_per_second = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f19e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_set_autoselect_int = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0510,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_set_autoselect_obj = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0648,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_set_autoselect_string = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f04a8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_set_bool = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0140,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_set_default_array = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0440,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_set_default_bool = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0380,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_set_default_double = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0320,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_set_default_frames_per_second = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1970,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_set_default_int = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f02b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_set_default_obj = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f03e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_set_default_string = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0258,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_set_double = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f00e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_set_frames_per_second = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1900,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_set_int = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0088,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_set_obj = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0198,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_set_string = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0030,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_unset_autoselect_value = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3efd18,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_unset_default_value = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3efcb0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_item_unset_user_value = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3efc48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_newref = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1b78,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_release = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee708,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_save_json = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee7b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_save_json_safe = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee810,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_array = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eeb10,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_autoselect_bool = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eee70,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_autoselect_double = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eee10,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_autoselect_frames_per_second = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1760,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_autoselect_int = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eedb0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_autoselect_obj = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eeed0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_autoselect_quat = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f11f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_autoselect_string = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eed50,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_autoselect_vec2 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f10d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_autoselect_vec3 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1130,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_autoselect_vec4 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1190,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_bool = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eea60,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_default_bool = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eec90,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_default_double = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eec30,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_default_frames_per_second = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f16f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_default_int = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eebd0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_default_obj = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eecf0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_default_quat = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1070,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_default_string = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eeb70,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_default_vec2 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0f50,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_default_vec3 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0fb0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_default_vec4 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1010,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_double = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eea08,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_frames_per_second = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1688,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_int = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee9b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_obj = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eeab8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_quat = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0ef0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_string = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee958,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_vec2 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0de8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_vec3 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0e40,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_set_vec4 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f0e98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_unset_autoselect_value = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3efbe8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_unset_default_value = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3efb88,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_data_unset_user_value = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3efb28,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_display_add_draw_callback = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7fa8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_display_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7e98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_display_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7ef0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_display_enabled = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e80c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_display_remove_draw_callback = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8010,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_display_resize = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7f48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_display_set_background_color = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8128,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_display_set_enabled = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8068,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_display_size = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8180,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_active = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404e08,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_addref = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404288,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_audio = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404db0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_create_rerouted = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405088,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_defaults = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404a20,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_get_caps = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404f70,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_get_codec = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4046d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_get_defaults = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404a80,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_get_display_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404170,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_get_extra_data = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404bf0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_get_height = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404898,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_get_id = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404ec0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_get_last_error = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405140,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_get_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4045c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_get_preferred_video_format = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4049c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_get_ref = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4043f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_get_sample_rate = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4048f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_get_settings = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404c50,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_get_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404728,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_get_type_data = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404e68,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_get_weak_encoder = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404450,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_get_width = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404840,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_packet_ref = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404fc8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_packet_release = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405028,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_paused = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4050e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_properties = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404b38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_release = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4042e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_scaling_enabled = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4047e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_set_audio = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404d00,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_set_last_error = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4051a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_set_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404570,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_set_preferred_video_format = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404960,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_set_scaled_size = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404788,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_set_video = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404ca8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_update = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404b90,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_encoder_video = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404d58,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_enter_graphics = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6b58,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_enum_audio_monitoring_devices = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e76e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_enum_encoder_types = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6aa8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_enum_encoders = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6e58,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_enum_filter_types = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6998,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_enum_hotkey_bindings = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4a90,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_enum_hotkeys = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4a30,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_enum_input_types = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6888,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_enum_input_types2 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e68e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_enum_modules = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e66c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_enum_output_types = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6a50,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_enum_outputs = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6e00,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_enum_scenes = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6da8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_enum_service_types = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6b00,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_enum_services = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6eb0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_enum_source_types = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6830,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_enum_sources = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4214f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_enum_transition_types = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e69f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_filter_get_parent = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8ac0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_filter_get_target = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8b18,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_find_data_file = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f5018,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_find_module_file = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6778,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_add_event_callback = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d422158,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_add_save_callback = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d422220,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_defer_save_begin = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408a80,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_defer_save_end = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408ae0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_get_current_preview_scene = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d409088,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_get_current_profile = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d422028,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_get_current_scene = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421c88,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_get_current_scene_collection = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421ef0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_get_current_transition = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421db0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_get_global_config = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408cd8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_get_profile_config = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408c78,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_get_profiles = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421fc0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_get_recording_output = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408bb0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_get_replay_buffer_output = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408c18,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_get_scene_collections = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421e80,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_get_scene_names = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421bd0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_get_scenes = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421c28,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_get_streaming_output = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408b48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_get_streaming_service = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408da8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_get_transitions = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421d48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_open_projector = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4089c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_preview_enabled = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d409020,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_preview_program_mode_active = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408e80,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_preview_program_trigger_transition = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408f58,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_recording_active = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408718,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_recording_pause = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408778,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_recording_paused = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4087d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_recording_start = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408658,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_recording_stop = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4086b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_remove_event_callback = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4220f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_remove_save_callback = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4221c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_replay_buffer_active = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408968,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_replay_buffer_save = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4088a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_replay_buffer_start = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408840,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_replay_buffer_stop = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408900,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_save = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408a20,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_save_streaming_service = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408e10,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_set_current_preview_scene = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4090f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_set_current_profile = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d422090,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_set_current_scene = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421ce8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_set_current_scene_collection = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421f60,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_set_current_transition = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421e18,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_set_preview_enabled = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408fc0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_set_preview_program_mode = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408ee8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_set_streaming_service = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408d40,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_streaming_active = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4085f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_streaming_start = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408538,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_streaming_stop = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408598,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_take_screenshot = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d409150,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_frontend_take_source_screenshot = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4091b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_active_fps = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7920,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_audio = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6c00,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_audio_info = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6130,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_audio_monitoring_device = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e77a8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_average_frame_time_ns = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7980,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_base_effect = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7068,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_cmdline_args = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5ee0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_encoder_by_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6fb8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_encoder_caps = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404f18,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_encoder_codec = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404620,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_encoder_properties = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404ae0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_encoder_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404678,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_frame_interval_ns = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e79e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_lagged_frames = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7a90,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_latest_input_type_id = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6940,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_locale = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5f80,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_main_texture = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7230,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_master_volume = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e72e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_module = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6220,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_module_author = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6448,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_module_binary_path = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6508,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_module_data_path = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6568,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_module_description = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e64a8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_module_file_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6398,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_module_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e63f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_output_by_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6f60,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_output_flags = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402f90,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_output_properties = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403048,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_output_source = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6d58,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_private_data = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7bf0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_proc_handler = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7118,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_profiler_name_store = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5fe0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_service_by_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7010,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_service_properties = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4056b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_signal_handler = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e70c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_source_by_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6f08,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_source_defaults = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8798,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_source_output_flags = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8740,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_source_properties = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e87f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_total_frames = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7a38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_version = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5dd8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_version_string = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5e30,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_video = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6c50,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_video_frame_time = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e78c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_get_video_info = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e60d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_group_from_source = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4027b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_binding_get_hotkey = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4230,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_binding_get_hotkey_id = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f41d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_binding_get_key_combination = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4168,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_enable_background_press = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4b50,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_enable_callback_rerouting = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4cf0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_enable_strict_modifiers = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4bb8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_get_description = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3fe0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_get_id = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3f28,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_get_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3f80,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_get_pair_partner_id = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4100,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_get_registerer = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f40a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_get_registerer_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4040,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_inject_event = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4ae8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_load = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f45f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_load_bindings = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f45a8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_pair_load = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f47c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_pair_save = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4868,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_pair_set_descriptions = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f43b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_pair_set_names = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4348,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_pair_unregister = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4548,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_register_frontend = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421a50,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_save = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4810,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_set_callback_routing_func = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4c20,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_set_description = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f42e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_set_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4288,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_trigger_routed_callback = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4c88,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_unregister = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4219f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkey_update_atomic = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4d50,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkeys_load_encoder = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4658,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkeys_load_output = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f46b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkeys_load_service = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4710,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkeys_load_source = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4768,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkeys_save_encoder = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f48c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkeys_save_output = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4920,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkeys_save_service = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4980,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkeys_save_source = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f49d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkeys_set_audio_hotkeys_translations = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4420,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_hotkeys_set_sceneitem_hotkeys_translations = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4490,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_init_module = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e61d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_initialized = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5d88,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_is_source_configurable = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8858,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_key_combination = {}
obslua.obs_key_combination_is_empty = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4fc0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_key_combination_to_str = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4e00,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_key_event = {}
obslua.obs_key_from_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4f60,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_key_from_virtual_key = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4e60,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_key_to_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4f08,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_key_to_str = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4da0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_key_to_virtual_key = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f4eb8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_leave_graphics = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6bb0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_load_all_modules = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6618,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_load_source = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7380,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_load_sources = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7478,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_log_loaded_modules = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6338,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_module_get_config_path = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e67d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_module_get_locale_string = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6280,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_module_get_locale_text = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e62e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_module_load_locale = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6720,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_mouse_event = {}
obslua.obs_nv12_tex_active = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7ae8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_obj_get_data = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7680,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_obj_get_id = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e75d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_obj_get_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7588,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_obj_invalid = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7628,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_open_module = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6180,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_active = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402ee0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_addref = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402998,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_audio = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4033c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_begin_data_capture = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403ff8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_can_begin_data_capture = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403f38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_can_pause = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403150,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402940,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_defaults = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402fe8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_end_data_capture = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404058,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_force_stop = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402e88,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_active_delay = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402e30,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_audio_encoder = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4036a8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_congestion = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403b68,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_connect_time_ms = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403bc8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_delay = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402dd0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_display_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4028e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_flags = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402f38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_frames_dropped = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403880,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_height = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4039f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_id = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403a48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_last_error = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403ce0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_mixer = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403478,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_mixers = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403528,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402c78,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_pause_offset = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404110,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_proc_handler = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403318,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_ref = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402af8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_service = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403758,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_settings = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403258,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_signal_handler = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4032b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_supported_audio_codecs = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403db0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_supported_video_codecs = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403d48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_total_bytes = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403820,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_total_frames = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4038e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_type_data = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403e10,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_video_encoder = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403648,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_weak_output = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402b58,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_get_width = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403998,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_initialize_encoders = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403f98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_output_caption_text1 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403aa8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_output_caption_text2 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403b08,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_pause = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4031a8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_paused = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403200,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_properties = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4030a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_reconnecting = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403c20,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_release = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4029f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_set_audio_conversion = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403ed0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_set_audio_encoder = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4035e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_set_delay = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402d78,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_set_last_error = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403c80,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_set_media = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403370,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_set_mixer = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403420,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_set_mixers = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4034d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_set_preferred_size = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403940,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_set_reconnect_settings = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4037c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_set_service = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403700,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_set_video_conversion = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403e70,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_set_video_encoder = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d403588,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_signal_stop = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4040b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_start = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402cd0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_stop = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402d20,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_output_update = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4030f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_post_load_modules = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6670,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_add_bool = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2030,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_add_button = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421ab0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_add_button2 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2370,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_add_color = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2310,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_add_editable_list = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2430,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_add_float = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f20e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_add_float_slider = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f21a8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_add_font = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f23c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_add_frame_rate = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2490,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_add_group = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f24f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_add_int = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2088,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_add_int_slider = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2148,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_add_list = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f22b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_add_path = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2258,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_add_text = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2200,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_apply_settings = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1fd8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1bd0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_create_param = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1c30,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1c88,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_first = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1e60,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_get = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1eb8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_get_flags = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1d48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_get_param = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1e08,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_get_parent = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1f18,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_remove_by_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1f78,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_set_flags = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1ce8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_properties_set_param = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f1da8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_button_clicked = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2610,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_description = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2850,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_editable_list_default_path = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f38b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_editable_list_filter = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3850,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_editable_list_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f37e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_enabled = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2960,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_float_max = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2c78,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_float_min = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2c20,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_float_set_limits = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f30d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_float_set_suffix = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3190,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_float_step = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2cd0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_float_suffix = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2d88,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_float_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2d28,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_frame_rate_clear = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3918,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_frame_rate_fps_range_add = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3ac0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_frame_rate_fps_range_insert = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3b98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_frame_rate_fps_range_max = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3e18,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_frame_rate_fps_range_min = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3db0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_frame_rate_fps_ranges_clear = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f39f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_frame_rate_fps_ranges_count = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3d48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_frame_rate_option_add = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3a58,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_frame_rate_option_description = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3cd8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_frame_rate_option_insert = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3b28,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_frame_rate_option_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3c68,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_frame_rate_options_clear = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3980,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_frame_rate_options_count = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3c00,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_get_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2908,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_group_content = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3ed0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_group_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3e70,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_int_max = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2ac0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_int_min = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2a68,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_int_set_limits = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3070,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_int_set_suffix = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3130,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_int_step = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2b18,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_int_suffix = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2bc8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_int_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2b70,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_list_add_float = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3368,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_list_add_int = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3308,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_list_add_string = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f32a8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_list_clear = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3248,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_list_format = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3010,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_list_insert_float = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3488,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_list_insert_int = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3428,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_list_insert_string = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f33c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_list_item_count = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3608,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_list_item_disable = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f34e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_list_item_disabled = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3548,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_list_item_float = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3788,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_list_item_int = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3728,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_list_item_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f3668,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_list_item_remove = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f35a8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_list_item_string = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f36c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_list_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2fb0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_long_description = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f28b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_modified = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f25b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f27f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_next = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2a10,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_path_default_path = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2f58,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_path_filter = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2ef8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_path_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2e98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_set_description = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2730,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_set_enabled = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f26d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_set_long_description = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2798,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_set_modified_callback = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421b18,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_set_modified_callback2 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2558,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_set_visible = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2670,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_text_monospace = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2e40,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_text_set_monospace = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f31f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_text_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f2de0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_property_visible = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f29b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_queue_task = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7c40,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_register_source = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421150,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_remove_data_path = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3f50c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_remove_main_render_callback = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421790,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_remove_raw_video_callback = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7868,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_remove_tick_callback = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421848,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_render_main_texture = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7170,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_render_main_texture_src_color_only = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e71d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_reset_audio = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6080,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_reset_video = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6030,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_save_source = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7330,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_save_sources = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e74d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_save_sources_filtered = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7530,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_scene_add = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4012b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_scene_add_group = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402260,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_scene_add_group2 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402310,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_scene_addref = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ebaf8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_scene_atomic_update = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401310,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_scene_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb9e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_scene_create_private = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eba48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_scene_duplicate = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ebaa0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_scene_enum_items = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421578,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_scene_find_sceneitem_by_id = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401158,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_scene_find_source = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ebc58,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_scene_find_source_recursive = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4010f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_scene_from_source = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ebc00,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_scene_get_group = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4023c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_scene_get_source = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ebba8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_scene_insert_group = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4022b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_scene_insert_group2 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402368,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_scene_is_group = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402700,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_scene_release = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ebb50,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_scene_reorder_items = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401208,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_scene_reorder_items2 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401268,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_addref = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401368,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_crop = {}
obslua.obs_sceneitem_defer_group_resize_begin = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402820,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_defer_group_resize_end = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402888,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_defer_update_begin = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402140,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_defer_update_end = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4021a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_force_update_transform = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4020d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_get_alignment = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401b48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_get_bounds = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401c70,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_get_bounds_alignment = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401c10,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_get_bounds_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401ba8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_get_box_scale = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401e48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_get_box_transform = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401de8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_get_crop = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401fb0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_get_draw_transform = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401d88,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_get_group = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402650,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_get_id = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4019e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_get_info = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401cc8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_get_pos = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401a38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_get_private_settings = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402208,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_get_rot = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401a90,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_get_scale = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401ae8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_get_scale_filter = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402070,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_get_scene = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401470,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_get_source = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4014d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_group_add_item = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402598,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_group_enum_items = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402760,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_group_get_scene = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402478,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_group_remove_item = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4025f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_group_ungroup = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4024d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_group_ungroup2 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402538,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_is_group = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402418,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_locked = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4015d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_order_info = {}
obslua.obs_sceneitem_release = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4013c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_remove = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401418,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_select = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401528,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_selected = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401580,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_set_alignment = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4017a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_set_bounds = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401988,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_set_bounds_alignment = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401928,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_set_bounds_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4018c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_set_crop = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401f58,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_set_info = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401d20,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_set_locked = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401638,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_set_order = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4017f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_set_order_position = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401860,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_set_pos = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401690,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_set_rot = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4016e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_set_scale = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401740,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_set_scale_filter = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402010,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_set_visible = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401f00,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_sceneitem_visible = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d401ea0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_service_addref = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405310,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_service_apply_encoder_settings = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4059f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_service_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405258,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_service_create_private = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4052b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_service_defaults = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405650,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_service_get_display_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405200,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_service_get_id = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405aa8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_service_get_key = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4058c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_service_get_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4055f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_service_get_output_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405b08,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_service_get_password = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405988,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_service_get_ref = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405478,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_service_get_settings = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405818,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_service_get_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405760,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_service_get_type_data = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405a50,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_service_get_url = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405870,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_service_get_username = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405928,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_service_get_weak_service = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4054d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_service_properties = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405708,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_service_release = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405368,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_service_update = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4057b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_set_audio_monitoring_device = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7748,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_set_cmdline_args = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5e88,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_set_locale = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5f30,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_set_master_volume = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7288,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_set_output_source = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6d00,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_set_private_data = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7b98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_set_ui_task_handler = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7c98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_shutdown = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5d38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_active = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9310,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_add_active_child = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea660,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_add_audio_capture_callback = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9bd8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_addref = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8348,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_async_decoupled = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eac58,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_async_unbuffered = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eab98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_audio = {}
obslua.obs_source_audio_active = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ead10,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_audio_mix = {}
obslua.obs_source_audio_pending = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eaa18,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_configurable = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e88b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_copy_filters = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e96f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8238,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_create_private = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8298,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_dec_active = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9638,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_dec_showing = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e95e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_default_render = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8b78,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_draw = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea010,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_draw_set_color_matrix = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9fc0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_duplicate = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e82f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_enable_push_to_mute = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9910,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_enable_push_to_talk = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9aa0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_enabled = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9748,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_enum_active_sources = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9258,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_enum_active_tree = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e92b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_enum_filters = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421550,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_filter_add = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8bd0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_filter_remove = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8c30,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_filter_set_order = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8c90,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_frame = {}
obslua.obs_source_frame2 = {}
obslua.obs_source_frame_copy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405cc8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_frame_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405c10,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_frame_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405c70,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_frame_free = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405bb8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_frame_init = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405b60,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_audio_mix = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eaad8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_audio_mixers = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e94d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_audio_timestamp = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eaa78,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_balance_value = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9138,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_base_height = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea9b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_base_width = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea958,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_deinterlace_field_order = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9dd8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_deinterlace_mode = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9d08,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_display_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e81e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_filter_by_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9698,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_flags = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9418,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_frame = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea418,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_height = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8a68,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_icon_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405d28,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_id = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8e48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_last_obs_version = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ead70,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_monitoring_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9e98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8d40,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_output_flags = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e86e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_private_settings = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9ef8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_proc_handler = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8f68,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_push_to_mute_delay = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9978,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_push_to_talk_delay = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9b08,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_ref = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e84a8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_settings = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8ce8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_signal_handler = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8f08,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_speaker_layout = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9078,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_sync_offset = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e91f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8df0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_type_data = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9f58,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_unversioned_id = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8ea8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_volume = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9018,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_weak_source = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8508,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_get_width = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8a10,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_inc_active = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9588,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_inc_showing = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9530,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_is_group = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4026a8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_load = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7420,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_media_ended = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb178,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_media_get_duration = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eafa0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_media_get_state = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb0c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_media_get_time = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb000,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_media_next = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eaee0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_media_play_pause = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eadd0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_media_previous = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eaf40,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_media_restart = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eae30,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_media_set_time = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb060,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_media_started = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb120,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_media_stop = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eae88,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_muted = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e97f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_output_audio = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea360,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_output_video = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea068,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_output_video2 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea0c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_preload_video = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea188,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_preload_video2 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea1e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_process_filter_begin = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea4d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_process_filter_end = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea538,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_process_filter_tech_end = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea5a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_properties = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8908,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_push_to_mute_enabled = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e98b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_push_to_talk_enabled = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9a40,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_release = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e83a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_release_frame = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea478,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_remove = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8628,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_remove_active_child = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea6c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_remove_audio_capture_callback = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9c48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_removed = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8680,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_save = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e73d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_send_focus = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea838,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_send_key_click = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea898,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_send_mouse_click = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea720,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_send_mouse_move = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea780,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_send_mouse_wheel = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea7e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_set_async_decoupled = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eabf8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_set_async_rotation = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea128,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_set_async_unbuffered = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eab38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_set_audio_active = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eacb8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_set_audio_mixers = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9478,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_set_balance_value = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e90d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_set_default_flags = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea8f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_set_deinterlace_field_order = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9d70,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_set_deinterlace_mode = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9ca8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_set_enabled = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e97a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_set_flags = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e93c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_set_monitoring_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9e38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_set_muted = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9850,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_set_name = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8d98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_set_push_to_mute_delay = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e99e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_set_push_to_talk_delay = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9b70,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_set_sync_offset = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9198,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_set_video_frame = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea2a8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_set_video_frame2 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea308,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_set_volume = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8fc0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_show_preloaded_video = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea248,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_showing = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e9368,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_skip_video_filter = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea600,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_update = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8960,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_update_properties = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ea3c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_source_video_render = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e89b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_startup = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e5ce8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transform_info = {}
obslua.obs_transition_audio_render = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb8d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transition_clear = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb230,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transition_enable_fixed = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb6a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transition_fixed = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb6f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transition_force_stop = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb7b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transition_get_active_source = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb298,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transition_get_alignment = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb590,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transition_get_scale_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb4d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transition_get_size = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb640,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transition_get_source = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb1d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transition_get_time = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb750,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transition_set = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb348,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transition_set_alignment = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb530,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transition_set_manual_time = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb3a8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transition_set_manual_torque = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb410,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transition_set_scale_type = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb470,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transition_set_size = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb5e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transition_start = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb2f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transition_swap_begin = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb938,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transition_swap_end = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb990,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transition_video_render = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb810,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_transition_video_render_direct = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3eb878,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_video_active = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e6ca8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_video_encoder_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4041d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_video_info = {}
obslua.obs_view_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7ce8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_view_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7d40,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_view_get_source = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7df0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_view_render = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7e40,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_view_set_source = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e7d98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_weak_encoder_addref = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404338,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_weak_encoder_get_encoder = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4044b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_weak_encoder_references_encoder = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404518,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_weak_encoder_release = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d404398,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_weak_output_addref = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402a48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_weak_output_get_output = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402bb8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_weak_output_references_output = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402c20,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_weak_output_release = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d402aa0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_weak_service_addref = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4053c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_weak_service_get_service = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405538,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_weak_service_references_service = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4055a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_weak_service_release = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d405420,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_weak_source_addref = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e83f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_weak_source_get_source = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8568,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_weak_source_references_source = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e85d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.obs_weak_source_release = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e8450,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_breakpoint = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4082b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_chdir = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407f00,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_closedir = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407d28,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_copyfile = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408098,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_cpu_usage_info_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407770,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_cpu_usage_info_query = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407710,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_cpu_usage_info_start = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4076b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_dirent = {}
obslua.os_dlclose = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407660,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_dlopen = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4075c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_dlsym = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407610,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_dtostr = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407570,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_end_high_performance = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407828,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_fgetsize = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406dc8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_file_exists = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407b38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_fopen = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406d78,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_fread_mbs = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406eb8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_fread_utf8 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406f08,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_fseeki64 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406e18,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_ftelli64 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406e68,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_generate_formatted_filename = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408148,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_get_abs_path = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407b88,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_get_abs_path_ptr = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407be0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_get_config_path = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407970,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_get_config_path_ptr = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4079c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_get_executable_path_ptr = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407ae8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_get_file_size = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407128,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_get_free_disk_space = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407f58,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_get_free_space = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407180,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_get_logical_cores = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408360,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_get_path_extension = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407c38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_get_physical_cores = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408308,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_get_proc_memory_usage = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408418,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_get_proc_resident_size = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408478,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_get_proc_virtual_size = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4084d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_get_program_data_path = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407a28,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_get_program_data_path_ptr = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407a88,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_get_sys_free_size = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4083b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_getcwd = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407eb0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_gettime_ns = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407918,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_glob = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407d70,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_glob_info = {}
obslua.os_globent = {}
obslua.os_globfree = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407dc0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_inhibit_sleep_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4081a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_inhibit_sleep_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408260,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_inhibit_sleep_set_active = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408200,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_mbs_to_utf8_ptr = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4074d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_mbs_to_wcs = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4071d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_mbs_to_wcs_ptr = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407318,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_mkdir = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407fa8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_mkdirs = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407ff8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_opendir = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407c88,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_proc_memory_usage = {}
obslua.os_quick_read_mbs_file = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407078,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_quick_read_utf8_file = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406f60,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_quick_write_mbs_file = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4070d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_quick_write_utf8_file = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406fc0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_quick_write_utf8_file_safe = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407020,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_readdir = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407cd8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_rename = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d408048,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_request_high_performance = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4077d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_rmdir = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407e60,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_safe_replace = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4080e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_sleep_ms = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4078c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_sleepto_ns = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407878,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_strtod = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407520,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_unlink = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407e10,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_utf8_to_mbs_ptr = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407478,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_utf8_to_wcs = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407220,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_utf8_to_wcs_ptr = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407370,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_wcs_to_mbs = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407270,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_wcs_to_mbs_ptr = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4073c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_wcs_to_utf8 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4072c0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_wcs_to_utf8_ptr = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d407420,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.os_wfopen = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406d28,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.proc_handler_add = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4065d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.proc_handler_call = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406628,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.proc_handler_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406520,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.proc_handler_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406578,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat = {}
obslua.quat_add = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df978,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_addf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dfa68,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_close = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dfd88,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_copy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df928,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_dist = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dfce8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_divf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dfb58,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_dot = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dfba8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_exp = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dffd8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_from_axisang = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dfde0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_from_matrix3 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dfe38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_from_matrix4 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dfe90,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_get_dir = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dfee0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_get_tangent = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee100,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_identity = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df888,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_interpolate = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e0030,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_interpolate_cubic = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3ee158,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_inv = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dfbf8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_len = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dfc98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_log = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dff88,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_mul = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dfa18,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_mulf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dfb08,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_neg = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dfc48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_norm = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dfd38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_set = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df8d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_set_look_dir = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dff38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_sub = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3df9c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.quat_subf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3dfab8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.remove_current_callback = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421b70,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.sceneitem_list_release = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421628,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.script_log = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d420f68,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.signal_handler_add = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406730,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.signal_handler_add_array = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406790,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.signal_handler_connect = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4218a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.signal_handler_connect_global = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421960,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.signal_handler_connect_ref = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4067f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.signal_handler_create = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406680,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.signal_handler_destroy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4066d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.signal_handler_disconnect = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421900,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.signal_handler_disconnect_global = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4219c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.signal_handler_signal = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d406848,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.source_list_release = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4215d0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.timer_add = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d4214a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.timer_remove = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d421268,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2 = {}
obslua.vec2_abs = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2e40,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_add = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2940,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_addf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2a80,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_ceil = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2ee0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_close = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2f30,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_copy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e28f0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_dist = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2cb0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_div = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2a30,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_divf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2b70,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_dot = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2c10,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_floor = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2e90,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_len = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2c60,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_max = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2df0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_maxf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2da0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_min = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2d50,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_minf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2d00,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_mul = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e29e0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_mulf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2b20,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_neg = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2bc0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_norm = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2f80,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_set = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e28a0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_sub = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2990,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_subf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2ad0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec2_zero = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2850,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3 = {}
obslua.vec3_abs = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2528,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_add = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1f38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_addf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2078,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_ceil = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e25c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_close = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2398,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_copy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1e98,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_cross = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2208,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_dist = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e22f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_div = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2028,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_divf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2168,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_dot = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e21b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_floor = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2578,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_from_vec4 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1ee8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_len = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e22a8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_max = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2488,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_maxf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e24d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_min = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e23e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_minf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2438,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_mirror = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2760,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_mirrorv = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e27b0,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_mul = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1fd8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_mulf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2118,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_neg = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2258,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_norm = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2348,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_plane_dist = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2618,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_rand = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2800,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_rotate = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e26b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_set = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1e48,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_sub = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1f88,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_subf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e20c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_transform = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2668,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_transform3x4 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e2710,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec3_zero = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1df8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4 = {}
obslua.vec4_abs = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1b78,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_add = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e15d8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_addf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1718,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_ceil = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1c18,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_close = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e19e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_copy = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1538,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_dist = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1948,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_div = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e16c8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_divf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1808,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_dot = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1858,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_floor = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1bc8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_from_bgra = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1d58,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_from_rgba = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1d08,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_from_vec3 = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1588,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_len = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e18f8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_max = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1ad8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_maxf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1b28,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_min = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1a38,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_minf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1a88,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_mul = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1678,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_mulf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e17b8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_neg = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e18a8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_norm = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1998,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_set = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e14e8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_sub = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1628,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_subf = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1768,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_to_bgra = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1cb8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_to_rgba = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1c68,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_transform = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1da8,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
obslua.vec4_zero = function() end -- {linedefined=-1,currentline=-1,func=function: 0x3d3e1498,isvararg=true,namewhat=,lastlinedefined=-1,source==[C],nups=0,what=C,nparams=0,short_src=[C]}
