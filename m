Return-Path: <SRS0=NA0D=IN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EA5C433E0
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 16:35:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB0164F26
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 16:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB0164F26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 944AE6F4FD;
	Mon, 15 Mar 2021 16:35:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4CMgXJ927toD; Mon, 15 Mar 2021 16:35:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id E163E6F56D;
	Mon, 15 Mar 2021 16:35:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6B73C000B;
	Mon, 15 Mar 2021 16:35:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBF3CC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 16:35:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D9318430EF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 16:35:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tF-hbTQHiFqg
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 16:35:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F3FB9430C4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 16:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615826103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8E7bQAO4mPMCMNy7czH8SXiPxDN2NhK2/K7/V4lwNsU=;
 b=Rnx3iP6ZRO9L5GFRCt8rkikV3pdZjoQ2V4kN+EAKsZPzOJJucxiCdPJY7xzjtSed3IiJ2o
 93vxml4ncf503grqOMJMgCI/jG2wNBx75CeSredyzwTRkRG8b/Olthx12Uh9KGuZE9zIXQ
 cZ58+zJ2OTYV4EQ0sTyyRFomJfHDy5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-3bB14KOROdS3_D81865z-Q-1; Mon, 15 Mar 2021 12:35:01 -0400
X-MC-Unique: 3bB14KOROdS3_D81865z-Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E03A6100C663;
 Mon, 15 Mar 2021 16:34:59 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-1.ams2.redhat.com [10.36.114.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 47AD319D7C;
 Mon, 15 Mar 2021 16:34:51 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v4 00/14] vdpa: add vdpa simulator for block device
Date: Mon, 15 Mar 2021 17:34:36 +0100
Message-Id: <20210315163450.254396-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xie Yongji <xieyongji@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

v4:
- added support for iproute2 vdpa management tool in vdpa_sim_blk
- removed get/set_config patches
  - 'vdpa: add return value to get_config/set_config callbacks'
  - 'vhost/vdpa: remove vhost_vdpa_config_validate()'
- added get_config_size() patches
  - 'vdpa: add get_config_size callback in vdpa_config_ops'
  - 'vhost/vdpa: use get_config_size callback in vhost_vdpa_config_validate()'

v3: https://lore.kernel.org/lkml/20210204172230.85853-1-sgarzare@redhat.com/
v2: https://lore.kernel.org/lkml/20210128144127.113245-1-sgarzare@redhat.com/
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

I used the Xie's patch coming from VDUSE series to allow vhost-vdpa to use
block devices, and I added get_config_size() callback to allow any device
in vhost-vdpa.

The series also includes small fixes for vringh, vdpa, and vdpa_sim that I
discovered while implementing and testing the block simulator.

Thanks for your feedback,
Stefano

Max Gurtovoy (1):
  vdpa: add vdpa simulator for block device

Stefano Garzarella (12):
  vdpa_sim: use iova module to allocate IOVA addresses
  vringh: add 'iotlb_lock' to synchronize iotlb accesses
  vringh: reset kiov 'consumed' field in __vringh_iov()
  vringh: explain more about cleaning riov and wiov
  vringh: implement vringh_kiov_advance()
  vringh: add vringh_kiov_length() helper
  vdpa_sim: cleanup kiovs in vdpasim_free()
  vdpa: add get_config_size callback in vdpa_config_ops
  vhost/vdpa: use get_config_size callback in
    vhost_vdpa_config_validate()
  vdpa_sim_blk: implement ramdisk behaviour
  vdpa_sim_blk: handle VIRTIO_BLK_T_GET_ID
  vdpa_sim_blk: add support for vdpa management tool

Xie Yongji (1):
  vhost/vdpa: Remove the restriction that only supports virtio-net
    devices

 drivers/vdpa/vdpa_sim/vdpa_sim.h     |   2 +
 include/linux/vdpa.h                 |   4 +
 include/linux/vringh.h               |  19 +-
 drivers/vdpa/ifcvf/ifcvf_main.c      |   6 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |   6 +
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 127 ++++++----
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 338 +++++++++++++++++++++++++++
 drivers/vdpa/virtio_pci/vp_vdpa.c    |   8 +
 drivers/vhost/vdpa.c                 |  15 +-
 drivers/vhost/vringh.c               |  69 ++++--
 drivers/vdpa/Kconfig                 |   8 +
 drivers/vdpa/vdpa_sim/Makefile       |   1 +
 12 files changed, 529 insertions(+), 74 deletions(-)
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c

-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
