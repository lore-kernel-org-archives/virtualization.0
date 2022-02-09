Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180BBC433EF
	for <virtualization@archiver.kernel.org>; Wed,  9 Feb 2022 12:29:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DBF482C18;
	Wed,  9 Feb 2022 12:29:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VPLKGxbcwf3J; Wed,  9 Feb 2022 12:29:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3289A82A2D;
	Wed,  9 Feb 2022 12:29:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A516C0021;
	Wed,  9 Feb 2022 12:29:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A0C7C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 78D2960E2F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uaPtKK_oqyZn
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C894360B58
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:05 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V4.YQeC_1644409741; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V4.YQeC_1644409741) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Feb 2022 20:29:02 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/14] virtio pci support VIRTIO_F_RING_RESET
Date: Wed,  9 Feb 2022 20:28:47 +0800
Message-Id: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
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

The virtio spec already supports the virtio queue reset function. This patch set
is to add this function to the kernel. The relevant virtio spec information is
here:

    https://github.com/oasis-tcs/virtio-spec/issues/124

Also regarding MMIO support for queue reset, I plan to support it after this
patch is passed.

Please review. Thanks.

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

Xuan Zhuo (14):
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
  virtio_pci: queue_reset: vp_setup_vq() support ring_num
  virtio_pci: queue_reset: support VIRTIO_F_RING_RESET

 drivers/virtio/virtio_pci_common.c     |  65 +++++++---
 drivers/virtio/virtio_pci_common.h     |  11 +-
 drivers/virtio/virtio_pci_legacy.c     |   5 +-
 drivers/virtio/virtio_pci_modern.c     |  99 ++++++++++++--
 drivers/virtio/virtio_pci_modern_dev.c |  36 +++++
 drivers/virtio/virtio_ring.c           | 173 ++++++++++++++++++-------
 include/linux/virtio.h                 |   6 +
 include/linux/virtio_config.h          |  13 ++
 include/linux/virtio_pci_modern.h      |   2 +
 include/linux/virtio_ring.h            |  37 ++++--
 include/uapi/linux/virtio_config.h     |   7 +-
 include/uapi/linux/virtio_pci.h        |  14 ++
 12 files changed, 375 insertions(+), 93 deletions(-)

--
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
