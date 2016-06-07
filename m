From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 11/20] drm: sti: Rely on the default ->best_encoder()
	behavior
Date: Tue,  7 Jun 2016 13:48:06 +0200
Message-ID: <1465300095-16971-12-git-send-email-boris.brezillon__8004.97852401367$1465300317$gmane$org@free-electrons.com>
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

All outputs have a 1:1 relationship between connectors and encoders
and the driver is relying on the atomic helpers: we can drop the custom
->best_encoder() implementations and let the core call
drm_atomic_helper_best_encoder() for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/sti/sti_dvo.c  | 10 ----------
 drivers/gpu/drm/sti/sti_hda.c  | 10 ----------
 drivers/gpu/drm/sti/sti_hdmi.c | 10 ----------
 3 files changed, 30 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
index 25f7663..d5627d1 100644
--- a/drivers/gpu/drm/sti/sti_dvo.c
+++ b/drivers/gpu/drm/sti/sti_dvo.c
@@ -384,20 +384,10 @@ static int sti_dvo_connector_mode_valid(struct drm_connector *connector,
 	return MODE_OK;
 }
 
-struct drm_encoder *sti_dvo_best_encoder(struct drm_connector *connector)
-{
-	struct sti_dvo_connector *dvo_connector
-		= to_sti_dvo_connector(connector);
-
-	/* Best encoder is the one associated during connector creation */
-	return dvo_connector->encoder;
-}
-
 static const
 struct drm_connector_helper_funcs sti_dvo_connector_helper_funcs = {
 	.get_modes = sti_dvo_connector_get_modes,
 	.mode_valid = sti_dvo_connector_mode_valid,
-	.best_encoder = sti_dvo_best_encoder,
 };
 
 static enum drm_connector_status
diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index f7d3464..c4649f5 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -676,20 +676,10 @@ static int sti_hda_connector_mode_valid(struct drm_connector *connector,
 	return MODE_OK;
 }
 
-struct drm_encoder *sti_hda_best_encoder(struct drm_connector *connector)
-{
-	struct sti_hda_connector *hda_connector
-		= to_sti_hda_connector(connector);
-
-	/* Best encoder is the one associated during connector creation */
-	return hda_connector->encoder;
-}
-
 static const
 struct drm_connector_helper_funcs sti_hda_connector_helper_funcs = {
 	.get_modes = sti_hda_connector_get_modes,
 	.mode_valid = sti_hda_connector_mode_valid,
-	.best_encoder = sti_hda_best_encoder,
 };
 
 static enum drm_connector_status
diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 6ef0715..dc9ab6e 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -897,20 +897,10 @@ static int sti_hdmi_connector_mode_valid(struct drm_connector *connector,
 	return MODE_OK;
 }
 
-struct drm_encoder *sti_hdmi_best_encoder(struct drm_connector *connector)
-{
-	struct sti_hdmi_connector *hdmi_connector
-		= to_sti_hdmi_connector(connector);
-
-	/* Best encoder is the one associated during connector creation */
-	return hdmi_connector->encoder;
-}
-
 static const
 struct drm_connector_helper_funcs sti_hdmi_connector_helper_funcs = {
 	.get_modes = sti_hdmi_connector_get_modes,
 	.mode_valid = sti_hdmi_connector_mode_valid,
-	.best_encoder = sti_hdmi_best_encoder,
 };
 
 /* get detection status of display device */
-- 
2.7.4
