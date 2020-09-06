// Based on DirectX 12 from Windows 10 kit 10.0.17134.0
module directx.dxgitype;

import combindings;

public import directx.dxgicommon;
public import directx.dxgiformat;

pragma( inline, true ) HRESULT MAKE_HRESULT( uint sev, uint fac, uint code )
{
	return ( sev << 31 ) | ( fac << 16 ) | code;
}

enum _FACDXGI    = 0x87a;

pragma( inline, true ) HRESULT MAKE_DXGI_HRESULT( uint code ) { return MAKE_HRESULT( 1, _FACDXGI, code ); }
pragma( inline, true ) HRESULT MAKE_DXGI_STATUS( uint code )  { return MAKE_HRESULT( 0, _FACDXGI, code ); }

// DXGI error messages have moved to winerror.h

enum DXGI_CPU_ACCESS_NONE                    = 0;
enum DXGI_CPU_ACCESS_DYNAMIC                 = 1;
enum DXGI_CPU_ACCESS_READ_WRITE              = 2;
enum DXGI_CPU_ACCESS_SCRATCH                 = 3;
enum DXGI_CPU_ACCESS_FIELD                   = 15;

struct DXGI_RGB
{
	float Red;
	float Green;
	float Blue;
}

struct D3DCOLORVALUE
{
	float r;
	float g;
	float b;
	float a;
}

alias DXGI_RGBA = D3DCOLORVALUE;

struct DXGI_GAMMA_CONTROL
{
	DXGI_RGB Scale;
	DXGI_RGB Offset;
	DXGI_RGB[ 1025 ] GammaCurve;
};

struct DXGI_GAMMA_CONTROL_CAPABILITIES
{
	BOOL ScaleAndOffsetSupported;
	float MaxConvertedValue;
	float MinConvertedValue;
	UINT NumGammaControlPoints;
	float[1025] ControlPointPositions;
}

enum DXGI_MODE_SCANLINE_ORDER
{
	DXGI_MODE_SCANLINE_ORDER_UNSPECIFIED        = 0,
	DXGI_MODE_SCANLINE_ORDER_PROGRESSIVE        = 1,
	DXGI_MODE_SCANLINE_ORDER_UPPER_FIELD_FIRST  = 2,
	DXGI_MODE_SCANLINE_ORDER_LOWER_FIELD_FIRST  = 3
}

enum DXGI_MODE_SCALING
{
	DXGI_MODE_SCALING_UNSPECIFIED   = 0,
	DXGI_MODE_SCALING_CENTERED      = 1,
	DXGI_MODE_SCALING_STRETCHED     = 2
}

enum DXGI_MODE_ROTATION
{
	DXGI_MODE_ROTATION_UNSPECIFIED  = 0,
	DXGI_MODE_ROTATION_IDENTITY     = 1,
	DXGI_MODE_ROTATION_ROTATE90     = 2,
	DXGI_MODE_ROTATION_ROTATE180    = 3,
	DXGI_MODE_ROTATION_ROTATE270    = 4
}

struct DXGI_MODE_DESC
{
	UINT Width;
	UINT Height;
	DXGI_RATIONAL RefreshRate;
	DXGI_FORMAT Format;
	DXGI_MODE_SCANLINE_ORDER ScanlineOrdering;
	DXGI_MODE_SCALING Scaling;
}

struct DXGI_JPEG_DC_HUFFMAN_TABLE
{
	BYTE[12] CodeCounts;
	BYTE[12] CodeValues;
}

struct DXGI_JPEG_AC_HUFFMAN_TABLE
{
	BYTE[16] CodeCounts;
	BYTE[162] CodeValues;
}

struct DXGI_JPEG_QUANTIZATION_TABLE
{
	BYTE[64] Elements;
}

mixin( Glue!"directx.dxgitype" );
