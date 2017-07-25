From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 7/8] drm: Nuke drm_atomic_helper_connector_dpms
Date: Tue, 25 Jul 2017 10:59:17 +0200
Message-ID: <1500973157.4101.13.camel__17717.7713755102$1500974578$gmane$org@pengutronix.de>
References: <20170725080122.20548-1-daniel.vetter@ffwll.ch>
	<20170725080122.20548-8-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170725080122.20548-8-daniel.vetter@ffwll.ch>
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
Cc: Martyn Welch <martyn.welch@collabora.co.uk>, Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Andrzej Hajda <a.hajda@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-mediatek@lists.infradead.org, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Romain Perier <romain.perier@collabora.com>, Daniel Vetter <daniel.vetter@intel.com>, Jyri Sarha <jsarha@ti.com>, Heiko Stuebner <heiko@sntech.de>, Marek Vasut <marex@denx.de>, linux-renesas-soc@vger.kernel.org, Archit Taneja <architt@codeaurora.org>, Lars-Peter Clausen <lars@metafoo.de>, Joonyoung Shim <jy0922.shim@samsung.com>, Kevin Hilman <khilman@baylibre.com>, Alexey Brodkin <abrodkin@synopsys.com>, Russell
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2017-07-25 at 10:01 +0200, Daniel Vetter wrote:
> It's dead code, the core handles all this directly now.
> 
> The only special case is nouveau and tda988x which used one function
> for both legacy modeset code and -nv50 atomic world instead of 2
> vtables. But amounts to exactly the same.
> 
> v2: Rebase over the panel/brideg refactorings in stm/ltdc.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
[...]
>  drivers/gpu/drm/imx/imx-ldb.c                      |  1 -
>  drivers/gpu/drm/imx/imx-tve.c                      |  1 -
>  drivers/gpu/drm/imx/parallel-display.c             |  1 -
>  drivers/gpu/drm/mediatek/mtk_dsi.c                 |  1 -
>  drivers/gpu/drm/mediatek/mtk_hdmi.c                |  1 -

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
