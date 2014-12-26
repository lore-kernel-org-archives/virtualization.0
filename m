From: Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH 3/3] virtio-net: using single MSIX irq for each TX/RX
	queue pair
Date: Fri, 26 Dec 2014 10:53:45 +0800
Message-ID: <1419562425-20614-4-git-send-email-jasowang@redhat.com>
References: <1419562425-20614-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1419562425-20614-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

This patch try to reduce the number of MSIX irqs required for
virtio-net by sharing a MSIX irq for each TX/RX queue pair through
channels. If transport support channel, about half of the MSIX irqs
were reduced.

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3ba3499..03a0c28 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -72,6 +72,9 @@ struct send_queue {
 
 	/* Name of the send queue: output.$index */
 	char name[40];
+
+	/* Name of the channel, share with rxq */
+	char channel_name[40];
 };
 
 /* Internal representation of a receive virtqueue */
@@ -1522,6 +1525,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 	int ret = -ENOMEM;
 	int i, total_vqs;
 	const char **names;
+	const char **channel_names;
+	unsigned *channels;
 
 	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
 	 * possible N-1 RX/TX queue pairs used in multiqueue mode, followed by
@@ -1540,6 +1545,14 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 	names = kmalloc(total_vqs * sizeof(*names), GFP_KERNEL);
 	if (!names)
 		goto err_names;
+	channel_names = kmalloc_array(vi->max_queue_pairs,
+				      sizeof(*channel_names),
+				      GFP_KERNEL);
+	if (!channel_names)
+		goto err_channel_names;
+	channels = kmalloc_array(total_vqs, sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		goto err_channels;
 
 	/* Parameters for control virtqueue, if any */
 	if (vi->has_cvq) {
@@ -1555,10 +1568,15 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 		sprintf(vi->sq[i].name, "output.%d", i);
 		names[rxq2vq(i)] = vi->rq[i].name;
 		names[txq2vq(i)] = vi->sq[i].name;
+		sprintf(vi->sq[i].channel_name, "txrx.%d", i);
+		channel_names[i] = vi->sq[i].channel_name;
+		channels[rxq2vq(i)] = i;
+		channels[txq2vq(i)] = i;
 	}
 
 	ret = vi->vdev->config->find_vqs(vi->vdev, total_vqs, vqs, callbacks,
-					 names, NULL, NULL, 0);
+					 names, channels, channel_names,
+					 vi->max_queue_pairs);
 	if (ret)
 		goto err_find;
 
@@ -1573,6 +1591,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 		vi->sq[i].vq = vqs[txq2vq(i)];
 	}
 
+	kfree(channels);
+	kfree(channel_names);
 	kfree(names);
 	kfree(callbacks);
 	kfree(vqs);
@@ -1580,6 +1600,10 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 	return 0;
 
 err_find:
+	kfree(channels);
+err_channels:
+	kfree(channel_names);
+err_channel_names:
 	kfree(names);
 err_names:
 	kfree(callbacks);
-- 
1.8.3.1
