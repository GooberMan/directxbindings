module directxbindings;

version (Windows) { version = DirectXBindings; }
else { static assert( false, "DirectXBindings is only enabled for Windows." ); }

version( DirectXBindings ):

int main( string[] args )
{
	import core.sys.windows.windows;

	import directx.d3d12;
	import directx.d3d12sdklayers;
	import directx.dxgi1_4;

	import combindings.util;

	IDXGIFactory4 factory;
	ID3D12Debug1 DebugController;

	UINT dxgiFactoryFlags;

	ID3D12Debug DC;
	D3D12GetDebugInterface( DC );
	QueryInterface( DC, DebugController );

	DebugController.EnableDebugLayer();
	DebugController.SetEnableGPUBasedValidation(true);
	DebugController.ReleaseAndNull();

	DC.ReleaseAndNull();

	dxgiFactoryFlags |= cast(UINT)DXGI_CREATE_FACTORY_DEBUG;

	auto kek = D3D12_FORMAT_SUPPORT1_SHADER_SAMPLE_MONO_TEXT | D3D12_FORMAT_SUPPORT1_SHADER_GATHER_COMPARISON;

	HRESULT result = CreateDXGIFactory2( dxgiFactoryFlags, factory );

	IDXGIAdapter1 OutAdapter;

	struct AdapterData
	{
		DXGI_ADAPTER_DESC1		Descriptor;
		D3D_FEATURE_LEVEL		FeatureLevel;
		IDXGIAdapter1			Adapter;
		ID3D12Device			Device;
		ID3D12DebugDevice		DebugDevice;
	}

	AdapterData[] ValidAdapters;

	for( UINT Index; factory.EnumAdapters1( Index, &OutAdapter ) == S_OK; ++Index )
	{
		AdapterData ThisAdapter = AdapterData.init;
		ThisAdapter.Adapter = OutAdapter;

		ThisAdapter.Adapter.GetDesc1( &ThisAdapter.Descriptor );

		HRESULT res = E_FAIL;

		if( !( ThisAdapter.Descriptor.Flags & DXGI_ADAPTER_FLAG_SOFTWARE ) )
		{
			foreach( FeatureLevel; [ D3D_FEATURE_LEVEL_12_1, D3D_FEATURE_LEVEL_12_0, D3D_FEATURE_LEVEL_11_1, D3D_FEATURE_LEVEL_11_0 ] )
			{
				res = D3D12CreateDevice!ID3D12Device( ThisAdapter.Adapter, FeatureLevel );
				if( res.SUCCEEDED )
				{
					ThisAdapter.FeatureLevel = FeatureLevel;
					ValidAdapters ~= ThisAdapter;
				}
			}
		}
	}

	factory.ReleaseAndNull();

	return 0;
}