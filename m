From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 02/20] drm: arc: Rely on the default ->best_encoder()
	behavior
Date: Tue,  7 Jun 2016 13:47:57 +0200
Message-ID: <1465300095-16971-3-git-send-email-boris.brezillon__46762.9243423746$1465300149$gmane$org@free-electrons.com>
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
->best_encoder(), and let the core call drm_atomic_helper_best_encoder()
for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/arc/arcpgu_hdmi.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/arc/arcpgu_hdmi.c b/drivers/gpu/drm/arc/arcpgu_hdmi.c
index 08b6bae..b7a8b2a 100644
--- a/drivers/gpu/drm/arc/arcpgu_hdmi.c
+++ b/drivers/gpu/drm/arc/arcpgu_hdmi.c
@@ -46,23 +46,6 @@ static int arcpgu_drm_connector_get_modes(struct drm_connector *connector)
 	return sfuncs->get_modes(&slave->base, connector);
 }
 
-struct drm_encoder *
-arcpgu_drm_connector_best_encoder(struct drm_connector *connector)
-{
-	struct drm_encoder_slave *slave;
-	struct arcpgu_drm_connector *con =
-		container_of(connector, struct arcpgu_drm_connector, connector);
-
-	slave = con->encoder_slave;
-	if (slave == NULL) {
-		dev_err(connector->dev->dev,
-			"connector_best_encoder: cannot find slave encoder for connector\n");
-		return NULL;
-	}
-
-	return &slave->base;
-}
-
 static enum drm_connector_status
 arcpgu_drm_connector_detect(struct drm_connector *connector, bool force)
 {
@@ -97,7 +80,6 @@ static void arcpgu_drm_connector_destroy(struct drm_connector *connector)
 static const struct drm_connector_helper_funcs
 arcpgu_drm_connector_helper_funcs = {
 	.get_modes = arcpgu_drm_connector_get_modes,
-	.best_encoder = arcpgu_drm_connector_best_encoder,
 };
 
 static const struct drm_connector_funcs arcpgu_drm_connector_funcs = {
-- 
2.7.4
