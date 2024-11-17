Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224AE1DA61E;
	Sun, 17 Nov 2024 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731878386; cv=none; b=FTIjNcKTgwnKcYOdUMBuX26NF4dH/FrXYN647kE5l9dN7dnBQrLT2YeaszxUObc0gBck2n+JAsp+l9uZewcHVjq42xlzPzM27SZSkVJjCyyQ5iTkt2Lq5d8kAtqWUUxUT+44ahS6RpqdFTA7ESG8OmHbEAQ8u+li8sw15kLWhvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731878386; c=relaxed/simple;
	bh=LCxOYDveABxYci6xcGPLQzoY5X2ur4NiEvJHNv8MSqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaQs+m1BzrcRD/n7LIknUR4oPQdX4Dm2+f8WYTT9KEfnmMTx9Fyy9Wr0Z191be8yOgTfyWN2mrtfpUlzFLcLvlLf6t9CzloOhJYMEXHh1BCGq6bIvaFq5G8S2pQ3P/9Orml+4KLCGeim0xu6Et2IiDGuZG1RDcaJuPxqx5De3DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=i1ESlBtd; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="i1ESlBtd"
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C67007CA;
	Sun, 17 Nov 2024 22:19:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1731878366;
	bh=LCxOYDveABxYci6xcGPLQzoY5X2ur4NiEvJHNv8MSqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1ESlBtdKSP8T3VJsiyviRYpYYbIEmbGaQmDPwC+LZ2O7kjbwJns8m16yNh8iQgt0
	 tJWzm+lcCtnLT6dw2MHxLrrP3j4E4ME5dwLNZw/bOqw3GIPpRMke3fcNRpRBPuYmsh
	 pEOpUxNtWT/SrQqwxbZe8h+iAv0MPMGJe6JswldA=
Date: Sun, 17 Nov 2024 23:19:33 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Raphael Gallais-Pou <rgallaispou@gmail.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Peter Senna Tschudin <peter.senna@gmail.com>,
	Ian Ray <ian.ray@ge.com>,
	Martyn Welch <martyn.welch@collabora.co.uk>,
	Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@csie.org>,
	Samuel Holland <samuel@sholland.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>, Zack Rusin <zack.rusin@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 3/5] drm/sti: hda: pass const struct drm_display_mode* to
 hda_get_mode_idx()
Message-ID: <20241117211933.GG12409@pendragon.ideasonboard.com>
References: <20241115-drm-connector-mode-valid-const-v1-0-b1b523156f71@linaro.org>
 <20241115-drm-connector-mode-valid-const-v1-3-b1b523156f71@linaro.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241115-drm-connector-mode-valid-const-v1-3-b1b523156f71@linaro.org>

Hi Dmitry,

Thank you for the patch.

On Fri, Nov 15, 2024 at 11:09:28PM +0200, Dmitry Baryshkov wrote:
> Make hda_get_mode_idx() accept const struct drm_display_mode pointer
> instead of just raw struct drm_display_mode.  This is a preparation to
> converting the mode_valid() callback of drm_connector to accept const
> struct drm_display_mode argument.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/sti/sti_hda.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
> index f18faad974aa2eda58c1e49537f8337db119d4b7..829dc4b034e8a79a908bda60485c2b94ef96890c 100644
> --- a/drivers/gpu/drm/sti/sti_hda.c
> +++ b/drivers/gpu/drm/sti/sti_hda.c
> @@ -280,12 +280,12 @@ static void hda_write(struct sti_hda *hda, u32 val, int offset)
>   *
>   * Return true if mode is found
>   */
> -static bool hda_get_mode_idx(struct drm_display_mode mode, int *idx)
> +static bool hda_get_mode_idx(const struct drm_display_mode *mode, int *idx)
>  {
>  	unsigned int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(hda_supported_modes); i++)
> -		if (drm_mode_equal(&hda_supported_modes[i].mode, &mode)) {
> +		if (drm_mode_equal(&hda_supported_modes[i].mode, mode)) {
>  			*idx = i;
>  			return true;
>  		}
> @@ -443,7 +443,7 @@ static void sti_hda_pre_enable(struct drm_bridge *bridge)
>  	if (clk_prepare_enable(hda->clk_hddac))
>  		DRM_ERROR("Failed to prepare/enable hda_hddac clk\n");
>  
> -	if (!hda_get_mode_idx(hda->mode, &mode_idx)) {
> +	if (!hda_get_mode_idx(&hda->mode, &mode_idx)) {
>  		DRM_ERROR("Undefined mode\n");
>  		return;
>  	}
> @@ -526,7 +526,7 @@ static void sti_hda_set_mode(struct drm_bridge *bridge,
>  
>  	drm_mode_copy(&hda->mode, mode);
>  
> -	if (!hda_get_mode_idx(hda->mode, &mode_idx)) {
> +	if (!hda_get_mode_idx(&hda->mode, &mode_idx)) {
>  		DRM_ERROR("Undefined mode\n");
>  		return;
>  	}
> @@ -614,7 +614,7 @@ sti_hda_connector_mode_valid(struct drm_connector *connector,
>  		= to_sti_hda_connector(connector);
>  	struct sti_hda *hda = hda_connector->hda;
>  
> -	if (!hda_get_mode_idx(*mode, &idx)) {
> +	if (!hda_get_mode_idx(mode, &idx)) {
>  		return MODE_BAD;
>  	} else {
>  		result = clk_round_rate(hda->clk_pix, target);
> 

-- 
Regards,

Laurent Pinchart
