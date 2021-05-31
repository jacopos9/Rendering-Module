Shader "Unlit/LighShader"
{
   Properties 
	{
		_Tint ("_Tint",Color) = (1,1,1,1)
		_MainTex ("Albedo",2D) = "White"{}
	}

	SubShader
	{
		pass
		{
			Tags
			{
				"lightMode" = "ForwardBase"
			}



			CGPROGRAM
			#pragma  vertex vert 
			#pragma fragment frag 
			//#include "UnityCG.cginc"
			#include "UnityStandardBRDF.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _Tint;


			struct Interpolators
			{
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
				float3 normal : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
			   /// float3 localPosition : TEXCOORD0;
			};

		    struct VertexData
			{
				float4 position : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			Interpolators vert(VertexData v)
			{
			   Interpolators i;
			   i.position = UnityObjectToClipPos(v.position);
			   i.normal = mul(transpose((float3x3)unity_WorldToObject),v.normal);
			   i.worldPos = mul(unity_ObjectToWorld, v.position);
			    i.normal = normalize(i.normal);
			   return i;
			}

			float4 frag(Interpolators i ) : SV_TARGET 
			{
				i.normal = normalize(i.normal);
				float3 lightDir = _WorldSpaceLightPos0.xyz;
				float3 viewDir = normalize(_WorldSpaceCameraPos - i.worldPos);
				float3 lightColor = _LightColor0.rgb;
				float3 albedo = tex2D(_MainTex, i.uv).rgb * _Tint.rgb;
				float3 diffuse = albedo *  lightColor * DotClamped(lightDir, i.normal);
				float3 reflectionDir = reflect(-lightDir, i.normal);
				return DotClamped(viewDir, reflectionDir);
			}

			ENDCG
		}
	}
}
