Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C96C433EF
	for <virtualization@archiver.kernel.org>; Thu, 20 Jan 2022 06:43:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CECB160BAE;
	Thu, 20 Jan 2022 06:43:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0m7MQR3bZVn1; Thu, 20 Jan 2022 06:43:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 878D860DA5;
	Thu, 20 Jan 2022 06:43:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48FD6C0039;
	Thu, 20 Jan 2022 06:43:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89265C002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 06:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E457828D1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 06:43:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OBoFKlwOIp6t
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 06:43:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2045282A7F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 06:43:09 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R501e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V2KWFIC_1642660983; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V2KWFIC_1642660983) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 20 Jan 2022 14:43:04 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 00/12] virtio pci support VIRTIO_F_RING_RESET
Date: Thu, 20 Jan 2022 14:42:51 +0800
Message-Id: <20220120064303.106639-1-xuanzhuo@linux.alibaba.com>
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

The virtio spec already supports the virtio queue reset function. This patch set
is to add this function to the kernel. The relevant virtio spec information is
here:

    https://github.com/oasis-tcs/virtio-spec/issues/124

Also regarding MMIO support for queue reset, I plan to support it after this
patch is passed.

#9-#12 is the disable/enable function of rx/tx pair implemented by virtio-net
using the new helper. This function is not currently referenced by other
functions. It is more to show the usage of the new helper, I not sure if they
are going to be merged together.

Please review. Thanks.

Xuan Zhuo (12):
  virtio: pci: struct virtio_pci_common_cfg add queue_notify_data
  virtio: queue_reset: add VIRTIO_F_RING_RESET
  virtio: queue_reset: struct virtio_config_ops add callbacks for
    queue_reset
  virtio: queue_reset: pci: update struct virtio_pci_common_cfg and
    option functions
  virito: queue_reset: pci: move the per queue irq logic from vp_del_vqs
    to vp_del_vq
  virtio: queue_reset: pci: add independent function to enable msix vq
  virtio: queue_reset: pci: support VIRTIO_F_RING_RESET
  virtio: queue_reset: add helper
  virtio_net: virtnet_tx_timeout() fix style
  virtio_net: virtnet_tx_timeout() stop ref sq->vq
  virtio_net: split free_unused_bufs()
  virtio-net: support pair disable/enable

 drivers/net/virtio_net.c               | 200 ++++++++++++++++++++++---
 drivers/virtio/virtio_pci_common.c     | 135 +++++++++++++----
 drivers/virtio/virtio_pci_common.h     |   4 +
 drivers/virtio/virtio_pci_modern.c     |  73 +++++++++
 drivers/virtio/virtio_pci_modern_dev.c |  28 ++++
 include/linux/virtio_config.h          |  63 ++++++++
 include/linux/virtio_pci_modern.h      |   2 +
 include/uapi/linux/virtio_config.h     |   7 +-
 include/uapi/linux/virtio_pci.h        |   2 +
 9 files changed, 460 insertions(+), 54 deletions(-)

--
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
