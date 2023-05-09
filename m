Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2AEC77B75
	for <virtualization@archiver.kernel.org>; Tue,  9 May 2023 08:09:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD95A614B3;
	Tue,  9 May 2023 08:09:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD95A614B3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6xE-KpJ6PTWR; Tue,  9 May 2023 08:09:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 61714611D0;
	Tue,  9 May 2023 08:09:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 61714611D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97BA5C008F;
	Tue,  9 May 2023 08:09:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5066C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 08:09:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 836266104F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 08:09:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 836266104F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5OJyDHAtOKLH
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 08:09:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9387E60E43
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9387E60E43
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 08:09:09 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R751e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0ViAH4kR_1683619742; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0ViAH4kR_1683619742) by smtp.aliyun-inc.com;
 Tue, 09 May 2023 16:09:03 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v8 00/12] virtio core prepares for AF_XDP
Date: Tue,  9 May 2023 16:08:50 +0800
Message-Id: <20230509080902.104619-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
X-Git-Hash: 3c61b1a50a99
Cc: Christoph Hellwig <hch@infradead.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
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

## About DMA APIs

Now, virtio may can not work with DMA APIs when virtio features do not have
VIRTIO_F_ACCESS_PLATFORM.

1. I tried to let DMA APIs return phy address by virtio-device. But DMA APIs just
   work with the "real" devices.
2. I tried to let xsk support callballs to get phy address from virtio-net
   driver as the dma address. But the maintainers of xsk may want to use dma-buf
   to replace the DMA APIs. I think that may be a larger effort. We will wait
   too long.

So rethinking this, firstly, we can support premapped-dma only for devices with
VIRTIO_F_ACCESS_PLATFORM. In the case of af-xdp, if the users want to use it,
they have to update the device to support VIRTIO_F_RING_RESET, and they can also
enable the device's VIRTIO_F_ACCESS_PLATFORM feature.

Thanks for the help from Christoph.

=================

XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
copy feature of xsk (XDP socket) needs to be supported by the driver. The
performance of zero copy is very good.

ENV: Qemu with vhost.

                   vhost cpu | Guest APP CPU |Guest Softirq CPU | PPS
-----------------------------|---------------|------------------|------------
xmit by sockperf:     90%    |   100%        |                  |  318967
xmit by xsk:          100%   |   30%         |   33%            | 1192064
recv by sockperf:     100%   |   68%         |   100%           |  692288
recv by xsk:          100%   |   33%         |   43%            |  771670

Before achieving the function of Virtio-Net, we also have to let virtio core
support these features:

1. virtio core support premapped
2. virtio core support reset per-queue
3. introduce DMA APIs to virtio core

Please review.

Thanks.

v8:
 1. vring_sg_address: check by sg_page(sg) not dma_address. Because 0 is a valid dma address
 2. remove unused code from vring_map_one_sg()

v7:
 1. virtqueue_dma_dev() return NULL when virtio is without DMA API.

v6:
 1. change the size of the flags to u32.

v5:
 1. fix for error handler
 2. add flags to record internal dma mapping

v4:
 1. rename map_inter to dma_map_internal
 2. fix: Excess function parameter 'vq' description in 'virtqueue_dma_dev'

v3:
 1. add map_inter to struct desc state to reocrd whether virtio core do dma map

v2:
 1. based on sgs[0]->dma_address to judgment is premapped
 2. based on extra.addr to judgment to do unmap for no-indirect desc
 3. based on indir_desc to judgment to do unmap for indirect desc
 4. rename virtqueue_get_dma_dev to virtqueue_dma_dev

v1:
 1. expose dma device. NO introduce the api for dma and sync
 2. split some commit for review.


Xuan Zhuo (12):
  virtio_ring: split: separate dma codes
  virtio_ring: packed: separate dma codes
  virtio_ring: packed-indirect: separate dma codes
  virtio_ring: split: support premapped
  virtio_ring: packed: support premapped
  virtio_ring: packed-indirect: support premapped
  virtio_ring: remove unused code
  virtio_ring: update document for virtqueue_add_*
  virtio_ring: introduce virtqueue_dma_dev()
  virtio_ring: correct the expression of the description of
    virtqueue_resize()
  virtio_ring: separate the logic of reset/enable from virtqueue_resize
  virtio_ring: introduce virtqueue_reset()

 drivers/virtio/virtio_ring.c | 375 +++++++++++++++++++++++++----------
 include/linux/virtio.h       |   4 +
 2 files changed, 272 insertions(+), 107 deletions(-)

--
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
