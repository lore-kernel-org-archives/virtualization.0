From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 18/22] virtio_rpmsg_bus: use simplified virtqueue accessors.
Date: Mon, 18 Mar 2013 20:04:49 +1030
Message-ID: <1363599293-23065-19-git-send-email-rusty@rustcorp.com.au>
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

We never add buffers with input and output parts, so use the new accessors.

Cc: Ohad Ben-Cohen <ohad@wizery.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/rpmsg/virtio_rpmsg_bus.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index a59684b..33d827b 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -757,14 +757,14 @@ int rpmsg_send_offchannel_raw(struct rpmsg_channel *rpdev, u32 src, u32 dst,
 	mutex_lock(&vrp->tx_lock);
 
 	/* add message to the remote processor's virtqueue */
-	err = virtqueue_add_buf(vrp->svq, &sg, 1, 0, msg, GFP_KERNEL);
+	err = virtqueue_add_outbuf(vrp->svq, &sg, 1, msg, GFP_KERNEL);
 	if (err) {
 		/*
 		 * need to reclaim the buffer here, otherwise it's lost
 		 * (memory won't leak, but rpmsg won't use it again for TX).
 		 * this will wait for a buffer management overhaul.
 		 */
-		dev_err(dev, "virtqueue_add_buf failed: %d\n", err);
+		dev_err(dev, "virtqueue_add_outbuf failed: %d\n", err);
 		goto out;
 	}
 
@@ -839,7 +839,7 @@ static void rpmsg_recv_done(struct virtqueue *rvq)
 	sg_init_one(&sg, msg, RPMSG_BUF_SIZE);
 
 	/* add the buffer back to the remote processor's virtqueue */
-	err = virtqueue_add_buf(vrp->rvq, &sg, 0, 1, msg, GFP_KERNEL);
+	err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, msg, GFP_KERNEL);
 	if (err < 0) {
 		dev_err(dev, "failed to add a virtqueue buffer: %d\n", err);
 		return;
@@ -970,7 +970,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
 
 		sg_init_one(&sg, cpu_addr, RPMSG_BUF_SIZE);
 
-		err = virtqueue_add_buf(vrp->rvq, &sg, 0, 1, cpu_addr,
+		err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, cpu_addr,
 								GFP_KERNEL);
 		WARN_ON(err); /* sanity check; this can't really happen */
 	}
-- 
1.7.10.4
