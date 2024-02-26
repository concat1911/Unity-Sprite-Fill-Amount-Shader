// Author: Nhat Linh
// Email: nhatlinh.nh2511@gmail.com
// Nocopy right, free to use
Shader "VeryDisco/Sprite2D/SpriteFillShader"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" { }
        _ProgressColor("Progress Color", Color) = (0, 0, 0, 0)
        _BGColor("Back Ground Color", Color) = (0, 0, 0, 0)
        _FillAmount ("Fill Amount", Range(0, 1)) = 0
    }

    SubShader
    {
		Tags
		{ 
			"Queue"="Transparent" 
			"IgnoreProjector"="True" 
			"RenderType"="Transparent" 
			"PreviewType"="Plane"
			"CanUseSpriteAtlas"="True"
		}

        Pass
        {
            CGPROGRAM
        
            #pragma vertex vert
			#pragma fragment frag
        	#pragma multi_compile _ PIXELSNAP_ON

			#include "UnityCG.cginc"
            
            float _FillAmount;
            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed4 _BGColor;
            fixed4 _ProgressColor;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f
            {
                float4 pos : POSITION;
                float2 uv : TEXCOORD0;
                UNITY_VERTEX_OUTPUT_STEREO
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
                UNITY_TRANSFER_INSTANCE_ID(v, o);
                return o;
            }

            fixed4 frag(v2f i) : COLOR
            {
                if (i.uv.x > _FillAmount)
                    return _BGColor;

                return tex2D(_MainTex, i.uv) * _ProgressColor;
            }

            ENDCG
        }
    }
}
