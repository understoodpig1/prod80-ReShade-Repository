/*
    Description : PD80 04 Contrast Brightness Saturation for Reshade https://reshade.me/
    Author      : prod80 (Bas Veth)
    License     : MIT, Copyright (c) 2020 prod80


    MIT License

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.

*/

#include "ReShade.fxh"
#include "ReShadeUI.fxh"

namespace pd80_conbrisat
{
    //// UI ELEMENTS ////////////////////////////////////////////////////////////////
    uniform bool enable_dither <
        ui_label = "Enable Dithering";
        ui_tooltip = "Enable Dithering";
        ui_category = "Global";
        > = true;
    uniform float tint <
        ui_label = "Tint";
        ui_tooltip = "Tint";
        ui_category = "Final Adjustments";
        ui_type = "slider";
        ui_min = -1.0;
        ui_max = 1.0;
        > = 0.0;
    uniform float exposureN <
        ui_label = "Exposure";
        ui_tooltip = "Exposure";
        ui_category = "Final Adjustments";
        ui_type = "slider";
        ui_min = -4.0;
        ui_max = 4.0;
        > = 0.0;
    uniform float contrast <
        ui_label = "Contrast";
        ui_tooltip = "Contrast";
        ui_category = "Final Adjustments";
        ui_type = "slider";
        ui_min = -1.0;
        ui_max = 1.5;
        > = 0.0;
    uniform float brightness <
        ui_label = "Brightness";
        ui_tooltip = "Brightness";
        ui_category = "Final Adjustments";
        ui_type = "slider";
        ui_min = -1.0;
        ui_max = 1.5;
        > = 0.0;
    uniform float saturation <
        ui_label = "Saturation";
        ui_tooltip = "Saturation";
        ui_category = "Final Adjustments";
        ui_type = "slider";
        ui_min = -1.0;
        ui_max = 1.0;
        > = 0.0;
    uniform float vibrance <
        ui_label = "Vibrance";
        ui_tooltip = "Vibrance";
        ui_category = "Final Adjustments";
        ui_type = "slider";
        ui_min = -1.0;
        ui_max = 1.0;
        > = 0.0;
    uniform float huemid <
    	ui_label = "Color Hue";
        ui_tooltip = "Custom Color Hue";
        ui_category = "Custom Saturation Adjustments";
        ui_type = "slider";
        ui_min = 0.0;
        ui_max = 1.0;
        > = 0.0;
    uniform float huerange <
        ui_label = "Hue Range Selection";
        ui_tooltip = "Custom Hue Range Selection";
        ui_category = "Custom Saturation Adjustments";
        ui_type = "slider";
        ui_min = 0.0;
        ui_max = 1.0;
        > = 0.167;
    uniform float sat_custom <
        ui_label = "Custom Saturation Level";
        ui_tooltip = "Custom Saturation Level";
        ui_category = "Custom Saturation Adjustments";
        ui_type = "slider";
        ui_min = -2.0;
        ui_max = 2.0;
        > = 0.0;
    uniform float sat_r <
        ui_label = "Red Saturation";
        ui_tooltip = "Red Saturation";
        ui_category = "Color Saturation Adjustments";
        ui_type = "slider";
        ui_min = -2.0;
        ui_max = 2.0;
        > = 0.0;
    uniform float sat_o <
        ui_label = "Orange Saturation";
        ui_tooltip = "Orange Saturation";
        ui_category = "Color Saturation Adjustments";
        ui_type = "slider";
        ui_min = -2.0;
        ui_max = 2.0;
        > = 0.0;
    uniform float sat_y <
        ui_label = "Yellow Saturation";
        ui_tooltip = "Yellow Saturation";
        ui_category = "Color Saturation Adjustments";
        ui_type = "slider";
        ui_min = -2.0;
        ui_max = 2.0;
        > = 0.0;
    uniform float sat_g <
        ui_label = "Green Saturation";
        ui_tooltip = "Green Saturation";
        ui_category = "Color Saturation Adjustments";
        ui_type = "slider";
        ui_min = -2.0;
        ui_max = 2.0;
        > = 0.0;
    uniform float sat_a <
        ui_label = "Aqua Saturation";
        ui_tooltip = "Aqua Saturation";
        ui_category = "Color Saturation Adjustments";
        ui_type = "slider";
        ui_min = -2.0;
        ui_max = 2.0;
        > = 0.0;
    uniform float sat_b <
        ui_label = "Blue Saturation";
        ui_tooltip = "Blue Saturation";
        ui_category = "Color Saturation Adjustments";
        ui_type = "slider";
        ui_min = -2.0;
        ui_max = 2.0;
        > = 0.0;
    uniform float sat_p <
        ui_label = "Purple Saturation";
        ui_tooltip = "Purple Saturation";
        ui_category = "Color Saturation Adjustments";
        ui_type = "slider";
        ui_min = -2.0;
        ui_max = 2.0;
        > = 0.0;
    uniform float sat_m <
        ui_label = "Magenta Saturation";
        ui_tooltip = "Magenta Saturation";
        ui_category = "Color Saturation Adjustments";
        ui_type = "slider";
        ui_min = -2.0;
        ui_max = 2.0;
        > = 0.0;
    uniform bool enable_depth <
        ui_label = "Enable depth based adjustments.\nMake sure you have setup your depth buffer correctly.";
        ui_tooltip = "Enable depth based adjustments";
        ui_category = "Final Adjustments: Depth";
        > = false;
    uniform bool display_depth <
        ui_label = "Show depth texture";
        ui_tooltip = "Show depth texture";
        ui_category = "Final Adjustments: Depth";
        > = false;
    uniform float depthStart <
        ui_type = "slider";
        ui_label = "Change Depth Start Plane";
        ui_tooltip = "Change Depth Start Plane";
        ui_category = "Final Adjustments: Depth";
        ui_min = 0.0f;
        ui_max = 1.0f;
        > = 0.0;
    uniform float depthEnd <
        ui_type = "slider";
        ui_label = "Change Depth End Plane";
        ui_tooltip = "Change Depth End Plane";
        ui_category = "Final Adjustments: Depth";
        ui_min = 0.0f;
        ui_max = 1.0f;
        > = 0.1;
    uniform float depthCurve <
        ui_label = "Depth Curve Adjustment";
        ui_tooltip = "Depth Curve Adjustment";
        ui_category = "Final Adjustments: Depth";
        ui_type = "slider";
        ui_min = 0.05;
        ui_max = 8.0;
        > = 1.0;
    uniform float exposureD <
        ui_label = "Exposure Far";
        ui_tooltip = "Exposure Far";
        ui_category = "Final Adjustments: Far";
        ui_type = "slider";
        ui_min = -4.0;
        ui_max = 4.0;
        > = 0.0;
    uniform float contrastD <
        ui_label = "Contrast Far";
        ui_tooltip = "Contrast Far";
        ui_category = "Final Adjustments: Far";
        ui_type = "slider";
        ui_min = -1.0;
        ui_max = 1.5;
        > = 0.0;
    uniform float brightnessD <
        ui_label = "Brightness Far";
        ui_tooltip = "Brightness Far";
        ui_category = "Final Adjustments: Far";
        ui_type = "slider";
        ui_min = -1.0;
        ui_max = 1.5;
        > = 0.0;
    uniform float saturationD <
        ui_label = "Saturation Far";
        ui_tooltip = "Saturation Far";
        ui_category = "Final Adjustments: Far";
        ui_type = "slider";
        ui_min = -1.0;
        ui_max = 1.0;
        > = 0.0;
    uniform float vibranceD <
        ui_label = "Vibrance Far";
        ui_tooltip = "Vibrance Far";
        ui_category = "Final Adjustments: Far";
        ui_type = "slider";
        ui_min = -1.0;
        ui_max = 1.0;
        > = 0.0;

    //// TEXTURES ///////////////////////////////////////////////////////////////////
    texture texColorBuffer : COLOR;
    texture texNoise < source = "monochrome_gaussnoise.png"; > { Width = 512; Height = 512; Format = RGBA8; };

    //// SAMPLERS ///////////////////////////////////////////////////////////////////
    sampler samplerColor { Texture = texColorBuffer; };
    sampler samplerNoise
    { 
        Texture = texNoise;
        MipFilter = POINT;
        MinFilter = POINT;
        MagFilter = POINT;
        AddressU = WRAP;
        AddressV = WRAP;
        AddressW = WRAP;
    };

    //// DEFINES ////////////////////////////////////////////////////////////////////

    //// FUNCTIONS //////////////////////////////////////////////////////////////////
    float getLuminance( in float3 x )
    {
        return dot( x, float3( 0.212656, 0.715158, 0.072186 ));
    }

    float3 HUEToRGB( in float H )
    {
        return saturate( float3( abs( H * 6.0f - 3.0f ) - 1.0f,
                                 2.0f - abs( H * 6.0f - 2.0f ),
                                 2.0f - abs( H * 6.0f - 4.0f )));
    }

    float3 RGBToHCV( in float3 RGB )
    {
        // Based on work by Sam Hocevar and Emil Persson
        float4 P         = ( RGB.g < RGB.b ) ? float4( RGB.bg, -1.0f, 2.0f/3.0f ) : float4( RGB.gb, 0.0f, -1.0f/3.0f );
        float4 Q1        = ( RGB.r < P.x ) ? float4( P.xyw, RGB.r ) : float4( RGB.r, P.yzx );
        float C          = Q1.x - min( Q1.w, Q1.y );
        float H          = abs(( Q1.w - Q1.y ) / ( 6.0f * C + 0.000001f ) + Q1.z );
        return float3( H, C, Q1.x );
    }

    float3 RGBToHSL( in float3 RGB )
    {
        RGB.xyz          = max( RGB.xyz, 0.000001f );
        float3 HCV       = RGBToHCV(RGB);
        float L          = HCV.z - HCV.y * 0.5f;
        float S          = HCV.y / ( 1.0f - abs( L * 2.0f - 1.0f ) + 0.000001f);
        return float3( HCV.x, S, L );
    }

    float3 HSLToRGB( in float3 HSL )
    {
        float3 RGB       = HUEToRGB(HSL.x);
        float C          = (1.0f - abs(2.0f * HSL.z - 1.0f)) * HSL.y;
        return ( RGB - 0.5f ) * C + HSL.z;
    }

    float curve( float x )
    {
        return x * x * ( 3.0 - 2.0 * x );
    }
    
    float3 softlight( float3 c, float3 b )
    { 
        return b < 0.5f ? ( 2.0f * c * b + c * c * ( 1.0f - 2.0f * b )) :
                          ( sqrt( c ) * ( 2.0f * b - 1.0f ) + 2.0f * c * ( 1.0f - b ));
    }

    float getAvgColor( float3 col )
    {
        return dot( col.xyz, float3( 0.333333f, 0.333334f, 0.333333f ));
    }

    // nVidia blend modes
    // Source: https://www.khronos.org/registry/OpenGL/extensions/NV/NV_blend_equation_advanced.txt
    float3 ClipColor( float3 color )
    {
        float lum         = getAvgColor( color.xyz );
        float mincol      = min( min( color.x, color.y ), color.z );
        float maxcol      = max( max( color.x, color.y ), color.z );
        color.xyz         = ( mincol < 0.0f ) ? lum + (( color.xyz - lum ) * lum ) / ( lum - mincol ) : color.xyz;
        color.xyz         = ( maxcol > 1.0f ) ? lum + (( color.xyz - lum ) * ( 1.0f - lum )) / ( maxcol - lum ) : color.xyz;
        return color;
    }
    
    // Luminosity: base, blend
    // Color: blend, base
    float3 blendLuma( float3 base, float3 blend )
    {
        float lumbase     = getAvgColor( base.xyz );
        float lumblend    = getAvgColor( blend.xyz );
        float ldiff       = lumblend - lumbase;
        float3 col        = base.xyz + ldiff;
        return ClipColor( col.xyz );
    }

    float3 exposure( float3 res, float x )
    {
        float b = 0.0f;
        b = x < 0.0f ? b = x * 0.333f : b = x;
        return saturate( res.xyz * ( b * ( 1.0f - res.xyz ) + 1.0f ));
    }

    float3 con( float3 res, float x )
    {
        //softlight
        float3 c = softlight( res.xyz, res.xyz );
        float b = 0.0f;
        b = x < 0.0f ? b = x * 0.5f : b = x;
        return saturate( lerp( res.xyz, c.xyz, b ));
    }

    float3 bri( float3 res, float x )
    {
        //screen
        float3 c = 1.0f - ( 1.0f - res.xyz ) * ( 1.0f - res.xyz );
        float b = 0.0f;
        b = x < 0.0f ? b = x * 0.5f : b = x;
        return saturate( lerp( res.xyz, c.xyz, b ));   
    }

    float3 sat( float3 res, float x )
    {
        return min( lerp( getLuminance( res.xyz ), res.xyz, x + 1.0f ), 1.0f );
    }

    float3 vib( float3 res, float x )
    {
        float4 sat = 0.0f;
        sat.xy = float2( min( min( res.x, res.y ), res.z ), max( max( res.x, res.y ), res.z ));
        sat.z = sat.y - sat.x;
        sat.w = getLuminance( res.xyz );
        return lerp( sat.w, res.xyz, 1.0f + ( x * ( 1.0f - sat.z )));
    }

    float3 channelsat( float3 col, float r, float o, float y, float g, float a, float b, float p, float m )
    {
        float3 hsl         = RGBToHSL( col.xyz ).x;
        float desat        = getLuminance( col.xyz );

        //Get weights
        float weight_r     = curve( max( 1.0f - abs(  hsl.x            * 8.0f ), 0.0f )) +
                             curve( max( 1.0f - abs(( hsl.x - 1.0f   ) * 8.0f ), 0.0f ));
        float weight_o     = curve( max( 1.0f - abs(( hsl.x - 0.125f ) * 8.0f ), 0.0f ));
        float weight_y     = curve( max( 1.0f - abs(( hsl.x - 0.25f  ) * 8.0f ), 0.0f ));
        float weight_g     = curve( max( 1.0f - abs(( hsl.x - 0.375f ) * 8.0f ), 0.0f ));
        float weight_a     = curve( max( 1.0f - abs(( hsl.x - 0.5f   ) * 8.0f ), 0.0f ));
        float weight_b     = curve( max( 1.0f - abs(( hsl.x - 0.625f ) * 8.0f ), 0.0f ));
        float weight_p     = curve( max( 1.0f - abs(( hsl.x - 0.75f  ) * 8.0f ), 0.0f ));
        float weight_m     = curve( max( 1.0f - abs(( hsl.x - 0.875f ) * 8.0f ), 0.0f ));

        float3 ret         = col.xyz;
        ret.xyz            = r > 0.0f ? lerp( desat, ret.xyz, min( 1.0f + r * weight_r * ( 1.0f - hsl.y ), 2.0f )) :
                                        lerp( desat, ret.xyz, max( 1.0f + r * weight_r, 0.0f ));
        ret.xyz            = o > 0.0f ? lerp( desat, ret.xyz, min( 1.0f + o * weight_o * ( 1.0f - hsl.y ), 2.0f )) :
                                        lerp( desat, ret.xyz, max( 1.0f + o * weight_o, 0.0f ));
        ret.xyz            = y > 0.0f ? lerp( desat, ret.xyz, min( 1.0f + y * weight_y * ( 1.0f - hsl.y ), 2.0f )) :
                                        lerp( desat, ret.xyz, max( 1.0f + y * weight_y, 0.0f ));
        ret.xyz            = g > 0.0f ? lerp( desat, ret.xyz, min( 1.0f + g * weight_g * ( 1.0f - hsl.y ), 2.0f )) :
                                        lerp( desat, ret.xyz, max( 1.0f + g * weight_g, 0.0f ));
        ret.xyz            = a > 0.0f ? lerp( desat, ret.xyz, min( 1.0f + a * weight_a * ( 1.0f - hsl.y ), 2.0f )) :
                                        lerp( desat, ret.xyz, max( 1.0f + a * weight_a, 0.0f ));
        ret.xyz            = b > 0.0f ? lerp( desat, ret.xyz, min( 1.0f + b * weight_b * ( 1.0f - hsl.y ), 2.0f )) :
                                        lerp( desat, ret.xyz, max( 1.0f + b * weight_b, 0.0f ));
        ret.xyz            = p > 0.0f ? lerp( desat, ret.xyz, min( 1.0f + p * weight_p * ( 1.0f - hsl.y ), 2.0f )) :
                                        lerp( desat, ret.xyz, max( 1.0f + p * weight_p, 0.0f ));
        ret.xyz            = m > 0.0f ? lerp( desat, ret.xyz, min( 1.0f + m * weight_m * ( 1.0f - hsl.y ), 2.0f )) :
                                        lerp( desat, ret.xyz, max( 1.0f + m * weight_m, 0.0f ));

        return saturate( ret.xyz );
    }

    float3 customsat( float3 col, float hue, float range, float sat )
    {
        float3 hsl         = RGBToHSL( col.xyz );
        float desat        = getLuminance( col.xyz );
        float r            = rcp( range );
        float3 w           = max( 1.0f - abs(( hsl.x - hue        ) * r ), 0.0f );
        w.y                = max( 1.0f - abs(( hsl.x + 1.0f - hue ) * r ), 0.0f );
        w.z                = max( 1.0f - abs(( hsl.x - 1.0f - hue ) * r ), 0.0f );
        float weight       = curve( dot( w.xyz, 1.0f )) * sat;
        col.xyz            = weight > 0.0f ? lerp( desat, col.xyz, min( 1.0f + weight * ( 1.0f - hsl.y ), 2.0f )) :
                                             lerp( desat, col.xyz, max( 1.0f + weight, 0.0f ));
        return saturate( col.xyz );
    }

    //// PIXEL SHADERS //////////////////////////////////////////////////////////////
    float4 PS_CBS(float4 pos : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
    {
        float4 color     = tex2D( samplerColor, texcoord );
        float depth      = ReShade::GetLinearizedDepth( texcoord ).x;
        depth            = smoothstep( depthStart, depthEnd, depth );
        depth            = pow( depth, depthCurve );
        float2 uv        = float2( BUFFER_WIDTH, BUFFER_HEIGHT) / float2( 512.0f, 512.0f );
        uv.xy            = uv.xy * texcoord.xy * 1.6f;
        float noise      = tex2D( samplerNoise, uv ).x;
        depth            = saturate( depth + lerp( -0.5/255, 0.5/255, noise ));
        
        color.xyz        = saturate( color.xyz );

        float3 cold      = float3( 0.0f,  0.365f, 1.0f ); //LBB
        float3 warm      = float3( 0.98f, 0.588f, 0.0f ); //LBA

        color.xyz        = ( tint < 0.0f ) ? lerp( color.xyz, blendLuma( cold.xyz, color.xyz ), abs( tint )) :
                                             lerp( color.xyz, blendLuma( warm.xyz, color.xyz ), tint );

        float3 dcolor    = color.xyz;
        color.xyz        = exposure( color.xyz, exposureN );
        color.xyz        = con( color.xyz, contrast   );
        color.xyz        = bri( color.xyz, brightness );
        color.xyz        = sat( color.xyz, saturation );
        color.xyz        = vib( color.xyz, vibrance   );

        dcolor.xyz       = exposure( dcolor.xyz, exposureD );
        dcolor.xyz       = con( dcolor.xyz, contrastD   );
        dcolor.xyz       = bri( dcolor.xyz, brightnessD );
        dcolor.xyz       = sat( dcolor.xyz, saturationD );
        dcolor.xyz       = vib( dcolor.xyz, vibranceD   );
        
        color.xyz        = lerp( color.xyz, dcolor.xyz, enable_depth * depth ); // apply based on depth

        color.xyz        = channelsat( color.xyz, sat_r, sat_o, sat_y, sat_g, sat_a, sat_b, sat_p, sat_m );
        color.xyz        = customsat( color.xyz, huemid, huerange, sat_custom );

        // Dither
        color.xyz        = enable_dither ? saturate( color.xyz + lerp( -0.5/255, 0.5/255, noise )) : color.xyz;
        color.xyz        = display_depth ? depth.xxx : color.xyz; // show depth

        return float4( color.xyz, 1.0f );
    }

    //// TECHNIQUES /////////////////////////////////////////////////////////////////
    technique prod80_04_ContrastBrightnessSaturation
    {
        pass ConBriSat
        {
            VertexShader   = PostProcessVS;
            PixelShader    = PS_CBS;
        }
    }
}