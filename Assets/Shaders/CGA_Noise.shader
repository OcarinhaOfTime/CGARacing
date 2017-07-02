Shader "Custom/CGANoise"
{
	Properties
	{
		[HideInInspector]_MainTex ("Texture", 2D) = "white" {}
		_NoiseTex ("NoiseTex", 2D) = "white" {}
		_NoiseAmmount("Noise Ammount", Range(0, 1)) = 0
		_NoiseSpeed("Noise Speed", Float) = 0
		_Level("_Level", Range(0, .5)) = .3
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
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			sampler2D _NoiseTex;
			float4 _MainTex_ST;
			float _Level;
			float _NoiseAmmount;
			float _NoiseSpeed;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float2 noise_uv = (i.uv.x, i.uv.y + _Time.x * _NoiseSpeed);
				fixed2 noise_col = tex2D(_NoiseTex, noise_uv) * 2 - 1;
				fixed4 col = tex2D(_MainTex, i.uv + noise_col * _NoiseAmmount);
				col = floor(col / _Level) * _Level;
				return col;
			}
			ENDCG
		}
	}
}
