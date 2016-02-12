From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 01/17] drm/virtio: removed optional dummy encoder mode_fixup
	function.
Date: Fri, 12 Feb 2016 13:50:01 +0000
Message-ID: <1455285017-2771-2-git-send-email-palminha__40378.8140546114$1455287066$gmane$org@synopsys.com>
References: <1455285017-2771-1-git-send-email-palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1455285017-2771-1-git-send-email-palminha@synopsys.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch, lars@metafoo.de, laurent.pinchart@ideasonboard.com
Cc: k.kozlowski@samsung.com, linux-samsung-soc@vger.kernel.org, heiko@sntech.de, benjamin.gaignard@linaro.org, airlied@linux.ie, jingoohan1@gmail.com, CARLOS.PALMINHA@synopsys.com, patrik.r.jakobsson@gmail.com, virtualization@lists.linux-foundation.org, linux-rockchip@lists.infradead.org, kgene@kernel.org, p.zabel@pengutronix.de, vincent.abriou@st.com, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com
List-Id: virtualization@lists.linuxfoundation.org

---
 drivers/gpu/drm/virtio/virtgpu_display.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index a165f03..429aa31 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -282,13 +282,6 @@ static const struct drm_crtc_helper_funcs virtio_gpu_crtc_helper_funcs = {
 	.atomic_check  = virtio_gpu_crtc_atomic_check,
 };
 
-static bool virtio_gpu_enc_mode_fixup(struct drm_encoder *encoder,
-				      const struct drm_display_mode *mode,
-				      struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void virtio_gpu_enc_mode_set(struct drm_encoder *encoder,
 				    struct drm_display_mode *mode,
 				    struct drm_display_mode *adjusted_mode)
@@ -362,7 +355,6 @@ virtio_gpu_best_encoder(struct drm_connector *connector)
 }
 
 static const struct drm_encoder_helper_funcs virtio_gpu_enc_helper_funcs = {
-	.mode_fixup = virtio_gpu_enc_mode_fixup,
 	.mode_set   = virtio_gpu_enc_mode_set,
 	.enable     = virtio_gpu_enc_enable,
 	.disable    = virtio_gpu_enc_disable,
-- 
2.5.0
