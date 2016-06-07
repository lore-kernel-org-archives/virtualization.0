From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 18/20] drm/bridge: ptn3460: Rely on the default
	->best_encoder() behavior
Date: Tue,  7 Jun 2016 13:48:13 +0200
Message-ID: <1465300095-16971-19-git-send-email-boris.brezillon__10991.6084948511$1465300355$gmane$org@free-electrons.com>
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

We have a 1:1 relationship between connectors and encoders, and the driver
is relying on the atomic helpers: we can drop the custom ->best_encoder(),
and let the core call drm_atomic_helper_best_encoder() for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/bridge/nxp-ptn3460.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
index 7ecd59f..93f3dac 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -235,16 +235,8 @@ out:
 	return num_modes;
 }
 
-static struct drm_encoder *ptn3460_best_encoder(struct drm_connector *connector)
-{
-	struct ptn3460_bridge *ptn_bridge = connector_to_ptn3460(connector);
-
-	return ptn_bridge->bridge.encoder;
-}
-
 static const struct drm_connector_helper_funcs ptn3460_connector_helper_funcs = {
 	.get_modes = ptn3460_get_modes,
-	.best_encoder = ptn3460_best_encoder,
 };
 
 static enum drm_connector_status ptn3460_detect(struct drm_connector *connector,
-- 
2.7.4
