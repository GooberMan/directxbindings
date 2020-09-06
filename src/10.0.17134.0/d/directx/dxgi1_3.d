// Based on DirectX 12 from Windows 10 kit 10.0.17134.0
module directx.dxgi1_3;

version (Windows) { version = DXGI1_3Enable; }
else { static assert( false, "DXGI1_3 is only enabled for Windows." ); }

version( DXGI1_3Enable ):
@system:
extern( C ):

import combindings;

public import directx.dxgi1_2;

enum DXGI_CREATE_FACTORY_DEBUG = 0x1;

extern( Windows ) HRESULT CreateDXGIFactory2(UINT Flags, REFIID riid, @_COM_Outptr_ void **ppFactory);
extern( Windows ) HRESULT DXGIGetDebugInterface1(UINT Flags, REFIID riid, @_COM_Outptr_ void **ppDebug);

extern( C ) extern const IID IID_IDXGIDevice3;
@MIDL_INTERFACE!("6007896c-3244-4afd-bf18-a6d3beda5023")
interface IDXGIDevice3 : IDXGIDevice2
{
public:
	void Trim();
}

struct DXGI_MATRIX_3X2_F
{
	FLOAT _11;
	FLOAT _12;
	FLOAT _21;
	FLOAT _22;
	FLOAT _31;
	FLOAT _32;
}

extern( C ) extern const IID IID_IDXGISwapChain2;
@MIDL_INTERFACE!("a8be2ac4-199f-4946-b331-79599fb98de7")
interface IDXGISwapChain2 : IDXGISwapChain1
{
public:
	HRESULT SetSourceSize( 
		UINT Width,
		UINT Height);

	HRESULT GetSourceSize( 
		UINT *pWidth,
		UINT *pHeight);

	HRESULT SetMaximumFrameLatency( 
		UINT MaxLatency);

	HRESULT GetMaximumFrameLatency( 
		UINT *pMaxLatency);

	HANDLE GetFrameLatencyWaitableObject();

	HRESULT SetMatrixTransform( 
		const DXGI_MATRIX_3X2_F *pMatrix);

	HRESULT GetMatrixTransform( 
		DXGI_MATRIX_3X2_F *pMatrix);
}

extern( C ) extern const IID IID_IDXGIOutput2;
@MIDL_INTERFACE!("595e39d1-2724-4663-99b1-da969de28364")
interface IDXGIOutput2 : IDXGIOutput1
{
public:
	BOOL SupportsOverlays();
}

extern( C ) extern const IID IID_IDXGIFactory3;
@MIDL_INTERFACE!("25483823-cd46-4c7d-86ca-47aa95b837bd")
interface IDXGIFactory3 : IDXGIFactory2
{
public:
	UINT GetCreationFlags();
}

struct DXGI_DECODE_SWAP_CHAIN_DESC
{
	UINT Flags;
}

enum DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS
{
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_NOMINAL_RANGE	= 0x1,
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_BT709	= 0x2,
    DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAG_xvYCC	= 0x4
}

extern( C ) extern const IID IID_IDXGIDecodeSwapChain;
@MIDL_INTERFACE!("2633066b-4514-4c7a-8fd8-12ea98059d18")
interface IDXGIDecodeSwapChain : IUnknown
{
public:
	HRESULT PresentBuffer( 
		UINT BufferToPresent,
		UINT SyncInterval,
		UINT Flags);

	HRESULT SetSourceRect( 
		const RECT *pRect);

	HRESULT SetTargetRect( 
		const RECT *pRect);

	HRESULT SetDestSize( 
		UINT Width,
		UINT Height);

	HRESULT GetSourceRect( 
		RECT *pRect);

	HRESULT GetTargetRect( 
		RECT *pRect);

	HRESULT GetDestSize( 
		UINT *pWidth,
		UINT *pHeight);

	HRESULT SetColorSpace( 
		DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS ColorSpace);

	DXGI_MULTIPLANE_OVERLAY_YCbCr_FLAGS GetColorSpace();
}
extern( C ) extern const IID IID_IDXGIFactoryMedia;
@MIDL_INTERFACE!("41e7d1f2-a591-4f7b-a2e5-fa9c843e1c12")
interface IDXGIFactoryMedia : IUnknown
{
public:
	HRESULT CreateSwapChainForCompositionSurfaceHandle( 
		IUnknown pDevice,
		HANDLE hSurface,
		const DXGI_SWAP_CHAIN_DESC1 *pDesc,
		IDXGIOutput pRestrictToOutput,
		IDXGISwapChain1 *ppSwapChain);

	HRESULT CreateDecodeSwapChainForCompositionSurfaceHandle( 
		IUnknown pDevice,
		HANDLE hSurface,
		DXGI_DECODE_SWAP_CHAIN_DESC *pDesc,
		IDXGIResource pYuvDecodeBuffers,
		IDXGIOutput pRestrictToOutput,
		IDXGIDecodeSwapChain *ppSwapChain);
}

enum DXGI_FRAME_PRESENTATION_MODE
{
	DXGI_FRAME_PRESENTATION_MODE_COMPOSED	= 0,
	DXGI_FRAME_PRESENTATION_MODE_OVERLAY	= 1,
	DXGI_FRAME_PRESENTATION_MODE_NONE	= 2,
	DXGI_FRAME_PRESENTATION_MODE_COMPOSITION_FAILURE	= 3
}

struct DXGI_FRAME_STATISTICS_MEDIA
{
	UINT PresentCount;
	UINT PresentRefreshCount;
	UINT SyncRefreshCount;
	LARGE_INTEGER SyncQPCTime;
	LARGE_INTEGER SyncGPUTime;
	DXGI_FRAME_PRESENTATION_MODE CompositionMode;
	UINT ApprovedPresentDuration;
}

extern( C ) extern const IID IID_IDXGISwapChainMedia;
@MIDL_INTERFACE!("dd95b90b-f05f-4f6a-bd65-25bfb264bd84")
interface IDXGISwapChainMedia : IUnknown
{
public:
	HRESULT GetFrameStatisticsMedia( 
		DXGI_FRAME_STATISTICS_MEDIA *pStats);

	HRESULT SetPresentDuration( 
		UINT Duration);

	HRESULT CheckPresentDurationSupport( 
		UINT DesiredPresentDuration,
		UINT *pClosestSmallerPresentDuration,
		UINT *pClosestLargerPresentDuration);

}

enum DXGI_OVERLAY_SUPPORT_FLAG
{
	DXGI_OVERLAY_SUPPORT_FLAG_DIRECT	= 0x1,
	DXGI_OVERLAY_SUPPORT_FLAG_SCALING	= 0x2
}

extern( C ) extern const IID IID_IDXGIOutput3;
@MIDL_INTERFACE!("8a6bb301-7e7e-41F4-a8e0-5b32f7f99b18")
interface IDXGIOutput3 : IDXGIOutput2
{
public:
	HRESULT CheckOverlaySupport( 
		DXGI_FORMAT EnumFormat,
		IUnknown pConcernedDevice,
		UINT *pFlags);
}

//pragma( msg, Glue!"directx.dxgi1_3" );
mixin( Glue!"directx.dxgi1_3" );
