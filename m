From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 3/6] virtio-gpu: wait for cursor updates finish
Date: Mon, 21 Sep 2015 11:40:14 +0200
Message-ID: <1442828417-6165-4-git-send-email-kraxel__34931.7390624948$1442828449$gmane$org@redhat.com>
References: <1442828417-6165-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1442828417-6165-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@redhat.com
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 4e160ef..97e5274 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -90,6 +90,9 @@ static int virtio_gpu_crtc_cursor_set(struct drm_crtc *crtc,
 					   cpu_to_le32(64),
 					   cpu_to_le32(64),
 					   0, 0, &fence);
+	reservation_object_add_excl_fence(qobj->tbo.resv,
+					  &fence->f);
+	virtio_gpu_object_wait(qobj, false);
 
 	output->cursor.hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_UPDATE_CURSOR);
 	output->cursor.resource_id = cpu_to_le32(qobj->hw_res_handle);
-- 
1.8.3.1
