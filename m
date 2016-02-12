From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 04/17] drm/amdgpu: removed optional dummy encoder mode_fixup
	function.
Date: Fri, 12 Feb 2016 13:50:56 +0000
Message-ID: <1455285069-2819-5-git-send-email-palminha__21695.1689254076$1455287017$gmane$org@synopsys.com>
References: <daniel.vetter@ffwll.ch,>
	<1455285069-2819-1-git-send-email-palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1455285069-2819-1-git-send-email-palminha@synopsys.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org
Cc: k.kozlowski@samsung.com, linux-samsung-soc@vger.kernel.org, heiko@sntech.de, benjamin.gaignard@linaro.org, airlied@linux.ie, jingoohan1@gmail.com, CARLOS.PALMINHA@synopsys.com, patrik.r.jakobsson@gmail.com, virtualization@lists.linux-foundation.org, linux-rockchip@lists.infradead.org, kgene@kernel.org, p.zabel@pengutronix.de, vincent.abriou@st.com, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com
List-Id: virtualization@lists.linuxfoundation.org

---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 8 --------
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c | 8 --------
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 8 --------
 3 files changed, 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 093599a..3483018 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -3624,16 +3624,8 @@ dce_v10_0_ext_dpms(struct drm_encoder *encoder, int mode)
 
 }
 
-static bool dce_v10_0_ext_mode_fixup(struct drm_encoder *encoder,
-				    const struct drm_display_mode *mode,
-				    struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static const struct drm_encoder_helper_funcs dce_v10_0_ext_helper_funcs = {
 	.dpms = dce_v10_0_ext_dpms,
-	.mode_fixup = dce_v10_0_ext_mode_fixup,
 	.prepare = dce_v10_0_ext_prepare,
 	.mode_set = dce_v10_0_ext_mode_set,
 	.commit = dce_v10_0_ext_commit,
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 8e67249..36deea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -3619,16 +3619,8 @@ dce_v11_0_ext_dpms(struct drm_encoder *encoder, int mode)
 
 }
 
-static bool dce_v11_0_ext_mode_fixup(struct drm_encoder *encoder,
-				    const struct drm_display_mode *mode,
-				    struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static const struct drm_encoder_helper_funcs dce_v11_0_ext_helper_funcs = {
 	.dpms = dce_v11_0_ext_dpms,
-	.mode_fixup = dce_v11_0_ext_mode_fixup,
 	.prepare = dce_v11_0_ext_prepare,
 	.mode_set = dce_v11_0_ext_mode_set,
 	.commit = dce_v11_0_ext_commit,
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index d0e128c..25dd8b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -3554,16 +3554,8 @@ dce_v8_0_ext_dpms(struct drm_encoder *encoder, int mode)
 
 }
 
-static bool dce_v8_0_ext_mode_fixup(struct drm_encoder *encoder,
-				    const struct drm_display_mode *mode,
-				    struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static const struct drm_encoder_helper_funcs dce_v8_0_ext_helper_funcs = {
 	.dpms = dce_v8_0_ext_dpms,
-	.mode_fixup = dce_v8_0_ext_mode_fixup,
 	.prepare = dce_v8_0_ext_prepare,
 	.mode_set = dce_v8_0_ext_mode_set,
 	.commit = dce_v8_0_ext_commit,
-- 
2.5.0
