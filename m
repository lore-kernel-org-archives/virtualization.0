From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 06/59] drm/prime: Actually remove DRIVER_PRIME everywhere
Date: Fri, 14 Jun 2019 23:36:06 +0200
Message-ID: <20190614213606.GB19476__46959.138177202$1560548183$gmane$org@ravnborg.org>
References: <20190614203615.12639-1-daniel.vetter@ffwll.ch>
	<20190614203615.12639-7-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190614203615.12639-7-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: linux-aspeed@lists.ozlabs.org, nouveau@lists.freedesktop.org, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Daniel Vetter <daniel.vetter@intel.com>, linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org, lima@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-rockchip@lists.infradead.org, VMware Graphics <linux-graphics-maintainer@vmware.com>, NXP Linux Team <linux-imx@nxp.com>, spice-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, etnaviv@lists.freedesktop.org, xen-devel@lists.xenproject.org, linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, freedreno@lists.freedesktop.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Daniel.

Minor nitpick..

> diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
> index 65d599065709..4fd09a9ad67a 100644
> --- a/drivers/gpu/drm/i915/i915_drv.c
> +++ b/drivers/gpu/drm/i915/i915_drv.c
> @@ -3193,7 +3193,7 @@ static struct drm_driver driver = {
>  	 * deal with them for Intel hardware.
>  	 */
>  	.driver_features =
> -	    DRIVER_GEM | DRIVER_PRIME |
> +	    DRIVER_GEM | 
>  	    DRIVER_RENDER | DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_SYNCOBJ,
Adds a whitespace.

	Sam
