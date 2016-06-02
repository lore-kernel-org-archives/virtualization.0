From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 06/20] drm: i915: Rely on the default ->best_encoder()
	behavior where appropriate
Date: Thu,  2 Jun 2016 16:31:33 +0200
Message-ID: <1464877907-27723-7-git-send-email-boris.brezillon__33118.7562704601$1464878010$gmane$org@free-electrons.com>
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

For all outputs except dp_mst, we have a 1:1 relationship between
connectors and encoders and the driver is relying on the atomic helpers:
we can drop the custom ->best_encoder() implementation and let the core
call drm_atomic_helper_best_encoder() for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/i915/intel_crt.c     | 1 -
 drivers/gpu/drm/i915/intel_display.c | 8 --------
 drivers/gpu/drm/i915/intel_dp.c      | 1 -
 drivers/gpu/drm/i915/intel_drv.h     | 1 -
 drivers/gpu/drm/i915/intel_dsi.c     | 1 -
 drivers/gpu/drm/i915/intel_dvo.c     | 1 -
 drivers/gpu/drm/i915/intel_hdmi.c    | 1 -
 drivers/gpu/drm/i915/intel_lvds.c    | 1 -
 drivers/gpu/drm/i915/intel_sdvo.c    | 1 -
 drivers/gpu/drm/i915/intel_tv.c      | 1 -
 10 files changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_crt.c b/drivers/gpu/drm/i915/intel_crt.c
index 3fbb6fc..bd0cd68 100644
--- a/drivers/gpu/drm/i915/intel_crt.c
+++ b/drivers/gpu/drm/i915/intel_crt.c
@@ -753,7 +753,6 @@ static const struct drm_connector_funcs intel_crt_connector_funcs = {
 static const struct drm_connector_helper_funcs intel_crt_connector_helper_funcs = {
 	.mode_valid = intel_crt_mode_valid,
 	.get_modes = intel_crt_get_modes,
-	.best_encoder = intel_best_encoder,
 };
 
 static const struct drm_encoder_funcs intel_crt_enc_funcs = {
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index 2113f40..77026ce 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -16113,14 +16113,6 @@ void intel_modeset_cleanup(struct drm_device *dev)
 	intel_teardown_gmbus(dev);
 }
 
-/*
- * Return which encoder is currently attached for connector.
- */
-struct drm_encoder *intel_best_encoder(struct drm_connector *connector)
-{
-	return &intel_attached_encoder(connector)->base;
-}
-
 void intel_connector_attach_encoder(struct intel_connector *connector,
 				    struct intel_encoder *encoder)
 {
diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
index f192f58..21b2833 100644
--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -4935,7 +4935,6 @@ static const struct drm_connector_funcs intel_dp_connector_funcs = {
 static const struct drm_connector_helper_funcs intel_dp_connector_helper_funcs = {
 	.get_modes = intel_dp_get_modes,
 	.mode_valid = intel_dp_mode_valid,
-	.best_encoder = intel_best_encoder,
 };
 
 static const struct drm_encoder_funcs intel_dp_enc_funcs = {
diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
index a28b4aa..79a4d6b 100644
--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -1128,7 +1128,6 @@ struct intel_connector *intel_connector_alloc(void);
 bool intel_connector_get_hw_state(struct intel_connector *connector);
 void intel_connector_attach_encoder(struct intel_connector *connector,
 				    struct intel_encoder *encoder);
-struct drm_encoder *intel_best_encoder(struct drm_connector *connector);
 struct drm_display_mode *intel_crtc_mode_get(struct drm_device *dev,
 					     struct drm_crtc *crtc);
 enum pipe intel_get_pipe_from_connector(struct intel_connector *connector);
diff --git a/drivers/gpu/drm/i915/intel_dsi.c b/drivers/gpu/drm/i915/intel_dsi.c
index 366ad6c..ec51952 100644
--- a/drivers/gpu/drm/i915/intel_dsi.c
+++ b/drivers/gpu/drm/i915/intel_dsi.c
@@ -1378,7 +1378,6 @@ static const struct drm_encoder_funcs intel_dsi_funcs = {
 static const struct drm_connector_helper_funcs intel_dsi_connector_helper_funcs = {
 	.get_modes = intel_dsi_get_modes,
 	.mode_valid = intel_dsi_mode_valid,
-	.best_encoder = intel_best_encoder,
 };
 
 static const struct drm_connector_funcs intel_dsi_connector_funcs = {
diff --git a/drivers/gpu/drm/i915/intel_dvo.c b/drivers/gpu/drm/i915/intel_dvo.c
index 286baec..34b7e3f 100644
--- a/drivers/gpu/drm/i915/intel_dvo.c
+++ b/drivers/gpu/drm/i915/intel_dvo.c
@@ -351,7 +351,6 @@ static const struct drm_connector_funcs intel_dvo_connector_funcs = {
 static const struct drm_connector_helper_funcs intel_dvo_connector_helper_funcs = {
 	.mode_valid = intel_dvo_mode_valid,
 	.get_modes = intel_dvo_get_modes,
-	.best_encoder = intel_best_encoder,
 };
 
 static void intel_dvo_enc_destroy(struct drm_encoder *encoder)
diff --git a/drivers/gpu/drm/i915/intel_hdmi.c b/drivers/gpu/drm/i915/intel_hdmi.c
index 2c3bd9c..aef4bc8 100644
--- a/drivers/gpu/drm/i915/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/intel_hdmi.c
@@ -2114,7 +2114,6 @@ static const struct drm_connector_funcs intel_hdmi_connector_funcs = {
 static const struct drm_connector_helper_funcs intel_hdmi_connector_helper_funcs = {
 	.get_modes = intel_hdmi_get_modes,
 	.mode_valid = intel_hdmi_mode_valid,
-	.best_encoder = intel_best_encoder,
 };
 
 static const struct drm_encoder_funcs intel_hdmi_enc_funcs = {
diff --git a/drivers/gpu/drm/i915/intel_lvds.c b/drivers/gpu/drm/i915/intel_lvds.c
index bc53c0d..d4faa5a 100644
--- a/drivers/gpu/drm/i915/intel_lvds.c
+++ b/drivers/gpu/drm/i915/intel_lvds.c
@@ -547,7 +547,6 @@ static int intel_lvds_set_property(struct drm_connector *connector,
 static const struct drm_connector_helper_funcs intel_lvds_connector_helper_funcs = {
 	.get_modes = intel_lvds_get_modes,
 	.mode_valid = intel_lvds_mode_valid,
-	.best_encoder = intel_best_encoder,
 };
 
 static const struct drm_connector_funcs intel_lvds_connector_funcs = {
diff --git a/drivers/gpu/drm/i915/intel_sdvo.c b/drivers/gpu/drm/i915/intel_sdvo.c
index 2128fae..5cd48ff 100644
--- a/drivers/gpu/drm/i915/intel_sdvo.c
+++ b/drivers/gpu/drm/i915/intel_sdvo.c
@@ -2191,7 +2191,6 @@ static const struct drm_connector_funcs intel_sdvo_connector_funcs = {
 static const struct drm_connector_helper_funcs intel_sdvo_connector_helper_funcs = {
 	.get_modes = intel_sdvo_get_modes,
 	.mode_valid = intel_sdvo_mode_valid,
-	.best_encoder = intel_best_encoder,
 };
 
 static void intel_sdvo_enc_destroy(struct drm_encoder *encoder)
diff --git a/drivers/gpu/drm/i915/intel_tv.c b/drivers/gpu/drm/i915/intel_tv.c
index 223129d..47fe241 100644
--- a/drivers/gpu/drm/i915/intel_tv.c
+++ b/drivers/gpu/drm/i915/intel_tv.c
@@ -1512,7 +1512,6 @@ static const struct drm_connector_funcs intel_tv_connector_funcs = {
 static const struct drm_connector_helper_funcs intel_tv_connector_helper_funcs = {
 	.mode_valid = intel_tv_mode_valid,
 	.get_modes = intel_tv_get_modes,
-	.best_encoder = intel_best_encoder,
 };
 
 static const struct drm_encoder_funcs intel_tv_enc_funcs = {
-- 
2.7.4
