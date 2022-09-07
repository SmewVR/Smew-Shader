Shader "Smew/Smew Brush AudioLink"
{
	Properties
	{
		_Color("Tint", Color) = (0, 0, 0, 1)
		_MainTex("Texture", 2D) = "white" {}
		_Transparency("Transparency", Range(0.0,1)) = 0.25
		//_Frequency("Frequency", Range(0.0,50)) = 50
	}
		SubShader
		{
			Tags { "RenderType" = "Opaque"  "Queue" = "Transparent"}
			Blend SrcAlpha OneMinusSrcAlpha
			Cull off
			//ZWrite off

			Pass
			{
				CGPROGRAM

				#include "UnityCG.cginc"
				#include "Assets/AudioLink/Shaders/AudioLink.cginc"

				#pragma vertex vert
				#pragma fragment frag

				sampler2D _MainTex;
				float4 _MainTex_ST;
				float Transparency;
				float _Frequency;

				fixed4 _Color;

				struct appdata
				{
					float4 vertex : POSITION;
					float2 uv : TEXCOORD0;
				};

				struct v2f
				{
					float4 vertex : SV_POSITION;

					float2 uv : TEXCOORD0;

					//         float4 vertex : SV_POSITION;
						 };



						 v2f vert(appdata v)
						 {
							 v2f o;
							 o.vertex = UnityObjectToClipPos(v.vertex);
							 o.uv = TRANSFORM_TEX(v.uv, _MainTex);
							 //UNITY_TRANSFER_FOG(o,o.vertex);
							 return o;
						 }
						 fixed4 frag(v2f i) : SV_TARGET
						 {
							 // Normalized pixel coordinates (from 0 to 1)
							 //fixed4 col = tex

							 float2 uv = i.uv;

							 // Time varying pixel color 
							 float3 col = 0.5 + 0.5*cos((_Time.y*AudioLinkGetAmplitudeAtFrequency(75) / 250 + uv.xyx + float3(0, 3, 4))*0.8);
							 col *= _Color.a;

							 //alpha
							 //col = 
							 // Output to screen
							 return float4(col, 1.0);
						 }


						 ENDCG
					 }
		}
}
