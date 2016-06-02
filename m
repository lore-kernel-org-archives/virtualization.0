From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 12/20] drm: sun4i: Rely on the default ->best_encoder()
	behavior
Date: Thu,  2 Jun 2016 16:31:39 +0200
Message-ID: <1464877907-27723-13-git-send-email-boris.brezillon__26089.4316169017$1464878113$gmane$org@free-electrons.com>
References: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Stefan Agner <stefan@agner.ch>, virtualization@lists.linux-foundation.org, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Alexey Brodkin <abrodkin@synopsys.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, linux-tegra@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, Inki Dae <inki.dae@sam>
List-Id: virtualization@lists.linuxfoundation.org

All outputs have a 1:1 relationship between connectors and encoders
and the driver is relying on the atomic helpers: we can drop the custom
->best_encoder() implementations and let the core call
drm_atomic_helper_best_encoder() for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c | 10 ----------
 drivers/gpu/drm/sun4i/sun4i_tv.c  |  9 ---------
 2 files changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index ab64948..442cfe2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -90,19 +90,9 @@ static int sun4i_rgb_mode_valid(struct drm_connector *connector,
 	return MODE_OK;
 }
 
-static struct drm_encoder *
-sun4i_rgb_best_encoder(struct drm_connector *connector)
-{
-	struct sun4i_rgb *rgb =
-		drm_connector_to_sun4i_rgb(connector);
-
-	return &rgb->encoder;
-}
-
 static struct drm_connector_helper_funcs sun4i_rgb_con_helper_funcs = {
 	.get_modes	= sun4i_rgb_get_modes,
 	.mode_valid	= sun4i_rgb_mode_valid,
-	.best_encoder	= sun4i_rgb_best_encoder,
 };
 
 static enum drm_connector_status
diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index bc047f9..b841478 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -526,18 +526,9 @@ static int sun4i_tv_comp_mode_valid(struct drm_connector *connector,
 	return MODE_OK;
 }
 
-static struct drm_encoder *
-sun4i_tv_comp_best_encoder(struct drm_connector *connector)
-{
-	struct sun4i_tv *tv = drm_connector_to_sun4i_tv(connector);
-
-	return &tv->encoder;
-}
-
 static struct drm_connector_helper_funcs sun4i_tv_comp_connector_helper_funcs = {
 	.get_modes	= sun4i_tv_comp_get_modes,
 	.mode_valid	= sun4i_tv_comp_mode_valid,
-	.best_encoder	= sun4i_tv_comp_best_encoder,
 };
 
 static enum drm_connector_status
-- 
2.7.4
