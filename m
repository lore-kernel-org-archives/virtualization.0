Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BC035C183
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761736; cv=none; b=bTxobz3t2Tk48CLNxWz/EM89tXewcovL6assD0+c/hRofYyqF8nKQFM1enh4rm+KoU1Lxn0KbFzOdsrbSfX99S5iLP1im78m1Nm0VtHEuFofO1ABjkijFAWU6eALo5F88p387kc8LN9FjsieQPqyqLqKuMzG0dYvWkyVBtrJ2uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761736; c=relaxed/simple;
	bh=Ir8txI41duHjjdUa1tYJv/Mb4slAcXRYTZiQjfKa4u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omEvfWvVb7RHUZ4hDTvR8/SLqMm7+MFLBGUu25XMcQJGS1+TQPY1i0FUGdmONsSPA90wRoMnpYvkiy27p+cjI0coOnXG4RA+/waF2WRgAlp+WT6IRIujzedVJn0IVUdTpVoGbTVIZC3QWhRf4lCaFxLNKcXAJob3ItMID5lANwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-97723f98735so2053940241.3
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 05:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785761734; x=1786366534;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WGVqxVKLC2Gks94xayPEyUqyvnJiYIaVHNXa8plDaec=;
        b=jnirZ5v9d+60vBqoQ2dE1QcOLrlo68zHiwOumgDIFve8LbW64PVwpSNgyZONlDGWpR
         e4MkDGYrVbVP5x6BKjGSGkXuxW8vZoCQT/quwDX81Lwh3GIssvb1CBTIw8OsgS+7kGVW
         CtrT9t8P9PUvHTmQUUazDyLQZO0ix5WbrpTfU0/nUMIrEvb9mzbuvYUeWhctF8DEI4Zs
         mrU1ObwJbpFMSpdYnDhEpY9NmqzMxjJhgmDQjgCl5MrWpkd3F/ykE0zfrc27ivvzR22/
         DzKVhuvoeVbET4ShESJVP9HKILaqaspq/+HFwIeJaZRT2ZmVBDHODV7uH7KAmsiJ5ii9
         DLrQ==
X-Forwarded-Encrypted: i=1; AHgh+Rphk2L/38ePKB3p5JYO58IhYUcQW8esOuVb4ErbAqAYZJtzZ2loki7YW8YD4Y7RawXlKKBO//Ag7VuUpzRiaA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcV+Uwuj61URT52QrRxYShjEqKIOYj6L893eIN5/8nUaaJidWN
	73O6TlmXgbOepkPom4hHcl1AripPERuAo7t6fc2Y4uM16QuHvcJeBbZLTxPWX20A
X-Gm-Gg: AR+sD10lSWyUINB2LMpxXl4h7zaVRaUpuKJodw0i50v+dOzRT11U/kGJ/ySKmV/feKW
	c/egUgb//zRPaQmsZMCmURoqaqFOByE56DyTHa4T5+CBxyTQVeHSrY3peo3KkxQSqR7p41kJQns
	gJOLxDzmrsePG++Y0avG06DMwQvzVGSChDk+2lab83WbvVcWyWvLSaw9xundM3K11dLOEN/aaST
	/j/9CrYOcDJI3dYaXGIs8Y7hFoiiwmrjE+4scWDSzZ6Koyowj32SavZb823Eb9GhMjCnjPVTg6A
	Uf9m0/FGzL6mF9q3Y8V1jhE33hY9+SAwEBkC6fWOL/lgogcKFJzyiYILZAJw3V57Y4T8+KrEm0D
	Su9Tc8n+U/vpFPXrDpKaCnfI9Ibo+vq4mc3HstaGRtp5Fo1RLiT8aEEW7IIVNokS//X/jRFEzjk
	kvgJmcH2qUTugnk/4xeRpLmxKZ3HC5CKSxof2QvAiTvYo6hbQcfjf0q7vNRCIFMSQ+TbkdEZJNx
	T6PRusW4i+8u/UxvpJxnPUZFCmOgx5j2GkB
X-Received: by 2002:a05:6102:160e:b0:752:757a:96f0 with SMTP id ada2fe7eead31-75b21a5ecf4mr8412508137.3.1785761733925;
        Mon, 03 Aug 2026 05:55:33 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-977e6213f7dsm6018781241.7.2026.08.03.05.55.33
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 05:55:33 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-74d55dac06eso1884580137.3
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 05:55:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqZSGjsU7mccGaKMno+2dGE0L9czlxrllCU7vGgcy0AzXQ61o2xKQxLMbtxXCYYUOScj/ycfCwhB/LOH+QKCQ==@lists.linux.dev
X-Received: by 2002:a05:6102:6a83:b0:729:affa:70fd with SMTP id
 ada2fe7eead31-75b2295c6d6mr7103654137.8.1785761305110; Mon, 03 Aug 2026
 05:48:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com> <20260720-drm_simple_encoder_init-v2-10-5020b630668a@gmail.com>
In-Reply-To: <20260720-drm_simple_encoder_init-v2-10-5020b630668a@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Aug 2026 14:48:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUe0F06RE4ahWb9ERFq0_pnNy-qGZ5ewod+59x-RtU_FQ@mail.gmail.com>
X-Gm-Features: AUfX_mz7dUNKx_CkXmX2bBiqeRWfQJXaKympC5b4Q722_mZANMq2M_rTZsMnNYo
Message-ID: <CAMuHMdUe0F06RE4ahWb9ERFq0_pnNy-qGZ5ewod+59x-RtU_FQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] drm/renesas/shmobile: remove dependency on DRM
 simple helpers
To: Diogo Silva <diogompaissilva@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
	Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Michal Simek <michal.simek@amd.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Stefan Agner <stefan@agner.ch>, 
	Alison Wang <alison.wang@nxp.com>, Anitha Chrisanthus <anitha.chrisanthus@intel.com>, 
	David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Jyri Sarha <jyri.sarha@iki.fi>, Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Xinliang Liu <xinliang.liu@linaro.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Yongqin Liu <yongqin.liu@linaro.org>, 
	John Stultz <jstultz@google.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
	virtualization@lists.linux.dev, imx@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Diogo,

On Mon, 20 Jul 2026 at 17:41, Diogo Silva <diogompaissilva@gmail.com> wrote:
> The simple KMS helpers are deprecated because they only add an
> intermediate layer between drivers and atomic modesetting.
>
> Open-code drm_simple_encoder_init() by calling drm_encoder_init()
> directly and providing driver-local drm_encoder_funcs.
>
> Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>

Thanks for your patch!

> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c

> @@ -29,7 +30,6 @@
>  #include <drm/drm_modeset_helper_vtables.h>
>  #include <drm/drm_panel.h>
>  #include <drm/drm_probe_helper.h>
> -#include <drm/drm_simple_kms_helper.h>
>  #include <drm/drm_vblank.h>
>
>  #include <video/videomode.h>
> @@ -436,6 +436,10 @@ static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
>         .mode_fixup = shmob_drm_encoder_mode_fixup,
>  };
>
> +static const struct drm_encoder_funcs shmob_encoder_funcs = {

Nit: shmob_drm_encoder_funcs?

> +       .destroy = drm_encoder_cleanup,
> +};
> +
>  /* -----------------------------------------------------------------------------
>   * Encoder
>   */

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
