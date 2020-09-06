// Based on DirectX 12 from Windows 10 kit 10.0.17134.0
module directx.dxgi1_6;

version (Windows) { version = DXGI1_6Enable; }
else { static assert( false, "DXGI1_6 is only enabled for Windows." ); }

version( DXGI1_6Enable ):
@system:
extern( C ):

import combindings;

public import directx.dxgi1_5;

extern( Windows ) HRESULT DXGIDeclareAdapterRemovalSupport();

@DEFINE_ENUM_FLAG_OPERATORS
enum DXGI_ADAPTER_FLAG3
{
	DXGI_ADAPTER_FLAG3_NONE	= 0,
	DXGI_ADAPTER_FLAG3_REMOTE	= 1,
	DXGI_ADAPTER_FLAG3_SOFTWARE	= 2,
	DXGI_ADAPTER_FLAG3_ACG_COMPATIBLE	= 4,
	DXGI_ADAPTER_FLAG3_SUPPORT_MONITORED_FENCES	= 8,
	DXGI_ADAPTER_FLAG3_SUPPORT_NON_MONITORED_FENCES	= 0x10,
	DXGI_ADAPTER_FLAG3_KEYED_MUTEX_CONFORMANCE	= 0x20,
	DXGI_ADAPTER_FLAG3_FORCE_DWORD	= 0xffffffff
}

struct DXGI_ADAPTER_DESC3
{
	WCHAR[ 128 ] Description;
	UINT VendorId;
	UINT DeviceId;
	UINT SubSysId;
	UINT Revision;
	SIZE_T DedicatedVideoMemory;
	SIZE_T DedicatedSystemMemory;
	SIZE_T SharedSystemMemory;
	LUID AdapterLuid;
	DXGI_ADAPTER_FLAG3 Flags;
	DXGI_GRAPHICS_PREEMPTION_GRANULARITY GraphicsPreemptionGranularity;
	DXGI_COMPUTE_PREEMPTION_GRANULARITY ComputePreemptionGranularity;
}

extern( C ) extern const IID IID_IDXGIAdapter4;
@MIDL_INTERFACE!("3c8d99d1-4fbf-4181-a82c-af66bf7bd24e")
interface IDXGIAdapter4 : IDXGIAdapter3
{
public:
	HRESULT GetDesc3( 
		DXGI_ADAPTER_DESC3 *pDesc);
}

struct DXGI_OUTPUT_DESC1
{
	WCHAR[ 32 ] DeviceName;
	RECT DesktopCoordinates;
	BOOL AttachedToDesktop;
	DXGI_MODE_ROTATION Rotation;
	HMONITOR Monitor;
	UINT BitsPerColor;
	DXGI_COLOR_SPACE_TYPE ColorSpace;
	FLOAT[ 2 ] RedPrimary;
	FLOAT[ 2 ] GreenPrimary;
	FLOAT[ 2 ] BluePrimary;
	FLOAT[ 2 ] WhitePoint;
	FLOAT MinLuminance;
	FLOAT MaxLuminance;
	FLOAT MaxFullFrameLuminance;
}

@DEFINE_ENUM_FLAG_OPERATORS
enum DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAGS
{
	DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAG_FULLSCREEN	= 1,
	DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAG_WINDOWED	= 2,
	DXGI_HARDWARE_COMPOSITION_SUPPORT_FLAG_CURSOR_STRETCHED	= 4
}

extern( C ) extern const IID IID_IDXGIOutput6;
@MIDL_INTERFACE!("068346e8-aaec-4b84-add7-137f513f77a1")
interface IDXGIOutput6 : IDXGIOutput5
{
public:
	HRESULT GetDesc1( 
		DXGI_OUTPUT_DESC1 *pDesc);

	HRESULT CheckHardwareCompositionSupport( 
		UINT *pFlags);
}

enum DXGI_GPU_PREFERENCE
{
	DXGI_GPU_PREFERENCE_UNSPECIFIED	= 0,
	DXGI_GPU_PREFERENCE_MINIMUM_POWER	= ( DXGI_GPU_PREFERENCE_UNSPECIFIED + 1 ) ,
	DXGI_GPU_PREFERENCE_HIGH_PERFORMANCE	= ( DXGI_GPU_PREFERENCE_MINIMUM_POWER + 1 ) 
}

extern( C ) extern const IID IID_IDXGIFactory6;
@MIDL_INTERFACE!("c1b6694f-ff09-44a9-b03c-77900a0a1d17")
interface IDXGIFactory6 : IDXGIFactory5
{
public:
	HRESULT EnumAdapterByGpuPreference( 
		UINT Adapter,
		DXGI_GPU_PREFERENCE GpuPreference,
		REFIID riid,
		void **ppvAdapter);
}

mixin( Glue!"directx.dxgi1_6" );
