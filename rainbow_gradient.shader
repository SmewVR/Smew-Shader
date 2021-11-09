﻿Shader "Unlit/rainbow 1"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }
			fixed4 frag(v2f i) : SV_Target
			{
				// Normalized pixel coordinates (from 0 to 1)
				float2 uv = i.uv;

				// Time varying pixel color
				float3 col = 0.5 + 0.5*cos((_Time.y + uv.xyx + float3(0, 2, 4))*0.8);

				// Output to screen
				return float4(col, 1.0);
			}


            ENDCG
        }
    }
}