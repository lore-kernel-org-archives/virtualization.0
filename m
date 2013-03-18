From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 22/22] virtio: remove virtqueue_add_buf().
Date: Mon, 18 Mar 2013 20:04:53 +1030
Message-ID: <1363599293-23065-23-git-send-email-rusty@rustcorp.com.au>
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

All users changed to virtqueue_add_sg() or virtqueue_add_outbuf/inbuf.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_ring.c |   31 -------------------------------
 include/linux/virtio.h       |    7 -------
 2 files changed, 38 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5217baf..52b3658 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -296,37 +296,6 @@ add_head:
 }
 
 /**
- * virtqueue_add_buf - expose buffer to other end
- * @vq: the struct virtqueue we're talking about.
- * @sg: the description of the buffer(s).
- * @out_num: the number of sg readable by other side
- * @in_num: the number of sg which are writable (after readable ones)
- * @data: the token identifying the buffer.
- * @gfp: how to do memory allocations (if necessary).
- *
- * Caller must ensure we don't call this with other virtqueue operations
- * at the same time (except where noted).
- *
- * Returns zero or a negative error (ie. ENOSPC, ENOMEM).
- */
-int virtqueue_add_buf(struct virtqueue *_vq,
-		      struct scatterlist sg[],
-		      unsigned int out,
-		      unsigned int in,
-		      void *data,
-		      gfp_t gfp)
-{
-	struct scatterlist *sgs[2];
-
-	sgs[0] = sg;
-	sgs[1] = sg + out;
-
-	return virtqueue_add(_vq, sgs, sg_next_arr,
-			     out, in, out ? 1 : 0, in ? 1 : 0, data, gfp);
-}
-EXPORT_SYMBOL_GPL(virtqueue_add_buf);
-
-/**
  * virtqueue_add_sgs - expose buffers to other end
  * @vq: the struct virtqueue we're talking about.
  * @sgs: array of terminated scatterlists.
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 833f17b..879ca0f 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -34,13 +34,6 @@ struct virtqueue {
 	void *priv;
 };
 
-int virtqueue_add_buf(struct virtqueue *vq,
-		      struct scatterlist sg[],
-		      unsigned int out_num,
-		      unsigned int in_num,
-		      void *data,
-		      gfp_t gfp);
-
 int virtqueue_add_outbuf(struct virtqueue *vq,
 			 struct scatterlist sg[], unsigned int num,
 			 void *data,
-- 
1.7.10.4
