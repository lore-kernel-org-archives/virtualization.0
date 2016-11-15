From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH for-4.9] drm/virtio: allocate some extra bufs
Date: Tue, 15 Nov 2016 09:53:23 +0100
Message-ID: <1479200004-18163-1-git-send-email-kraxel__27028.7312254824$1479200065$gmane$org@redhat.com>
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
To: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
Cc: open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

virtio-gpu guest driver appearently can run out of buffers.
allocate some extra buffers, as quick stopgap for 4.9.
analyzing root cause and fixing it properly is TBD.

Reported-by: Jiri Slaby <jslaby@suse.cz>
Tested-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 5a0f8a7..974f941 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -75,7 +75,7 @@ void virtio_gpu_cursor_ack(struct virtqueue *vq)
 int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev)
 {
 	struct virtio_gpu_vbuffer *vbuf;
-	int i, size, count = 0;
+	int i, size, count = 16;
 	void *ptr;
 
 	INIT_LIST_HEAD(&vgdev->free_vbufs);
-- 
1.8.3.1
