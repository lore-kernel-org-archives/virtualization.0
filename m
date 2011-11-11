From: Krishna Kumar <krkumar2@in.ibm.com>
Subject: [RFC] [ver3 PATCH 6/6] virtio_net: Convert virtio_net driver to use
	find_vqs_irq
Date: Fri, 11 Nov 2011 18:37:15 +0530
Message-ID: <20111111130715.9878.31409.sendpatchset__2616.55894942141$1321021797$gmane$org@krkumar2.in.ibm.com>
References: <20111111130223.9878.59517.sendpatchset@krkumar2.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111111130223.9878.59517.sendpatchset@krkumar2.in.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, mst@redhat.com
Cc: Krishna Kumar <krkumar2@in.ibm.com>, netdev@vger.kernel.org, davem@davemloft.net, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Convert virtio_net driver to use find_vqs_irq(). The TX vq's
share a single irq, while the RX vq's have individual irq's.
The skb_xmit_done handler also checks if any work is required.

Signed-off-by: krkumar2@in.ibm.com
---
 drivers/net/virtio_net.c |   29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff -ruNp org/drivers/net/virtio_net.c new/drivers/net/virtio_net.c
--- org/drivers/net/virtio_net.c	2011-11-11 16:45:17.000000000 +0530
+++ new/drivers/net/virtio_net.c	2011-11-11 16:48:45.000000000 +0530
@@ -163,11 +163,13 @@ static void skb_xmit_done(struct virtque
 	struct virtnet_info *vi = vq->vdev->priv;
 	int qnum = vq->queue_index / 2; /* RX/TX vqs are allocated in pairs */
 
-	/* Suppress further interrupts. */
-	virtqueue_disable_cb(vq);
+	if (__netif_subqueue_stopped(vi->dev, qnum)) {
+		/* Suppress further interrupts. */
+		virtqueue_disable_cb(vq);
 
-	/* We were probably waiting for more output buffers. */
-	netif_wake_subqueue(vi->dev, qnum);
+		/* We were probably waiting for more output buffers. */
+		netif_wake_subqueue(vi->dev, qnum);
+	}
 }
 
 static void set_skb_frag(struct sk_buff *skb, struct page *page,
@@ -1120,6 +1122,7 @@ static void setup_cvq(struct virtnet_inf
 
 static int invoke_find_vqs(struct virtnet_info *vi)
 {
+	unsigned long *flags = NULL;
 	vq_callback_t **callbacks;
 	struct virtqueue **vqs;
 	int ret = -ENOMEM;
@@ -1141,6 +1144,14 @@ static int invoke_find_vqs(struct virtne
 	if (!vqs || !callbacks || !names)
 		goto err;
 
+	if (vi->num_queue_pairs > 1) {
+		int num = (total_vqs + BITS_PER_LONG - 1) / BITS_PER_LONG;
+
+		flags = kzalloc(num * sizeof(*flags), GFP_KERNEL);
+		if (!flags)
+			goto err;
+	}
+
 	/* Allocate/initialize parameters for recv virtqueues */
 	for (i = 0; i < vi->num_queue_pairs * 2; i += 2) {
 		callbacks[i] = skb_recv_done;
@@ -1155,6 +1166,8 @@ static int invoke_find_vqs(struct virtne
 		names[i] = kasprintf(GFP_KERNEL, "output.%d", i / 2);
 		if (!names[i])
 			goto err;
+		if (flags)
+			set_bit(i, flags);
 	}
 
 	/* Parameters for control virtqueue, if any */
@@ -1163,9 +1176,9 @@ static int invoke_find_vqs(struct virtne
 		names[i - 1] = "control";
 	}
 
-	ret = vi->vdev->config->find_vqs(vi->vdev, total_vqs, vqs, callbacks,
-					 (const char **)names);
-
+	ret = vi->vdev->config->find_vqs_irq(vi->vdev, total_vqs, vqs,
+					     callbacks, (const char **)names,
+					     flags);
 	if (ret)
 		goto err;
 
@@ -1174,6 +1187,8 @@ static int invoke_find_vqs(struct virtne
 	setup_cvq(vi, vqs, vi->num_queue_pairs * 2);
 
 err:
+	kfree(flags);
+
 	if (ret && names)
 		for (i = 0; i < vi->num_queue_pairs * 2; i++)
 			kfree(names[i]);
