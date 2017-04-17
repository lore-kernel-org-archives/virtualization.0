From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH] tools/virtio: fix build breakage
Date: Mon, 17 Apr 2017 16:42:15 +0530
Message-ID: <1c53d16c7a8689c19ea9cab9d8741ff1968e8785.1492427289.git.nsekhar__45186.0697976828$1493076987$gmane$org@ti.com>
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
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Commit db932ced55cf ("virtio: add context flag to find vqs")
added a new 'context' flag to vring_new_virtqueue(), but the
corresponding API in tools/virtio/ is not updated causing
build errors due to conflicting declarations.

Bring code in tools/virtio in sync with that in kernel.

I have used 'false' for the value of the new boolean 'context'
flag as that seems to be the best way to preserve existing
behavior.

Tested with:

$ make -C tools/virtio clean all ARCH=x86

Fixes: db932ced55cf ("virtio: add context flag to find vqs")
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
I am not really a virtio user so I have not tested
these apart from the build test. Applies on linux-next
of April 11 2017

 tools/virtio/linux/virtio.h | 1 +
 tools/virtio/virtio_test.c  | 2 +-
 tools/virtio/vringh_test.c  | 7 ++++---
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
index 9377c8b4ac16..d8f534025b7f 100644
--- a/tools/virtio/linux/virtio.h
+++ b/tools/virtio/linux/virtio.h
@@ -57,6 +57,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      unsigned int vring_align,
 				      struct virtio_device *vdev,
 				      bool weak_barriers,
+				      bool ctx,
 				      void *pages,
 				      bool (*notify)(struct virtqueue *vq),
 				      void (*callback)(struct virtqueue *vq),
diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index e0445898f08f..76d6f583c249 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -100,7 +100,7 @@ static void vq_info_add(struct vdev_info *dev, int num)
 	vring_init(&info->vring, num, info->ring, 4096);
 	info->vq = vring_new_virtqueue(info->idx,
 				       info->vring.num, 4096, &dev->vdev,
-				       true, info->ring,
+				       true, false, info->ring,
 				       vq_notify, vq_callback, "test");
 	assert(info->vq);
 	info->vq->priv = info;
diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 5f94f5105678..9476c616d064 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -314,7 +314,8 @@ static int parallel_test(u64 features,
 			err(1, "Could not set affinity to cpu %u", first_cpu);
 
 		vq = vring_new_virtqueue(0, RINGSIZE, ALIGN, &gvdev.vdev, true,
-					 guest_map, fast_vringh ? no_notify_host
+					 false, guest_map,
+					 fast_vringh ? no_notify_host
 					 : parallel_notify_host,
 					 never_callback_guest, "guest vq");
 
@@ -479,7 +480,7 @@ int main(int argc, char *argv[])
 	memset(__user_addr_min, 0, vring_size(RINGSIZE, ALIGN));
 
 	/* Set up guest side. */
-	vq = vring_new_virtqueue(0, RINGSIZE, ALIGN, &vdev, true,
+	vq = vring_new_virtqueue(0, RINGSIZE, ALIGN, &vdev, true, false,
 				 __user_addr_min,
 				 never_notify_host, never_callback_guest,
 				 "guest vq");
@@ -663,7 +664,7 @@ int main(int argc, char *argv[])
 		/* Force creation of direct, which we modify. */
 		__virtio_clear_bit(&vdev, VIRTIO_RING_F_INDIRECT_DESC);
 		vq = vring_new_virtqueue(0, RINGSIZE, ALIGN, &vdev, true,
-					 __user_addr_min,
+					 false, __user_addr_min,
 					 never_notify_host,
 					 never_callback_guest,
 					 "guest vq");
-- 
2.9.0
