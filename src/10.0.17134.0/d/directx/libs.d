// This module does absolutely nothing except force linkage to DirectX libraries

module directx.libs;

version (Windows) { version = DirectXLibsEnable; }
else { static assert( false, "DirectX is only enabled for Windows." ); }

version( DirectXLibsEnable ):
@system:
extern( C ):

pragma( lib, "d3d12.lib" );
pragma( lib, "dxgi.lib" );
pragma( lib, "dxguid.lib" );
