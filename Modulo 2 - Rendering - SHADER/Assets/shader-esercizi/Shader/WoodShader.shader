// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/WoodShader"
{
	Properties // inserire le proprietà dello shader
	{
		_Tint ("_Tint",Color) = (1,1,1,1)
		_MainTex ("Texture",2D) = "White"{}
	}

	SubShader
	{
		pass
		{
			CGPROGRAM
			#pragma  vertex vert 
			#pragma fragment frag 
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _Tint;


			struct Interpolators
			{
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
			   /// float3 localPosition : TEXCOORD0;
			};

		    struct VertexData
			{
				float4 position : POSITION;
				float2 uv : TEXCOORD0;
			};

			Interpolators vert(VertexData v)
			{
			   Interpolators i;
			   i.position = UnityObjectToClipPos(v.position);
			   i.uv = TRANSFORM_TEX(v.uv, _MainTex);
			   return i;
			}

			float4 frag(Interpolators i ) : SV_TARGET 
			{
				return tex2D(_MainTex,i.uv) * _Tint;
			}

			ENDCG
		}
	}
}
