From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 14/20] drm: vc4: Rely on the default ->best_encoder()
	behavior
Date: Tue,  7 Jun 2016 13:48:09 +0200
Message-ID: <1465300095-16971-15-git-send-email-boris.brezillon__9792.78870295293$1465300339$gmane$org@free-electrons.com>
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

All outputs have a 1:1 relationship between connectors and encoders and
the driver is relying on the atomic helpers: we can drop the custom
->best_encoder() implementations and let the core call
drm_atomic_helper_best_encoder() for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/vc4/vc4_dpi.c  | 9 ---------
 drivers/gpu/drm/vc4/vc4_hdmi.c | 9 ---------
 2 files changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dpi.c b/drivers/gpu/drm/vc4/vc4_dpi.c
index 9817dbf..dba1114 100644
--- a/drivers/gpu/drm/vc4/vc4_dpi.c
+++ b/drivers/gpu/drm/vc4/vc4_dpi.c
@@ -208,14 +208,6 @@ static int vc4_dpi_connector_get_modes(struct drm_connector *connector)
 	return 0;
 }
 
-static struct drm_encoder *
-vc4_dpi_connector_best_encoder(struct drm_connector *connector)
-{
-	struct vc4_dpi_connector *dpi_connector =
-		to_vc4_dpi_connector(connector);
-	return dpi_connector->encoder;
-}
-
 static const struct drm_connector_funcs vc4_dpi_connector_funcs = {
 	.dpms = drm_atomic_helper_connector_dpms,
 	.detect = vc4_dpi_connector_detect,
@@ -228,7 +220,6 @@ static const struct drm_connector_funcs vc4_dpi_connector_funcs = {
 
 static const struct drm_connector_helper_funcs vc4_dpi_connector_helper_funcs = {
 	.get_modes = vc4_dpi_connector_get_modes,
-	.best_encoder = vc4_dpi_connector_best_encoder,
 };
 
 static struct drm_connector *vc4_dpi_connector_init(struct drm_device *dev,
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index fd2644d..68df91c 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -208,14 +208,6 @@ static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
-static struct drm_encoder *
-vc4_hdmi_connector_best_encoder(struct drm_connector *connector)
-{
-	struct vc4_hdmi_connector *hdmi_connector =
-		to_vc4_hdmi_connector(connector);
-	return hdmi_connector->encoder;
-}
-
 static const struct drm_connector_funcs vc4_hdmi_connector_funcs = {
 	.dpms = drm_atomic_helper_connector_dpms,
 	.detect = vc4_hdmi_connector_detect,
@@ -228,7 +220,6 @@ static const struct drm_connector_funcs vc4_hdmi_connector_funcs = {
 
 static const struct drm_connector_helper_funcs vc4_hdmi_connector_helper_funcs = {
 	.get_modes = vc4_hdmi_connector_get_modes,
-	.best_encoder = vc4_hdmi_connector_best_encoder,
 };
 
 static struct drm_connector *vc4_hdmi_connector_init(struct drm_device *dev,
-- 
2.7.4
