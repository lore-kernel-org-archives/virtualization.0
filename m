Return-Path: <SRS0=vMKq=G7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13543C433E0
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 14:41:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DED64DD9
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 14:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DED64DD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 06C262044C;
	Thu, 28 Jan 2021 14:41:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rtmhEr0Gd2wX; Thu, 28 Jan 2021 14:41:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 60D6C2036B;
	Thu, 28 Jan 2021 14:41:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C0E3C0FA8;
	Thu, 28 Jan 2021 14:41:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D82DCC08A1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 14:41:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C78F98679E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 14:41:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7NrEeUNQN9ZB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 14:41:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DD5F48679B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 14:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611844899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oKQyktnzCEz0hqPUDHkW7dyXbU3t7aSFEMciUM7CkaI=;
 b=HwVZl0LfOL39aRr8cB5UE3rV6dt8r9wX8MzHTPH1hqn8eiZRBpyblputci5yWciPgIuwVH
 HWuV7h40teLH+LWt199gaPJ6wEZtPfUuS3RSUr6PmjZi14FGrXR0MZxnbjR7vw+dZ1QQ1m
 ivm7pWYxGDFNidZ95TXusJQM8BZbMC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-oddZIRJDMeiHx4rcSfnbdg-1; Thu, 28 Jan 2021 09:41:37 -0500
X-MC-Unique: oddZIRJDMeiHx4rcSfnbdg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 784211800D41;
 Thu, 28 Jan 2021 14:41:36 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-219.ams2.redhat.com
 [10.36.113.219])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 832AE60875;
 Thu, 28 Jan 2021 14:41:28 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v2 00/10] vdpa: add vdpa simulator for block device
Date: Thu, 28 Jan 2021 15:41:17 +0100
Message-Id: <20210128144127.113245-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

v1: https://lore.kernel.org/lkml/93f207c0-61e6-3696-f218-e7d7ea9a7c93@redhat.com/

This series is the second part of the v1 linked above. The first part with
refactoring of vdpa_sim has already been merged.

The patches are based on Max Gurtovoy's work and extend the block simulator to
have a ramdisk behaviour.

As mentioned in the v1 there was 2 issues and I fixed them in this series:
1. The identical mapping in the IOMMU used until now in vdpa_sim created issues
   when mapping different virtual pages with the same physical address.
   Fixed by patch "vdpa_sim: use iova module to allocate IOVA addresses"

2. There was a race accessing the IOMMU between the vdpasim_blk_work() and the
   device driver that map/unmap DMA regions. Fixed by patch "vringh: add
   'iotlb_lock' to synchronize iotlb accesses"

Since this series is still a RFC, I used the Xie's patch as is to allow
vhost-vdpa to use block devices, but I'll rebase when he splits it into
multiple patches.

The series also includes small fixes for vdpa_sim that I discovered while
implementing the block simulator.

Thanks for your feedback,
Stefano

Max Gurtovoy (1):
  vdpa: add vdpa simulator for block device

Stefano Garzarella (8):
  vdpa_sim: use iova module to allocate IOVA addresses
  vringh: add 'iotlb_lock' to synchronize iotlb accesses
  vringh: reset kiov 'consumed' field in __vringh_iov()
  vringh: implement vringh_kiov_advance()
  vringh: add vringh_kiov_length() helper
  vdpa_sim: cleanup kiovs in vdpasim_free()
  vdpa_sim_blk: implement ramdisk behaviour
  vdpa_sim_blk: handle VIRTIO_BLK_T_GET_ID

Xie Yongji (1):
  vdpa: Remove the restriction that only supports virtio-net devices

 drivers/vdpa/vdpa_sim/vdpa_sim.h     |   2 +
 include/linux/vringh.h               |  19 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 118 +++++++----
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 288 +++++++++++++++++++++++++++
 drivers/vhost/vdpa.c                 |  28 +--
 drivers/vhost/vringh.c               |  54 +++--
 drivers/vdpa/Kconfig                 |   8 +
 drivers/vdpa/vdpa_sim/Makefile       |   1 +
 8 files changed, 433 insertions(+), 85 deletions(-)
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c

-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
