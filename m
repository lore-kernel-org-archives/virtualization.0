From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v4 09/12] tools/virtio: switch to virtio_legacy_init/size
Date: Mon, 6 Apr 2020 17:02:10 -0400
Message-ID: <20200406210108.148131-10-mst@redhat.com>
References: <20200406210108.148131-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200406210108.148131-1-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

These are used for legacy ring format, switch to APIs that make this
explicit.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/ringtest/virtio_ring_0_9.c |  6 +++---
 tools/virtio/virtio_test.c              |  6 +++---
 tools/virtio/vringh_test.c              | 18 +++++++++---------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/virtio/ringtest/virtio_ring_0_9.c b/tools/virtio/ringtest/virtio_ring_0_9.c
index 13a035a390e9..e2ab6ac53966 100644
--- a/tools/virtio/ringtest/virtio_ring_0_9.c
+++ b/tools/virtio/ringtest/virtio_ring_0_9.c
@@ -67,13 +67,13 @@ void alloc_ring(void)
 	int i;
 	void *p;
 
-	ret = posix_memalign(&p, 0x1000, vring_size(ring_size, 0x1000));
+	ret = posix_memalign(&p, 0x1000, vring_legacy_size(ring_size, 0x1000));
 	if (ret) {
 		perror("Unable to allocate ring buffer.\n");
 		exit(3);
 	}
-	memset(p, 0, vring_size(ring_size, 0x1000));
-	vring_init(&ring, ring_size, p, 0x1000);
+	memset(p, 0, vring_legacy_size(ring_size, 0x1000));
+	vring_legacy_init(&ring, ring_size, p, 0x1000);
 
 	guest.avail_idx = 0;
 	guest.kicked_avail_idx = -1;
diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 93d81cd64ba0..25be607d8711 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -102,10 +102,10 @@ static void vq_info_add(struct vdev_info *dev, int num)
 	info->idx = dev->nvqs;
 	info->kick = eventfd(0, EFD_NONBLOCK);
 	info->call = eventfd(0, EFD_NONBLOCK);
-	r = posix_memalign(&info->ring, 4096, vring_size(num, 4096));
+	r = posix_memalign(&info->ring, 4096, vring_legacy_size(num, 4096));
 	assert(r >= 0);
-	memset(info->ring, 0, vring_size(num, 4096));
-	vring_init(&info->vring, num, info->ring, 4096);
+	memset(info->ring, 0, vring_legacy_size(num, 4096));
+	vring_legacy_init(&info->vring, num, info->ring, 4096);
 	info->vq = vring_new_virtqueue(info->idx,
 				       info->vring.num, 4096, &dev->vdev,
 				       true, false, info->ring,
diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 293653463303..8ee2c9a6ad46 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -151,7 +151,7 @@ static int parallel_test(u64 features,
 		err(1, "Opening /tmp/vringh_test-file");
 
 	/* Extra room at the end for some data, and indirects */
-	mapsize = vring_size(RINGSIZE, ALIGN)
+	mapsize = vring_legacy_size(RINGSIZE, ALIGN)
 		+ RINGSIZE * 2 * sizeof(int)
 		+ RINGSIZE * 6 * sizeof(struct vring_desc);
 	mapsize = (mapsize + getpagesize() - 1) & ~(getpagesize() - 1);
@@ -185,7 +185,7 @@ static int parallel_test(u64 features,
 		close(to_guest[0]);
 		close(to_host[1]);
 
-		vring_init(&vrh.vring, RINGSIZE, host_map, ALIGN);
+		vring_legacy_init(&vrh.vring, RINGSIZE, host_map, ALIGN);
 		vringh_init_user(&vrh, features, RINGSIZE, true,
 				 vrh.vring.desc, vrh.vring.avail, vrh.vring.used);
 		CPU_SET(first_cpu, &cpu_set);
@@ -297,7 +297,7 @@ static int parallel_test(u64 features,
 		unsigned int finished = 0;
 
 		/* We pass sg[]s pointing into here, but we need RINGSIZE+1 */
-		data = guest_map + vring_size(RINGSIZE, ALIGN);
+		data = guest_map + vring_legacy_size(RINGSIZE, ALIGN);
 		indirects = (void *)data + (RINGSIZE + 1) * 2 * sizeof(int);
 
 		/* We are the guest. */
@@ -478,7 +478,7 @@ int main(int argc, char *argv[])
 	if (posix_memalign(&__user_addr_min, PAGE_SIZE, USER_MEM) != 0)
 		abort();
 	__user_addr_max = __user_addr_min + USER_MEM;
-	memset(__user_addr_min, 0, vring_size(RINGSIZE, ALIGN));
+	memset(__user_addr_min, 0, vring_legacy_size(RINGSIZE, ALIGN));
 
 	/* Set up guest side. */
 	vq = vring_new_virtqueue(0, RINGSIZE, ALIGN, &vdev, true, false,
@@ -487,7 +487,7 @@ int main(int argc, char *argv[])
 				 "guest vq");
 
 	/* Set up host side. */
-	vring_init(&vrh.vring, RINGSIZE, __user_addr_min, ALIGN);
+	vring_legacy_init(&vrh.vring, RINGSIZE, __user_addr_min, ALIGN);
 	vringh_init_user(&vrh, vdev.features, RINGSIZE, true,
 			 vrh.vring.desc, vrh.vring.avail, vrh.vring.used);
 
@@ -506,7 +506,7 @@ int main(int argc, char *argv[])
 	sgs[1] = &guest_sg[1];
 
 	/* May allocate an indirect, so force it to allocate user addr */
-	__kmalloc_fake = __user_addr_min + vring_size(RINGSIZE, ALIGN);
+	__kmalloc_fake = __user_addr_min + vring_legacy_size(RINGSIZE, ALIGN);
 	err = virtqueue_add_sgs(vq, sgs, 1, 1, &err, GFP_KERNEL);
 	if (err)
 		errx(1, "virtqueue_add_sgs: %i", err);
@@ -556,7 +556,7 @@ int main(int argc, char *argv[])
 		errx(1, "vringh_complete_user: %i", err);
 
 	/* Guest should see used token now. */
-	__kfree_ignore_start = __user_addr_min + vring_size(RINGSIZE, ALIGN);
+	__kfree_ignore_start = __user_addr_min + vring_legacy_size(RINGSIZE, ALIGN);
 	__kfree_ignore_end = __kfree_ignore_start + 1;
 	ret = virtqueue_get_buf(vq, &i);
 	if (ret != &err)
@@ -575,7 +575,7 @@ int main(int argc, char *argv[])
 		((char *)__user_addr_max - USER_MEM/4)[i] = i;
 
 	/* This will allocate an indirect, so force it to allocate user addr */
-	__kmalloc_fake = __user_addr_min + vring_size(RINGSIZE, ALIGN);
+	__kmalloc_fake = __user_addr_min + vring_legacy_size(RINGSIZE, ALIGN);
 	err = virtqueue_add_outbuf(vq, guest_sg, RINGSIZE, &err, GFP_KERNEL);
 	if (err)
 		errx(1, "virtqueue_add_outbuf (large): %i", err);
@@ -680,7 +680,7 @@ int main(int argc, char *argv[])
 		if (err)
 			errx(1, "virtqueue_add_outbuf (indirect): %i", err);
 
-		vring_init(&vring, RINGSIZE, __user_addr_min, ALIGN);
+		vring_legacy_init(&vring, RINGSIZE, __user_addr_min, ALIGN);
 
 		/* They're used in order, but double-check... */
 		assert(vring.desc[0].addr == (unsigned long)d);
-- 
MST
