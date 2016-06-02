From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 03/20] drm: atmel-hlcdc: Rely on the default ->best_encoder()
	behavior
Date: Thu,  2 Jun 2016 16:31:30 +0200
Message-ID: <1464877907-27723-4-git-send-email-boris.brezillon__22910.2084217176$1464877970$gmane$org@free-electrons.com>
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

We have a 1:1 relationship between connectors and encoders and the
driver is relying on the atomic helpers: we can drop the custom
->best_encoder() and let the core call drm_atomic_helper_best_encoder()
for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
index 39802c0..473a475 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -113,21 +113,9 @@ static int atmel_hlcdc_rgb_mode_valid(struct drm_connector *connector,
 	return atmel_hlcdc_dc_mode_valid(rgb->dc, mode);
 }
 
-
-
-static struct drm_encoder *
-atmel_hlcdc_rgb_best_encoder(struct drm_connector *connector)
-{
-	struct atmel_hlcdc_rgb_output *rgb =
-			drm_connector_to_atmel_hlcdc_rgb_output(connector);
-
-	return &rgb->encoder;
-}
-
 static const struct drm_connector_helper_funcs atmel_hlcdc_panel_connector_helper_funcs = {
 	.get_modes = atmel_hlcdc_panel_get_modes,
 	.mode_valid = atmel_hlcdc_rgb_mode_valid,
-	.best_encoder = atmel_hlcdc_rgb_best_encoder,
 };
 
 static enum drm_connector_status
-- 
2.7.4
