Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DED2C433FE
	for <virtualization@archiver.kernel.org>; Sun, 24 Apr 2022 02:40:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25E4140933;
	Sun, 24 Apr 2022 02:40:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xwWl7aXKmF3k; Sun, 24 Apr 2022 02:40:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6265A40924;
	Sun, 24 Apr 2022 02:40:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EFF2C0032;
	Sun, 24 Apr 2022 02:40:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03F8CC002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF9E981A23
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QbYxHaPH_Phn
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9A88E819FC
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:49 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0VAzRZXj_1650768044; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VAzRZXj_1650768044) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 24 Apr 2022 10:40:45 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 00/16] virtio_ring: resize support re-use the old buffers
Date: Sun, 24 Apr 2022 10:40:28 +0800
Message-Id: <20220424024044.94749-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
X-Git-Hash: c42022d07dde
Cc: virtualization@lists.linux-foundation.org,
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

This patch set is based on "virtio pci support VIRTIO_F_RING_RESET". This patch
set is rfc since it hasn't been merged yet. And "virtio pci support
VIRTIO_F_RING_RESET" is currently waiting for Jason Wang's "rework on the IRQ
hardening of virtio".

This patch set implements the reuse of buffers committed before resize.
And it is resubmitted to the new vq in the order of the original submission.

A core idea is to detach the original vring after the new vring is allocated.
Then, the buffers are sequentially obtained from the old vring and submitted to
the new vq.

Please review.

Xuan Zhuo (16):
  virtio_ring: split: vring_unmap_one_split() get extra by arg
  virtio_ring: split: introduce vring_virtqueue_detach_split()
  virtio_ring: split: extract virtqueue_update_split()
  virtio_ring: split: extract detach_from_vring_split()
  virtio_ring: split: support copy from vring
  virtio_ring: split: introduce vring_reuse_bufs_split()
  virtio_ring: split: resize support re-use buffers
  virtio_ring: packed: extract next_idx()
  virtio_ring: packed: always update desc_extra
  virtio_ring: packed: introduce vring_virtqueue_detach_packed()
  virtio_ring: packed: extract virtqueue_update_packed()
  virtio_ring: packed: extract detach_from_vring_packed()
  virtio_ring: packed: support copy from vring
  virtio_ring: packed: introduce vring_reuse_bufs_packed()
  virtio_ring: packed: resize support re-use buffers
  virtio_ring: virtqueue_resize() no longer call recycle() directly

 drivers/virtio/virtio_ring.c | 685 ++++++++++++++++++++++++++---------
 1 file changed, 518 insertions(+), 167 deletions(-)

--
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
