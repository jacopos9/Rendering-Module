// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/ExeShader"
{
	Properties 
	{
		_Tint ("_Tint",Color) = (1,1,1,1)
		_MainTex ("Texture",2D) = "White"{}
		_DetailTex ("Detail Texure",2D) = "gray"{}
	}

	SubShader
	{
		pass
		{
			CGPROGRAM
			#pragma  vertex vert 
			#pragma fragment frag 
			#include "UnityCG.cginc"

			sampler2D _MainTex, _DetailTex;
			float4 _MainTex_ST, _DetailTex_ST;
			float4 _Tint;


			struct Interpolators
			{
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
			    float2 uvDetail : TEXCOORD1;
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
			   i.uvDetail = TRANSFORM_TEX(v.uv,_DetailTex);
			   return i;
			}

			float4 frag(Interpolators i ) : SV_TARGET 
			{
			    float4 color = tex2D(_MainTex, i.uv) *_Tint;
				color *= tex2D(_MainTex,i.uvDetail)* unity_ColorSpaceDouble;
				return color;
			}

			ENDCG
		}
	}
}