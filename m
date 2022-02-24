Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE49C433EF
	for <virtualization@archiver.kernel.org>; Thu, 24 Feb 2022 11:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A73C981C2F;
	Thu, 24 Feb 2022 11:04:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qXDxcJ5iaT7t; Thu, 24 Feb 2022 11:04:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 594158198A;
	Thu, 24 Feb 2022 11:04:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 313C7C0021;
	Thu, 24 Feb 2022 11:04:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAE19C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 11:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A4F8A404F7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 11:04:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ggu2vo7QFifn
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 11:04:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 131ED40482
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 11:04:06 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V5O5g7L_1645700642; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V5O5g7L_1645700642) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 24 Feb 2022 19:04:03 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 0/9] virtio: support advance DMA
Date: Thu, 24 Feb 2022 19:03:53 +0800
Message-Id: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
X-Git-Hash: d02e086a8668
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

v2:
    1. rename predma -> premapped
    2. virtio net xdp tx use virtio dma api

v1:
   1. All sgs requested at one time are required to be unified PREDMA, and several
      of them are not supported to be PREDMA
   2. virtio_dma_map() is removed from this patch set and will be submitted
      together with the next time AF_XDP supports virtio dma
   3. Added patch #2 #3 to remove the check for flags when performing unmap
      indirect desc

Xuan Zhuo (9):
  virtio_ring: rename vring_unmap_state_packed() to
    vring_unmap_extra_packed()
  virtio_ring: remove flags check for unmap split indirect desc
  virtio_ring: remove flags check for unmap packed indirect desc
  virtio_ring: virtqueue_add() support premapped
  virtio_ring: split: virtqueue_add_split() support premapped
  virtio_ring: packed: virtqueue_add_packed() support premapped
  virtio_ring: add api virtio_dma_map() for advance dma
  virtio_ring: introduce virtqueue_add_outbuf_premapped()
  virtio_net: xdp xmit use virtio dma api

 drivers/net/virtio_net.c     |  42 +++++-
 drivers/virtio/virtio_ring.c | 280 ++++++++++++++++++++++++++---------
 include/linux/virtio.h       |  12 ++
 3 files changed, 254 insertions(+), 80 deletions(-)

--
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
