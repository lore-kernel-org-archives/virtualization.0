Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70784C6FD20
	for <virtualization@archiver.kernel.org>; Wed, 22 Mar 2023 02:57:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10FE681325;
	Wed, 22 Mar 2023 02:57:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 10FE681325
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gTjG9crw3yjg; Wed, 22 Mar 2023 02:57:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9B191811F7;
	Wed, 22 Mar 2023 02:57:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9B191811F7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73F65C007E;
	Wed, 22 Mar 2023 02:57:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CF9DC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 02:57:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3B8B810D6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 02:57:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B3B8B810D6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sLa_5rMJyPMb
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 02:57:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD32281186
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD32281186
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 02:57:09 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VeOqTO5_1679453821; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VeOqTO5_1679453821) by smtp.aliyun-inc.com;
 Wed, 22 Mar 2023 10:57:01 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v4 00/11] virtio core prepares for AF_XDP
Date: Wed, 22 Mar 2023 10:56:50 +0800
Message-Id: <20230322025701.2955-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
X-Git-Hash: b085e6b5b953
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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



Xuan Zhuo (11):
  virtio_ring: split: separate dma codes
  virtio_ring: packed: separate dma codes
  virtio_ring: packed-indirect: separate dma codes
  virtio_ring: split: support premapped
  virtio_ring: packed: support premapped
  virtio_ring: packed-indirect: support premapped
  virtio_ring: update document for virtqueue_add_*
  virtio_ring: introduce virtqueue_dma_dev()
  virtio_ring: correct the expression of the description of
    virtqueue_resize()
  virtio_ring: separate the logic of reset/enable from virtqueue_resize
  virtio_ring: introduce virtqueue_reset()

 drivers/virtio/virtio.c      |   6 +
 drivers/virtio/virtio_ring.c | 342 +++++++++++++++++++++++++----------
 include/linux/virtio.h       |   4 +
 3 files changed, 255 insertions(+), 97 deletions(-)

--
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
