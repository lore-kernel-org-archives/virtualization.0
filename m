From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 3/3] virtio-gpu: add locking for vbuf pool
Date: Tue, 16 Jun 2015 11:34:31 +0200
Message-ID: <1434447271-16461-4-git-send-email-kraxel@redhat.com>
References: <1434447271-16461-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1434447271-16461-1-git-send-email-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, Dave Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Dave Airlie <airlied@redhat.com>

Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h | 1 +
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index ff8de3d..6d4db2d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -162,6 +162,7 @@ struct virtio_gpu_device {
 	struct virtio_gpu_queue ctrlq;
 	struct virtio_gpu_queue cursorq;
 	struct list_head free_vbufs;
+	spinlock_t free_vbufs_lock;
 	void *vbufs;
 	bool vqs_ready;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index c506792..1698669f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -79,6 +79,7 @@ int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev)
 	void *ptr;
 
 	INIT_LIST_HEAD(&vgdev->free_vbufs);
+	spin_lock_init(&vgdev->free_vbufs_lock);
 	count += virtqueue_get_vring_size(vgdev->ctrlq.vq);
 	count += virtqueue_get_vring_size(vgdev->cursorq.vq);
 	size = count * VBUFFER_SIZE;
@@ -106,6 +107,7 @@ void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev)
 	count += virtqueue_get_vring_size(vgdev->ctrlq.vq);
 	count += virtqueue_get_vring_size(vgdev->cursorq.vq);
 
+	spin_lock(&vgdev->free_vbufs_lock);
 	for (i = 0; i < count; i++) {
 		if (WARN_ON(list_empty(&vgdev->free_vbufs)))
 			return;
@@ -113,6 +115,7 @@ void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev)
 					struct virtio_gpu_vbuffer, list);
 		list_del(&vbuf->list);
 	}
+	spin_unlock(&vgdev->free_vbufs_lock);
 	kfree(vgdev->vbufs);
 }
 
@@ -123,10 +126,12 @@ virtio_gpu_get_vbuf(struct virtio_gpu_device *vgdev,
 {
 	struct virtio_gpu_vbuffer *vbuf;
 
+	spin_lock(&vgdev->free_vbufs_lock);
 	BUG_ON(list_empty(&vgdev->free_vbufs));
 	vbuf = list_first_entry(&vgdev->free_vbufs,
 				struct virtio_gpu_vbuffer, list);
 	list_del(&vbuf->list);
+	spin_unlock(&vgdev->free_vbufs_lock);
 	memset(vbuf, 0, VBUFFER_SIZE);
 
 	BUG_ON(size > MAX_INLINE_CMD_SIZE);
@@ -201,7 +206,9 @@ static void free_vbuf(struct virtio_gpu_device *vgdev,
 	if (vbuf->resp_size > MAX_INLINE_RESP_SIZE)
 		kfree(vbuf->resp_buf);
 	kfree(vbuf->data_buf);
+	spin_lock(&vgdev->free_vbufs_lock);
 	list_add(&vbuf->list, &vgdev->free_vbufs);
+	spin_unlock(&vgdev->free_vbufs_lock);
 }
 
 static void reclaim_vbufs(struct virtqueue *vq, struct list_head *reclaim_list)
-- 
1.8.3.1
