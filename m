From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 04/20] drm: exynos: Rely on the default ->best_encoder()
	behavior
Date: Thu,  2 Jun 2016 16:31:31 +0200
Message-ID: <1464877907-27723-5-git-send-email-boris.brezillon__11896.6533024379$1464878005$gmane$org@free-electrons.com>
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

We have 1:1 relationship between connectors and encoders and the driver
is relying on the atomic helpers: we can drop the custom ->best_encoder()
implementations and let the core call drm_atomic_helper_best_encoder()
for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dpi.c  | 9 ---------
 drivers/gpu/drm/exynos/exynos_drm_dsi.c  | 9 ---------
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 8 --------
 drivers/gpu/drm/exynos/exynos_hdmi.c     | 8 --------
 4 files changed, 34 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dpi.c b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
index 5e38e74..ad6b73c 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dpi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
@@ -93,17 +93,8 @@ static int exynos_dpi_get_modes(struct drm_connector *connector)
 	return 0;
 }
 
-static struct drm_encoder *
-exynos_dpi_best_encoder(struct drm_connector *connector)
-{
-	struct exynos_dpi *ctx = connector_to_dpi(connector);
-
-	return &ctx->encoder;
-}
-
 static const struct drm_connector_helper_funcs exynos_dpi_connector_helper_funcs = {
 	.get_modes = exynos_dpi_get_modes,
-	.best_encoder = exynos_dpi_best_encoder,
 };
 
 static int exynos_dpi_create_connector(struct drm_encoder *encoder)
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 601ecf8..e07cb1f 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1566,17 +1566,8 @@ static int exynos_dsi_get_modes(struct drm_connector *connector)
 	return 0;
 }
 
-static struct drm_encoder *
-exynos_dsi_best_encoder(struct drm_connector *connector)
-{
-	struct exynos_dsi *dsi = connector_to_dsi(connector);
-
-	return &dsi->encoder;
-}
-
 static const struct drm_connector_helper_funcs exynos_dsi_connector_helper_funcs = {
 	.get_modes = exynos_dsi_get_modes,
-	.best_encoder = exynos_dsi_best_encoder,
 };
 
 static int exynos_dsi_create_connector(struct drm_encoder *encoder)
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 608b0af..e8f6c92 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -378,16 +378,8 @@ static int vidi_get_modes(struct drm_connector *connector)
 	return drm_add_edid_modes(connector, edid);
 }
 
-static struct drm_encoder *vidi_best_encoder(struct drm_connector *connector)
-{
-	struct vidi_context *ctx = ctx_from_connector(connector);
-
-	return &ctx->encoder;
-}
-
 static const struct drm_connector_helper_funcs vidi_connector_helper_funcs = {
 	.get_modes = vidi_get_modes,
-	.best_encoder = vidi_best_encoder,
 };
 
 static int vidi_create_connector(struct drm_encoder *encoder)
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 58de5a4..1625d7c 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -937,17 +937,9 @@ static int hdmi_mode_valid(struct drm_connector *connector,
 	return MODE_OK;
 }
 
-static struct drm_encoder *hdmi_best_encoder(struct drm_connector *connector)
-{
-	struct hdmi_context *hdata = connector_to_hdmi(connector);
-
-	return &hdata->encoder;
-}
-
 static const struct drm_connector_helper_funcs hdmi_connector_helper_funcs = {
 	.get_modes = hdmi_get_modes,
 	.mode_valid = hdmi_mode_valid,
-	.best_encoder = hdmi_best_encoder,
 };
 
 static int hdmi_create_connector(struct drm_encoder *encoder)
-- 
2.7.4
