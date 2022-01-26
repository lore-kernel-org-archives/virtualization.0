Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33DFC636D5
	for <virtualization@archiver.kernel.org>; Wed, 26 Jan 2022 07:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74374415DE;
	Wed, 26 Jan 2022 07:35:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nj6AajPhLlv0; Wed, 26 Jan 2022 07:35:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1B271415C5;
	Wed, 26 Jan 2022 07:35:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D092DC0031;
	Wed, 26 Jan 2022 07:35:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BAE7EC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 07:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B78A082E9C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 07:35:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZrxVtTQrvaY1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 07:35:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 151C182E14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 07:35:38 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V2uVHkt_1643182533; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V2uVHkt_1643182533) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 26 Jan 2022 15:35:33 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 00/17] virtio pci support VIRTIO_F_RING_RESET
Date: Wed, 26 Jan 2022 15:35:16 +0800
Message-Id: <20220126073533.44994-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
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

================================================================================
The virtio spec already supports the virtio queue reset function. This patch set
is to add this function to the kernel. The relevant virtio spec information is
here:

    https://github.com/oasis-tcs/virtio-spec/issues/124

Also regarding MMIO support for queue reset, I plan to support it after this
patch is passed.

#14-#17 is the disable/enable function of rx/tx pair implemented by virtio-net
using the new helper. This function is not currently referenced by other
functions. It is more to show the usage of the new helper, I not sure if they
are going to be merged together.

Please review. Thanks.

v3:
  1. keep vq, irq unreleased

Xuan Zhuo (17):
  virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
  virtio: queue_reset: add VIRTIO_F_RING_RESET
  virtio: queue_reset: struct virtio_config_ops add callbacks for
    queue_reset
  virtio: queue_reset: add helper
  vritio_ring: queue_reset: extract the release function of the vq ring
  virtio_ring: queue_reset: split: add __vring_init_virtqueue()
  virtio_ring: queue_reset: split: support enable reset queue
  virtio_ring: queue_reset: packed: support enable reset queue
  virtio_ring: queue_reset: add vring_reset_virtqueue()
  virtio_pci: queue_reset: update struct virtio_pci_common_cfg and
    option functions
  virtio_pci: queue_reset: release vq by vp_dev->vqs
  virtio_pci: queue_reset: setup_vq use vring_setup_virtqueue()
  virtio_pci: queue_reset: support VIRTIO_F_RING_RESET
  virtio_net: virtnet_tx_timeout() fix style
  virtio_net: virtnet_tx_timeout() stop ref sq->vq
  virtio_net: split free_unused_bufs()
  virtio_net: support pair disable/enable

 drivers/net/virtio_net.c               | 220 ++++++++++++++++++++++---
 drivers/virtio/virtio_pci_common.c     |  62 ++++---
 drivers/virtio/virtio_pci_common.h     |  11 +-
 drivers/virtio/virtio_pci_legacy.c     |   5 +-
 drivers/virtio/virtio_pci_modern.c     | 120 +++++++++++++-
 drivers/virtio/virtio_pci_modern_dev.c |  28 ++++
 drivers/virtio/virtio_ring.c           | 144 +++++++++++-----
 include/linux/virtio.h                 |   1 +
 include/linux/virtio_config.h          |  75 ++++++++-
 include/linux/virtio_pci_modern.h      |   2 +
 include/linux/virtio_ring.h            |  42 +++--
 include/uapi/linux/virtio_config.h     |   7 +-
 include/uapi/linux/virtio_pci.h        |   2 +
 13 files changed, 618 insertions(+), 101 deletions(-)

--
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
