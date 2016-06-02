From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 19/20] drm/bridge: ps8622: Rely on the default
	->best_encoder() behavior
Date: Thu,  2 Jun 2016 16:31:46 +0200
Message-ID: <1464877907-27723-20-git-send-email-boris.brezillon__20711.2532495104$1464878202$gmane$org@free-electrons.com>
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

We have a 1:1 relationship between connectors and encoders, and the driver
is relying on the atomic helpers: we can drop the custom ->best_encoder(),
and let the core call drm_atomic_helper_best_encoder() for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/bridge/parade-ps8622.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridge/parade-ps8622.c
index be881e9..5cd8dd7 100644
--- a/drivers/gpu/drm/bridge/parade-ps8622.c
+++ b/drivers/gpu/drm/bridge/parade-ps8622.c
@@ -474,18 +474,8 @@ static int ps8622_get_modes(struct drm_connector *connector)
 	return drm_panel_get_modes(ps8622->panel);
 }
 
-static struct drm_encoder *ps8622_best_encoder(struct drm_connector *connector)
-{
-	struct ps8622_bridge *ps8622;
-
-	ps8622 = connector_to_ps8622(connector);
-
-	return ps8622->bridge.encoder;
-}
-
 static const struct drm_connector_helper_funcs ps8622_connector_helper_funcs = {
 	.get_modes = ps8622_get_modes,
-	.best_encoder = ps8622_best_encoder,
 };
 
 static enum drm_connector_status ps8622_detect(struct drm_connector *connector,
-- 
2.7.4
