From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 20/20] drm/bridge: dw-hdmi: Use
	drm_atomic_helper_best_encoder()
Date: Tue,  7 Jun 2016 13:48:15 +0200
Message-ID: <1465300095-16971-21-git-send-email-boris.brezillon__15591.3791539662$1465300397$gmane$org@free-electrons.com>
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

We have a 1:1 relationship between connectors and encoders, which means
we can rely on the drm_atomic_helper_best_encoder() behavior.

We still have to explicitly assign ->best_encoder() to
drm_atomic_helper_best_encoder(), because the automated fallback to
drm_atomic_helper_best_encoder() when ->best_encoder() is NULL is only
available when the DRM device is using the atomic helpers, and this bridge
is compatible with non-atomic and atomic devices.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/bridge/dw-hdmi.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw-hdmi.c b/drivers/gpu/drm/bridge/dw-hdmi.c
index c9d9412..70b1f7d 100644
--- a/drivers/gpu/drm/bridge/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/dw-hdmi.c
@@ -1476,15 +1476,6 @@ dw_hdmi_connector_mode_valid(struct drm_connector *connector,
 	return mode_status;
 }
 
-static struct drm_encoder *dw_hdmi_connector_best_encoder(struct drm_connector
-							   *connector)
-{
-	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
-					     connector);
-
-	return hdmi->encoder;
-}
-
 static void dw_hdmi_connector_destroy(struct drm_connector *connector)
 {
 	drm_connector_unregister(connector);
@@ -1525,7 +1516,7 @@ static const struct drm_connector_funcs dw_hdmi_atomic_connector_funcs = {
 static const struct drm_connector_helper_funcs dw_hdmi_connector_helper_funcs = {
 	.get_modes = dw_hdmi_connector_get_modes,
 	.mode_valid = dw_hdmi_connector_mode_valid,
-	.best_encoder = dw_hdmi_connector_best_encoder,
+	.best_encoder = drm_atomic_helper_best_encoder,
 };
 
 static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
-- 
2.7.4
