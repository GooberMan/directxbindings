// Based on DirectX 12 from Windows 10 kit 10.0.17134.0
module directx.dxgi;

version (Windows) { version = DXGIEnable; }
else { static assert( false, "DXGI is only enabled for Windows." ); }

version( DXGIEnable ):
@system:
extern( C ):

import combindings;

public import directx.dxgicommon;
public import directx.dxgiformat;
public import directx.dxgitype;


enum DXGI_CPU_ACCESS_NONE    = 0;
enum DXGI_CPU_ACCESS_DYNAMIC    = 1;
enum DXGI_CPU_ACCESS_READ_WRITE    = 2;
enum DXGI_CPU_ACCESS_SCRATCH    = 3;
enum DXGI_CPU_ACCESS_FIELD        = 15;
enum DXGI_USAGE_SHADER_INPUT             = 0x00000010U;
enum DXGI_USAGE_RENDER_TARGET_OUTPUT     = 0x00000020U;
enum DXGI_USAGE_BACK_BUFFER              = 0x00000040U;
enum DXGI_USAGE_SHARED                   = 0x00000080U;
enum DXGI_USAGE_READ_ONLY                = 0x00000100U;
enum DXGI_USAGE_DISCARD_ON_PRESENT       = 0x00000200U;
enum DXGI_USAGE_UNORDERED_ACCESS         = 0x00000400U;
alias DXGI_USAGE = UINT;

struct DXGI_FRAME_STATISTICS
{
	UINT PresentCount;
	UINT PresentRefreshCount;
	UINT SyncRefreshCount;
	LARGE_INTEGER SyncQPCTime;
	LARGE_INTEGER SyncGPUTime;
}

struct DXGI_MAPPED_RECT
{
	INT Pitch;
	BYTE *pBits;
}
struct DXGI_ADAPTER_DESC
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
}

alias HMONITOR = HANDLE;

struct DXGI_OUTPUT_DESC
{
	WCHAR[ 32 ] DeviceName;
	RECT DesktopCoordinates;
	BOOL AttachedToDesktop;
	DXGI_MODE_ROTATION Rotation;
	HMONITOR Monitor;
}

struct DXGI_SHARED_RESOURCE
{
	HANDLE Handle;
}

enum DXGI_RESOURCE_PRIORITY_MINIMUM	= 0x28000000;
enum DXGI_RESOURCE_PRIORITY_LOW	= 0x50000000;
enum DXGI_RESOURCE_PRIORITY_NORMAL	= 0x78000000;
enum DXGI_RESOURCE_PRIORITY_HIGH	= 0xa0000000;
enum DXGI_RESOURCE_PRIORITY_MAXIMUM	= 0xc8000000;

enum DXGI_RESIDENCY
{
	DXGI_RESIDENCY_FULLY_RESIDENT	= 1,
	DXGI_RESIDENCY_RESIDENT_IN_SHARED_MEMORY	= 2,
	DXGI_RESIDENCY_EVICTED_TO_DISK	= 3
}

struct DXGI_SURFACE_DESC
{
	UINT Width;
	UINT Height;
	DXGI_FORMAT Format;
	DXGI_SAMPLE_DESC SampleDesc;
}

enum DXGI_SWAP_EFFECT
{
	DXGI_SWAP_EFFECT_DISCARD	= 0,
	DXGI_SWAP_EFFECT_SEQUENTIAL	= 1,
	DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL	= 3,
	DXGI_SWAP_EFFECT_FLIP_DISCARD	= 4
}

enum DXGI_SWAP_CHAIN_FLAG
{
	DXGI_SWAP_CHAIN_FLAG_NONPREROTATED	= 1,
	DXGI_SWAP_CHAIN_FLAG_ALLOW_MODE_SWITCH	= 2,
	DXGI_SWAP_CHAIN_FLAG_GDI_COMPATIBLE	= 4,
	DXGI_SWAP_CHAIN_FLAG_RESTRICTED_CONTENT	= 8,
	DXGI_SWAP_CHAIN_FLAG_RESTRICT_SHARED_RESOURCE_DRIVER	= 16,
	DXGI_SWAP_CHAIN_FLAG_DISPLAY_ONLY	= 32,
	DXGI_SWAP_CHAIN_FLAG_FRAME_LATENCY_WAITABLE_OBJECT	= 64,
	DXGI_SWAP_CHAIN_FLAG_FOREGROUND_LAYER	= 128,
	DXGI_SWAP_CHAIN_FLAG_FULLSCREEN_VIDEO	= 256,
	DXGI_SWAP_CHAIN_FLAG_YUV_VIDEO	= 512,
	DXGI_SWAP_CHAIN_FLAG_HW_PROTECTED	= 1024,
	DXGI_SWAP_CHAIN_FLAG_ALLOW_TEARING	= 2048,
	DXGI_SWAP_CHAIN_FLAG_RESTRICTED_TO_ALL_HOLOGRAPHIC_DISPLAYS	= 4096
}

struct DXGI_SWAP_CHAIN_DESC
{
	DXGI_MODE_DESC BufferDesc;
	DXGI_SAMPLE_DESC SampleDesc;
	DXGI_USAGE BufferUsage;
	UINT BufferCount;
	HWND OutputWindow;
	BOOL Windowed;
	DXGI_SWAP_EFFECT SwapEffect;
	UINT Flags;
}

extern( C ) extern const IID IID_IDXGIObject;
@MIDL_INTERFACE!("aec22fb8-76f3-4639-9be0-28eb43a67a2e")
interface IDXGIObject : IUnknown
{
public:
	HRESULT SetPrivateData( 
		REFGUID Name,
		UINT DataSize,
		const void *pData);

	HRESULT SetPrivateDataInterface( 
		REFGUID Name,
		const IUnknown pUnknown);

	HRESULT GetPrivateData( 
		REFGUID Name,
		UINT *pDataSize,
		void *pData);

	HRESULT GetParent( 
		REFIID riid,
		void **ppParent);
}

extern( C ) extern const IID IID_IDXGIDeviceSubObject;
@MIDL_INTERFACE!("3d3e0379-f9de-4d58-bb6c-18d62992f1a6")
interface IDXGIDeviceSubObject : IDXGIObject
{
public:
	HRESULT GetDevice( 
		REFIID riid,
		void **ppDevice);
}

extern( C ) extern const IID IID_IDXGIResource;
@MIDL_INTERFACE!("035f3ab4-482e-4e50-b41f-8a7f8bd8960b")
interface IDXGIResource : IDXGIDeviceSubObject
{
public:
	HRESULT GetSharedHandle( 
		HANDLE *pSharedHandle);

	HRESULT GetUsage( 
		DXGI_USAGE *pUsage);

	HRESULT SetEvictionPriority( 
		UINT EvictionPriority);

	HRESULT GetEvictionPriority( 
		UINT *pEvictionPriority);
}

extern( C ) extern const IID IID_IDXGIKeyedMutex;
@MIDL_INTERFACE!("9d8e1289-d7b3-465f-8126-250e349af85d")
interface IDXGIKeyedMutex : IDXGIDeviceSubObject
{
public:
	HRESULT AcquireSync( 
		UINT64 Key,
		DWORD dwMilliseconds);

	HRESULT ReleaseSync( 
		UINT64 Key);
}

enum DXGI_MAP_READ		= 1U;
enum DXGI_MAP_WRITE		= 2U;
enum DXGI_MAP_DISCARD	= 4U;

extern( C ) extern const IID IID_IDXGISurface;
@MIDL_INTERFACE!("cafcb56c-6ac3-4889-bf47-9e23bbd260ec")
interface IDXGISurface : IDXGIDeviceSubObject
{
public:
	HRESULT GetDesc( 
		DXGI_SURFACE_DESC *pDesc);

	HRESULT Map( 
		DXGI_MAPPED_RECT *pLockedRect,
		UINT MapFlags);

	HRESULT Unmap();
}

extern( C ) extern const IID IID_IDXGISurface1;

@MIDL_INTERFACE!("4AE63092-6327-4c1b-80AE-BFE12EA32B86")
interface IDXGISurface1 : IDXGISurface
{
public:
	HRESULT GetDC( 
		BOOL Discard,
		HDC *phdc);

	HRESULT ReleaseDC( 
		RECT *pDirtyRect);
}

extern( C ) extern const IID IID_IDXGIAdapter;
@MIDL_INTERFACE!("2411e7e1-12ac-4ccf-bd14-9798e8534dc0")
interface IDXGIAdapter : IDXGIObject
{
public:
	HRESULT EnumOutputs( 
		UINT Output,
		IDXGIOutput *ppOutput);

	HRESULT GetDesc( 
		DXGI_ADAPTER_DESC *pDesc);

	HRESULT CheckInterfaceSupport( 
		REFGUID InterfaceName,
		LARGE_INTEGER *pUMDVersion);
}

enum DXGI_ENUM_MODES_INTERLACED	= 1U;
enum DXGI_ENUM_MODES_SCALING	= 2U;

extern( C ) extern const IID IID_IDXGIOutput;
@MIDL_INTERFACE!("ae02eedb-c735-4690-8d52-5a8dc20213aa")
interface IDXGIOutput : IDXGIObject
{
public:
	HRESULT GetDesc( 
		DXGI_OUTPUT_DESC *pDesc);

	HRESULT GetDisplayModeList( 
		DXGI_FORMAT EnumFormat,
		UINT Flags,
		UINT *pNumModes,
		DXGI_MODE_DESC *pDesc);

	HRESULT FindClosestMatchingMode( 
		const DXGI_MODE_DESC *pModeToMatch,
		DXGI_MODE_DESC *pClosestMatch,
		IUnknown pConcernedDevice);

	HRESULT WaitForVBlank();

	HRESULT TakeOwnership( 
		IUnknown pDevice,
		BOOL Exclusive);

	void ReleaseOwnership();

	HRESULT GetGammaControlCapabilities( 
		DXGI_GAMMA_CONTROL_CAPABILITIES *pGammaCaps);

	HRESULT SetGammaControl( 
		const DXGI_GAMMA_CONTROL *pArray);

	HRESULT GetGammaControl( 
		DXGI_GAMMA_CONTROL *pArray);

	HRESULT SetDisplaySurface( 
		IDXGISurface pScanoutSurface);

	HRESULT GetDisplaySurfaceData( 
		IDXGISurface pDestination);

	HRESULT GetFrameStatistics( 
		DXGI_FRAME_STATISTICS *pStats);
}

enum DXGI_MAX_SWAP_CHAIN_BUFFERS            = 16;
enum DXGI_PRESENT_TEST                      = 0x00000001U;
enum DXGI_PRESENT_DO_NOT_SEQUENCE           = 0x00000002U;
enum DXGI_PRESENT_RESTART                   = 0x00000004U;
enum DXGI_PRESENT_DO_NOT_WAIT               = 0x00000008U;
enum DXGI_PRESENT_STEREO_PREFER_RIGHT       = 0x00000010U;
enum DXGI_PRESENT_STEREO_TEMPORARY_MONO     = 0x00000020U;
enum DXGI_PRESENT_RESTRICT_TO_OUTPUT        = 0x00000040U;
enum DXGI_PRESENT_USE_DURATION              = 0x00000100U;
enum DXGI_PRESENT_ALLOW_TEARING             = 0x00000200U;

extern( C ) extern const IID IID_IDXGISwapChain;
@MIDL_INTERFACE!("310d36a0-d2e7-4c0a-aa04-6a9d23b8886a")
interface IDXGISwapChain : IDXGIDeviceSubObject
{
public:
	HRESULT Present( 
		UINT SyncInterval,
		UINT Flags);

	HRESULT GetBuffer( 
		UINT Buffer,
		REFIID riid,
		void **ppSurface);

	HRESULT SetFullscreenState( 
		BOOL Fullscreen,
		IDXGIOutput pTarget);

	HRESULT GetFullscreenState( 
		BOOL *pFullscreen,
		IDXGIOutput *ppTarget);

	HRESULT GetDesc( 
		DXGI_SWAP_CHAIN_DESC *pDesc);

	HRESULT ResizeBuffers( 
		UINT BufferCount,
		UINT Width,
		UINT Height,
		DXGI_FORMAT NewFormat,
		UINT SwapChainFlags);

	HRESULT ResizeTarget( 
		const DXGI_MODE_DESC *pNewTargetParameters);

	HRESULT GetContainingOutput( 
		IDXGIOutput *ppOutput);

	HRESULT GetFrameStatistics( 
		DXGI_FRAME_STATISTICS *pStats);

	HRESULT GetLastPresentCount( 
		UINT *pLastPresentCount);
}

enum DXGI_MWA_NO_WINDOW_CHANGES      = 1 << 0;
enum DXGI_MWA_NO_ALT_ENTER           = 1 << 1;
enum DXGI_MWA_NO_PRINT_SCREEN        = 1 << 2;
enum DXGI_MWA_VALID                  = 0x7;

extern( C ) extern const IID IID_IDXGIFactory;
@MIDL_INTERFACE!("7b7166ec-21c7-44ae-b21a-c9ae321ae369")
interface IDXGIFactory : IDXGIObject
{
public:
	HRESULT EnumAdapters( 
		UINT Adapter,
		IDXGIAdapter *ppAdapter);

	HRESULT MakeWindowAssociation( 
		HWND WindowHandle,
		UINT Flags);

	HRESULT GetWindowAssociation( 
		HWND *pWindowHandle);

	HRESULT CreateSwapChain( 
		IUnknown pDevice,
		DXGI_SWAP_CHAIN_DESC *pDesc,
		IDXGISwapChain *ppSwapChain);

	HRESULT CreateSoftwareAdapter( 
		HMODULE Module,
		IDXGIAdapter *ppAdapter);

}

extern( Windows ) HRESULT CreateDXGIFactory(REFIID riid, void **ppFactory);
extern( Windows ) HRESULT CreateDXGIFactory1(REFIID riid, void **ppFactory);

extern( C ) extern const IID IID_IDXGIDevice;
@MIDL_INTERFACE!("54ec77fa-1377-44e6-8c32-88fd5f44c84c")
interface IDXGIDevice : IDXGIObject
{
public:
	HRESULT GetAdapter( 
		IDXGIAdapter *pAdapter);

	HRESULT CreateSurface( 
		const DXGI_SURFACE_DESC *pDesc,
		UINT NumSurfaces,
		DXGI_USAGE Usage,
		const DXGI_SHARED_RESOURCE *pSharedResource,
		IDXGISurface *ppSurface);

	HRESULT QueryResourceResidency( 
		IUnknown /+*const+/ *ppResources,
		DXGI_RESIDENCY *pResidencyStatus,
		UINT NumResources);

	HRESULT SetGPUThreadPriority( 
		INT Priority);

	HRESULT GetGPUThreadPriority( 
		INT *pPriority);
}

enum DXGI_ADAPTER_FLAG
{
	DXGI_ADAPTER_FLAG_NONE	= 0,
	DXGI_ADAPTER_FLAG_REMOTE	= 1,
	DXGI_ADAPTER_FLAG_SOFTWARE	= 2,
	DXGI_ADAPTER_FLAG_FORCE_DWORD	= 0xffffffff
}

struct DXGI_ADAPTER_DESC1
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
	UINT Flags;
}

struct DXGI_DISPLAY_COLOR_SPACE
{
	FLOAT[ 2 ][ 8 ] PrimaryCoordinates;
	FLOAT[ 2 ][ 16 ] WhitePoints;
}

extern( C ) extern const IID IID_IDXGIFactory1;
@MIDL_INTERFACE!("770aae78-f26f-4dba-a829-253c83d1b387")
interface IDXGIFactory1 : IDXGIFactory
{
public:
	HRESULT EnumAdapters1( 
		UINT Adapter,
		IDXGIAdapter1 *ppAdapter);

	BOOL IsCurrent();
}

extern( C ) extern const IID IID_IDXGIAdapter1;
@MIDL_INTERFACE!("29038f61-3839-4626-91fd-086879011a05")
interface IDXGIAdapter1 : IDXGIAdapter
{
public:
	HRESULT GetDesc1( 
		DXGI_ADAPTER_DESC1 *pDesc);
}

extern( C ) extern const IID IID_IDXGIDevice1;
@MIDL_INTERFACE!("77db970f-6276-48ba-ba28-070143b4392c")
interface IDXGIDevice1 : IDXGIDevice
{
public:
	HRESULT SetMaximumFrameLatency( 
		UINT MaxLatency);

	HRESULT GetMaximumFrameLatency( 
		UINT *pMaxLatency);
}

mixin( Glue!"directx.dxgi" );
