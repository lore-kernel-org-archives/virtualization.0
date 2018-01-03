From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [bpf-next V4 PATCH 11/14] virtio_net: setup xdp_rxq_info
Date: Wed, 03 Jan 2018 11:26:04 +0100
Message-ID: <151497516458.18176.3036145292442370270.stgit__46146.6647139334$1514975077$gmane$org@firesoul>
References: <151497504273.18176.10177133999720101758.stgit@firesoul>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <151497504273.18176.10177133999720101758.stgit@firesoul>
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
fairly static.  This allow us to simply add the reg/unreg to
net_device open/close functions.

Driver hook points for xdp_rxq_info:
 * reg  : virtnet_open
 * unreg: virtnet_close

V3:
 - bugfix, also setup xdp.rxq in receive_mergeable()
 - Tested bpf-sample prog inside guest on a virtio_net device

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6fb7b658a6cc..ed8299343728 100644
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
@@ -559,6 +562,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 		xdp.data = xdp.data_hard_start + xdp_headroom;
 		xdp_set_data_meta_invalid(&xdp);
 		xdp.data_end = xdp.data + len;
+		xdp.rxq = &rq->xdp_rxq;
 		orig_data = xdp.data;
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 
@@ -692,6 +696,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		xdp.data = data + vi->hdr_len;
 		xdp_set_data_meta_invalid(&xdp);
 		xdp.data_end = xdp.data + (len - vi->hdr_len);
+		xdp.rxq = &rq->xdp_rxq;
+
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 
 		if (act != XDP_PASS)
@@ -1225,13 +1231,18 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 static int virtnet_open(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	int i;
+	int i, err;
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
 			/* Make sure we have some buffers: if oom use wq. */
 			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
 				schedule_delayed_work(&vi->refill, 0);
+
+		err = xdp_rxq_info_reg(&vi->rq[i].xdp_rxq, dev, i);
+		if (err < 0)
+			return err;
+
 		virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
 		virtnet_napi_tx_enable(vi, vi->sq[i].vq, &vi->sq[i].napi);
 	}
@@ -1560,6 +1571,7 @@ static int virtnet_close(struct net_device *dev)
 	cancel_delayed_work_sync(&vi->refill);
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
+		xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
 		napi_disable(&vi->rq[i].napi);
 		virtnet_napi_tx_disable(&vi->sq[i].napi);
 	}
