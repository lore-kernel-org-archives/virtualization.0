From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 21/22] tools/virtio: remove virtqueue_add_buf() from tests.
Date: Mon, 18 Mar 2013 20:04:52 +1030
Message-ID: <1363599293-23065-22-git-send-email-rusty@rustcorp.com.au>
References: <1363599293-23065-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363599293-23065-1-git-send-email-rusty@rustcorp.com.au>
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
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 tools/virtio/linux/virtio.h |    7 -------
 tools/virtio/virtio_test.c  |    6 +++---
 tools/virtio/vringh_test.c  |   22 ++++++++++++----------
 3 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
index 6df181a..cd80183 100644
--- a/tools/virtio/linux/virtio.h
+++ b/tools/virtio/linux/virtio.h
@@ -49,13 +49,6 @@ struct virtqueue {
 	const char *__MODULE_LICENSE_name = __MODULE_LICENSE_value
 
 /* Interfaces exported by virtio_ring. */
-int virtqueue_add_buf(struct virtqueue *vq,
-		      struct scatterlist sg[],
-		      unsigned int out_num,
-		      unsigned int in_num,
-		      void *data,
-		      gfp_t gfp);
-
 int virtqueue_add_sgs(struct virtqueue *vq,
 		      struct scatterlist *sgs[],
 		      unsigned int out_sgs,
diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 814ae80..da7a195 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -166,9 +166,9 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 		do {
 			if (started < bufs) {
 				sg_init_one(&sl, dev->buf, dev->buf_size);
-				r = virtqueue_add_buf(vq->vq, &sl, 1, 0,
-						      dev->buf + started,
-						      GFP_ATOMIC);
+				r = virtqueue_add_outbuf(vq->vq, &sl, 1,
+							 dev->buf + started,
+							 GFP_ATOMIC);
 				if (likely(r == 0)) {
 					++started;
 					virtqueue_kick(vq->vq);
diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 88fe02a..760db1c 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -388,7 +388,7 @@ static int parallel_test(unsigned long features,
 			}
 
 			if (err)
-				errx(1, "virtqueue_add_buf: %i", err);
+				errx(1, "virtqueue_add_in/outbuf: %i", err);
 
 			xfers++;
 			virtqueue_kick(vq);
@@ -431,7 +431,7 @@ int main(int argc, char *argv[])
 	struct virtio_device vdev;
 	struct virtqueue *vq;
 	struct vringh vrh;
-	struct scatterlist guest_sg[RINGSIZE];
+	struct scatterlist guest_sg[RINGSIZE], *sgs[2];
 	struct iovec host_riov[2], host_wiov[2];
 	struct vringh_iov riov, wiov;
 	struct vring_used_elem used[RINGSIZE];
@@ -492,12 +492,14 @@ int main(int argc, char *argv[])
 	sg_set_buf(&guest_sg[0], __user_addr_max - 1, 1);
 	sg_init_table(guest_sg+1, 1);
 	sg_set_buf(&guest_sg[1], __user_addr_max - 3, 2);
+	sgs[0] = &guest_sg[0];
+	sgs[1] = &guest_sg[1];
 
 	/* May allocate an indirect, so force it to allocate user addr */
 	__kmalloc_fake = __user_addr_min + vring_size(RINGSIZE, ALIGN);
-	err = virtqueue_add_buf(vq, guest_sg, 1, 1, &err, GFP_KERNEL);
+	err = virtqueue_add_sgs(vq, sgs, 1, 1, &err, GFP_KERNEL);
 	if (err)
-		errx(1, "virtqueue_add_buf: %i", err);
+		errx(1, "virtqueue_add_sgs: %i", err);
 	__kmalloc_fake = NULL;
 
 	/* Host retreives it. */
@@ -564,9 +566,9 @@ int main(int argc, char *argv[])
 
 	/* This will allocate an indirect, so force it to allocate user addr */
 	__kmalloc_fake = __user_addr_min + vring_size(RINGSIZE, ALIGN);
-	err = virtqueue_add_buf(vq, guest_sg, RINGSIZE, 0, &err, GFP_KERNEL);
+	err = virtqueue_add_outbuf(vq, guest_sg, RINGSIZE, &err, GFP_KERNEL);
 	if (err)
-		errx(1, "virtqueue_add_buf (large): %i", err);
+		errx(1, "virtqueue_add_outbuf (large): %i", err);
 	__kmalloc_fake = NULL;
 
 	/* Host picks it up (allocates new iov). */
@@ -616,9 +618,9 @@ int main(int argc, char *argv[])
 	sg_init_table(guest_sg, 1);
 	sg_set_buf(&guest_sg[0], __user_addr_max - 1, 1);
 	for (i = 0; i < RINGSIZE; i++) {
-		err = virtqueue_add_buf(vq, guest_sg, 1, 0, &err, GFP_KERNEL);
+		err = virtqueue_add_outbuf(vq, guest_sg, 1, &err, GFP_KERNEL);
 		if (err)
-			errx(1, "virtqueue_add_buf (multiple): %i", err);
+			errx(1, "virtqueue_add_outbuf (multiple): %i", err);
 	}
 
 	/* Now get many, and consume them all at once. */
@@ -665,9 +667,9 @@ int main(int argc, char *argv[])
 		sg_set_buf(&guest_sg[2], data + 6, 4);
 		sg_set_buf(&guest_sg[3], d + 3, sizeof(*d)*3);
 
-		err = virtqueue_add_buf(vq, guest_sg, 4, 0, &err, GFP_KERNEL);
+		err = virtqueue_add_outbuf(vq, guest_sg, 4, &err, GFP_KERNEL);
 		if (err)
-			errx(1, "virtqueue_add_buf (indirect): %i", err);
+			errx(1, "virtqueue_add_outbuf (indirect): %i", err);
 
 		vring_init(&vring, RINGSIZE, __user_addr_min, ALIGN);
 
-- 
1.7.10.4
