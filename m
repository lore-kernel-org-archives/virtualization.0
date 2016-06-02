From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 13/20] drm: tegra: Rely on the default ->best_encoder()
	behavior
Date: Thu,  2 Jun 2016 16:31:40 +0200
Message-ID: <1464877907-27723-14-git-send-email-boris.brezillon__11924.0328706384$1464878129$gmane$org@free-electrons.com>
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
->best_encoder() implementation and let the core call
drm_atomic_helper_best_encoder() for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/tegra/drm.h    | 2 --
 drivers/gpu/drm/tegra/dsi.c    | 1 -
 drivers/gpu/drm/tegra/hdmi.c   | 1 -
 drivers/gpu/drm/tegra/output.c | 8 --------
 drivers/gpu/drm/tegra/rgb.c    | 1 -
 drivers/gpu/drm/tegra/sor.c    | 1 -
 6 files changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
index f52d6cb2..0ddcce1 100644
--- a/drivers/gpu/drm/tegra/drm.h
+++ b/drivers/gpu/drm/tegra/drm.h
@@ -239,8 +239,6 @@ int tegra_output_init(struct drm_device *drm, struct tegra_output *output);
 void tegra_output_exit(struct tegra_output *output);
 
 int tegra_output_connector_get_modes(struct drm_connector *connector);
-struct drm_encoder *
-tegra_output_connector_best_encoder(struct drm_connector *connector);
 enum drm_connector_status
 tegra_output_connector_detect(struct drm_connector *connector, bool force);
 void tegra_output_connector_destroy(struct drm_connector *connector);
diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index d1239eb..099cccb 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -794,7 +794,6 @@ tegra_dsi_connector_mode_valid(struct drm_connector *connector,
 static const struct drm_connector_helper_funcs tegra_dsi_connector_helper_funcs = {
 	.get_modes = tegra_output_connector_get_modes,
 	.mode_valid = tegra_dsi_connector_mode_valid,
-	.best_encoder = tegra_output_connector_best_encoder,
 };
 
 static const struct drm_encoder_funcs tegra_dsi_encoder_funcs = {
diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index b7ef492..2fdb879 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -806,7 +806,6 @@ static const struct drm_connector_helper_funcs
 tegra_hdmi_connector_helper_funcs = {
 	.get_modes = tegra_output_connector_get_modes,
 	.mode_valid = tegra_hdmi_connector_mode_valid,
-	.best_encoder = tegra_output_connector_best_encoder,
 };
 
 static const struct drm_encoder_funcs tegra_hdmi_encoder_funcs = {
diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
index 46664b6..1480f6a 100644
--- a/drivers/gpu/drm/tegra/output.c
+++ b/drivers/gpu/drm/tegra/output.c
@@ -42,14 +42,6 @@ int tegra_output_connector_get_modes(struct drm_connector *connector)
 	return err;
 }
 
-struct drm_encoder *
-tegra_output_connector_best_encoder(struct drm_connector *connector)
-{
-	struct tegra_output *output = connector_to_output(connector);
-
-	return &output->encoder;
-}
-
 enum drm_connector_status
 tegra_output_connector_detect(struct drm_connector *connector, bool force)
 {
diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index e246334..a131b44 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -112,7 +112,6 @@ tegra_rgb_connector_mode_valid(struct drm_connector *connector,
 static const struct drm_connector_helper_funcs tegra_rgb_connector_helper_funcs = {
 	.get_modes = tegra_output_connector_get_modes,
 	.mode_valid = tegra_rgb_connector_mode_valid,
-	.best_encoder = tegra_output_connector_best_encoder,
 };
 
 static const struct drm_encoder_funcs tegra_rgb_encoder_funcs = {
diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index 757c6e8..34958d7 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -1087,7 +1087,6 @@ tegra_sor_connector_mode_valid(struct drm_connector *connector,
 static const struct drm_connector_helper_funcs tegra_sor_connector_helper_funcs = {
 	.get_modes = tegra_sor_connector_get_modes,
 	.mode_valid = tegra_sor_connector_mode_valid,
-	.best_encoder = tegra_output_connector_best_encoder,
 };
 
 static const struct drm_encoder_funcs tegra_sor_encoder_funcs = {
-- 
2.7.4
