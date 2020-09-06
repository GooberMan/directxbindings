// Based on DirectX 12 from Windows 10 kit 10.0.17134.0
module directx.dxgi1_4;

version (Windows) { version = DXGI1_4Enable; }
else { static assert( false, "DXGI1_4 is only enabled for Windows." ); }

version( DXGI1_4Enable ):
@system:
extern( C ):

import combindings;

public import directx.dxgi1_3;

enum DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG
{
	DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG_PRESENT	= 0x1,
	DXGI_SWAP_CHAIN_COLOR_SPACE_SUPPORT_FLAG_OVERLAY_PRESENT	= 0x2
}

extern( C ) extern const IID IID_IDXGISwapChain3;
@MIDL_INTERFACE!("94d99bdb-f1f8-4ab0-b236-7da0170edab1")
interface IDXGISwapChain3 : IDXGISwapChain2
{
public:
	UINT GetCurrentBackBufferIndex();

	HRESULT CheckColorSpaceSupport( 
		DXGI_COLOR_SPACE_TYPE ColorSpace,
		UINT *pColorSpaceSupport);

	HRESULT SetColorSpace1( 
		DXGI_COLOR_SPACE_TYPE ColorSpace);

	HRESULT ResizeBuffers1( 
		UINT BufferCount,
		UINT Width,
		UINT Height,
		DXGI_FORMAT Format,
		UINT SwapChainFlags,
		const UINT *pCreationNodeMask,
		IUnknown /+*const+/ *ppPresentQueue);
}

enum DXGI_OVERLAY_COLOR_SPACE_SUPPORT_FLAG
{
	DXGI_OVERLAY_COLOR_SPACE_SUPPORT_FLAG_PRESENT	= 0x1
}

extern( C ) extern const IID IID_IDXGIOutput4;
@MIDL_INTERFACE!("dc7dca35-2196-414d-9F53-617884032a60")
interface IDXGIOutput4 : IDXGIOutput3
{
public:
	HRESULT CheckOverlayColorSpaceSupport( 
		DXGI_FORMAT Format,
		DXGI_COLOR_SPACE_TYPE ColorSpace,
		IUnknown pConcernedDevice,
		UINT *pFlags);
}

extern( C ) extern const IID IID_IDXGIFactory4;
@MIDL_INTERFACE!("1bc6ea02-ef36-464f-bf0c-21ca39e5168a")
interface IDXGIFactory4 : IDXGIFactory3
{
public:
	HRESULT EnumAdapterByLuid( 
		LUID AdapterLuid,
		REFIID riid,
		void **ppvAdapter);
	HRESULT EnumWarpAdapter( 
		REFIID riid,
		void **ppvAdapter);
}

enum DXGI_MEMORY_SEGMENT_GROUP
{
	DXGI_MEMORY_SEGMENT_GROUP_LOCAL	= 0,
	DXGI_MEMORY_SEGMENT_GROUP_NON_LOCAL	= 1
}

struct DXGI_QUERY_VIDEO_MEMORY_INFO
{
	UINT64 Budget;
	UINT64 CurrentUsage;
	UINT64 AvailableForReservation;
	UINT64 CurrentReservation;
}

extern( C ) extern const IID IID_IDXGIAdapter3;
@MIDL_INTERFACE!("645967A4-1392-4310-A798-8053CE3E93FD")
interface IDXGIAdapter3 : IDXGIAdapter2
{
public:
	HRESULT RegisterHardwareContentProtectionTeardownStatusEvent( 
		HANDLE hEvent,
		DWORD *pdwCookie);

	void UnregisterHardwareContentProtectionTeardownStatus( 
		DWORD dwCookie);

	HRESULT QueryVideoMemoryInfo( 
		UINT NodeIndex,
		DXGI_MEMORY_SEGMENT_GROUP MemorySegmentGroup,
		DXGI_QUERY_VIDEO_MEMORY_INFO *pVideoMemoryInfo);

	HRESULT SetVideoMemoryReservation( 
		UINT NodeIndex,
		DXGI_MEMORY_SEGMENT_GROUP MemorySegmentGroup,
		UINT64 Reservation);

	HRESULT RegisterVideoMemoryBudgetChangeNotificationEvent( 
		HANDLE hEvent,
		DWORD *pdwCookie);

	void UnregisterVideoMemoryBudgetChangeNotification( 
		DWORD dwCookie);
}

mixin( Glue!"directx.dxgi1_4" );
