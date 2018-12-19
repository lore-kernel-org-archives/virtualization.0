From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 03/14] drm/bochs: atomic: add atomic_flush+atomic_enable
	callbacks.
Date: Wed, 19 Dec 2018 12:51:16 +0100
Message-ID: <20181219115127.31359-4-kraxel__41499.622030142$1545220171$gmane$org@redhat.com>
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

Conversion to atomic modesetting, step one.
Add atomic crtc helper callbacks.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_kms.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index f7e6d1a9b3..59d469f343 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -115,6 +115,29 @@ static int bochs_crtc_page_flip(struct drm_crtc *crtc,
 	return 0;
 }
 
+static void bochs_crtc_atomic_enable(struct drm_crtc *crtc,
+				     struct drm_crtc_state *old_crtc_state)
+{
+}
+
+static void bochs_crtc_atomic_flush(struct drm_crtc *crtc,
+				    struct drm_crtc_state *old_crtc_state)
+{
+	struct drm_device *dev = crtc->dev;
+	struct drm_pending_vblank_event *event;
+	unsigned long irqflags;
+
+	if (crtc->state && crtc->state->event) {
+		event = crtc->state->event;
+		crtc->state->event = NULL;
+
+		spin_lock_irqsave(&dev->event_lock, irqflags);
+		drm_crtc_send_vblank_event(crtc, event);
+		spin_unlock_irqrestore(&dev->event_lock, irqflags);
+	}
+}
+
+
 /* These provide the minimum set of functions required to handle a CRTC */
 static const struct drm_crtc_funcs bochs_crtc_funcs = {
 	.set_config = drm_crtc_helper_set_config,
@@ -128,6 +151,8 @@ static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
 	.mode_set_base = bochs_crtc_mode_set_base,
 	.prepare = bochs_crtc_prepare,
 	.commit = bochs_crtc_commit,
+	.atomic_enable = bochs_crtc_atomic_enable,
+	.atomic_flush = bochs_crtc_atomic_flush,
 };
 
 static const uint32_t bochs_formats[] = {
-- 
2.9.3
