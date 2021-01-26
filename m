Return-Path: <SRS0=+Z4V=G5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A49C433E0
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 13:25:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DDF9207A0
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 13:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDF9207A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4F8C385570;
	Tue, 26 Jan 2021 13:25:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MowYLPLQ4-DT; Tue, 26 Jan 2021 13:24:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0313185585;
	Tue, 26 Jan 2021 13:24:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7BCFC08A1;
	Tue, 26 Jan 2021 13:24:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 509ACC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 13:24:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4702220017
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 13:24:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OBOy7of-EatA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 13:24:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by silver.osuosl.org (Postfix) with ESMTPS id 38AB6203FE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 13:24:55 +0000 (UTC)
IronPort-SDR: Czce/Y4eMov5sa74LU5Z+7KwWnWWL8YOzLa66xoUmTA809pKzJFTpjBOeujRU/kn7n94ZtBNFh
 BLyhDvnQX8sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="241429101"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; d="scan'208";a="241429101"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2021 05:24:53 -0800
IronPort-SDR: g4Zswe3qz4zMid/EyEG5xz4WWhFPriWd/t2t5KrG0ShP0j9WNEEJayXNCJQTEkRkM2/IHRNzgx
 zk+bb8SSGplQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; d="scan'208";a="369103591"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
 by orsmga002.jf.intel.com with SMTP; 26 Jan 2021 05:24:36 -0800
Received: by stinkbox (sSMTP sendmail emulation);
 Tue, 26 Jan 2021 15:24:35 +0200
Date: Tue, 26 Jan 2021 15:24:35 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v2 10/11] drm: Use state helper instead of the plane
 state pointer
Message-ID: <YBAYE4YH4bgURmuf@intel.com>
References: <20210121163537.1466118-1-maxime@cerno.tech>
 <20210121163537.1466118-10-maxime@cerno.tech>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210121163537.1466118-10-maxime@cerno.tech>
X-Patchwork-Hint: comment
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>,
 Liviu Dudau <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org,
 Russell King <linux@armlinux.org.uk>, Paul Cercueil <paul@crapouillou.net>,
 Thierry Reding <thierry.reding@gmail.com>,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>,
 Jerome Brunet <jbrunet@baylibre.com>, Marek Vasut <marex@denx.de>,
 linux-renesas-soc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 Joonyoung Shim <jy0922.shim@samsung.com>, linux-rockchip@lists.infradead.org,
 Alexey Brodkin <abrodkin@synopsys.com>, Michal Simek <michal.simek@xilinx.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 Roland Scheidegger <sroland@vmware.com>,
 Xinliang Liu <xinliang.liu@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 NXP Linux Team <linux-imx@nxp.com>, Chen Feng <puck.chen@hisilicon.com>,
 Dave Airlie <airlied@redhat.com>, Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-msm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
 Alison Wang <alison.wang@nxp.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-mips@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mediatek@lists.infradead, Hyun Kwon <hyun.kwon@xilinx.com>,
 Philippe Cornu <philippe.cornu@st.com>, Sandy Huang <hjc@rock-chips.com>,
 Yannick Fertre <yannick.fertre@st.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, freedreno@lists.freedesktop.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Jan 21, 2021 at 05:35:35PM +0100, Maxime Ripard wrote:
> Many drivers reference the plane->state pointer in order to get the
> current plane state in their atomic_update or atomic_disable hooks,
> which would be the new plane state in the global atomic state since
> _swap_state happened when those hooks are run.
> =

> Use the drm_atomic_get_new_plane_state helper to get that state to make it
> more obvious.
> =

> This was made using the coccinelle script below:
> =

> @ plane_atomic_func @
> identifier helpers;
> identifier func;
> @@
> =

> (
>  static const struct drm_plane_helper_funcs helpers =3D {
>  	...,
>  	.atomic_disable =3D func,
> 	...,
>  };
> |
>  static const struct drm_plane_helper_funcs helpers =3D {
>  	...,
>  	.atomic_update =3D func,
> 	...,
>  };
> )
> =

> @ adds_new_state @
> identifier plane_atomic_func.func;
> identifier plane, state;
> identifier new_state;
> @@
> =

>  func(struct drm_plane *plane, struct drm_atomic_state *state)
>  {
>  	...
> -	struct drm_plane_state *new_state =3D plane->state;
> +	struct drm_plane_state *new_state =3D drm_atomic_get_new_plane_state(st=
ate, plane);
> 	...
>  }
> =

> @ include depends on adds_new_state @
> @@
> =

>  #include <drm/drm_atomic.h>
> =

> @ no_include depends on !include && adds_new_state @
> @@
> =

> + #include <drm/drm_atomic.h>
>   #include <drm/...>
> =

> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Looks great.

Reviewed-by: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>

-- =

Ville Syrj=E4l=E4
Intel
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
