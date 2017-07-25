From: Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH 7/8] drm: Nuke drm_atomic_helper_connector_dpms
Date: Tue, 25 Jul 2017 15:00:19 +0530
Message-ID: <250ddff2-61ef-4e9e-5312-87014bb4b285__3703.93913840434$1500975054$gmane$org@codeaurora.org>
References: <20170725080122.20548-1-daniel.vetter@ffwll.ch>
	<20170725080122.20548-8-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170725080122.20548-8-daniel.vetter@ffwll.ch>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc: Martyn Welch <martyn.welch@collabora.co.uk>, Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, Stefan Agner <stefan@agner.ch>, virtualization@lists.linux-foundation.org, Andrzej Hajda <a.hajda@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-mediatek@lists.infradead.org, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Romain Perier <romain.perier@collabora.com>, Daniel Vetter <daniel.vetter@intel.com>, Jyri Sarha <jsarha@ti.com>, Heiko Stuebner <heiko@sntech.de>, Marek Vasut <marex@denx.de>, linux-renesas-soc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Joonyoung Shim <jy0922.shim@samsung.com>, Kevin Hilman <khilman@baylibre.com>, Alexey Brodkin <abrodkin@synopsys.com>, Russell King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk@ker>
List-Id: virtualization@lists.linuxfoundation.org



On 07/25/2017 01:31 PM, Daniel Vetter wrote:
> It's dead code, the core handles all this directly now.
> 
> The only special case is nouveau and tda988x which used one function
> for both legacy modeset code and -nv50 atomic world instead of 2
> vtables. But amounts to exactly the same.
> 
> v2: Rebase over the panel/brideg refactorings in stm/ltdc.

s/brideg/bridge

<snip>


> ---
>   drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |  1 -
>   drivers/gpu/drm/bridge/analogix-anx78xx.c          |  1 -
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  1 -
>   drivers/gpu/drm/bridge/dumb-vga-dac.c              |  1 -
>   .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |  1 -
>   drivers/gpu/drm/bridge/nxp-ptn3460.c               |  1 -
>   drivers/gpu/drm/bridge/panel.c                     |  1 -
>   drivers/gpu/drm/bridge/parade-ps8622.c             |  1 -
>   drivers/gpu/drm/bridge/sii902x.c                   |  1 -
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |  1 -
>   drivers/gpu/drm/bridge/tc358767.c                  |  1 -
>   drivers/gpu/drm/bridge/ti-tfp410.c                 |  1 -

For bridge changes:

Acked-by: Archit Taneja <architt@codeaurora.org>

Archit

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
