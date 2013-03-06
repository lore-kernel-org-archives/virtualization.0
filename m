From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 5/6] tools/virtio: make vringh_test use inbuf/outbuf.
Date: Wed, 06 Mar 2013 16:24:05 +1100
Message-ID: <874ngpayoa.fsf@rustcorp.com.au>
References: <87k3plaz3d.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87k3plaz3d.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: sjur.brandeland@stericsson.com, mst@redhat.com
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The simplified accessors are faster.

Before:
	Using CPUS 0 and 3
	Guest: notified 0, pinged 39062-39063(39063)
	Host: notified 39062-39063(39063), pinged 0
	Wall time:1.760000-2.220000(1.789167)

After:
	Using CPUS 0 and 3
	Guest: notified 0, pinged 39037-39063(39062)
	Host: notified 39037-39063(39062), pinged 0
	Wall time:1.640000-1.810000(1.676875)

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
index 5fa612a..6df181a 100644
--- a/tools/virtio/linux/virtio.h
+++ b/tools/virtio/linux/virtio.h
@@ -63,6 +63,16 @@ int virtqueue_add_sgs(struct virtqueue *vq,
 		      void *data,
 		      gfp_t gfp);
 
+int virtqueue_add_outbuf(struct virtqueue *vq,
+			 struct scatterlist sg[], unsigned int num,
+			 void *data,
+			 gfp_t gfp);
+
+int virtqueue_add_inbuf(struct virtqueue *vq,
+			struct scatterlist sg[], unsigned int num,
+			void *data,
+			gfp_t gfp);
+
 void virtqueue_kick(struct virtqueue *vq);
 
 void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 7fedde8..cf33672 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -342,11 +342,11 @@ static int parallel_test(unsigned long features,
 			 * user addr */
 			__kmalloc_fake = indirects + (xfers % RINGSIZE) * 3;
 			if (output)
-				err = virtqueue_add_buf(vq, sg, num_sg, 0, dbuf,
-							GFP_KERNEL);
+				err = virtqueue_add_outbuf(vq, sg, num_sg, dbuf,
+							   GFP_KERNEL);
 			else
-				err = virtqueue_add_buf(vq, sg, 0, num_sg, dbuf,
-							GFP_KERNEL);
+				err = virtqueue_add_inbuf(vq, sg, num_sg,
+							  dbuf, GFP_KERNEL);
 
 			if (err == -ENOSPC) {
 				char buf[128];
