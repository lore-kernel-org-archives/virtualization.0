From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/5] tools/virtio: fix compile.
Date: Tue, 19 Feb 2013 08:59:30 +1030
Message-ID: <1361226573-12481-4-git-send-email-rusty@rustcorp.com.au>
References: <1361226573-12481-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1361226573-12481-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, sjur.brandeland@stericsson.com
List-Id: virtualization@lists.linuxfoundation.org

Didn't test that it actually works, mind you!

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 tools/virtio/linux/virtio.h |    9 ++++++++-
 tools/virtio/virtio_test.c  |    6 +++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
index 81847dd..ccfc901 100644
--- a/tools/virtio/linux/virtio.h
+++ b/tools/virtio/linux/virtio.h
@@ -86,6 +86,10 @@ typedef enum {
 	GFP_KERNEL,
 	GFP_ATOMIC,
 } gfp_t;
+
+#define __GFP_HIGHMEM 0
+#define __GFP_HIGH 0
+
 typedef enum {
 	IRQ_NONE,
 	IRQ_HANDLED
@@ -163,6 +167,8 @@ struct virtqueue {
 	void (*callback)(struct virtqueue *vq);
 	const char *name;
 	struct virtio_device *vdev;
+	unsigned int index;
+	unsigned int num_free;
 	void *priv;
 };
 
@@ -206,7 +212,8 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
 bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
 
 void *virtqueue_detach_unused_buf(struct virtqueue *vq);
-struct virtqueue *vring_new_virtqueue(unsigned int num,
+struct virtqueue *vring_new_virtqueue(unsigned int index,
+				      unsigned int num,
 				      unsigned int vring_align,
 				      struct virtio_device *vdev,
 				      bool weak_barriers,
diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index fcc9aa2..a07142c 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -81,7 +81,7 @@ void vhost_vq_setup(struct vdev_info *dev, struct vq_info *info)
 	assert(r >= 0);
 }
 
-static void vq_info_add(struct vdev_info *dev, int num)
+static void vq_info_add(struct vdev_info *dev, int idx, int num)
 {
 	struct vq_info *info = &dev->vqs[dev->nvqs];
 	int r;
@@ -92,7 +92,7 @@ static void vq_info_add(struct vdev_info *dev, int num)
 	assert(r >= 0);
 	memset(info->ring, 0, vring_size(num, 4096));
 	vring_init(&info->vring, num, info->ring, 4096);
-	info->vq = vring_new_virtqueue(info->vring.num, 4096, &dev->vdev,
+	info->vq = vring_new_virtqueue(idx, info->vring.num, 4096, &dev->vdev,
 				       true, info->ring,
 				       vq_notify, vq_callback, "test");
 	assert(info->vq);
@@ -277,7 +277,7 @@ int main(int argc, char **argv)
 
 done:
 	vdev_info_init(&dev, features);
-	vq_info_add(&dev, 256);
+	vq_info_add(&dev, 0, 256);
 	run_test(&dev, &dev.vqs[0], delayed, 0x100000);
 	return 0;
 }
-- 
1.7.10.4
