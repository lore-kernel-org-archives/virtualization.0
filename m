Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B70C678D4
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 11:59:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C769D40FC4;
	Thu,  2 Mar 2023 11:59:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C769D40FC4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oaoi-z94HUqS; Thu,  2 Mar 2023 11:59:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4805E40C20;
	Thu,  2 Mar 2023 11:59:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4805E40C20
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28786C0035;
	Thu,  2 Mar 2023 11:59:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66901C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E6C96113B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E6C96113B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KxGtZePkss-x
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F47360EC4
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F47360EC4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:12 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VcxJKlJ_1677758348; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VcxJKlJ_1677758348) by smtp.aliyun-inc.com;
 Thu, 02 Mar 2023 19:59:08 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v1 00/12] virtio core prepares for AF_XDP
Date: Thu,  2 Mar 2023 19:58:56 +0800
Message-Id: <20230302115908.1461-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
X-Git-Hash: b21604ee9ed7
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

v1:
 1. expose dma device. NO introduce the api for dma and sync
 2. split some commit for review.

Xuan Zhuo (12):
  virtio_ring: split: refactor virtqueue_add_split() for premapped
  virtio_ring: split: separate DMA codes
  virtio_ring: split: introduce virtqueue_add_split_premapped()
  virtio_ring: packed: separate prepare code from
    virtuque_add_indirect_packed()
  virtio_ring: packed: refactor virtqueue_add_packed() for premapped
  virtio_ring: packed: separate DMA codes
  virtio_ring: packed: introduce virtqueue_add_packed_premapped()
  virtio_ring: introduce virtqueue_add_inbuf_premapped()
  virtio_ring: introduce virtqueue_get_dma_dev()
  virtio_ring: correct the expression of the description of
    virtqueue_resize()
  virtio_ring: separate the logic of reset/enable from virtqueue_resize
  virtio_ring: introduce virtqueue_reset()

 drivers/virtio/virtio.c      |   6 +
 drivers/virtio/virtio_ring.c | 636 ++++++++++++++++++++++++-----------
 include/linux/virtio.h       |  14 +
 3 files changed, 466 insertions(+), 190 deletions(-)

--
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
