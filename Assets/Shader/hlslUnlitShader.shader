Shader "HLSL basic shader"
{
    // Properties {
    //     _Color ("Main Color", Color) = (1,1,1,0)
    //     _SpecColor ("Spec Color", Color) = (1,1,1,1)
    //     _Emission ("Emmisive Color", Color) = (0,0,0,0)
    //     _Shininess ("Shininess", Range (0.01, 1)) = 0.7
    //     _MainTex ("Base (RGB)", 2D) = "white" {}
    // }
    SubShader {
        Pass {

            CGPROGRAM
            // このスニペットのコンパイラーディレクティブ。例:
            #pragma vertex vert
            #pragma fragment frag

            // the Cg/HLSL code itself
            struct VS_INPUT
            {
                float4 Pos : POSITION;
                float4 Normal : NORMAL;
                // float4 Tan : TANGENT;
                // float4 Col : COLOR0;
            };

            // （３）ピクセルシェーダーで利用する情報を入れるところ
            struct VS_TO_PS
            {
                float4 HPos : SV_Position;
                float4 Normal : NORMAL;
                // float4 Tan : TANGENT;
                // float4 Col : COLOR0;
            };

            // （４）頂点シェーダーの処理を作るところ　基本Posの行はそのままで、他のチャンネル情報を加味する場合は後述する
            VS_TO_PS vert(VS_INPUT In)
            {
                VS_TO_PS Out;
                Out.HPos = UnityObjectToClipPos(In.Pos);
                Out.Normal = In.Normal;
                // Out.Tan = In.Tan;
                // Out.Col = In.Col;
                return Out;
            }

            // （５）ピクセルシェーダーの処理を作るところ
            float4 frag(VS_TO_PS In) : SV_Target
            {
                // return float4(1.0, 0.5, 0.0, 1.0);
                return In.Normal;
                // return In.Tan;
                // return In.Col;
            }

            // （６）頂点シェーダーとピクセルシェーダーをまとめるところ
            // technique11 HelloShader
            // {
            //     pass P0
            //     {
            //         SetVertexShader(CompileShader(vs_5_0, VS()));
            //         SetPixelShader(CompileShader(ps_5_0, PS()));
            //     }
            // }

            ENDCG
            // ... pass  設定の残り ...
        }
    }
    FallBack "Diffuse"
}