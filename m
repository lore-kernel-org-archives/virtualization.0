Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D66C433FE
	for <virtualization@archiver.kernel.org>; Wed, 19 Jan 2022 02:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3395F410D3;
	Wed, 19 Jan 2022 02:35:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id piGePIHFP-q9; Wed, 19 Jan 2022 02:35:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CCE3141296;
	Wed, 19 Jan 2022 02:35:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DE4BC0078;
	Wed, 19 Jan 2022 02:35:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EFEDC0039
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 02:35:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6325A410D4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 02:35:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cwSMbVHLPrGE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 02:35:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2002E4093A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 02:35:47 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V2Eoch._1642559743; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V2Eoch._1642559743) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 19 Jan 2022 10:35:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 0/6] virtio pci support VIRTIO_F_RING_RESET
Date: Wed, 19 Jan 2022 10:35:37 +0800
Message-Id: <20220119023543.91620-1-xuanzhuo@linux.alibaba.com>
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

The virtio spec already supports the virtio queue reset function. This patch set
is to add this function to the kernel. The relevant virtio spec information is
here:

    https://github.com/oasis-tcs/virtio-spec/issues/124

virtio-net's queue disable/enable function based on virtio queue reset is here

    https://github.com/fengidri/linux/commit/021165b4eda44f87c4b7771ef637bab2512d066f

I plan to include this patch in the subsequent virtio-net support AF_XDP
patch set.

Also regarding MMIO support for queue reset, I plan to support it after this
patch is passed.

Please review. Thanks.

Xuan Zhuo (6):
  virtio: pci: struct virtio_pci_common_cfg add queue_notify_data
  virtio: queue_reset: add VIRTIO_F_RING_RESET
  virtio: queue_reset: pci: update struct virtio_pci_common_cfg and
    option functions
  virtio: queue_reset: pci: extract some functions for subsequent
    patches
  virtio: queue_reset: pci: support VIRTIO_F_RING_RESET
  virtio: queue_reset: add helper

 drivers/virtio/virtio_pci_common.c     | 140 +++++++++++++++++++------
 drivers/virtio/virtio_pci_common.h     |   5 +
 drivers/virtio/virtio_pci_modern.c     |  81 ++++++++++++++
 drivers/virtio/virtio_pci_modern_dev.c |  28 +++++
 include/linux/virtio_config.h          |  78 ++++++++++++++
 include/linux/virtio_pci_modern.h      |   2 +
 include/uapi/linux/virtio_config.h     |   7 +-
 include/uapi/linux/virtio_pci.h        |   2 +
 8 files changed, 310 insertions(+), 33 deletions(-)

--
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
