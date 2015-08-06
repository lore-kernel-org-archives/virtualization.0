From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V2] virtio-input: reset device and detach unused during remove
Date: Thu,  6 Aug 2015 13:54:21 +0800
Message-ID: <1438840461-18547-1-git-send-email-jasowang@redhat.com>
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
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Spec requires a device reset during cleanup, so do it and avoid warn
in virtio core. And detach unused buffers to avoid memory leak.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes from V1: detach unused buffers for sts queue.
---
 drivers/virtio/virtio_input.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index 60e2a16..c96944b 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -313,6 +313,7 @@ err_init_vq:
 static void virtinput_remove(struct virtio_device *vdev)
 {
 	struct virtio_input *vi = vdev->priv;
+	void *buf;
 	unsigned long flags;
 
 	spin_lock_irqsave(&vi->lock, flags);
@@ -320,6 +321,9 @@ static void virtinput_remove(struct virtio_device *vdev)
 	spin_unlock_irqrestore(&vi->lock, flags);
 
 	input_unregister_device(vi->idev);
+	vdev->config->reset(vdev);
+	while ((buf = virtqueue_detach_unused_buf(vi->sts)) != NULL)
+		kfree(buf);
 	vdev->config->del_vqs(vdev);
 	kfree(vi);
 }
-- 
2.1.4
