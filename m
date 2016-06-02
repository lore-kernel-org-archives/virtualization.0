From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 15/20] drm: virtgpu: Rely on the default ->best_encoder()
	behavior
Date: Thu,  2 Jun 2016 16:31:42 +0200
Message-ID: <1464877907-27723-16-git-send-email-boris.brezillon__5337.64608339897$1464878142$gmane$org@free-electrons.com>
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

The virtgpu output exposes a 1:1 relationship between connectors and
encoders and the driver is relying on the atomic helpers: we can drop
the custom ->best_encoder() implementation and let the core call
drm_atomic_helper_best_encoder() for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index d4305da..4d41dcb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -341,15 +341,6 @@ static int virtio_gpu_conn_mode_valid(struct drm_connector *connector,
 	return MODE_BAD;
 }
 
-static struct drm_encoder*
-virtio_gpu_best_encoder(struct drm_connector *connector)
-{
-	struct virtio_gpu_output *virtio_gpu_output =
-		drm_connector_to_virtio_gpu_output(connector);
-
-	return &virtio_gpu_output->enc;
-}
-
 static const struct drm_encoder_helper_funcs virtio_gpu_enc_helper_funcs = {
 	.mode_set   = virtio_gpu_enc_mode_set,
 	.enable     = virtio_gpu_enc_enable,
@@ -359,7 +350,6 @@ static const struct drm_encoder_helper_funcs virtio_gpu_enc_helper_funcs = {
 static const struct drm_connector_helper_funcs virtio_gpu_conn_helper_funcs = {
 	.get_modes    = virtio_gpu_conn_get_modes,
 	.mode_valid   = virtio_gpu_conn_mode_valid,
-	.best_encoder = virtio_gpu_best_encoder,
 };
 
 static enum drm_connector_status virtio_gpu_conn_detect(
-- 
2.7.4
