// CPC FX - V8 - Benjamin Forgeau 2020/05/xx
// Default colors from Cédric Andreu 2020/05/19 - mode 0 : set color [9] to 0 instead of 25 to remove golden style.
// Overscan resolution : 768x544 pixels.

// OBS-specific syntax adaptation to HLSL standard to avoid errors reported by the code editor
#define SamplerState sampler_state
#define Texture2D texture2d

// Constants
#define PI 3.141592653589793238

// Uniform variables set by OBS (required)
uniform float4x4 ViewProj; // View-projection matrix used in the vertex shader
uniform Texture2D image;   // Texture containing the source picture

// Size of the source picture
uniform int width;
uniform int height;

// User settings
uniform int DisplayCPCMode <
	string name = "CPC Video Mode (MODE 0/1/2 or 3)";
	string description = "Modes: \n0: 160x200 with 16 colors out of 27\n1: 320x200 with 4 colors out of 27\n2: 640x200 with 2 colors out of 27\n3: 640x400 with 27 colors (for tests - not available on CPC)";
	int minimum = 0;
	int maximum = 3;
	string field_type = "slider";
> = 1;

uniform float DisplayDownscale <
	string name = "Pixel size (0 for exact CPC resolution)";
	string description = "Number of source pixels in displayed downscaled pixels. If set to 0 then the exact resolution of the CPC is determined (e.g. 320x200 for Mode 1) and displayed. This may lead to aliasing on the displayed picture due to inadequation between the source and the displayed area. Use supersampling (i.e. 400% or more shader display size) for better results.";
	float minimum = 0.0;
	float maximum = 8.0;
	float step = 1.0;
	string field_type = "slider";
> = 1.0;

uniform float DisplayFrameOverscan<
	string name = "Overscan Level";
	string field_type = "slider";
	float minimum = 0.0;
	float maximum = 1.0;
> = 0.5;

uniform float DisplayGammaCorrection <
	string name = "Gamma correction";
	float minimum = -0.8;
	float maximum = 0.8;
	string field_type = "slider";
> = 0.0;

uniform bool DisplayGrayscale <
	string name = "Grayscale conversion of the source";
> = false;

uniform float DitheringSpread <
	string name = "Dithering Spread";
	string description = "Spread of the dithering effect (0 means no dithering), factor multiplied to the related value of the Bayer matrix";
	string field_type = "slider";
	float minimum = 0.0;
	float maximum = 1.0;
> = 0.15;

uniform int DitheringMatrix <
	string name = "Dithering Matrix";
	string description = "Dithering matrix, among different sizes and shapes:\n1: 2x2 Bayer\n2: 4x4 Bayer\n3: 8x8 Bayer\n4: 3x3 Dot\n5: 3x3 Dot with RGB offsets\n4: 5x5 Dot\n5: 5x5 Dot with RGB offsets\n4: 6x6 Dot\n5: 6x6 Dot with RGB offsets";
	int minimum = 1;
	int maximum = 9;
	string field_type = "slider";
> = 3;

uniform float OutlineEdge <
	string name = "Outline Edge Level";
	string description = "Threshold/Factor to draw Outline based on edge detection (0.0 no Outline)";
	string field_type = "slider";
	float minimum = 0.0;
	float maximum = 4.0;
> = 0.5;

uniform float4 OutlineEdgeColor <
	bool visible = true;
	string name = "Outline Color";
	string field_type = "slider";
	float4 minimum = {0.0, 0.0, 0.0, 1.0};
	float4 maximum = {1.0, 1.0, 1.0, 1.0};
> = {0.0, 0.0, 0.0, 1.0};

uniform int PaletteAdaptedColors<
	string name = "Palette signals (1: Gate Array, 2: ASIC, 3: Perfect)";
	string description = "The Colors used in the Palette can reproduce:\n0: Gate-Array based CPC\n1: ASIC-based CPC (later generation before CPC+)\n2: Perfect palette";
	string field_type = "slider";
	int minimum = 1;
	int maximum = 3;
> = 1;

uniform float PaletteBorder<
	string name = "Color of the Border from the 27-colors Palette";
	string field_type = "slider";
	float minimum = 0.0;
	float maximum = 26.0;
	float step = 1.0;
> = 2;

uniform float4x4 PaletteInks<
	string name = "Color of each Ink from the 27-colors Palette";
	string field_type = "slider";
	int size = 16;
	float4x4 minimum = {0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.};
	float4x4 maximum = {26.,26.,26.,26.,26.,26.,26.,26.,26.,26.,26.,26.,26.,26.,26.,26.};
	float4x4 step = {1.,1.,1.,1.,1.,1.,1.,1.,1.,1.,1.,1.,1.,1.,1.,1.};
> = {0., 26., 15., 2., 1., 6., 3., 18., 9., 25., 0., 0., 0., 0., 0., 0.};

uniform float TransparencyBorder<
	string name = "Transparency level of the Border";
	string field_type = "slider";
	float minimum = 0.0;
	float maximum = 1.0;
> = 0.0;

uniform float4x4 TransparencyInks <
	string name = "Transparency levels of the Inks";
	string field_type = "slider";
	float4x4 minimum = {0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.};
	float4x4 maximum = {1.,1.,1.,1.,1.,1.,1.,1.,1.,1.,1.,1.,1.,1.,1.,1.};
> = {0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.};

uniform float3 XDitheringRGBCorrection <
	string name = "Dithering RGB Correction";
	string description = "Adjust the Dithering Spread on each RGB component";
	string field_type = "slider";
	float3 minimum = {0.0, 0.0, 0.0};
	float3 maximum = {1.0, 1.0, 1.0};
> = {1.0, 1.0, 1.0};

// Definition of the processing of the input texture
// See https://docs.microsoft.com/en-us/windows/win32/api/d3d11/ns-d3d11-d3d11_sampler_desc
sampler_state def_sampler
{
	AddressU  = Clamp;
	AddressV  = Clamp;
	Filter    = Linear;
	//BorderColor = 00000000;
};

/*
// Interpolation method and wrap mode for sampling a texture
SamplerState linear_clamp
{
  Filter    = Linear;     // Anisotropy / Point / Linear
  AddressU  = Clamp;      // Wrap / Clamp / Mirror / Border / MirrorOnce
  AddressV  = Clamp;      // Wrap / Clamp / Mirror / Border / MirrorOnce
  BorderColor = 00000000; // Used only with Border edges (optional)
};

SamplerState linear_wrap
{
  Filter    = Linear; 
  AddressU  = Wrap;
  AddressV  = Wrap;
};

SamplerState point_clamp
{
  Filter    = Point; 
  AddressU  = Clamp;
  AddressV  = Clamp;
};

// Data type of the input of the vertex shader
struct vertex_data
{
  float4 pos : POSITION;  // Homogeneous space coordinates XYZW
  float2 uv  : TEXCOORD0; // UV coordinates in the source picture
};

// Data type of the output returned by the vertex shader, and used as input 
// for the pixel shader after interpolation for each pixel
struct pixel_data
{
  float4 pos : POSITION;  // Homogeneous screen coordinates XYZW
  float2 uv  : TEXCOORD0; // UV coordinates in the source picture
};
*/

// Helper structure used as input of the vertex and fragment shaders
struct VertFragData
{
	float4 pos : POSITION;
	float2 uv  : TEXCOORD0;
};

// Vertex Shader code 
VertFragData VSDefault(VertFragData vtx)
{
	VertFragData res;
	res.pos = mul(float4(vtx.pos.xyz, 1.0), ViewProj);
	res.uv = vtx.uv;
	return res;
}

// Returns 3 numbers between -0.5 and 0.5 according to DitheringMatrix at given position
float3 getDitheringLevels(in int x, in int y)
{
	static const float2x2 Bayer2x2 = 
	{-0.25, 0.5, 0.25, 0.0};

	static const float4x4 Bayer4x4 =
	{-0.5, 0.033, -0.367, 0.167, 0.3, -0.233, 0.433, -0.1,
	 -0.3, 0.233, -0.433, 0.1, 0.5, -0.033, 0.367, -0.167};

	static const float Bayer8x8[64] =
	{-0.5, 0.25, -0.313, 0.438, -0.453, 0.297, -0.266, 0.484, 0.0, -0.25,
	 0.188, -0.063, 0.047, -0.203, 0.234, -0.016, -0.375, 0.375, -0.438,
	 0.313, -0.328, 0.422, -0.391, 0.359, 0.125, -0.125, 0.063, -0.188,
	 0.172, -0.078, 0.109, -0.141, -0.469, 0.281, -0.281, 0.469, -0.484,
	 0.25, -0.297, 0.453, 0.031, -0.219, 0.219, -0.031, 0.016, -0.234,
	 0.203, -0.047, -0.344, 0.406, -0.406, 0.344, -0.359, 0.391, -0.422,
	 0.328, 0.156, -0.094, 0.094, -0.156, 0.141, -0.109, 0.078, -0.172};

	static const float3x3 Dot3x3 =
	{0.278, -0.056, 0.389, -0.167, -0.5, -0.389, 0.167, -0.278, 0.056};

	static const float4x4 Dot4x4 =
	{0.313, 0.0, 0.063, 0.375, -0.063, -0.375, -0.313, 0.125,
	-0.125, -0.438, -0.5, 0.188, 0.25, -0.188, -0.25, 0.438};

	static const float Dot6x6[36] =
	{0.389, 0.222, 0.0, 0.028, 0.25, 0.417, 0.194, -0.167, -0.361,
	-0.333, -0.139, 0.278, -0.028, -0.389, -0.5, -0.472, -0.306,
	 0.056, -0.056, -0.194, -0.417, -0.444, -0.278, 0.083, 0.167,
	-0.083, -0.222, -0.25, -0.111, 0.306, 0.472, 0.361, 0.139,
	 0.111, 0.333, 0.444};

	float f = 0;
	if (DitheringMatrix==1)
		f = Bayer2x2[x&1][y&1];
	else if (DitheringMatrix==2)
		f = Bayer4x4[x&3][y&3];
	else if (DitheringMatrix==3)
		f = Bayer8x8[((x&7)<<3) + (y&7)];
	else if (DitheringMatrix==4)
		f = Dot3x3[fmod(x,3)][fmod(y,3)];
	else if (DitheringMatrix==5)
		return float3(Dot3x3[fmod(x,3)][fmod(y,3)],
									Dot3x3[fmod(x+2,3)][fmod(y,3)],
									Dot3x3[fmod(x+1,3)][fmod(y+2,3)]);
	else if (DitheringMatrix==6)
		f = Dot4x4[x&3][y&3];
	else if (DitheringMatrix==7)
		return float3(Dot4x4[x&3][y&3],
									Dot4x4[(x+2)&3][y&3],
									Dot4x4[(x+1)&3][(+2)&3]);
	else if (DitheringMatrix==8)
		f = Dot6x6[fmod(x,6)*6 + fmod(y,6)];
	else if (DitheringMatrix==9)
		return float3(Dot6x6[fmod(x,6)*6 + fmod(y,6)],
									Dot6x6[fmod(x+3,6)*6 + fmod(y,6)],
									Dot6x6[fmod(x+2,6)*6 + fmod(y+2,6)]);

	return float3(f, f, f);
}

// Returns RGB color corresponding to the Ink number
float3 getColor(in int n)
{
	// CPC palette Gate Array from https://www.grimware.org/doku.php/documentations/devices/gatearray
	static const float3 PaletteGateArray[27] =
	{
		float3(0.000, 0.008, 0.004),  // 0: Black
		float3(0.000, 0.008, 0.420),  // 1: Blue
		float3(0.047, 0.008, 0.957),  // 2: Bright Blue
		float3(0.424, 0.008, 0.004),  // 3: Red
		float3(0.412, 0.008, 0.408),  // 4: Magenta
		float3(0.424, 0.008, 0.949),  // 5: Mauve
		float3(0.953, 0.020, 0.024),  // 6: Bright Red
		float3(0.941, 0.008, 0.408),  // 7: Purple
		float3(0.953, 0.008, 0.957),  // 8: Bright Magenta
		float3(0.008, 0.471, 0.004),  // 9: Green
		float3(0.000, 0.471, 0.408),  // 10: Cyan
		float3(0.047, 0.482, 0.957),  // 11: Sky Blue
		float3(0.431, 0.482, 0.004),  // 12: Yellow
		float3(0.431, 0.490, 0.420),  // 13: White //cut by pif sinon prends la majorité des pixels
		float3(0.431, 0.482, 0.965),  // 14: Pastel Blue
		float3(0.953, 0.490, 0.051),  // 15: Orange
		float3(0.953, 0.490, 0.420),  // 16: Pink
		float3(0.980, 0.502, 0.976),  // 17: Pastel Magenta
		float3(0.008, 0.941, 0.004),  // 18: Bright Green
		float3(0.000, 0.953, 0.420),  // 19: Sea Green
		float3(0.059, 0.953, 0.949),  // 20: Bright Cyan
		float3(0.443, 0.961, 0.016),  // 21: Lime
		float3(0.443, 0.953, 0.420),  // 22: Pastel Green
		float3(0.443, 0.953, 0.957),  // 23: Pastel Cyan
		float3(0.953, 0.953, 0.051),  // 24: Bright Yellow
		float3(0.953, 0.953, 0.427),  // 25: Pastel Yellow
		float3(1.000, 0.953, 0.976),  // 26: Bright White
	};

	// CPC palette ASIC from https://www.grimware.org/doku.php/documentations/devices/gatearray
	static const float3 PaletteASIC[27] =
	{
		float3(0.008, 0.027, 0.008),  // 0: Black
		float3(0.020, 0.024, 0.388),  // 1: Blue
		float3(0.020, 0.027, 0.945),  // 2: Bright Blue
		float3(0.404, 0.024, 0.000),  // 3: Red
		float3(0.408, 0.027, 0.392),  // 4: Magenta
		float3(0.408, 0.027, 0.945),  // 5: Mauve
		float3(0.992, 0.027, 0.016),  // 6: Bright Red
		float3(1.000, 0.027, 0.392),  // 7: Purple
		float3(0.992, 0.027, 0.949),  // 8: Bright Magenta
		float3(0.016, 0.404, 0.012),  // 9: Green
		float3(0.016, 0.404, 0.392),  // 10: Cyan
		float3(0.020, 0.404, 0.945),  // 11: Sky Blue
		float3(0.408, 0.404, 0.016),  // 12: Yellow
		float3(0.408, 0.404, 0.392),  // 13: White
		float3(0.408, 0.404, 0.945),  // 14: Pastel Blue
		float3(0.992, 0.404, 0.016),  // 15: Orange
		float3(0.992, 0.404, 0.388),  // 16: Pink
		float3(0.992, 0.404, 0.945),  // 17: Pastel Magenta
		float3(0.016, 0.961, 0.008),  // 18: Bright Green
		float3(0.016, 0.961, 0.384),  // 19: Sea Green
		float3(0.016, 0.961, 0.945),  // 20: Bright Cyan
		float3(0.408, 0.961, 0.000),  // 21: Lime
		float3(0.408, 0.961, 0.392),  // 22: Pastel Green
		float3(0.408, 0.961, 0.945),  // 23: Pastel Cyan
		float3(0.996, 0.961, 0.016),  // 24: Bright Yellow
		float3(0.992, 0.961, 0.388),  // 25: Pastel Yellow
		float3(0.992, 0.961, 0.941),  // 26: Bright White
	};

	// Theoretical CPC palette from http://www.cpcwiki.eu/index.php/CPC_Palette
	static const float3 PalettePerfect[27] =
	{
		float3(0.0, 0.0, 0.0),  //  0: Black
		float3(0.0, 0.0, 0.5),  //  1: Blue
		float3(0.0, 0.0, 1.0),  //  2: Bright Blue
		float3(0.5, 0.0, 0.0),  //  3: Red
		float3(0.5, 0.0, 0.5),  //  4: Magenta
		float3(0.5, 0.0, 1.0),  //  5: Mauve
		float3(1.0, 0.0, 0.0),  //  6: Bright Red
		float3(1.0, 0.0, 0.5),  //  7: Purple
		float3(1.0, 0.0, 1.0),  //  8: Bright Magenta
		float3(0.0, 0.5, 0.0),  //  9: Green
		float3(0.0, 0.5, 0.5),  // 10: Cyan
		float3(0.0, 0.5, 1.0),  // 11: Sky Blue
		float3(0.5, 0.5, 0.0),  // 12: Yellow
		float3(0.0, 0.0, 0.0), // float3(0.5, 0.5, 0.5),  // 13: White //zero by pif sinon prends la majorité des pixels
		float3(0.5, 0.5, 1.0),  // 14: Pastel Blue
		float3(1.0, 0.5, 0.0),  // 15: Orange
		float3(1.0, 0.5, 0.5),  // 16: Pink
		float3(1.0, 0.5, 1.0),  // 17: Pastel Magenta
		float3(0.0, 1.0, 0.0),  // 18: Bright Green
		float3(0.0, 1.0, 0.5),  // 19: Sea Green
		float3(0.0, 1.0, 1.0),  // 20: Bright Cyan
		float3(0.5, 1.0, 0.0),  // 21: Lime
		float3(0.5, 1.0, 0.5),  // 22: Pastel Green
		float3(0.5, 1.0, 1.0),  // 23: Pastel Cyan
		float3(1.0, 1.0, 0.0),  // 24: Bright Yellow
		float3(1.0, 1.0, 0.5),  // 25: Pastel Yellow
		float3(1.0, 1.0, 1.0)   // 26: Bright White
	};

	if (PaletteAdaptedColors == 2)
		return PaletteASIC[n];
	else if (PaletteAdaptedColors == 1)
		return PaletteGateArray[n];
	else
		return PalettePerfect[n];
}

// Determines the closest RGB color in the palette, with Ink number in Alpha component
float4 getClosestColor(in float3 color)
{
	// Find closest color in palette
	float minlen = 1e100;
	float3 col = float3(0.0, 0.0, 0.0);
	int ink = -1;
	int maxcol = DisplayCPCMode==2 ? 2 : (DisplayCPCMode==1 ? 4 : (DisplayCPCMode==0 ? 16 : 27));
	for (int i=0 ; i<maxcol ; i++)
	{
		// Gets color from the inks or the complete palette (mode 3)
		float3 pcol = getColor(DisplayCPCMode>2 ? i : PaletteInks[i&3][i>>2]);

		// Color distance is simply the length of the RGB delta
		// This part can be improved using other color spaces (CIELAB)
		float len = length(color.rgb-pcol.rgb);
		if (len < minlen)
		{
			col = pcol;
			minlen = len;
			ink = i;
		}
	}

	// Returns the determined color
	return float4(col, ink);
}

// Main function called for each single pixel
float4 PSDefault(VertFragData vtx) : TARGET
{

	// return float4(fmod(vtx.pos.x, 50.0)/50.0, fmod(vtx.pos.y, 50.0)/50.0, 0.5, 1.0);

	float2 ViewSize = float2(width, height);

	// Determines bpix, i.e. side size in source pixels of one downscaled pixel
	//  in PAL resolution (downscaled pixel is a square), adapted to fit any source dimension
	//  to contain PAL area (depending on source aspect ratio).
	float bpix = (ViewSize.x/ViewSize.y >= 768.0/544.0) ? ViewSize.y/544.0 : ViewSize.x/768.0;

	// Returns if current position is in the border, i.e. more than half-screen of
	//  640x400 bpix from center, adjusted by Overscan level
	/* if (abs(ViewSize.x/2.-vtx.pos.x) > lerp(320*bpix, ViewSize.x/2., DisplayFrameOverscan) ||
			abs(ViewSize.y/2.-vtx.pos.y) > lerp(200*bpix, ViewSize.y/2., DisplayFrameOverscan))
		return float4(getColor(PaletteBorder), 1.0-TransparencyBorder); */

	// Pixel size in source pixels depending on mode 0/1/2/3 and downscale method/size
	float2 psize =(DisplayDownscale>0 ? DisplayDownscale : bpix ) *
	               float2(DisplayCPCMode>=2 ? 1.0 : 2.0*(2-DisplayCPCMode),
								        DisplayCPCMode==3 ? 1.0 : 2.0);

	// Position of downscaled pixel
	float2 pos = floor(vtx.uv.xy * ViewSize.xy / psize);

	// Position of downscaled pixel in UV coordinates (centered on downscaled pixel)
	float2 posuv = (pos+0.5) * psize / ViewSize.xy; // (pos+0.5) * psize / ViewSize.xy;

	// ------------ Pixel-level Downscale ------------


	// ------- Edge detection ----------

	// Macro to retrieve a float4 pixel color at uv plus an integer delta
	#define source(uv, dx, dy) (image.Sample(def_sampler, (uv) + float2((dx),(dy)) / ViewSize.xy))

	// Retrieves 9 pixel colors at and around the current position in the source picture
	float4 p[9] = {source(posuv, -1, -1), source(posuv,  0, -1), source(posuv,  1, -1),
								 source(posuv, -1,  0), source(posuv,  0,  0), source(posuv,  1,  0),
								 source(posuv, -1,  1), source(posuv,  0,  1), source(posuv,  1,  1)};

	// Computes the luminance of these pixel colors
	static const float3 LuminanceRGB = {0.3, 0.59, 0.11};
	float3x3 lumat = {dot(p[0].rgb, LuminanceRGB), dot(p[1].rgb, LuminanceRGB), dot(p[2].rgb, LuminanceRGB),
										dot(p[3].rgb, LuminanceRGB), dot(p[4].rgb, LuminanceRGB), dot(p[5].rgb, LuminanceRGB),
										dot(p[6].rgb, LuminanceRGB), dot(p[7].rgb, LuminanceRGB), dot(p[8].rgb, LuminanceRGB)};

	// Defines the Sobel operator via convolution kernels in x and y
	// See https://en.wikipedia.org/wiki/Sobel_operator
	// See https://en.wikipedia.org/wiki/Kernel_(image_processing)
	static const float3x3 SobelX = {1.0, 0.0, -1.0, 2.0, 0.0, -2.0, 1.0, 0.0, -1.0};
	static const float3x3 SobelY = {1.0, 2.0, 1.0, 0.0, 0.0, 0.0, -1.0, -2.0, -1.0};

	// Applies convolution kernel using 3 dot products
	float px = dot(lumat[0], SobelX[0]) + dot(lumat[1], SobelX[1]) + dot(lumat[2], SobelX[2]);
	float py = dot(lumat[0], SobelY[0]) + dot(lumat[1], SobelY[1]) + dot(lumat[2], SobelY[2]);
	float edge = length(float2(px, py));

	// Source pixel at this position
	float4 smp = image.Sample(def_sampler, posuv);
	//float4 smp = p[4];

	// Adapts source color to grayscale
	if (DisplayGrayscale)
	{
		float lum = 0.3*smp.r + 0.59*smp.g + 0.11*smp.b;
		smp.rgb = float3(lum, lum, lum);
	}

	// Adjusts gamma
	if(DisplayGammaCorrection!=0.0)
	{
		float g = 1.0 - DisplayGammaCorrection;
		smp.rgb = pow(smp.rgb, float3(g, g, g));
	}

	// Dithering principle: add some noise to current color to ressemble other
	//  similar colors in the palette, and use such similar color if near
	//  enough. By mixing the set of similar colors according to the
	//  probability of reaching such colors, the overall mix approximates
	//  the original color.
	float3 attempt = smp.rgb + XDitheringRGBCorrection.rgb*getDitheringLevels(pos.x, pos.y) *
	 														DitheringSpread;

	// Determines closest color, overwritten by edge outline if sufficent intensity
	float4 col = getClosestColor(lerp(attempt, OutlineEdgeColor, edge*OutlineEdge));
	int ink = col.a;

	// For mode 3 (no ink numbers) the transparency levels set
	// successive colors 2-by-2 (transparency levels 0 to 13)
	if(DisplayCPCMode>2)
		ink/=2;
	
	// Determines final alpha mixing original alpha with the selected transparency
	float alpha = smp.a * (1.0-TransparencyInks[ink&3][ink>>2]);

	// Final color
	return float4(col.rgb, alpha);
}

technique Draw
{
	pass
	{
		vertex_shader = VSDefault(vtx);
		pixel_shader  = PSDefault(vtx); 
	}
}
