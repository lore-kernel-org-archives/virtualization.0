From: Wendy Liang <wendy.liang@xilinx.com>
Subject: [PATCH 2/2] rpmsg: DMA map sgs passed to virtio
Date: Wed, 7 Dec 2016 22:59:13 -0800
Message-ID: <1481180353-11139-3-git-send-email-jliang@xilinx.com>
References: <1481180353-11139-1-git-send-email-jliang@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481180353-11139-1-git-send-email-jliang@xilinx.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux-foundation.org, ohad@wizery.com, bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Wendy Liang <jliang@xilinx.com>
List-Id: virtualization@lists.linuxfoundation.org

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

As rpmsg uses dma_alloc_coherent() to allocate memory to shared
with the remote. Virtio ring requires the shared buffers to be
passed as sg struct. As the memory has already been mapped,
and we cannot convert the virtual address got from dma_alloc_coherent()
back to the physical address. We set the sg_dma_addr to store the
DMA address before we pass it to virtio.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Wendy Liang <jliang@xilinx.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 3090b0d..af76187 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -192,6 +192,22 @@ static int virtio_rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src,
 	.trysend_offchannel = virtio_rpmsg_trysend_offchannel,
 };
 
+static inline dma_addr_t msg_dma_address(struct virtproc_info *vrp, void *msg)
+{
+	unsigned long offset = msg - vrp->rbufs;
+
+	return vrp->bufs_dma + offset;
+}
+
+static inline void rpmsg_msg_sg_init(struct virtproc_info *vrp,
+				     struct scatterlist *sg,
+				     void *msg, unsigned int len)
+{
+	sg_init_table(sg, 1);
+	sg_dma_address(sg) = msg_dma_address(vrp, msg);
+	sg_dma_len(sg) = len;
+}
+
 /**
  * __ept_release() - deallocate an rpmsg endpoint
  * @kref: the ept's reference count
@@ -604,7 +620,7 @@ static int rpmsg_send_offchannel_raw(struct rpmsg_device *rpdev,
 			 msg, sizeof(*msg) + msg->len, true);
 #endif
 
-	sg_init_one(&sg, msg, sizeof(*msg) + len);
+	rpmsg_msg_sg_init(vrp, &sg, msg, sizeof(*msg) + len);
 
 	mutex_lock(&vrp->tx_lock);
 
@@ -729,7 +745,7 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
 		dev_warn(dev, "msg received with no recipient\n");
 
 	/* publish the real size of the buffer */
-	sg_init_one(&sg, msg, RPMSG_BUF_SIZE);
+	rpmsg_msg_sg_init(vrp, &sg, msg, RPMSG_BUF_SIZE);
 
 	/* add the buffer back to the remote processor's virtqueue */
 	err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, msg, GFP_KERNEL);
@@ -911,7 +927,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
 		struct scatterlist sg;
 		void *cpu_addr = vrp->rbufs + i * RPMSG_BUF_SIZE;
 
-		sg_init_one(&sg, cpu_addr, RPMSG_BUF_SIZE);
+		rpmsg_msg_sg_init(vrp, &sg, cpu_addr, RPMSG_BUF_SIZE);
 
 		err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, cpu_addr,
 					  GFP_KERNEL);
-- 
1.9.1
