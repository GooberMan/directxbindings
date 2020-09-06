// Based on DirectX 12 from Windows 10 kit 10.0.17134.0
module directx.dxgi1_2;

version (Windows) { version = DXGI1_2Enable; }
else { static assert( false, "DXGI1_2 is only enabled for Windows." ); }

version( DXGI1_2Enable ):
@system:
extern( C ):

import combindings;

public import directx.dxgi;

extern( C ) extern const IID IID_IDXGIDisplayControl;
@MIDL_INTERFACE!("ea9dbf1a-c88e-4486-854a-98aa0138f30c")
interface IDXGIDisplayControl : IUnknown
{
public:
	BOOL IsStereoEnabled();

	void SetStereoEnabled( 
		BOOL enabled);

}

struct DXGI_OUTDUPL_MOVE_RECT
{
	POINT SourcePoint;
	RECT DestinationRect;
}

struct DXGI_OUTDUPL_DESC
{
	DXGI_MODE_DESC ModeDesc;
	DXGI_MODE_ROTATION Rotation;
	BOOL DesktopImageInSystemMemory;
}

struct DXGI_OUTDUPL_POINTER_POSITION
{
	POINT Position;
	BOOL Visible;
}

enum DXGI_OUTDUPL_POINTER_SHAPE_TYPE
{
	DXGI_OUTDUPL_POINTER_SHAPE_TYPE_MONOCHROME	= 0x1,
	DXGI_OUTDUPL_POINTER_SHAPE_TYPE_COLOR	= 0x2,
	DXGI_OUTDUPL_POINTER_SHAPE_TYPE_MASKED_COLOR	= 0x4
}

struct DXGI_OUTDUPL_POINTER_SHAPE_INFO
{
	UINT Type;
	UINT Width;
	UINT Height;
	UINT Pitch;
	POINT HotSpot;
}

struct DXGI_OUTDUPL_FRAME_INFO
{
	LARGE_INTEGER LastPresentTime;
	LARGE_INTEGER LastMouseUpdateTime;
	UINT AccumulatedFrames;
	BOOL RectsCoalesced;
	BOOL ProtectedContentMaskedOut;
	DXGI_OUTDUPL_POINTER_POSITION PointerPosition;
	UINT TotalMetadataBufferSize;
	UINT PointerShapeBufferSize;
}

extern( C ) extern const IID IID_IDXGIOutputDuplication;
@MIDL_INTERFACE!("191cfac3-a341-470d-b26e-a864f428319c")
interface IDXGIOutputDuplication : IDXGIObject
{
public:
	void GetDesc( 
		DXGI_OUTDUPL_DESC *pDesc);

	HRESULT AcquireNextFrame( 
		UINT TimeoutInMilliseconds,
		DXGI_OUTDUPL_FRAME_INFO *pFrameInfo,
		IDXGIResource ppDesktopResource);

	HRESULT GetFrameDirtyRects( 
		UINT DirtyRectsBufferSize,
		RECT *pDirtyRectsBuffer,
		UINT *pDirtyRectsBufferSizeRequired);

	HRESULT GetFrameMoveRects( 
		UINT MoveRectsBufferSize,
		DXGI_OUTDUPL_MOVE_RECT *pMoveRectBuffer,
		UINT *pMoveRectsBufferSizeRequired);

	HRESULT GetFramePointerShape( 
		UINT PointerShapeBufferSize,
		void *pPointerShapeBuffer,
		UINT *pPointerShapeBufferSizeRequired,
		DXGI_OUTDUPL_POINTER_SHAPE_INFO *pPointerShapeInfo);

	HRESULT MapDesktopSurface( 
		DXGI_MAPPED_RECT *pLockedRect);

	HRESULT UnMapDesktopSurface();

	HRESULT ReleaseFrame();
}

enum DXGI_ALPHA_MODE
{
	DXGI_ALPHA_MODE_UNSPECIFIED	= 0,
	DXGI_ALPHA_MODE_PREMULTIPLIED	= 1,
	DXGI_ALPHA_MODE_STRAIGHT	= 2,
	DXGI_ALPHA_MODE_IGNORE	= 3,
	DXGI_ALPHA_MODE_FORCE_DWORD	= 0xffffffff
}

extern( C ) extern const IID IID_IDXGISurface2;
@MIDL_INTERFACE!("aba496dd-b617-4cb8-a866-bc44d7eb1fa2")
interface IDXGISurface2 : IDXGISurface1
{
public:
	HRESULT GetResource( 
		REFIID riid,
		void **ppParentResource,
		UINT *pSubresourceIndex);
}

extern( C ) extern const IID IID_IDXGIResource1;
@MIDL_INTERFACE!("30961379-4609-4a41-998e-54fe567ee0c1")
interface IDXGIResource1 : IDXGIResource
{
public:
	HRESULT CreateSubresourceSurface( 
		UINT index,
		IDXGISurface2 *ppSurface);

	HRESULT CreateSharedHandle( 
		const SECURITY_ATTRIBUTES *pAttributes,
		DWORD dwAccess,
		LPCWSTR lpName,
		HANDLE *pHandle);
}

enum DXGI_OFFER_RESOURCE_PRIORITY
{
	DXGI_OFFER_RESOURCE_PRIORITY_LOW	= 1,
	DXGI_OFFER_RESOURCE_PRIORITY_NORMAL	= ( DXGI_OFFER_RESOURCE_PRIORITY_LOW + 1 ) ,
	DXGI_OFFER_RESOURCE_PRIORITY_HIGH	= ( DXGI_OFFER_RESOURCE_PRIORITY_NORMAL + 1 ) 
}

extern( C ) extern const IID IID_IDXGIDevice2;
@MIDL_INTERFACE!("05008617-fbfd-4051-a790-144884b4f6a9")
interface IDXGIDevice2 : IDXGIDevice1
{
public:
	HRESULT OfferResources( 
		UINT NumResources,
		IDXGIResource /+*const+/ *ppResources,
		DXGI_OFFER_RESOURCE_PRIORITY Priority);

	HRESULT ReclaimResources( 
		UINT NumResources,
		IDXGIResource /+*const+/ *ppResources,
		BOOL *pDiscarded);

	HRESULT EnqueueSetEvent( 
		HANDLE hEvent);
}

enum DXGI_ENUM_MODES_STEREO	= 4U;
enum DXGI_ENUM_MODES_DISABLED_STEREO	= 8U;
enum DXGI_SHARED_RESOURCE_READ	= 0x80000000;
enum DXGI_SHARED_RESOURCE_WRITE	= 1;

struct DXGI_MODE_DESC1
{
	UINT Width;
	UINT Height;
	DXGI_RATIONAL RefreshRate;
	DXGI_FORMAT Format;
	DXGI_MODE_SCANLINE_ORDER ScanlineOrdering;
	DXGI_MODE_SCALING Scaling;
	BOOL Stereo;
}

enum DXGI_SCALING
{
	DXGI_SCALING_STRETCH	= 0,
	DXGI_SCALING_NONE	= 1,
	DXGI_SCALING_ASPECT_RATIO_STRETCH	= 2
}

struct DXGI_SWAP_CHAIN_DESC1
{
	UINT Width;
	UINT Height;
	DXGI_FORMAT Format;
	BOOL Stereo;
	DXGI_SAMPLE_DESC SampleDesc;
	DXGI_USAGE BufferUsage;
	UINT BufferCount;
	DXGI_SCALING Scaling;
	DXGI_SWAP_EFFECT SwapEffect;
	DXGI_ALPHA_MODE AlphaMode;
	UINT Flags;
}

struct DXGI_SWAP_CHAIN_FULLSCREEN_DESC
{
	DXGI_RATIONAL RefreshRate;
	DXGI_MODE_SCANLINE_ORDER ScanlineOrdering;
	DXGI_MODE_SCALING Scaling;
	BOOL Windowed;
}

struct DXGI_PRESENT_PARAMETERS
{
	UINT DirtyRectsCount;
	RECT *pDirtyRects;
	RECT *pScrollRect;
	POINT *pScrollOffset;
}

extern( C ) extern const IID IID_IDXGISwapChain1;
@MIDL_INTERFACE!("790a45f7-0d42-4876-983a-0a55cfe6f4aa")
interface IDXGISwapChain1 : IDXGISwapChain
{
public:
	HRESULT GetDesc1( 
		DXGI_SWAP_CHAIN_DESC1 *pDesc);

	HRESULT GetFullscreenDesc( 
		DXGI_SWAP_CHAIN_FULLSCREEN_DESC *pDesc);

	HRESULT GetHwnd( 
		HWND *pHwnd);

	HRESULT GetCoreWindow( 
		REFIID refiid,
		void **ppUnk);

	HRESULT Present1( 
		UINT SyncInterval,
		UINT PresentFlags,
		const DXGI_PRESENT_PARAMETERS *pPresentParameters);

	BOOL IsTemporaryMonoSupported();

	HRESULT GetRestrictToOutput( 
		IDXGIOutput ppRestrictToOutput);

	HRESULT SetBackgroundColor( 
		const DXGI_RGBA *pColor);

	HRESULT GetBackgroundColor( 
		DXGI_RGBA *pColor);

	HRESULT SetRotation( 
		DXGI_MODE_ROTATION Rotation);

	HRESULT GetRotation( 
		DXGI_MODE_ROTATION *pRotation);
}

extern( C ) extern const IID IID_IDXGIFactory2;
@MIDL_INTERFACE!("50c83a1c-e072-4c48-87b0-3630fa36a6d0")
interface IDXGIFactory2 : IDXGIFactory1
{
public:
	BOOL IsWindowedStereoEnabled();

	HRESULT CreateSwapChainForHwnd( 
		IUnknown pDevice,
		HWND hWnd,
		const DXGI_SWAP_CHAIN_DESC1 *pDesc,
		const DXGI_SWAP_CHAIN_FULLSCREEN_DESC *pFullscreenDesc,
		IDXGIOutput pRestrictToOutput,
		IDXGISwapChain1 *ppSwapChain);

	HRESULT CreateSwapChainForCoreWindow( 
		IUnknown pDevice,
		IUnknown pWindow,
		const DXGI_SWAP_CHAIN_DESC1 *pDesc,
		IDXGIOutput pRestrictToOutput,
		IDXGISwapChain1 *ppSwapChain);

	HRESULT GetSharedResourceAdapterLuid( 
		HANDLE hResource,
		LUID *pLuid);

	HRESULT RegisterStereoStatusWindow( 
		HWND WindowHandle,
		UINT wMsg,
		DWORD *pdwCookie);

	HRESULT RegisterStereoStatusEvent( 
		HANDLE hEvent,
		DWORD *pdwCookie);

	void UnregisterStereoStatus( 
		DWORD dwCookie);

	HRESULT RegisterOcclusionStatusWindow( 
		HWND WindowHandle,
		UINT wMsg,
		DWORD *pdwCookie);

	HRESULT RegisterOcclusionStatusEvent( 
		HANDLE hEvent,
		DWORD *pdwCookie);

	void UnregisterOcclusionStatus( 
		DWORD dwCookie);

	HRESULT CreateSwapChainForComposition( 
		IUnknown pDevice,
		const DXGI_SWAP_CHAIN_DESC1 *pDesc,
		IDXGIOutput pRestrictToOutput,
		IDXGISwapChain1 *ppSwapChain);
}

enum DXGI_GRAPHICS_PREEMPTION_GRANULARITY
{
	DXGI_GRAPHICS_PREEMPTION_DMA_BUFFER_BOUNDARY	= 0,
	DXGI_GRAPHICS_PREEMPTION_PRIMITIVE_BOUNDARY	= 1,
	DXGI_GRAPHICS_PREEMPTION_TRIANGLE_BOUNDARY	= 2,
	DXGI_GRAPHICS_PREEMPTION_PIXEL_BOUNDARY	= 3,
	DXGI_GRAPHICS_PREEMPTION_INSTRUCTION_BOUNDARY	= 4
}

enum DXGI_COMPUTE_PREEMPTION_GRANULARITY
{
	DXGI_COMPUTE_PREEMPTION_DMA_BUFFER_BOUNDARY	= 0,
	DXGI_COMPUTE_PREEMPTION_DISPATCH_BOUNDARY	= 1,
	DXGI_COMPUTE_PREEMPTION_THREAD_GROUP_BOUNDARY	= 2,
	DXGI_COMPUTE_PREEMPTION_THREAD_BOUNDARY	= 3,
	DXGI_COMPUTE_PREEMPTION_INSTRUCTION_BOUNDARY	= 4
}

struct DXGI_ADAPTER_DESC2
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
	DXGI_GRAPHICS_PREEMPTION_GRANULARITY GraphicsPreemptionGranularity;
	DXGI_COMPUTE_PREEMPTION_GRANULARITY ComputePreemptionGranularity;
}

extern( C ) extern const IID IID_IDXGIAdapter2;
@MIDL_INTERFACE!("0AA1AE0A-FA0E-4B84-8644-E05FF8E5ACB5")
interface IDXGIAdapter2 : IDXGIAdapter1
{
public:
	HRESULT GetDesc2( 
		DXGI_ADAPTER_DESC2 *pDesc);
}

extern( C ) extern const IID IID_IDXGIOutput1;
@MIDL_INTERFACE!("00cddea8-939b-4b83-a340-a685226666cc")
interface IDXGIOutput1 : IDXGIOutput
{
public:
	HRESULT GetDisplayModeList1( 
		DXGI_FORMAT EnumFormat,
		UINT Flags,
		UINT *pNumModes,
		DXGI_MODE_DESC1 *pDesc);

	HRESULT FindClosestMatchingMode1( 
		const DXGI_MODE_DESC1 *pModeToMatch,
		DXGI_MODE_DESC1 *pClosestMatch,
		IUnknown pConcernedDevice);

	HRESULT GetDisplaySurfaceData1( 
		IDXGIResource pDestination);

	HRESULT DuplicateOutput( 
		IUnknown pDevice,
		IDXGIOutputDuplication *ppOutputDuplication);
}

mixin( Glue!"directx.dxgi1_2" );
