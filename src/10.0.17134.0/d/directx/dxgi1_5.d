// Based on DirectX 12 from Windows 10 kit 10.0.17134.0
module directx.dxgi1_5;

version (Windows) { version = DXGI1_5Enable; }
else { static assert( false, "DXGI1_5 is only enabled for Windows." ); }

version( DXGI1_5Enable ):
@system:
extern( C ):

import combindings;

public import directx.dxgi1_4;

enum DXGI_OUTDUPL_FLAG
{
	DXGI_OUTDUPL_COMPOSITED_UI_CAPTURE_ONLY	= 1
}

extern( C ) extern const IID IID_IDXGIOutput5;
@MIDL_INTERFACE!("80A07424-AB52-42EB-833C-0C42FD282D98")
interface IDXGIOutput5 : IDXGIOutput4
{
public:
	HRESULT DuplicateOutput1( 
		IUnknown pDevice,
		UINT SupportedFormatsCount,
		const DXGI_FORMAT *pSupportedFormats,
		IDXGIOutputDuplication *ppOutputDuplication);
}

enum DXGI_HDR_METADATA_TYPE
{
	DXGI_HDR_METADATA_TYPE_NONE	= 0,
	DXGI_HDR_METADATA_TYPE_HDR10	= 1,
	DXGI_HDR_METADATA_TYPE_HDR10PLUS	= 2
}

struct DXGI_HDR_METADATA_HDR10
{
	UINT16[ 2 ] RedPrimary;
	UINT16[ 2 ] GreenPrimary;
	UINT16[ 2 ] BluePrimary;
	UINT16[ 2 ] WhitePoint;
	UINT MaxMasteringLuminance;
	UINT MinMasteringLuminance;
	UINT16 MaxContentLightLevel;
	UINT16 MaxFrameAverageLightLevel;
}

struct DXGI_HDR_METADATA_HDR10PLUS
{
	BYTE[ 72 ] Data;
}

extern( C ) extern const IID IID_IDXGISwapChain4;
@MIDL_INTERFACE!("3D585D5A-BD4A-489E-B1F4-3DBCB6452FFB")
interface IDXGISwapChain4 : IDXGISwapChain3
{
public:
	HRESULT SetHDRMetaData( 
		DXGI_HDR_METADATA_TYPE Type,
		UINT Size,
		void *pMetaData);
}

enum DXGI_OFFER_RESOURCE_FLAGS
{
	DXGI_OFFER_RESOURCE_FLAG_ALLOW_DECOMMIT	= 0x1
}

enum DXGI_RECLAIM_RESOURCE_RESULTS
{
	DXGI_RECLAIM_RESOURCE_RESULT_OK	= 0,
	DXGI_RECLAIM_RESOURCE_RESULT_DISCARDED	= 1,
	DXGI_RECLAIM_RESOURCE_RESULT_NOT_COMMITTED	= 2
}

extern( C ) extern const IID IID_IDXGIDevice4;
@MIDL_INTERFACE!("95B4F95F-D8DA-4CA4-9EE6-3B76D5968A10")
interface IDXGIDevice4 : IDXGIDevice3
{
public:
	HRESULT OfferResources1( 
		UINT NumResources,
		IDXGIResource /+*const+/ *ppResources,
		DXGI_OFFER_RESOURCE_PRIORITY Priority,
		UINT Flags);

	HRESULT ReclaimResources1( 
		UINT NumResources,
		IDXGIResource /+*const+/ *ppResources,
		DXGI_RECLAIM_RESOURCE_RESULTS *pResults);
}

enum DXGI_FEATURE
{
	DXGI_FEATURE_PRESENT_ALLOW_TEARING	= 0
}

extern( C ) extern const IID IID_IDXGIFactory5;
@MIDL_INTERFACE!("7632e1f5-ee65-4dca-87fd-84cd75f8838d")
interface IDXGIFactory5 : IDXGIFactory4
{
public:
	HRESULT CheckFeatureSupport( 
		DXGI_FEATURE Feature,
		void *pFeatureSupportData,
		UINT FeatureSupportDataSize);
}

mixin( Glue!"directx.dxgi1_5" );