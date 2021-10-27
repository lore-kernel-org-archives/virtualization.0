Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB2CC4332F
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 06:19:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E2260F0F
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 06:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 51E2260F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1CBE4401FE;
	Wed, 27 Oct 2021 06:19:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aIgjNHAXQ7Xa; Wed, 27 Oct 2021 06:19:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8AA6D403D7;
	Wed, 27 Oct 2021 06:19:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98E53C003E;
	Wed, 27 Oct 2021 06:19:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDC8BC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 06:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A138680D5A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 06:19:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tfbu6-Zu_9te
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 06:19:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ACB0B80D58
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 06:19:18 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R961e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0Utr84H5_1635315555; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Utr84H5_1635315555) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 27 Oct 2021 14:19:16 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH 3/3] virtio-net: enable virtio indirect cache
Date: Wed, 27 Oct 2021 14:19:13 +0800
Message-Id: <20211027061913.76276-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211027061913.76276-1-xuanzhuo@linux.alibaba.com>
References: <20211027061913.76276-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

If the VIRTIO_RING_F_INDIRECT_DESC negotiation succeeds, and the number
of sgs used for sending packets is greater than 1. We must constantly
call __kmalloc/kfree to allocate/release desc.

In the case of extremely fast package delivery, the overhead cannot be
ignored:

  27.46%  [kernel]  [k] virtqueue_add
  16.66%  [kernel]  [k] detach_buf_split
  16.51%  [kernel]  [k] virtnet_xsk_xmit
  14.04%  [kernel]  [k] virtqueue_add_outbuf
   5.18%  [kernel]  [k] __kmalloc
   4.08%  [kernel]  [k] kfree
   2.80%  [kernel]  [k] virtqueue_get_buf_ctx
   2.22%  [kernel]  [k] xsk_tx_peek_desc
   2.08%  [kernel]  [k] memset_erms
   0.83%  [kernel]  [k] virtqueue_kick_prepare
   0.76%  [kernel]  [k] virtnet_xsk_run
   0.62%  [kernel]  [k] __free_old_xmit_ptr
   0.60%  [kernel]  [k] vring_map_one_sg
   0.53%  [kernel]  [k] native_apic_mem_write
   0.46%  [kernel]  [k] sg_next
   0.43%  [kernel]  [k] sg_init_table
   0.41%  [kernel]  [k] kmalloc_slab

Compared to not using virtio indirect cache, virtio-net can get a 16%
performance improvement when using indirect desc cache.

In the test case, the CPU where the package is sent has reached 100%.
The following are the PPS in two cases:

    indirect desc cache  | no cache
    3074658              | 2685132
    3111866              | 2666118
    3152527              | 2653632
    3125867              | 2669820
    3027147              | 2644464
    3069211              | 2669777
    3038522              | 2675645
    3034507              | 2671302
    3102257              | 2685504
    3083712              | 2692800
    3051771              | 2676928
    3080684              | 2695040
    3147816              | 2720876
    3123887              | 2705492
    3180963              | 2699520
    3191579              | 2676480
    3161670              | 2686272
    3189768              | 2692588
    3174272              | 2686692
    3143434              | 2682416

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4ad25a8b0870..0ec29cf90d0a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -27,9 +27,11 @@ static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
 
 static bool csum = true, gso = true, napi_tx = true;
+static bool virtio_desc_cache = true;
 module_param(csum, bool, 0444);
 module_param(gso, bool, 0444);
 module_param(napi_tx, bool, 0644);
+module_param(virtio_desc_cache, bool, 0644);
 
 /* FIXME: MTU in config. */
 #define GOOD_PACKET_LEN (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)
@@ -3214,6 +3216,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 		vi->curr_queue_pairs = num_online_cpus();
 	vi->max_queue_pairs = max_queue_pairs;
 
+	virtio_use_desc_cache(vdev, virtio_desc_cache);
+
 	/* Allocate/initialize the rx/tx queues, and invoke find_vqs */
 	err = init_vqs(vi);
 	if (err)
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
