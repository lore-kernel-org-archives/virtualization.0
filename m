From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: qxl: Fix possible null-pointer dereferences in
	qxl_crtc_atomic_flush()
Date: Thu, 25 Jul 2019 18:21:27 +0800
Message-ID: <20190725102127.16086-1-baijiaju1990__1932.86535083956$1564050108$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: airlied@redhat.com, kraxel@redhat.com, airlied@linux.ie, daniel@ffwll.ch
Cc: spice-devel@lists.freedesktop.org, Jia-Ju Bai <baijiaju1990@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

In qxl_crtc_atomic_flush(), there is an if statement on line 376 to
check whether crtc->state is NULL:
    if (crtc->state && crtc->state->event)

When crtc->state is NULL and qxl_crtc_update_monitors_config() is call, 
qxl_crtc_update_monitors_config() uses crtc->state on line 326:
    if (crtc->state->active)
and on line 358:
    DRM_DEBUG_KMS(..., crtc->state->active, ...);

Thus, possible null-pointer dereferences may occur.

To fix these bugs, crtc->state is checked before calling
qxl_crtc_update_monitors_config().

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 8b319ebbb0fb..fae18ef1ba59 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -382,7 +382,8 @@ static void qxl_crtc_atomic_flush(struct drm_crtc *crtc,
 		spin_unlock_irqrestore(&dev->event_lock, flags);
 	}
 
-	qxl_crtc_update_monitors_config(crtc, "flush");
+	if (crtc->state)
+		qxl_crtc_update_monitors_config(crtc, "flush");
 }
 
 static void qxl_crtc_destroy(struct drm_crtc *crtc)
-- 
2.17.0
