From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 8/9] drm: remove no longer needed drm-get-put coccinelle
	script
Date: Sun, 18 Nov 2018 12:04:04 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1811181203410.3530__17388.7414894581$1542538943$gmane$org@hadrien>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
	<20181115221634.22715-9-greenfoo@gluegarage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181115221634.22715-9-greenfoo@gluegarage.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Fernando Ramos <greenfoo@gluegarage.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Gilles Muller <Gilles.Muller@lip6.fr>, David Airlie <airlied@linux.ie>, Linus Walleij <linus.walleij@linaro.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>, cocci@systeme.lip6.fr, Marek Vasut <marex@denx.de>, Archit Taneja <architt@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Russell King <linux+etnaviv@armlinux.org.uk>, Nicolas Palix <nicolas.palix@imag.fr>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, etnaviv@lists.freedesktop.org, Boris Brezillon <boris.brezillon@bootlin.com>, Christian Gmeiner <christian.gmeiner@gmail.com>Stefan Agner <s>
List-Id: virtualization@lists.linuxfoundation.org



On Thu, 15 Nov 2018, Fernando Ramos wrote:

> The coccinelle script was used to rename some (deprecated) functions
> which no longer exist now.
>
> Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>


> ---
>  scripts/coccinelle/api/drm-get-put.cocci | 78 ------------------------
>  1 file changed, 78 deletions(-)
>  delete mode 100644 scripts/coccinelle/api/drm-get-put.cocci
>
> diff --git a/scripts/coccinelle/api/drm-get-put.cocci b/scripts/coccinelle/api/drm-get-put.cocci
> deleted file mode 100644
> index 3a09c97ad87d..000000000000
> --- a/scripts/coccinelle/api/drm-get-put.cocci
> +++ /dev/null
> @@ -1,78 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -///
> -/// Use drm_*_get() and drm_*_put() helpers instead of drm_*_reference() and
> -/// drm_*_unreference() helpers.
> -///
> -// Confidence: High
> -// Copyright: (C) 2017 NVIDIA Corporation
> -// Options: --no-includes --include-headers
> -//
> -
> -virtual patch
> -virtual report
> -
> -@depends on patch@
> -expression object;
> -@@
> -
> -(
> -- drm_connector_reference(object)
> -+ drm_connector_get(object)
> -|
> -- drm_connector_unreference(object)
> -+ drm_connector_put(object)
> -|
> -- drm_framebuffer_reference(object)
> -+ drm_framebuffer_get(object)
> -|
> -- drm_framebuffer_unreference(object)
> -+ drm_framebuffer_put(object)
> -|
> -- drm_gem_object_reference(object)
> -+ drm_gem_object_get(object)
> -|
> -- drm_gem_object_unreference(object)
> -+ drm_gem_object_put(object)
> -|
> -- __drm_gem_object_unreference(object)
> -+ __drm_gem_object_put(object)
> -|
> -- drm_gem_object_unreference_unlocked(object)
> -+ drm_gem_object_put_unlocked(object)
> -|
> -- drm_dev_unref(object)
> -+ drm_dev_put(object)
> -)
> -
> -@r depends on report@
> -expression object;
> -position p;
> -@@
> -
> -(
> -drm_connector_unreference@p(object)
> -|
> -drm_connector_reference@p(object)
> -|
> -drm_framebuffer_unreference@p(object)
> -|
> -drm_framebuffer_reference@p(object)
> -|
> -drm_gem_object_unreference@p(object)
> -|
> -drm_gem_object_reference@p(object)
> -|
> -__drm_gem_object_unreference(object)
> -|
> -drm_gem_object_unreference_unlocked(object)
> -|
> -drm_dev_unref@p(object)
> -)
> -
> -@script:python depends on report@
> -object << r.object;
> -p << r.p;
> -@@
> -
> -msg="WARNING: use get/put helpers to reference and dereference %s" % (object)
> -coccilib.report.print_report(p[0], msg)
> --
> 2.19.1
>
>
