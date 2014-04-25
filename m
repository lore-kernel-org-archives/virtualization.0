From: Amos Kong <akong@redhat.com>
Subject: [PATCH] virtio-rng: support multiple virtio-rng devices
Date: Sat, 26 Apr 2014 00:12:53 +0800
Message-ID: <1398442373-19412-1-git-send-email-akong@redhat.com>
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
To: virtualization@lists.linux-foundation.org
Cc: amit.shah@redhat.com, qemu-devel@nongnu.org, aliguori@amazon.com
List-Id: virtualization@lists.linuxfoundation.org

Current hwrng core supports to register multiple hwrng devices,
and there is only one device really works in the same time.
QEMU alsu supports to have multiple virtio-rng backends.

This patch changes virtio-rng driver to support multiple
virtio-rng devices.

]# cat /sys/class/misc/hw_random/rng_available
virtio_rng.0 virtio_rng.1
]# cat /sys/class/misc/hw_random/rng_current
virtio_rng.0
]# echo -n virtio_rng.1 > /sys/class/misc/hw_random/rng_current
]# dd if=/dev/hwrng of=/dev/null

Signed-off-by: Amos Kong <akong@redhat.com>
---
 drivers/char/hw_random/virtio-rng.c | 102 ++++++++++++++++++++++--------------
 include/linux/hw_random.h           |   2 +-
 2 files changed, 64 insertions(+), 40 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 2ce0e22..12e242b 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -25,88 +25,108 @@
 #include <linux/virtio_rng.h>
 #include <linux/module.h>
 
-static struct virtqueue *vq;
-static unsigned int data_avail;
-static DECLARE_COMPLETION(have_data);
-static bool busy;
+
+struct virtrng_info {
+	struct virtio_device *vdev;
+	struct hwrng hwrng;
+	struct virtqueue *vq;
+	unsigned int data_avail;
+	struct completion have_data;
+	bool busy;
+};
 
 static void random_recv_done(struct virtqueue *vq)
 {
+	struct virtrng_info *vi = vq->vdev->priv;
+
 	/* We can get spurious callbacks, e.g. shared IRQs + virtio_pci. */
-	if (!virtqueue_get_buf(vq, &data_avail))
+	if (!virtqueue_get_buf(vi->vq, &vi->data_avail))
 		return;
 
-	complete(&have_data);
+	complete(&vi->have_data);
 }
 
 /* The host will fill any buffer we give it with sweet, sweet randomness. */
-static void register_buffer(u8 *buf, size_t size)
+static void register_buffer(struct virtrng_info *vi, u8 *buf, size_t size)
 {
 	struct scatterlist sg;
 
 	sg_init_one(&sg, buf, size);
 
 	/* There should always be room for one buffer. */
-	virtqueue_add_inbuf(vq, &sg, 1, buf, GFP_KERNEL);
+	virtqueue_add_inbuf(vi->vq, &sg, 1, buf, GFP_KERNEL);
 
-	virtqueue_kick(vq);
+	virtqueue_kick(vi->vq);
 }
 
 static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 {
 	int ret;
+	struct virtrng_info *vi = (struct virtrng_info *)rng->priv;
 
-	if (!busy) {
-		busy = true;
-		init_completion(&have_data);
-		register_buffer(buf, size);
+	if (!vi->busy) {
+		vi->busy = true;
+		init_completion(&vi->have_data);
+		register_buffer(vi, buf, size);
 	}
 
 	if (!wait)
 		return 0;
 
-	ret = wait_for_completion_killable(&have_data);
+	ret = wait_for_completion_killable(&vi->have_data);
 	if (ret < 0)
 		return ret;
 
-	busy = false;
+	vi->busy = false;
 
-	return data_avail;
+	return vi->data_avail;
 }
 
 static void virtio_cleanup(struct hwrng *rng)
 {
-	if (busy)
-		wait_for_completion(&have_data);
-}
-
+	struct virtrng_info *vi = (struct virtrng_info *)rng->priv;
 
-static struct hwrng virtio_hwrng = {
-	.name		= "virtio",
-	.cleanup	= virtio_cleanup,
-	.read		= virtio_read,
-};
+	if (vi->busy)
+		wait_for_completion(&vi->have_data);
+}
 
 static int probe_common(struct virtio_device *vdev)
 {
-	int err;
+	int err, i;
+	struct virtrng_info *vi = NULL;
+
+	vi = kmalloc(sizeof(struct virtrng_info), GFP_KERNEL);
+	vi->hwrng.name = kmalloc(40, GFP_KERNEL);
+	init_completion(&vi->have_data);
+
+	vi->hwrng.read = virtio_read;
+	vi->hwrng.cleanup = virtio_cleanup;
+	vi->hwrng.priv = (unsigned long)vi;
+	vdev->priv = vi;
 
-	if (vq) {
-		/* We only support one device for now */
-		return -EBUSY;
-	}
 	/* We expect a single virtqueue. */
-	vq = virtio_find_single_vq(vdev, random_recv_done, "input");
-	if (IS_ERR(vq)) {
-		err = PTR_ERR(vq);
-		vq = NULL;
+	vi->vq = virtio_find_single_vq(vdev, random_recv_done, "input");
+	if (IS_ERR(vi->vq)) {
+		err = PTR_ERR(vi->vq);
+		kfree(vi->hwrng.name);
+		vi->vq = NULL;
+		kfree(vi);
+		vi = NULL;
 		return err;
 	}
 
-	err = hwrng_register(&virtio_hwrng);
+	i = 0;
+	do {
+		sprintf(vi->hwrng.name, "virtio_rng.%d", i++);
+		err = hwrng_register(&vi->hwrng);
+	} while (err == -EEXIST);
+
 	if (err) {
 		vdev->config->del_vqs(vdev);
-		vq = NULL;
+		kfree(vi->hwrng.name);
+		vi->vq = NULL;
+		kfree(vi);
+		vi = NULL;
 		return err;
 	}
 
@@ -115,11 +135,15 @@ static int probe_common(struct virtio_device *vdev)
 
 static void remove_common(struct virtio_device *vdev)
 {
+	struct virtrng_info *vi = vdev->priv;
 	vdev->config->reset(vdev);
-	busy = false;
-	hwrng_unregister(&virtio_hwrng);
+	vi->busy = false;
+	hwrng_unregister(&vi->hwrng);
 	vdev->config->del_vqs(vdev);
-	vq = NULL;
+	kfree(vi->hwrng.name);
+	vi->vq = NULL;
+	kfree(vi);
+	vi = NULL;
 }
 
 static int virtrng_probe(struct virtio_device *vdev)
diff --git a/include/linux/hw_random.h b/include/linux/hw_random.h
index b4b0eef..02d9c87 100644
--- a/include/linux/hw_random.h
+++ b/include/linux/hw_random.h
@@ -31,7 +31,7 @@
  * @priv:		Private data, for use by the RNG driver.
  */
 struct hwrng {
-	const char *name;
+	char *name;
 	int (*init)(struct hwrng *rng);
 	void (*cleanup)(struct hwrng *rng);
 	int (*data_present)(struct hwrng *rng, int wait);
-- 
1.9.0
