Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B2BC433EF
	for <virtualization@archiver.kernel.org>; Thu, 10 Feb 2022 08:51:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD3AF410A5;
	Thu, 10 Feb 2022 08:51:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DuUqg5r9J_d3; Thu, 10 Feb 2022 08:51:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 690EB410D1;
	Thu, 10 Feb 2022 08:51:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABF75C0072;
	Thu, 10 Feb 2022 08:51:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 328C0C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 08:51:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2433040A04
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 08:51:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EyZXPqz2JGrg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 08:51:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 54174410A5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 08:51:29 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V43G28E_1644483084; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V43G28E_1644483084) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 10 Feb 2022 16:51:25 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v1 0/6] virtio: support advance DMA
Date: Thu, 10 Feb 2022 16:51:18 +0800
Message-Id: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
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

virtqueue_add() only supports virtual addresses, dma is completed in
virtqueue_add().

In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
it is necessary for us to support passing the DMA address to virtqueue_add().

Record this predma information in extra->flags, which can be skipped when
executing dma unmap.

v1:
   1. All sgs requested at one time are required to be unified PREDMA, and several
      of them are not supported to be PREDMA
   2. virtio_dma_map() is removed from this patch set and will be submitted
      together with the next time AF_XDP supports virtio dma
   3. Added patch #2 #3 to remove the check for flags when performing unmap
      indirect desc

Xuan Zhuo (6):
  virtio: rename vring_unmap_state_packed() to
    vring_unmap_extra_packed()
  virtio: remove flags check for unmap split indirect desc
  virtio: remove flags check for unmap packed indirect desc
  virtio: virtqueue_add() support predma
  virtio: split: virtqueue_add_split() support dma address
  virtio: packed: virtqueue_add_packed() support dma address

 drivers/virtio/virtio_ring.c | 199 ++++++++++++++++++++++-------------
 1 file changed, 126 insertions(+), 73 deletions(-)

--
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
