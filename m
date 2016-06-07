From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 16/20] drm: omap: Rely on the default ->best_encoder()
	behavior
Date: Tue,  7 Jun 2016 13:48:11 +0200
Message-ID: <1465300095-16971-17-git-send-email-boris.brezillon__37974.0983517424$1465300324$gmane$org@free-electrons.com>
References: <1465300095-16971-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1465300095-16971-1-git-send-email-boris.brezillon@free-electrons.com>
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

We have a 1:1 relationship between connectors and encoders and the
driver is relying on the atomic helpers: we can drop the custom
->best_encoder() implementation and let the core call
drm_atomic_helper_best_encoder() for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/gpu/drm/omapdrm/omap_connector.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index ce2d67b..137fe69 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -32,7 +32,6 @@
 struct omap_connector {
 	struct drm_connector base;
 	struct omap_dss_device *dssdev;
-	struct drm_encoder *encoder;
 	bool hdmi_mode;
 };
 
@@ -256,13 +255,6 @@ static int omap_connector_mode_valid(struct drm_connector *connector,
 	return ret;
 }
 
-struct drm_encoder *omap_connector_attached_encoder(
-		struct drm_connector *connector)
-{
-	struct omap_connector *omap_connector = to_omap_connector(connector);
-	return omap_connector->encoder;
-}
-
 static const struct drm_connector_funcs omap_connector_funcs = {
 	.dpms = drm_atomic_helper_connector_dpms,
 	.reset = drm_atomic_helper_connector_reset,
@@ -276,7 +268,6 @@ static const struct drm_connector_funcs omap_connector_funcs = {
 static const struct drm_connector_helper_funcs omap_connector_helper_funcs = {
 	.get_modes = omap_connector_get_modes,
 	.mode_valid = omap_connector_mode_valid,
-	.best_encoder = omap_connector_attached_encoder,
 };
 
 /* initialize connector */
@@ -296,7 +287,6 @@ struct drm_connector *omap_connector_init(struct drm_device *dev,
 		goto fail;
 
 	omap_connector->dssdev = dssdev;
-	omap_connector->encoder = encoder;
 
 	connector = &omap_connector->base;
 
-- 
2.7.4
