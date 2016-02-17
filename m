From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 07/16] drm/omapdrm: removed optional dummy crtc mode_fixup
	function.
Date: Wed, 17 Feb 2016 17:24:08 +0200
Message-ID: <12773333.2XRLo5cZeb__38604.5706960887$1455725045$gmane$org@avalon>
References: <cover.1455630967.git.palminha@synopsys.com>
	<101f043d5fa747291c09ae765bac4d55c6e39988.1455630967.git.palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <101f043d5fa747291c09ae765bac4d55c6e39988.1455630967.git.palminha@synopsys.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Cc: nicolas.pitre@linaro.org, boris.brezillon@free-electrons.com, jianwei.wang.chn@gmail.com, airlied@linux.ie, daniel.vetter@ffwll.ch, alison.wang@freescale.com, patrik.r.jakobsson@gmail.com, virtualization@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, jani.nikula@intel.com, dri-devel@lists.freedesktop.org, benjamin.gaignard@linaro.org, vincent.abriou@st.com, sudipm.mukherjee@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Carlos,

Thank you for the patch.

On Tuesday 16 February 2016 14:18:12 Carlos Palminha wrote:
> This patch set nukes all the dummy crtc mode_fixup implementations.
> (made on top of Daniel topic/drm-misc branch)
> 
> Signed-off-by: Carlos Palminha <palminha@synopsys.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/omapdrm/omap_crtc.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c
> b/drivers/gpu/drm/omapdrm/omap_crtc.c index d38fcbc..483acdb 100644
> --- a/drivers/gpu/drm/omapdrm/omap_crtc.c
> +++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
> @@ -330,13 +330,6 @@ static void omap_crtc_destroy(struct drm_crtc *crtc)
>  	kfree(omap_crtc);
>  }
> 
> -static bool omap_crtc_mode_fixup(struct drm_crtc *crtc,
> -		const struct drm_display_mode *mode,
> -		struct drm_display_mode *adjusted_mode)
> -{
> -	return true;
> -}
> -
>  static void omap_crtc_enable(struct drm_crtc *crtc)
>  {
>  	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
> @@ -451,7 +444,6 @@ static const struct drm_crtc_funcs omap_crtc_funcs = {
>  };
> 
>  static const struct drm_crtc_helper_funcs omap_crtc_helper_funcs = {
> -	.mode_fixup = omap_crtc_mode_fixup,
>  	.mode_set_nofb = omap_crtc_mode_set_nofb,
>  	.disable = omap_crtc_disable,
>  	.enable = omap_crtc_enable,

-- 
Regards,

Laurent Pinchart
