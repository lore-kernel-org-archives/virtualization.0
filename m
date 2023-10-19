Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E357CDB465
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 06:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E07442847;
	Thu, 19 Oct 2023 06:35:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E07442847
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HCKsxEpoZ9BN; Thu, 19 Oct 2023 06:35:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 00A8C426BE;
	Thu, 19 Oct 2023 06:35:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 00A8C426BE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9234CC0071;
	Thu, 19 Oct 2023 06:35:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63FD1C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:35:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 328F3424EF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:35:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 328F3424EF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d44m-XUimC_3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:35:44 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C82E9424E7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:35:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C82E9424E7
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R271e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VuT.sgQ_1697697333; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VuT.sgQ_1697697333) by smtp.aliyun-inc.com;
 Thu, 19 Oct 2023 14:35:34 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost] virtio-ring: split: update avali idx lazily
Date: Thu, 19 Oct 2023 14:35:33 +0800
Message-Id: <20231019063533.99684-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
X-Git-Hash: a4a7a56e126b
Cc: mst@redhat.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

If the vhost-user device is in busy-polling mode, the cachelines of
avali ring are raced by the driver process and the vhost-user process.
Because that the idx will be updated everytime, when the new ring items
are updated. So one cache line will be read too times, the two processes
will race the cache line. So I change the way the idx is updated, we
only update the idx before notifying the device.

test command:
    This is the command, that testpmd runs with virtio-net AF_XDP.

    ./build/app/dpdk-testpmd -l 1-2 --no-pci --main-lcore=2 \
            --vdev net_af_xdp0,iface=ens5,queue_count=1,busy_budget=0 \
            --log-level=pmd.net.af_xdp:8 \
            -- -i -a --nb-cores=1 --rxq=1 --txq=1 --forward-mode=macswap

without this commit:
    testpmd> show port stats all

      ######################## NIC statistics for port 0  ########################
      RX-packets: 3615824336 RX-missed: 0          RX-bytes:  202486162816
      RX-errors: 0
      RX-nombuf:  0
      TX-packets: 3615795592 TX-errors: 20738      TX-bytes:  202484553152

      Throughput (since last show)
      Rx-pps:      3790446          Rx-bps:   1698120056
      Tx-pps:      3790446          Tx-bps:   1698120056
      ############################################################################

with this commit:
    testpmd> show port stats all

      ######################## NIC statistics for port 0  ########################
      RX-packets: 68152727   RX-missed: 0          RX-bytes:  3816552712
      RX-errors: 0
      RX-nombuf:  0
      TX-packets: 68114967   TX-errors: 33216      TX-bytes:  3814438152

      Throughput (since last show)
      Rx-pps:      6333196          Rx-bps:   2837272088
      Tx-pps:      6333227          Tx-bps:   2837285936
      ############################################################################

perf c2c:

    On the vhost-user side, the perf c2c show 34.25% Hitm of the first cache
    line of the avail structure without this commit. The hitm reduces to
    1.57% when this commit is included.

dpdk:

    I read the code of the dpdk, there is the similar code.

    virtio_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
    {
    	[...]

    	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {

    		[...]

    		/* Enqueue Packet buffers */
    		virtqueue_enqueue_xmit(txvq, txm, slots, use_indirect,
    			can_push, 0);
    	}

    	[...]

    	if (likely(nb_tx)) {
    -->		vq_update_avail_idx(vq);

    		if (unlikely(virtqueue_kick_prepare(vq))) {
    			virtqueue_notify(vq);
    			PMD_TX_LOG(DEBUG, "Notified backend after xmit");
    		}
    	}
    }

End:

    Is all the _prepared() is called before _notify()?
    I checked, all the _notify() is called after the _prepare().

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 51d8f3299c10..215a38065d22 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -687,12 +687,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
 	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
 
-	/* Descriptors and available array need to be set before we expose the
-	 * new available array entries. */
-	virtio_wmb(vq->weak_barriers);
 	vq->split.avail_idx_shadow++;
-	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
-						vq->split.avail_idx_shadow);
 	vq->num_added++;
 
 	pr_debug("Added buffer head %i to %p\n", head, vq);
@@ -738,6 +733,14 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 	bool needs_kick;
 
 	START_USE(vq);
+
+	/* Descriptors and available array need to be set before we expose the
+	 * new available array entries.
+	 */
+	virtio_wmb(vq->weak_barriers);
+	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
+						vq->split.avail_idx_shadow);
+
 	/* We need to expose available array entries before checking avail
 	 * event. */
 	virtio_mb(vq->weak_barriers);
@@ -2355,6 +2358,8 @@ EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
  * virtqueue_notify - second half of split virtqueue_kick call.
  * @_vq: the struct virtqueue
  *
+ * The caller MUST call virtqueue_kick_prepare() firstly.
+ *
  * This does not need to be serialized.
  *
  * Returns false if host notify failed or queue is broken, otherwise true.
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
