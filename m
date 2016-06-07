From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 05/20] drm: fsl-dcu: Rely on the default ->best_encoder()
	behavior
Date: Tue,  7 Jun 2016 13:48:00 +0200
Message-ID: <1465300095-16971-6-git-send-email-boris.brezillon__44639.1569487334$1465300226$gmane$org@free-electrons.com>
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
->best_encoder() and let the core call drm_atomic_helper_best_encoder()
for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
index 98c998d..0b0989e 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
@@ -102,14 +102,6 @@ static const struct drm_connector_funcs fsl_dcu_drm_connector_funcs = {
 	.reset = drm_atomic_helper_connector_reset,
 };
 
-static struct drm_encoder *
-fsl_dcu_drm_connector_best_encoder(struct drm_connector *connector)
-{
-	struct fsl_dcu_drm_connector *fsl_con = to_fsl_dcu_connector(connector);
-
-	return fsl_con->encoder;
-}
-
 static int fsl_dcu_drm_connector_get_modes(struct drm_connector *connector)
 {
 	struct fsl_dcu_drm_connector *fsl_connector;
@@ -136,7 +128,6 @@ static int fsl_dcu_drm_connector_mode_valid(struct drm_connector *connector,
 }
 
 static const struct drm_connector_helper_funcs connector_helper_funcs = {
-	.best_encoder = fsl_dcu_drm_connector_best_encoder,
 	.get_modes = fsl_dcu_drm_connector_get_modes,
 	.mode_valid = fsl_dcu_drm_connector_mode_valid,
 };
-- 
2.7.4
