From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 07/20] drm: mediatek: Rely on the default
	->best_encoder() behavior
Date: Wed, 8 Jun 2016 13:17:07 +0200
Message-ID: <5757FEB3.8050001__35229.3093958453$1465487272$gmane$org@gmail.com>
References: <1465300095-16971-1-git-send-email-boris.brezillon@free-electrons.com>
	<1465300095-16971-8-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1465300095-16971-8-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Stefan Agner <stefan@agner.ch>, virtualization@lists.linux-foundation.org, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, Alexey Brodkin <abrodkin@synopsys.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, Inki Dae <inki.dae@samsung.com>, linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org, Vincent
List-Id: virtualization@lists.linuxfoundation.org



On 07/06/16 13:48, Boris Brezillon wrote:
> We have a 1:1 relationship between connectors and encoders and the
> driver is relying on the atomic helpers: we can drop the custom
> ->best_encoder() implementation and let the core call
> drm_atomic_helper_best_encoder() for us.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/gpu/drm/mediatek/mtk_dsi.c | 9 ---------
>   1 file changed, 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 2d808e5..7343ffc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -575,14 +575,6 @@ static int mtk_dsi_connector_get_modes(struct drm_connector *connector)
>   	return drm_panel_get_modes(dsi->panel);
>   }
>
> -static struct drm_encoder *mtk_dsi_connector_best_encoder(
> -		struct drm_connector *connector)
> -{
> -	struct mtk_dsi *dsi = connector_to_dsi(connector);
> -
> -	return &dsi->encoder;
> -}
> -
>   static const struct drm_encoder_helper_funcs mtk_dsi_encoder_helper_funcs = {
>   	.mode_fixup = mtk_dsi_encoder_mode_fixup,
>   	.mode_set = mtk_dsi_encoder_mode_set,
> @@ -603,7 +595,6 @@ static const struct drm_connector_funcs mtk_dsi_connector_funcs = {
>   static const struct drm_connector_helper_funcs
>   	mtk_dsi_connector_helper_funcs = {
>   	.get_modes = mtk_dsi_connector_get_modes,
> -	.best_encoder = mtk_dsi_connector_best_encoder,
>   };
>
>   static int mtk_drm_attach_bridge(struct drm_bridge *bridge,
>
