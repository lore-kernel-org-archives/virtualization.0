Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52263C4332F
	for <virtualization@archiver.kernel.org>; Mon, 14 Feb 2022 08:14:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05724813D2;
	Mon, 14 Feb 2022 08:14:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wZCHY_skypSa; Mon, 14 Feb 2022 08:14:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9CC0C81361;
	Mon, 14 Feb 2022 08:14:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 716D3C0077;
	Mon, 14 Feb 2022 08:14:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32DFCC0011
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DAB4840370
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TSS4jyNwZygu
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4798B401D5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:31 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V4NbDMb_1644826456; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V4NbDMb_1644826456) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 14 Feb 2022 16:14:17 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 00/22] virtio pci support VIRTIO_F_RING_RESET
Date: Mon, 14 Feb 2022 16:13:54 +0800
Message-Id: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
X-Git-Hash: 24fd8391539b
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

The virtio spec already supports the virtio queue reset function. This patch set
is to add this function to the kernel. The relevant virtio spec information is
here:

    https://github.com/oasis-tcs/virtio-spec/issues/124

Also regarding MMIO support for queue reset, I plan to support it after this
patch is passed.

Performing reset on a queue is divided into four steps:
    1. reset_vq: reset one vq
    2. recycle the buffer from vq by virtqueue_detach_unused_buf()
    3. release the ring of the vq by vring_release_virtqueue()
    4. enable_reset_vq: re-enable the reset queue

#2-#8  : virtio ring support re-enable reset queue and release vring
#9-#14 : virtio PCI support reset queue and re-enable
#15    : add queue reset helper
#16-#17: virtio-net support rx, tx reset
#18-#22: virtio-net support set ringparam

Please review. Thanks.

v5:
  1. add virtio-net support set_ringparam

v4:
  1. just the code of virtio, without virtio-net
  2. Performing reset on a queue is divided into these steps:
    1. reset_vq: reset one vq
    2. recycle the buffer from vq by virtqueue_detach_unused_buf()
    3. release the ring of the vq by vring_release_virtqueue()
    4. enable_reset_vq: re-enable the reset queue
  3. Simplify the parameters of enable_reset_vq()
  4. add container structures for virtio_pci_common_cfg

v3:
  1. keep vq, irq unreleased

Xuan Zhuo (22):
  virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
  virtio: queue_reset: add VIRTIO_F_RING_RESET
  virtio_ring: queue_reset: add function vring_setup_virtqueue()
  virtio_ring: queue_reset: split: add __vring_init_virtqueue()
  virtio_ring: queue_reset: split: support enable reset queue
  virtio_ring: queue_reset: packed: support enable reset queue
  virtio_ring: queue_reset: extract the release function of the vq ring
  virtio_ring: queue_reset: add vring_release_virtqueue()
  virtio: queue_reset: struct virtio_config_ops add callbacks for
    queue_reset
  virtio_pci: queue_reset: update struct virtio_pci_common_cfg and
    option functions
  virtio_pci: queue_reset: release vq by vp_dev->vqs
  virtio_pci: queue_reset: setup_vq() support vring_setup_virtqueue()
  virtio_pci: queue_reset: reserve vq->priv for re-enable queue
  virtio_pci: queue_reset: support VIRTIO_F_RING_RESET
  virtio: queue_reset: add helper
  virtio_net: split free_unused_bufs()
  virtio_net: support rx/tx queue reset
  virtio: add helper virtqueue_get_vring_max_size()
  virtio: add helper virtio_set_max_ring_num()
  virtio_net: set the default max ring num
  virtio_net: get max ring size by virtqueue_get_vring_max_size()
  virtio_net: support set_ringparam

 drivers/net/virtio_net.c               | 238 ++++++++++++++++++++++---
 drivers/virtio/virtio_mmio.c           |   2 +
 drivers/virtio/virtio_pci_common.c     |  61 +++++--
 drivers/virtio/virtio_pci_common.h     |  10 +-
 drivers/virtio/virtio_pci_legacy.c     |   6 +-
 drivers/virtio/virtio_pci_modern.c     |  82 ++++++++-
 drivers/virtio/virtio_pci_modern_dev.c |  36 ++++
 drivers/virtio/virtio_ring.c           | 193 +++++++++++++++-----
 include/linux/virtio.h                 |  15 ++
 include/linux/virtio_config.h          |  82 +++++++++
 include/linux/virtio_pci_modern.h      |   2 +
 include/linux/virtio_ring.h            |  37 ++--
 include/uapi/linux/virtio_config.h     |   7 +-
 include/uapi/linux/virtio_pci.h        |  14 ++
 14 files changed, 668 insertions(+), 117 deletions(-)

--
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
