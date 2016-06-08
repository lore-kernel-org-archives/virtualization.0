From: Vincent ABRIOU <vincent.abriou@st.com>
Subject: Re: [PATCH v2 11/20] drm: sti: Rely on the default ->best_encoder()
	behavior
Date: Wed, 8 Jun 2016 11:35:40 +0200
Message-ID: <5757E6EC.1050802__36505.9473937892$1465380064$gmane$org@st.com>
References: <1465300095-16971-1-git-send-email-boris.brezillon@free-electrons.com>
	<1465300095-16971-12-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1465300095-16971-12-git-send-email-boris.brezillon@free-electrons.com>
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
To: Boris Brezillon <boris.brezillon@free-electrons.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel.vetter@intel.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Stefan Agner <stefan@agner.ch>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Joonyoung Shim <jy0922.shim@samsung.com>, Alexey Brodkin <abrodkin@synopsys.com>, Kyungmin Park <kyungmin.park@samsung.com>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.
List-Id: virtualization@lists.linuxfoundation.org

Hi Boris,

Thanks for the patch.

Acked-by: Vincent Abriou <vincent.abriou@st.com>

Vincent

On 06/07/2016 01:48 PM, Boris Brezillon wrote:
> All outputs have a 1:1 relationship between connectors and encoders
> and the driver is relying on the atomic helpers: we can drop the custom
> ->best_encoder() implementations and let the core call
> drm_atomic_helper_best_encoder() for us.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>   drivers/gpu/drm/sti/sti_dvo.c  | 10 ----------
>   drivers/gpu/drm/sti/sti_hda.c  | 10 ----------
>   drivers/gpu/drm/sti/sti_hdmi.c | 10 ----------
>   3 files changed, 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
> index 25f7663..d5627d1 100644
> --- a/drivers/gpu/drm/sti/sti_dvo.c
> +++ b/drivers/gpu/drm/sti/sti_dvo.c
> @@ -384,20 +384,10 @@ static int sti_dvo_connector_mode_valid(struct drm_connector *connector,
>   	return MODE_OK;
>   }
>
> -struct drm_encoder *sti_dvo_best_encoder(struct drm_connector *connector)
> -{
> -	struct sti_dvo_connector *dvo_connector
> -		= to_sti_dvo_connector(connector);
> -
> -	/* Best encoder is the one associated during connector creation */
> -	return dvo_connector->encoder;
> -}
> -
>   static const
>   struct drm_connector_helper_funcs sti_dvo_connector_helper_funcs = {
>   	.get_modes = sti_dvo_connector_get_modes,
>   	.mode_valid = sti_dvo_connector_mode_valid,
> -	.best_encoder = sti_dvo_best_encoder,
>   };
>
>   static enum drm_connector_status
> diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
> index f7d3464..c4649f5 100644
> --- a/drivers/gpu/drm/sti/sti_hda.c
> +++ b/drivers/gpu/drm/sti/sti_hda.c
> @@ -676,20 +676,10 @@ static int sti_hda_connector_mode_valid(struct drm_connector *connector,
>   	return MODE_OK;
>   }
>
> -struct drm_encoder *sti_hda_best_encoder(struct drm_connector *connector)
> -{
> -	struct sti_hda_connector *hda_connector
> -		= to_sti_hda_connector(connector);
> -
> -	/* Best encoder is the one associated during connector creation */
> -	return hda_connector->encoder;
> -}
> -
>   static const
>   struct drm_connector_helper_funcs sti_hda_connector_helper_funcs = {
>   	.get_modes = sti_hda_connector_get_modes,
>   	.mode_valid = sti_hda_connector_mode_valid,
> -	.best_encoder = sti_hda_best_encoder,
>   };
>
>   static enum drm_connector_status
> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
> index 6ef0715..dc9ab6e 100644
> --- a/drivers/gpu/drm/sti/sti_hdmi.c
> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> @@ -897,20 +897,10 @@ static int sti_hdmi_connector_mode_valid(struct drm_connector *connector,
>   	return MODE_OK;
>   }
>
> -struct drm_encoder *sti_hdmi_best_encoder(struct drm_connector *connector)
> -{
> -	struct sti_hdmi_connector *hdmi_connector
> -		= to_sti_hdmi_connector(connector);
> -
> -	/* Best encoder is the one associated during connector creation */
> -	return hdmi_connector->encoder;
> -}
> -
>   static const
>   struct drm_connector_helper_funcs sti_hdmi_connector_helper_funcs = {
>   	.get_modes = sti_hdmi_connector_get_modes,
>   	.mode_valid = sti_hdmi_connector_mode_valid,
> -	.best_encoder = sti_hdmi_best_encoder,
>   };
>
>   /* get detection status of display device */
>
