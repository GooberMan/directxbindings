// Based on DirectX 12 from Windows 10 kit 10.0.17134.0
module directx.d3d12video;

version (Windows) { version = D3D12VideoEnable; }
else { static assert( false, "D3D12 is only enabled for Windows." ); }

version( D3D12VideoEnable ):
@system:
extern( C ):

import combindings;

import directx.dxgicommon;
import directx.dxgiformat;
import directx.d3d12;

enum D3D12_VIDEO_FIELD_TYPE
{
	D3D12_VIDEO_FIELD_TYPE_NONE	= 0,
	D3D12_VIDEO_FIELD_TYPE_INTERLACED_TOP_FIELD_FIRST	= 1,
	D3D12_VIDEO_FIELD_TYPE_INTERLACED_BOTTOM_FIELD_FIRST	= 2
}

enum D3D12_VIDEO_FRAME_STEREO_FORMAT
{
	D3D12_VIDEO_FRAME_STEREO_FORMAT_NONE	= 0,
	D3D12_VIDEO_FRAME_STEREO_FORMAT_MONO	= 1,
	D3D12_VIDEO_FRAME_STEREO_FORMAT_HORIZONTAL	= 2,
	D3D12_VIDEO_FRAME_STEREO_FORMAT_VERTICAL	= 3,
	D3D12_VIDEO_FRAME_STEREO_FORMAT_SEPARATE	= 4
}

struct D3D12_VIDEO_FORMAT
{
	DXGI_FORMAT Format;
	DXGI_COLOR_SPACE_TYPE ColorSpace;
}

struct D3D12_VIDEO_SAMPLE
{
	UINT Width;
	UINT Height;
	D3D12_VIDEO_FORMAT Format;
}

enum D3D12_VIDEO_FRAME_CODED_INTERLACE_TYPE
{
	D3D12_VIDEO_FRAME_CODED_INTERLACE_TYPE_NONE	= 0,
	D3D12_VIDEO_FRAME_CODED_INTERLACE_TYPE_FIELD_BASED	= 1
}

enum D3D12_FEATURE_VIDEO
{
	D3D12_FEATURE_VIDEO_DECODE_SUPPORT	= 0,
	D3D12_FEATURE_VIDEO_DECODE_PROFILES	= 1,
	D3D12_FEATURE_VIDEO_DECODE_FORMATS	= 2,
	D3D12_FEATURE_VIDEO_DECODE_CONVERSION_SUPPORT	= 3,
	D3D12_FEATURE_VIDEO_PROCESS_SUPPORT	= 5,
	D3D12_FEATURE_VIDEO_PROCESS_MAX_INPUT_STREAMS	= 6,
	D3D12_FEATURE_VIDEO_PROCESS_REFERENCE_INFO	= 7,
	D3D12_FEATURE_VIDEO_DECODER_HEAP_SIZE	= 8,
	D3D12_FEATURE_VIDEO_PROCESSOR_SIZE	= 9,
	D3D12_FEATURE_VIDEO_DECODE_PROFILE_COUNT	= 10,
	D3D12_FEATURE_VIDEO_DECODE_FORMAT_COUNT	= 11,
	D3D12_FEATURE_VIDEO_ARCHITECTURE	= 17,
	D3D12_FEATURE_VIDEO_DECODE_HISTOGRAM	= 18
}

enum D3D12_BITSTREAM_ENCRYPTION_TYPE
{
	D3D12_BITSTREAM_ENCRYPTION_TYPE_NONE	= 0
}

struct D3D12_VIDEO_DECODE_CONFIGURATION
{
	GUID DecodeProfile;
	D3D12_BITSTREAM_ENCRYPTION_TYPE BitstreamEncryption;
	D3D12_VIDEO_FRAME_CODED_INTERLACE_TYPE InterlaceType;
}

struct D3D12_VIDEO_DECODER_DESC
{
	UINT NodeMask;
	D3D12_VIDEO_DECODE_CONFIGURATION Configuration;
}

struct D3D12_VIDEO_DECODER_HEAP_DESC
{
	UINT NodeMask;
	D3D12_VIDEO_DECODE_CONFIGURATION Configuration;
	UINT DecodeWidth;
	UINT DecodeHeight;
	DXGI_FORMAT Format;
	DXGI_RATIONAL FrameRate;
	UINT BitRate;
	UINT MaxDecodePictureBufferCount;
}

struct D3D12_VIDEO_SIZE_RANGE
{
	UINT MaxWidth;
	UINT MaxHeight;
	UINT MinWidth;
	UINT MinHeight;
}

enum D3D12_VIDEO_PROCESS_FILTER
{
	D3D12_VIDEO_PROCESS_FILTER_BRIGHTNESS	= 0,
	D3D12_VIDEO_PROCESS_FILTER_CONTRAST	= 1,
	D3D12_VIDEO_PROCESS_FILTER_HUE	= 2,
	D3D12_VIDEO_PROCESS_FILTER_SATURATION	= 3,
	D3D12_VIDEO_PROCESS_FILTER_NOISE_REDUCTION	= 4,
	D3D12_VIDEO_PROCESS_FILTER_EDGE_ENHANCEMENT	= 5,
	D3D12_VIDEO_PROCESS_FILTER_ANAMORPHIC_SCALING	= 6,
	D3D12_VIDEO_PROCESS_FILTER_STEREO_ADJUSTMENT	= 7
}

@DEFINE_ENUM_FLAG_OPERATORS
enum D3D12_VIDEO_PROCESS_FILTER_FLAGS
{
	D3D12_VIDEO_PROCESS_FILTER_FLAG_NONE	= 0,
	D3D12_VIDEO_PROCESS_FILTER_FLAG_BRIGHTNESS	= ( 1 << D3D12_VIDEO_PROCESS_FILTER.D3D12_VIDEO_PROCESS_FILTER_BRIGHTNESS ) ,
	D3D12_VIDEO_PROCESS_FILTER_FLAG_CONTRAST	= ( 1 << D3D12_VIDEO_PROCESS_FILTER.D3D12_VIDEO_PROCESS_FILTER_CONTRAST ) ,
	D3D12_VIDEO_PROCESS_FILTER_FLAG_HUE	= ( 1 << D3D12_VIDEO_PROCESS_FILTER.D3D12_VIDEO_PROCESS_FILTER_HUE ) ,
	D3D12_VIDEO_PROCESS_FILTER_FLAG_SATURATION	= ( 1 << D3D12_VIDEO_PROCESS_FILTER.D3D12_VIDEO_PROCESS_FILTER_SATURATION ) ,
	D3D12_VIDEO_PROCESS_FILTER_FLAG_NOISE_REDUCTION	= ( 1 << D3D12_VIDEO_PROCESS_FILTER.D3D12_VIDEO_PROCESS_FILTER_NOISE_REDUCTION ) ,
	D3D12_VIDEO_PROCESS_FILTER_FLAG_EDGE_ENHANCEMENT	= ( 1 << D3D12_VIDEO_PROCESS_FILTER.D3D12_VIDEO_PROCESS_FILTER_EDGE_ENHANCEMENT ) ,
	D3D12_VIDEO_PROCESS_FILTER_FLAG_ANAMORPHIC_SCALING	= ( 1 << D3D12_VIDEO_PROCESS_FILTER.D3D12_VIDEO_PROCESS_FILTER_ANAMORPHIC_SCALING ) ,
	D3D12_VIDEO_PROCESS_FILTER_FLAG_STEREO_ADJUSTMENT	= ( 1 << D3D12_VIDEO_PROCESS_FILTER.D3D12_VIDEO_PROCESS_FILTER_STEREO_ADJUSTMENT ) 
}

@DEFINE_ENUM_FLAG_OPERATORS
enum D3D12_VIDEO_PROCESS_DEINTERLACE_FLAGS
{
	D3D12_VIDEO_PROCESS_DEINTERLACE_FLAG_NONE	= 0,
	D3D12_VIDEO_PROCESS_DEINTERLACE_FLAG_BOB	= 0x1,
	D3D12_VIDEO_PROCESS_DEINTERLACE_FLAG_CUSTOM	= 0x80000000
}

struct D3D12_VIDEO_PROCESS_ALPHA_BLENDING
{
	BOOL Enable;
	FLOAT Alpha;
}

struct D3D12_VIDEO_PROCESS_LUMA_KEY
{
	BOOL Enable;
	FLOAT Lower;
	FLOAT Upper;
}

struct D3D12_VIDEO_PROCESS_INPUT_STREAM_DESC
{
	DXGI_FORMAT Format;
	DXGI_COLOR_SPACE_TYPE ColorSpace;
	DXGI_RATIONAL SourceAspectRatio;
	DXGI_RATIONAL DestinationAspectRatio;
	DXGI_RATIONAL FrameRate;
	D3D12_VIDEO_SIZE_RANGE SourceSizeRange;
	D3D12_VIDEO_SIZE_RANGE DestinationSizeRange;
	BOOL EnableOrientation;
	D3D12_VIDEO_PROCESS_FILTER_FLAGS FilterFlags;
	D3D12_VIDEO_FRAME_STEREO_FORMAT StereoFormat;
	D3D12_VIDEO_FIELD_TYPE FieldType;
	D3D12_VIDEO_PROCESS_DEINTERLACE_FLAGS DeinterlaceMode;
	BOOL EnableAlphaBlending;
	D3D12_VIDEO_PROCESS_LUMA_KEY LumaKey;
	UINT NumPastFrames;
	UINT NumFutureFrames;
	BOOL EnableAutoProcessing;
}

enum D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE
{
	D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE_OPAQUE	= 0,
	D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE_BACKGROUND	= 1,
	D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE_DESTINATION	= 2,
	D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE_SOURCE_STREAM	= 3
}

struct D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC
{
	DXGI_FORMAT Format;
	DXGI_COLOR_SPACE_TYPE ColorSpace;
	D3D12_VIDEO_PROCESS_ALPHA_FILL_MODE AlphaFillMode;
	UINT AlphaFillModeSourceStreamIndex;
	FLOAT[ 4 ] BackgroundColor;
	DXGI_RATIONAL FrameRate;
	BOOL EnableStereo;
}

extern( C ) extern const IID IID_ID3D12VideoDecoderHeap;
@MIDL_INTERFACE!("0946B7C9-EBF6-4047-BB73-8683E27DBB1F")
interface ID3D12VideoDecoderHeap : ID3D12Pageable
{
public:
	D3D12_VIDEO_DECODER_HEAP_DESC GetDesc();
}

extern( C ) extern const IID IID_ID3D12VideoDevice;
@MIDL_INTERFACE!("1F052807-0B46-4ACC-8A89-364F793718A4")
interface ID3D12VideoDevice : IUnknown
{
public:
	HRESULT CheckFeatureSupport( 
		D3D12_FEATURE_VIDEO FeatureVideo,
		void *pFeatureSupportData,
		UINT FeatureSupportDataSize);

	HRESULT CreateVideoDecoder( 
		const D3D12_VIDEO_DECODER_DESC *pDesc,
		REFIID riid,
		void **ppVideoDecoder);

	HRESULT CreateVideoDecoderHeap( 
		const D3D12_VIDEO_DECODER_HEAP_DESC *pVideoDecoderHeapDesc,
		REFIID riid,
		void **ppVideoDecoderHeap);

	HRESULT CreateVideoProcessor( 
		UINT NodeMask,
		const D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC *pOutputStreamDesc,
		UINT NumInputStreamDescs,
		const D3D12_VIDEO_PROCESS_INPUT_STREAM_DESC *pInputStreamDescs,
		REFIID riid,
		void **ppVideoProcessor);
}

extern( C ) extern const IID IID_ID3D12VideoDecoder;
@MIDL_INTERFACE!("C59B6BDC-7720-4074-A136-17A156037470")
interface ID3D12VideoDecoder : ID3D12Pageable
{
public:
	D3D12_VIDEO_DECODER_DESC GetDesc();

}

enum D3D12_VIDEO_DECODE_TIER
{
	D3D12_VIDEO_DECODE_TIER_NOT_SUPPORTED	= 0,
	D3D12_VIDEO_DECODE_TIER_1	= 1,
	D3D12_VIDEO_DECODE_TIER_2	= 2,
	D3D12_VIDEO_DECODE_TIER_3	= 3
}

@DEFINE_ENUM_FLAG_OPERATORS
enum D3D12_VIDEO_DECODE_SUPPORT_FLAGS
{
	D3D12_VIDEO_DECODE_SUPPORT_FLAG_NONE	= 0,
	D3D12_VIDEO_DECODE_SUPPORT_FLAG_SUPPORTED	= 0x1
}

@DEFINE_ENUM_FLAG_OPERATORS
enum D3D12_VIDEO_DECODE_CONFIGURATION_FLAGS
{
	D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_NONE	= 0,
	D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_HEIGHT_ALIGNMENT_MULTIPLE_32_REQUIRED	= 0x1,
	D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_POST_PROCESSING_SUPPORTED	= 0x2,
	D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_REFERENCE_ONLY_ALLOCATIONS_REQUIRED	= 0x4,
	D3D12_VIDEO_DECODE_CONFIGURATION_FLAG_ALLOW_RESOLUTION_CHANGE_ON_NON_KEY_FRAME	= 0x8
}

enum D3D12_VIDEO_DECODE_STATUS
{
	D3D12_VIDEO_DECODE_STATUS_OK	= 0,
	D3D12_VIDEO_DECODE_STATUS_CONTINUE	= 1,
	D3D12_VIDEO_DECODE_STATUS_CONTINUE_SKIP_DISPLAY	= 2,
	D3D12_VIDEO_DECODE_STATUS_RESTART	= 3
}

enum D3D12_VIDEO_DECODE_ARGUMENT_TYPE
{
	D3D12_VIDEO_DECODE_ARGUMENT_TYPE_PICTURE_PARAMETERS	= 0,
	D3D12_VIDEO_DECODE_ARGUMENT_TYPE_INVERSE_QUANTIZATION_MATRIX	= 1,
	D3D12_VIDEO_DECODE_ARGUMENT_TYPE_SLICE_CONTROL	= 2,
	D3D12_VIDEO_DECODE_ARGUMENT_TYPE_MAX_VALID	= 3
}

struct D3D12_FEATURE_DATA_VIDEO_DECODE_SUPPORT
{
	UINT NodeIndex;
	D3D12_VIDEO_DECODE_CONFIGURATION Configuration;
	UINT Width;
	UINT Height;
	DXGI_FORMAT DecodeFormat;
	DXGI_RATIONAL FrameRate;
	UINT BitRate;
	D3D12_VIDEO_DECODE_SUPPORT_FLAGS SupportFlags;
	D3D12_VIDEO_DECODE_CONFIGURATION_FLAGS ConfigurationFlags;
	D3D12_VIDEO_DECODE_TIER DecodeTier;
}

struct D3D12_FEATURE_DATA_VIDEO_DECODE_PROFILE_COUNT
{
	UINT NodeIndex;
	UINT ProfileCount;
}

struct D3D12_FEATURE_DATA_VIDEO_DECODE_PROFILES
{
	UINT NodeIndex;
	UINT ProfileCount;
	@_Field_size_full_!(ProfileCount)
	GUID *pProfiles;
}

struct D3D12_FEATURE_DATA_VIDEO_DECODE_FORMAT_COUNT
{
	UINT NodeIndex;
	D3D12_VIDEO_DECODE_CONFIGURATION Configuration;
	UINT FormatCount;
}

struct D3D12_FEATURE_DATA_VIDEO_DECODE_FORMATS
{
	UINT NodeIndex;
	D3D12_VIDEO_DECODE_CONFIGURATION Configuration;
	UINT FormatCount;
	@_Field_size_full_!(FormatCount)
	DXGI_FORMAT *pOutputFormats;
}

struct D3D12_FEATURE_DATA_VIDEO_ARCHITECTURE
{
	BOOL IOCoherent;
}

enum D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT
{
	D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_Y	= 0,
	D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_U	= 1,
	D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_V	= 2,
	D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_R	= 0,
	D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_G	= 1,
	D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_B	= 2,
	D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_A	= 3
}

@DEFINE_ENUM_FLAG_OPERATORS
enum D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAGS
{
	D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_NONE	= 0,
	D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_Y	= ( 1 << D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT.D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_Y ) ,
	D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_U	= ( 1 << D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT.D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_U ) ,
	D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_V	= ( 1 << D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT.D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_V ) ,
	D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_R	= ( 1 << D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT.D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_R ) ,
	D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_G	= ( 1 << D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT.D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_G ) ,
	D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_B	= ( 1 << D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT.D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_B ) ,
	D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAG_A	= ( 1 << D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT.D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_A ) 
}

struct D3D12_FEATURE_DATA_VIDEO_DECODE_HISTOGRAM
{
	UINT NodeIndex;
	GUID DecodeProfile;
	UINT Width;
	UINT Height;
	DXGI_FORMAT DecodeFormat;
	D3D12_VIDEO_DECODE_HISTOGRAM_COMPONENT_FLAGS Components;
	UINT BinCount;
	UINT CounterBitDepth;
}

@DEFINE_ENUM_FLAG_OPERATORS
enum D3D12_VIDEO_DECODE_CONVERSION_SUPPORT_FLAGS
{
	D3D12_VIDEO_DECODE_CONVERSION_SUPPORT_FLAG_NONE	= 0,
	D3D12_VIDEO_DECODE_CONVERSION_SUPPORT_FLAG_SUPPORTED	= 0x1
}

@DEFINE_ENUM_FLAG_OPERATORS
enum D3D12_VIDEO_SCALE_SUPPORT_FLAGS
{
	D3D12_VIDEO_SCALE_SUPPORT_FLAG_NONE	= 0,
	D3D12_VIDEO_SCALE_SUPPORT_FLAG_POW2_ONLY	= 0x1,
	D3D12_VIDEO_SCALE_SUPPORT_FLAG_EVEN_DIMENSIONS_ONLY	= 0x2
}

struct D3D12_VIDEO_SCALE_SUPPORT
{
	D3D12_VIDEO_SIZE_RANGE OutputSizeRange;
	D3D12_VIDEO_SCALE_SUPPORT_FLAGS Flags;
}

struct D3D12_FEATURE_DATA_VIDEO_DECODE_CONVERSION_SUPPORT
{
	UINT NodeIndex;
	D3D12_VIDEO_DECODE_CONFIGURATION Configuration;
	D3D12_VIDEO_SAMPLE DecodeSample;
	D3D12_VIDEO_FORMAT OutputFormat;
	DXGI_RATIONAL FrameRate;
	UINT BitRate;
	D3D12_VIDEO_DECODE_CONVERSION_SUPPORT_FLAGS SupportFlags;
	D3D12_VIDEO_SCALE_SUPPORT ScaleSupport;
}

struct D3D12_FEATURE_DATA_VIDEO_DECODER_HEAP_SIZE
{
	D3D12_VIDEO_DECODER_HEAP_DESC VideoDecoderHeapDesc;
	UINT64 MemoryPoolL0Size;
	UINT64 MemoryPoolL1Size;
}

struct D3D12_FEATURE_DATA_VIDEO_PROCESSOR_SIZE
{
	UINT NodeMask;
	const D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC *pOutputStreamDesc;
	UINT NumInputStreamDescs;
	const D3D12_VIDEO_PROCESS_INPUT_STREAM_DESC *pInputStreamDescs;
	UINT64 MemoryPoolL0Size;
	UINT64 MemoryPoolL1Size;
}

struct D3D12_QUERY_DATA_VIDEO_DECODE_STATISTICS
{
	UINT64 Status;
	UINT64 NumMacroblocksAffected;
	DXGI_RATIONAL FrameRate;
	UINT BitRate;
}

struct D3D12_VIDEO_DECODE_SUB_SAMPLE_MAPPING_BLOCK
{
	UINT ClearSize;
	UINT EncryptedSize;
}

struct D3D12_VIDEO_DECODE_FRAME_ARGUMENT
{
	D3D12_VIDEO_DECODE_ARGUMENT_TYPE Type;
	UINT Size;
	@_Field_size_bytes_full_!(Size)
	void *pData;
}

struct D3D12_VIDEO_DECODE_REFERENCE_FRAMES
{
	UINT NumTexture2Ds;
	@_Field_size_full_!(NumTexture2Ds)
	ID3D12Resource *ppTexture2Ds;
	@_Field_size_full_!(NumTexture2Ds)
	UINT *pSubresources;
	@_Field_size_full_opt_!(NumTexture2Ds)
	ID3D12VideoDecoderHeap *ppHeaps;
}

struct D3D12_VIDEO_DECODE_COMPRESSED_BITSTREAM
{
	ID3D12Resource pBuffer;
	UINT64 Offset;
	UINT64 Size;
}

struct D3D12_VIDEO_DECODE_CONVERSION_ARGUMENTS
{
	BOOL Enable;
	ID3D12Resource pReferenceTexture2D;
	UINT ReferenceSubresource;
	DXGI_COLOR_SPACE_TYPE OutputColorSpace;
	DXGI_COLOR_SPACE_TYPE DecodeColorSpace;
}

struct D3D12_VIDEO_DECODE_INPUT_STREAM_ARGUMENTS
{
	UINT NumFrameArguments;
	D3D12_VIDEO_DECODE_FRAME_ARGUMENT[ 10 ] FrameArguments;
	D3D12_VIDEO_DECODE_REFERENCE_FRAMES ReferenceFrames;
	D3D12_VIDEO_DECODE_COMPRESSED_BITSTREAM CompressedBitstream;
	ID3D12VideoDecoderHeap pHeap;
}

struct D3D12_VIDEO_DECODE_OUTPUT_STREAM_ARGUMENTS
{
	ID3D12Resource pOutputTexture2D;
	UINT OutputSubresource;
	D3D12_VIDEO_DECODE_CONVERSION_ARGUMENTS ConversionArguments;
}

extern( C ) extern const IID IID_ID3D12VideoProcessor;
@MIDL_INTERFACE!("304FDB32-BEDE-410A-8545-943AC6A46138")
interface ID3D12VideoProcessor : ID3D12Pageable
{
public:
	UINT GetNodeMask();

	UINT GetNumInputStreamDescs();

	HRESULT GetInputStreamDescs( 
		UINT NumInputStreamDescs,
		D3D12_VIDEO_PROCESS_INPUT_STREAM_DESC *pInputStreamDescs);

	D3D12_VIDEO_PROCESS_OUTPUT_STREAM_DESC GetOutputStreamDesc();
}

@DEFINE_ENUM_FLAG_OPERATORS
enum D3D12_VIDEO_PROCESS_FEATURE_FLAGS
{
	D3D12_VIDEO_PROCESS_FEATURE_FLAG_NONE	= 0,
	D3D12_VIDEO_PROCESS_FEATURE_FLAG_ALPHA_FILL	= 0x1,
	D3D12_VIDEO_PROCESS_FEATURE_FLAG_LUMA_KEY	= 0x2,
	D3D12_VIDEO_PROCESS_FEATURE_FLAG_STEREO	= 0x4,
	D3D12_VIDEO_PROCESS_FEATURE_FLAG_ROTATION	= 0x8,
	D3D12_VIDEO_PROCESS_FEATURE_FLAG_FLIP	= 0x10,
	D3D12_VIDEO_PROCESS_FEATURE_FLAG_ALPHA_BLENDING	= 0x20,
	D3D12_VIDEO_PROCESS_FEATURE_FLAG_PIXEL_ASPECT_RATIO	= 0x40
}

@DEFINE_ENUM_FLAG_OPERATORS
enum D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAGS
{
	D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_NONE	= 0,
	D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_DENOISE	= 0x1,
	D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_DERINGING	= 0x2,
	D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_EDGE_ENHANCEMENT	= 0x4,
	D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_COLOR_CORRECTION	= 0x8,
	D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_FLESH_TONE_MAPPING	= 0x10,
	D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_IMAGE_STABILIZATION	= 0x20,
	D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_SUPER_RESOLUTION	= 0x40,
	D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_ANAMORPHIC_SCALING	= 0x80,
	D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAG_CUSTOM	= 0x80000000
}

enum D3D12_VIDEO_PROCESS_ORIENTATION
{
	D3D12_VIDEO_PROCESS_ORIENTATION_DEFAULT	= 0,
	D3D12_VIDEO_PROCESS_ORIENTATION_FLIP_HORIZONTAL	= 1,
	D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_90	= 2,
	D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_90_FLIP_HORIZONTAL	= 3,
	D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_180	= 4,
	D3D12_VIDEO_PROCESS_ORIENTATION_FLIP_VERTICAL	= 5,
	D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_270	= 6,
	D3D12_VIDEO_PROCESS_ORIENTATION_CLOCKWISE_270_FLIP_HORIZONTAL	= 7
}

@DEFINE_ENUM_FLAG_OPERATORS
enum D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAGS
{
	D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAG_NONE	= 0,
	D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAG_FRAME_DISCONTINUITY	= 0x1,
	D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAG_FRAME_REPEAT	= 0x2
}

struct D3D12_VIDEO_PROCESS_FILTER_RANGE
{
	INT Minimum;
	INT Maximum;
	INT Default;
	FLOAT Multiplier;
}

@DEFINE_ENUM_FLAG_OPERATORS
enum D3D12_VIDEO_PROCESS_SUPPORT_FLAGS
{
	D3D12_VIDEO_PROCESS_SUPPORT_FLAG_NONE	= 0,
	D3D12_VIDEO_PROCESS_SUPPORT_FLAG_SUPPORTED	= 0x1
}

struct D3D12_FEATURE_DATA_VIDEO_PROCESS_SUPPORT
{
	UINT NodeIndex;
	D3D12_VIDEO_SAMPLE InputSample;
	D3D12_VIDEO_FIELD_TYPE InputFieldType;
	D3D12_VIDEO_FRAME_STEREO_FORMAT InputStereoFormat;
	DXGI_RATIONAL InputFrameRate;
	D3D12_VIDEO_FORMAT OutputFormat;
	D3D12_VIDEO_FRAME_STEREO_FORMAT OutputStereoFormat;
	DXGI_RATIONAL OutputFrameRate;
	D3D12_VIDEO_PROCESS_SUPPORT_FLAGS SupportFlags;
	D3D12_VIDEO_SCALE_SUPPORT ScaleSupport;
	D3D12_VIDEO_PROCESS_FEATURE_FLAGS FeatureSupport;
	D3D12_VIDEO_PROCESS_DEINTERLACE_FLAGS DeinterlaceSupport;
	D3D12_VIDEO_PROCESS_AUTO_PROCESSING_FLAGS AutoProcessingSupport;
	D3D12_VIDEO_PROCESS_FILTER_FLAGS FilterSupport;
	D3D12_VIDEO_PROCESS_FILTER_RANGE[ 32 ] FilterRangeSupport;
}

struct D3D12_FEATURE_DATA_VIDEO_PROCESS_MAX_INPUT_STREAMS
{
	UINT NodeIndex;
	UINT MaxInputStreams;
}

struct D3D12_FEATURE_DATA_VIDEO_PROCESS_REFERENCE_INFO
{
	UINT NodeIndex;
	D3D12_VIDEO_PROCESS_DEINTERLACE_FLAGS DeinterlaceMode;
	D3D12_VIDEO_PROCESS_FILTER_FLAGS Filters;
	D3D12_VIDEO_PROCESS_FEATURE_FLAGS FeatureSupport;
	DXGI_RATIONAL InputFrameRate;
	DXGI_RATIONAL OutputFrameRate;
	BOOL EnableAutoProcessing;
	UINT PastFrames;
	UINT FutureFrames;
}

struct D3D12_VIDEO_PROCESS_REFERENCE_SET
{
	UINT NumPastFrames;
	ID3D12Resource *ppPastFrames;
	UINT *pPastSubresources;
	UINT NumFutureFrames;
	ID3D12Resource *ppFutureFrames;
	UINT *pFutureSubresources;
}

struct D3D12_VIDEO_PROCESS_TRANSFORM
{
	D3D12_RECT SourceRectangle;
	D3D12_RECT DestinationRectangle;
	D3D12_VIDEO_PROCESS_ORIENTATION Orientation;
}

struct D3D12_VIDEO_PROCESS_INPUT_STREAM_RATE
{
	UINT OutputIndex;
	UINT InputFrameOrField;
}

struct D3D12_VIDEO_PROCESS_INPUT_STREAM
{
	ID3D12Resource pTexture2D;
	UINT Subresource;
	D3D12_VIDEO_PROCESS_REFERENCE_SET ReferenceSet;
}

struct D3D12_VIDEO_PROCESS_INPUT_STREAM_ARGUMENTS
{
	D3D12_VIDEO_PROCESS_INPUT_STREAM[ 2 ] InputStream;
	D3D12_VIDEO_PROCESS_TRANSFORM Transform;
	D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAGS Flags;
	D3D12_VIDEO_PROCESS_INPUT_STREAM_RATE RateInfo;
	INT[ 32 ] FilterLevels;
	D3D12_VIDEO_PROCESS_ALPHA_BLENDING AlphaBlending;
}

struct D3D12_VIDEO_PROCESS_OUTPUT_STREAM
{
	ID3D12Resource pTexture2D;
	UINT Subresource;
}

struct D3D12_VIDEO_PROCESS_OUTPUT_STREAM_ARGUMENTS
{
	D3D12_VIDEO_PROCESS_OUTPUT_STREAM[ 2 ] OutputStream;
	D3D12_RECT TargetRectangle;
}

extern( C ) extern const IID IID_ID3D12VideoDecodeCommandList;
@MIDL_INTERFACE!("3B60536E-AD29-4E64-A269-F853837E5E53")
interface ID3D12VideoDecodeCommandList : ID3D12CommandList
{
public:
	HRESULT Close();

	HRESULT Reset( 
		ID3D12CommandAllocator pAllocator);

	void ClearState();
        
	void ResourceBarrier( 
		UINT NumBarriers,
		const D3D12_RESOURCE_BARRIER *pBarriers);

	void DiscardResource( 
		ID3D12Resource pResource,
		const D3D12_DISCARD_REGION *pRegion);
        
	void BeginQuery( 
		ID3D12QueryHeap pQueryHeap,
		D3D12_QUERY_TYPE Type,
		UINT Index);

	void EndQuery( 
		ID3D12QueryHeap pQueryHeap,
		D3D12_QUERY_TYPE Type,
		UINT Index);

	void ResolveQueryData( 
		ID3D12QueryHeap pQueryHeap,
		D3D12_QUERY_TYPE Type,
		UINT StartIndex,
		UINT NumQueries,
		ID3D12Resource pDestinationBuffer,
		UINT64 AlignedDestinationBufferOffset);

	void SetPredication( 
		ID3D12Resource pBuffer,
		UINT64 AlignedBufferOffset,
		D3D12_PREDICATION_OP Operation);

	void SetMarker( 
		UINT Metadata,
		const void *pData,
		UINT Size);

	void BeginEvent( 
		UINT Metadata,
		const void *pData,
		UINT Size);

	void EndEvent();

	void DecodeFrame( 
		ID3D12VideoDecoder pDecoder,
		const D3D12_VIDEO_DECODE_OUTPUT_STREAM_ARGUMENTS *pOutputArguments,
		const D3D12_VIDEO_DECODE_INPUT_STREAM_ARGUMENTS *pInputArguments);

	void WriteBufferImmediate( 
		UINT Count,
		const D3D12_WRITEBUFFERIMMEDIATE_PARAMETER *pParams,
		const D3D12_WRITEBUFFERIMMEDIATE_MODE *pModes);
}

extern( C ) extern const IID IID_ID3D12VideoProcessCommandList;
@MIDL_INTERFACE!("AEB2543A-167F-4682-ACC8-D159ED4A6209")
interface ID3D12VideoProcessCommandList : ID3D12CommandList
{
public:
	HRESULT Close();

	HRESULT Reset( 
		ID3D12CommandAllocator pAllocator);

	void ClearState();

	void ResourceBarrier( 
		UINT NumBarriers,
		const D3D12_RESOURCE_BARRIER *pBarriers);

	void DiscardResource( 
		ID3D12Resource pResource,
		const D3D12_DISCARD_REGION *pRegion);

	void BeginQuery( 
		ID3D12QueryHeap pQueryHeap,
		D3D12_QUERY_TYPE Type,
		UINT Index);

	void EndQuery( 
		ID3D12QueryHeap pQueryHeap,
		D3D12_QUERY_TYPE Type,
		UINT Index);

	void ResolveQueryData( 
		ID3D12QueryHeap pQueryHeap,
		D3D12_QUERY_TYPE Type,
		UINT StartIndex,
		UINT NumQueries,
		ID3D12Resource pDestinationBuffer,
		UINT64 AlignedDestinationBufferOffset);

	void SetPredication( 
		ID3D12Resource pBuffer,
		UINT64 AlignedBufferOffset,
		D3D12_PREDICATION_OP Operation);

	void SetMarker( 
		UINT Metadata,
		const void *pData,
		UINT Size);

	void BeginEvent( 
		UINT Metadata,
		const void *pData,
		UINT Size);

	void EndEvent();

	void ProcessFrames( 
		ID3D12VideoProcessor pVideoProcessor,
		const D3D12_VIDEO_PROCESS_OUTPUT_STREAM_ARGUMENTS *pOutputArguments,
		UINT NumInputStreams,
		const D3D12_VIDEO_PROCESS_INPUT_STREAM_ARGUMENTS *pInputArguments);

	void WriteBufferImmediate( 
		UINT Count,
		const D3D12_WRITEBUFFERIMMEDIATE_PARAMETER *pParams,
		const D3D12_WRITEBUFFERIMMEDIATE_MODE *pModes);
}

struct D3D12_VIDEO_DECODE_OUTPUT_HISTOGRAM
{
	UINT64 Offset;
	ID3D12Resource pBuffer;
}

struct D3D12_VIDEO_DECODE_CONVERSION_ARGUMENTS1
{
	BOOL Enable;
	ID3D12Resource pReferenceTexture2D;
	UINT ReferenceSubresource;
	DXGI_COLOR_SPACE_TYPE OutputColorSpace;
	DXGI_COLOR_SPACE_TYPE DecodeColorSpace;
	UINT OutputWidth;
	UINT OutputHeight;
}

struct D3D12_VIDEO_DECODE_OUTPUT_STREAM_ARGUMENTS1
{
	ID3D12Resource pOutputTexture2D;
	UINT OutputSubresource;
	D3D12_VIDEO_DECODE_CONVERSION_ARGUMENTS1 ConversionArguments;
	D3D12_VIDEO_DECODE_OUTPUT_HISTOGRAM[ 4 ] Histograms;
}

extern( C ) extern const IID IID_ID3D12VideoDecodeCommandList1;
@MIDL_INTERFACE!("D52F011B-B56E-453C-A05A-A7F311C8F472")
interface ID3D12VideoDecodeCommandList1 : ID3D12VideoDecodeCommandList
{
public:
	void DecodeFrame1( 
		ID3D12VideoDecoder pDecoder,
		const D3D12_VIDEO_DECODE_OUTPUT_STREAM_ARGUMENTS1 *pOutputArguments,
		const D3D12_VIDEO_DECODE_INPUT_STREAM_ARGUMENTS *pInputArguments);
}

struct D3D12_VIDEO_PROCESS_INPUT_STREAM_ARGUMENTS1
{
	D3D12_VIDEO_PROCESS_INPUT_STREAM[ 2 ] InputStream;
	D3D12_VIDEO_PROCESS_TRANSFORM Transform;
	D3D12_VIDEO_PROCESS_INPUT_STREAM_FLAGS Flags;
	D3D12_VIDEO_PROCESS_INPUT_STREAM_RATE RateInfo;
	INT[ 32 ] FilterLevels;
	D3D12_VIDEO_PROCESS_ALPHA_BLENDING AlphaBlending;
	D3D12_VIDEO_FIELD_TYPE FieldType;
}

extern( C ) extern const IID IID_ID3D12VideoProcessCommandList1;
@MIDL_INTERFACE!("542C5C4D-7596-434F-8C93-4EFA6766F267")
interface ID3D12VideoProcessCommandList1 : ID3D12VideoProcessCommandList
{
public:
	void ProcessFrames1( 
		ID3D12VideoProcessor pVideoProcessor,
		const D3D12_VIDEO_PROCESS_OUTPUT_STREAM_ARGUMENTS *pOutputArguments,
		UINT NumInputStreams,
		const D3D12_VIDEO_PROCESS_INPUT_STREAM_ARGUMENTS1 *pInputArguments);
}

mixin( Glue!"directx.d3d12video" );