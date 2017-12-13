From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [bpf-next V1-RFC PATCH 11/14] virtio_net: setup xdp_rxq_info
Date: Wed, 13 Dec 2017 12:20:16 +0100
Message-ID: <151316401687.14967.455517333454358524.stgit@firesoul>
References: <151316391502.14967.13292358380181773729.stgit@firesoul>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <151316391502.14967.13292358380181773729.stgit@firesoul>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Borkmann <borkmann@iogearbox.net>, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>, virtualization@lists.linux-foundation.org, dsahern@gmail.com, gospo@broadcom.com, bjorn.topel@intel.com, michael.chan@broadcom.com
List-Id: virtualization@lists.linuxfoundation.org

The virtio_net driver doesn't dynamically change the RX-ring queue
layout and backing pages, but instead reject XDP setup if all the
conditions for XDP is not meet.  Thus, the xdp_rxq_info also remains
fairly static.  This allow us to simply add the init+reg/unreg to
net_device open/close functions.

Driver hook points for xdp_rxq_info:
 * init+reg: virtnet_open
 * unreg   : virtnet_close

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/virtio_net.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 19a985ef9104..9792183befbf 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -31,6 +31,7 @@
 #include <linux/average.h>
 #include <linux/filter.h>
 #include <net/route.h>
+#include <net/xdp.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -115,6 +116,8 @@ struct receive_queue {
 
 	/* Name of this receive queue: input.$index */
 	char name[40];
+
+	struct xdp_rxq_info xdp_rxq;
 };
 
 struct virtnet_info {
@@ -556,6 +559,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 		xdp.data = xdp.data_hard_start + xdp_headroom;
 		xdp_set_data_meta_invalid(&xdp);
 		xdp.data_end = xdp.data + len;
+		xdp.rxq = &rq->xdp_rxq;
 		orig_data = xdp.data;
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 
@@ -1229,6 +1233,13 @@ static int virtnet_open(struct net_device *dev)
 			/* Make sure we have some buffers: if oom use wq. */
 			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
 				schedule_delayed_work(&vi->refill, 0);
+
+		/* XDP RX queue info */
+		xdp_rxq_info_init(&vi->rq[i].xdp_rxq);
+		vi->rq[i].xdp_rxq.dev = dev;
+		vi->rq[i].xdp_rxq.queue_index = i;
+		xdp_rxq_info_reg(&vi->rq[i].xdp_rxq);
+
 		virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
 		virtnet_napi_tx_enable(vi, vi->sq[i].vq, &vi->sq[i].napi);
 	}
@@ -1557,6 +1568,7 @@ static int virtnet_close(struct net_device *dev)
 	cancel_delayed_work_sync(&vi->refill);
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
+		xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
 		napi_disable(&vi->rq[i].napi);
 		virtnet_napi_tx_disable(&vi->sq[i].napi);
 	}
