From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 05/22] virtio_ring: virtqueue_add_outbuf / virtqueue_add_inbuf.
Date: Mon, 18 Mar 2013 20:04:36 +1030
Message-ID: <1363599293-23065-6-git-send-email-rusty@rustcorp.com.au>
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

These are specialized versions of virtqueue_add_buf(), which cover
over 80% of cases and are far clearer.

In particular, the scatterlists passed to these functions don't have
to be clean (ie. we ignore end markers).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_ring.c |   44 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |   10 ++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a78ad45..5217baf 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -366,6 +366,50 @@ int virtqueue_add_sgs(struct virtqueue *_vq,
 EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
 
 /**
+ * virtqueue_add_outbuf - expose output buffers to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sgs: array of scatterlists (need not be terminated!)
+ * @num: the number of scatterlists readable by other side
+ * @data: the token identifying the buffer.
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM).
+ */
+int virtqueue_add_outbuf(struct virtqueue *vq,
+			 struct scatterlist sg[], unsigned int num,
+			 void *data,
+			 gfp_t gfp)
+{
+	return virtqueue_add(vq, &sg, sg_next_arr, num, 0, 1, 0, data, gfp);
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
+
+/**
+ * virtqueue_add_inbuf - expose input buffers to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sgs: array of scatterlists (need not be terminated!)
+ * @num: the number of scatterlists writable by other side
+ * @data: the token identifying the buffer.
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM).
+ */
+int virtqueue_add_inbuf(struct virtqueue *vq,
+			struct scatterlist sg[], unsigned int num,
+			void *data,
+			gfp_t gfp)
+{
+	return virtqueue_add(vq, &sg, sg_next_arr, 0, num, 0, 1, data, gfp);
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
+
+/**
  * virtqueue_kick_prepare - first half of split virtqueue_kick call.
  * @vq: the struct virtqueue
  *
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index ac80288..833f17b 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -41,6 +41,16 @@ int virtqueue_add_buf(struct virtqueue *vq,
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
 int virtqueue_add_sgs(struct virtqueue *vq,
 		      struct scatterlist *sgs[],
 		      unsigned int out_sgs,
-- 
1.7.10.4
