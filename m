Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D138B379971
	for <virtualization@lists.linux.dev>; Tue, 28 Jul 2026 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255789; cv=none; b=OPgbQLaw2E/nLzOtJCruSrpksjT2E/xUqDVwmrtSwA/5WGwtTP9aOyL5USr9hg7yRK3pp2TlYGWWCLS77tGucXOT4ekzj840+0JRInPzCB1O/2TgORKa5WwhnclXcm3wdlB8+imMlwfuFxr+nFeAp1JPDJh9HNoNy+XPspkoj44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255789; c=relaxed/simple;
	bh=MuoYv/trvB+apkFilFU7ge8EmIYL0Cz7Mp4H5bYBY04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5JLNjRQdQBgR/8VT+dpMYfFHYo4zX1374vrGdar/jk22q1b4kd6caKweCCNPnxgviAkVpuVGffjOKVACDnrU/SM6JzuwZJXkXU3ubY/5jJZKPrPVzYbEyluidTMqxxd/rbZQFszP6PappcwFBY4H2g/pyZwVAmQ8P8+4hkJi8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TuQ1uIUd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TuQ1uIUd"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06B4C1A9A
	for <virtualization@lists.linux.dev>; Tue, 28 Jul 2026 09:23:03 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C0E903F763
	for <virtualization@lists.linux.dev>; Tue, 28 Jul 2026 09:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785255787; bh=MuoYv/trvB+apkFilFU7ge8EmIYL0Cz7Mp4H5bYBY04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TuQ1uIUdr6XeriSU0lLugWjHtnYVb8IMBRkipJHY7V0SmZ/8LKPzQX70qicriUoGB
	 tqxpzSywljuSc02k1VJsHtMuqjRpeWbc++6oUVxmlpd+rtWcEQEWUpkn0105sbZwzF
	 HsD8mWIqD4atY45VnIjYMUo0psZfxZr/dVvjpKbw=
Date: Tue, 28 Jul 2026 17:21:58 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Diogo Silva <diogompaissilva@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Michal Simek <michal.simek@amd.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>,
	Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
	Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Xinliang Liu <xinliang.liu@linaro.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Yongqin Liu <yongqin.liu@linaro.org>,
	John Stultz <jstultz@google.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, virtualization@lists.linux.dev,
	imx@lists.linux.dev, linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 12/15] drm/arm/komeda: remove dependency on DRM simple
 helpers
Message-ID: <amjXJrbgka00CQX2@e142607>
References: <20260719-drm_simple_encoder_init-v1-0-a78c509e3062@gmail.com>
 <20260719-drm_simple_encoder_init-v1-12-a78c509e3062@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260719-drm_simple_encoder_init-v1-12-a78c509e3062@gmail.com>

On Sun, Jul 19, 2026 at 01:35:43AM +0200, Diogo Silva wrote:
> The simple KMS helpers are deprecated because they only add an
> intermediate layer between drivers and atomic modesetting.
> 
> Open-code drm_simple_encoder_init() by calling drm_encoder_init()
> directly and providing driver-local drm_encoder_funcs.
> 
> Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> index e8cb782a6f8e..719568d9f7c2 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -11,9 +11,9 @@
>  
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_encoder.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_vblank.h>
> -#include <drm/drm_simple_kms_helper.h>
>  #include <drm/drm_bridge.h>
>  
>  #include "komeda_dev.h"
> @@ -635,6 +635,10 @@ static int komeda_attach_bridge(struct device *dev,
>  	return err;
>  }
>  
> +static const struct drm_encoder_funcs komeda_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
>  static int komeda_crtc_add(struct komeda_kms_dev *kms,
>  			   struct komeda_crtc *kcrtc)
>  {
> @@ -658,7 +662,8 @@ static int komeda_crtc_add(struct komeda_kms_dev *kms,
>  	 * bridge
>  	 */
>  	kcrtc->encoder.possible_crtcs = drm_crtc_mask(crtc);
> -	err = drm_simple_encoder_init(base, encoder, DRM_MODE_ENCODER_TMDS);
> +	err = drm_encoder_init(base, encoder, &komeda_encoder_funcs,
> +			       DRM_MODE_ENCODER_TMDS, NULL);
>  	if (err)
>  		return err;
>  
> 
> -- 
> 2.54.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
