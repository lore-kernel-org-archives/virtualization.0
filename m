From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [RFC 3/4] virtio: Add dma variants of virtqueue_add_in and outbuf
Date: Fri,  1 May 2015 15:01:46 +1000
Message-ID: <1430456507-26862-4-git-send-email-edgar.iglesias@gmail.com>
References: <1430456507-26862-1-git-send-email-edgar.iglesias@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1430456507-26862-1-git-send-email-edgar.iglesias@gmail.com>
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
Cc: edgar.iglesias@xilinx.com, linux@arm.linux.org.uk, mst@redhat.com, michal.simek@xilinx.com, j.wu@xilinx.com
List-Id: virtualization@lists.linuxfoundation.org

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 drivers/virtio/virtio_ring.c | 18 ++++++++++++++++++
 include/linux/virtio.h       | 10 ++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 233f3c6..dd6c640 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -323,6 +323,15 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
 
+int dma_virtqueue_add_outbuf(struct virtqueue *vq,
+			     struct scatterlist *sg, unsigned int num,
+			     void *data,
+			     gfp_t gfp)
+{
+	return virtqueue_add(vq, &sg, num, 1, 0, data, gfp, true);
+}
+EXPORT_SYMBOL_GPL(dma_virtqueue_add_outbuf);
+
 /**
  * virtqueue_add_inbuf - expose input buffers to other end
  * @vq: the struct virtqueue we're talking about.
@@ -345,6 +354,15 @@ int virtqueue_add_inbuf(struct virtqueue *vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
 
+int dma_virtqueue_add_inbuf(struct virtqueue *vq,
+			    struct scatterlist *sg, unsigned int num,
+			    void *data,
+			    gfp_t gfp)
+{
+	return virtqueue_add(vq, &sg, num, 0, 1, data, gfp, true);
+}
+EXPORT_SYMBOL_GPL(dma_virtqueue_add_inbuf);
+
 /**
  * virtqueue_kick_prepare - first half of split virtqueue_kick call.
  * @vq: the struct virtqueue
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 8f4d4bf..c31b3e2 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -34,6 +34,16 @@ struct virtqueue {
 	void *priv;
 };
 
+int dma_virtqueue_add_outbuf(struct virtqueue *vq,
+			     struct scatterlist sg[], unsigned int num,
+			     void *data,
+			     gfp_t gfp);
+
+int dma_virtqueue_add_inbuf(struct virtqueue *vq,
+			    struct scatterlist sg[], unsigned int num,
+			    void *data,
+			    gfp_t gfp);
+
 int virtqueue_add_outbuf(struct virtqueue *vq,
 			 struct scatterlist sg[], unsigned int num,
 			 void *data,
-- 
1.9.1
