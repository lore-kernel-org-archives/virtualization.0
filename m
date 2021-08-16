Return-Path: <SRS0=J2aX=NH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBC7C4338F
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 04:51:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4DD61881
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 04:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD4DD61881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8D994401AE;
	Mon, 16 Aug 2021 04:51:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TT_T3SIkFQ73; Mon, 16 Aug 2021 04:51:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 15A28401F5;
	Mon, 16 Aug 2021 04:51:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD93EC001A;
	Mon, 16 Aug 2021 04:51:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39FF4C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 04:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2470660661
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 04:51:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DojYf2CZm_1Q
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 04:51:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 344DC6062F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 04:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629089460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=rZs3mSB34nogWH2zmgxUCeVHfLL1OdFQlCndY96/B/0=;
 b=LUdJlzPTp7GpIpDcHcYdiVGG1vqrkDSyfmKonYW5Wjx5ygVgiaqEUGCY1Mdz7kpnrtjg5a
 9MlhlqvtYe1oDr5804k1S/TOrUdvupUhBFlPOXHwdsr8TMTSbEoqMiFTHiRiM8CttCc05B
 EOlzHQz48nDwabNx9UjhdngNcKrzjp4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-dr4GLDBAOyOoLqomB8OTFg-1; Mon, 16 Aug 2021 00:50:59 -0400
X-MC-Unique: dr4GLDBAOyOoLqomB8OTFg-1
Received: by mail-wm1-f70.google.com with SMTP id
 l19-20020a05600c4f13b029025b036c91c6so3911594wmq.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Aug 2021 21:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=rZs3mSB34nogWH2zmgxUCeVHfLL1OdFQlCndY96/B/0=;
 b=uheuHdnVARpP7y73/MkkybhQOIAYTA2EhPoQKS1RkP0J3uhhZN+mQXGvBSN3MSFwcy
 1VI3JX1XFum8QGKYqfKIUtPJff6q/qZ7ZYU2goB/aw2BgQyVfjQjOEV4wug2gwrSnWPj
 +/gmOou2g2X3q7I1CEKv7inhAE1r1byhgVrCw3dmhTQvnGdj9/3pIT2RwlJHPGia+cME
 TcTTVcQt+aP/WvG0YCh8ktrjQkfQ2jU3MSyg6RL3SlrPI5npF7znABJFcW74FKqU9P2L
 22qC3XJecNoM1AWqMOM1WAtxLF0LBR8k9s3esa9zkfO0vzaWAdctx086A5CtbthcuhEv
 XOpA==
X-Gm-Message-State: AOAM530KrCcb1N7Ih82dlaDjoa/B9chWoNxqHFXhmXyqP7JMo9uGrFpu
 uUUHqXToyTQ9lmgQSuqfSggXPZcCV5PcgVPPmZrLNZY2enN9LQ4suOtDmVryrx1kJac7X/dZrVq
 IoRBRDoIwO1+fs/DDPbzgXt5oUle5YEsU2gmYDA+Tgw==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr1228059wrq.378.1629089458120; 
 Sun, 15 Aug 2021 21:50:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjBjilHWhHeVXJ212gHSVnkj7N49KZUrKpxQq7yztn932X8qS+NGWF0om+LCe2aMv5wZThUw==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr1228046wrq.378.1629089457942; 
 Sun, 15 Aug 2021 21:50:57 -0700 (PDT)
Received: from redhat.com ([2.55.8.239])
 by smtp.gmail.com with ESMTPSA id m10sm12398087wro.63.2021.08.15.21.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Aug 2021 21:50:57 -0700 (PDT)
Date: Mon, 16 Aug 2021 00:50:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio,vhost,vdpa: bugfixes
Message-ID: <20210816005054-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 vincent.whitchurch@axis.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 elic@nvidia.com, neeraju@codeaurora.org, dan.carpenter@oracle.com
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

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 879753c816dbbdb2a9a395aa4448d29feee92d1a:

  vdpa/mlx5: Fix queue type selection logic (2021-08-11 06:44:43 -0400)

----------------------------------------------------------------
virtio,vhost,vdpa: bugfixes

Fixes in virtio,vhost,vdpa drivers.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eli Cohen (2):
      vdpa/mlx5: Avoid destroying MR on empty iotlb
      vdpa/mlx5: Fix queue type selection logic

Michael S. Tsirkin (3):
      vringh: pull in spinlock header
      virtio_ring: pull in spinlock header
      tools/virtio: fix build

Neeraj Upadhyay (1):
      vringh: Use wiov->used to check for read/write desc order

Parav Pandit (4):
      virtio: Improve vq->broken access to avoid any compiler optimization
      virtio: Keep vring_del_virtqueue() mirror of VQ create
      virtio: Protect vqs list access
      virtio_pci: Support surprise removal of virtio pci device

Vincent Whitchurch (1):
      virtio_vdpa: reject invalid vq indices

Xie Yongji (7):
      vhost-vdpa: Fix integer overflow in vhost_vdpa_process_iotlb_update()
      vhost: Fix the calculation in vhost_overflow()
      vdpa_sim: Fix return value check for vdpa_alloc_device()
      vp_vdpa: Fix return value check for vdpa_alloc_device()
      vDPA/ifcvf: Fix return value check for vdpa_alloc_device()
      vdpa: Add documentation for vdpa_alloc_device() macro
      virtio-blk: Add validation for block size in config space

 drivers/block/virtio_blk.c         | 39 ++++++++++++++++++++++----
 drivers/vdpa/ifcvf/ifcvf_main.c    |  4 +--
 drivers/vdpa/mlx5/core/mr.c        |  9 ------
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 14 +++++++---
 drivers/vdpa/vdpa_sim/vdpa_sim.c   |  4 ++-
 drivers/vdpa/virtio_pci/vp_vdpa.c  |  4 +--
 drivers/vhost/vdpa.c               |  3 +-
 drivers/vhost/vhost.c              | 10 +++++--
 drivers/vhost/vringh.c             |  2 +-
 drivers/virtio/virtio.c            |  1 +
 drivers/virtio/virtio_pci_common.c |  7 +++++
 drivers/virtio/virtio_ring.c       | 18 ++++++++++--
 drivers/virtio/virtio_vdpa.c       |  3 ++
 include/linux/mlx5/mlx5_ifc_vdpa.h | 10 ++++---
 include/linux/vdpa.h               | 11 ++++++++
 include/linux/virtio.h             |  1 +
 include/linux/vringh.h             |  1 +
 tools/virtio/Makefile              |  3 +-
 tools/virtio/linux/spinlock.h      | 56 ++++++++++++++++++++++++++++++++++++++
 tools/virtio/linux/virtio.h        |  2 ++
 20 files changed, 166 insertions(+), 36 deletions(-)
 create mode 100644 tools/virtio/linux/spinlock.h

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
