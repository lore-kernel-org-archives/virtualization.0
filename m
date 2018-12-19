From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 04/14] drm/bochs: atomic: add mode_set_nofb callback.
Date: Wed, 19 Dec 2018 12:51:17 +0100
Message-ID: <20181219115127.31359-5-kraxel@redhat.com>
References: <20181219115127.31359-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181219115127.31359-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Conversion to atomic modesetting, step two.
Add mode_set_nofb crtc helper callback.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_kms.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 59d469f343..18b705fb0b 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -86,6 +86,14 @@ static int bochs_crtc_mode_set(struct drm_crtc *crtc,
 	return 0;
 }
 
+static void bochs_crtc_mode_set_nofb(struct drm_crtc *crtc)
+{
+	struct bochs_device *bochs =
+		container_of(crtc, struct bochs_device, crtc);
+
+	bochs_hw_setmode(bochs, &crtc->mode);
+}
+
 static void bochs_crtc_prepare(struct drm_crtc *crtc)
 {
 }
@@ -149,6 +157,7 @@ static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
 	.dpms = bochs_crtc_dpms,
 	.mode_set = bochs_crtc_mode_set,
 	.mode_set_base = bochs_crtc_mode_set_base,
+	.mode_set_nofb = bochs_crtc_mode_set_nofb,
 	.prepare = bochs_crtc_prepare,
 	.commit = bochs_crtc_commit,
 	.atomic_enable = bochs_crtc_atomic_enable,
-- 
2.9.3
