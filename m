From: Gustavo Padovan <gustavo@padovan.org>
Subject: [PATCH 13/14] drm/virtio: use drm_crtc_send_vblank_event()
Date: Thu, 14 Apr 2016 10:48:24 -0700
Message-ID: <1460656118-16766-13-git-send-email-gustavo@padovan.org>
References: <1460656118-16766-1-git-send-email-gustavo@padovan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1460656118-16766-1-git-send-email-gustavo@padovan.org>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Gustavo Padovan <gustavo.padovan@collabora.co.uk>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Replace the legacy drm_send_vblank_event() with the new helper function.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 4854dac..66be450 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -163,7 +163,7 @@ static int virtio_gpu_page_flip(struct drm_crtc *crtc,
 
 	if (event) {
 		spin_lock_irqsave(&crtc->dev->event_lock, irqflags);
-		drm_send_vblank_event(crtc->dev, -1, event);
+		drm_crtc_send_vblank_event(crtc, event);
 		spin_unlock_irqrestore(&crtc->dev->event_lock, irqflags);
 	}
 
-- 
2.5.5
