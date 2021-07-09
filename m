Return-Path: <SRS0=F8NL=MB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5B0C07E99
	for <virtualization@archiver.kernel.org>; Fri,  9 Jul 2021 11:20:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A262A6008E
	for <virtualization@archiver.kernel.org>; Fri,  9 Jul 2021 11:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A262A6008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D98383CEB;
	Fri,  9 Jul 2021 11:20:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d04BRoxnpa8d; Fri,  9 Jul 2021 11:20:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 038BF83CEF;
	Fri,  9 Jul 2021 11:20:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4703C001A;
	Fri,  9 Jul 2021 11:20:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAD2FC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 11:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E733B83CEF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 11:20:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ClHLXcR0NPOs
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 11:20:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DDBD883CEB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 11:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625829606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=hKiczKxzAPI29UJiV3gO14mPIUiI0XC1F52rfsccKc4=;
 b=QpwFaQymhvROh7dryuamIpSzdgUZp3Xacx0nWnfc2hQJ6o6XU7LJTLaUcqOa3ieq6TV6kp
 VKvheXPV1sZm0fv/dPFHzCpEghcKIdLQ5RDWpmvgtYlnPmbBP+FbkU60v1C9bXN7gWmcHB
 CpQh87d8tAXhX3cZ0swS0DOtq37IqCM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149--9JTNl6uP0WUXFZtE_FYSA-1; Fri, 09 Jul 2021 07:20:03 -0400
X-MC-Unique: -9JTNl6uP0WUXFZtE_FYSA-1
Received: by mail-ej1-f72.google.com with SMTP id
 rl7-20020a1709072167b02904f7606bd58fso2571798ejb.11
 for <virtualization@lists.linux-foundation.org>;
 Fri, 09 Jul 2021 04:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=hKiczKxzAPI29UJiV3gO14mPIUiI0XC1F52rfsccKc4=;
 b=dy7mvtoEDs84qb+pm02nQa/5+PnD/sXzRo48m8NKm78W6Bd3nOXVMekVwoSpl+VMhL
 cwGwKt5DxsXNEGh7hbVWKEDrSj+mpeaX693RjGDURAU9NiA6P/hIT9+sKTqaYy9snMUv
 vDS1gIInmX+ag7RPBJXMQjCFHwWos/GpFpdRvsnMnwIwMudVMJoSL0YhiBA27zPpPVs9
 diY+3wCkSGTuOCKDvD+1xp1i3+vyUbm3LTyB5fWKQn7BhmmMvBmjXbnAxbEzRpfZu9op
 BR5TFs5jPztdUFiRzVhUr4QtRsECh6Qk3zdZ4hj3QERNwWJ66DIm/FWO4MFVx5q8dIcL
 B8Ag==
X-Gm-Message-State: AOAM531ZlWA8RBD9bVFTUQryRFZ1HZ80WinAoNOscYnqFstirr5uE7ZF
 rHVKJG9gqj18gMjCok4wXkYyv3TNf5dz2yJ7FD9pBPLqDo7NUN7efdocqMb7tHFaKtFG3v3Nauy
 Qw7q7OR5+t5z4R2L1UwXeHUtO/a3g6IVDN4b7Bs30Qw==
X-Received: by 2002:a17:907:3d8e:: with SMTP id
 he14mr37164171ejc.374.1625829602181; 
 Fri, 09 Jul 2021 04:20:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtc4xWGn+OHTWUqQ2ZN7QMBLRjQS+tqvvgK+bB1PKTcn/km2lYNbAnqdYoxRG3K4UGhWeOuQ==
X-Received: by 2002:a17:907:3d8e:: with SMTP id
 he14mr37164137ejc.374.1625829601998; 
 Fri, 09 Jul 2021 04:20:01 -0700 (PDT)
Received: from redhat.com ([2.55.150.102])
 by smtp.gmail.com with ESMTPSA id s4sm2830932edu.49.2021.07.09.04.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jul 2021 04:20:01 -0700 (PDT)
Date: Fri, 9 Jul 2021 07:19:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio,vhost,vdpa: features, fixes
Message-ID: <20210709071952-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: sohaib.amhmd@gmail.com, lkp@intel.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, mst@redhat.com, abaci@linux.alibaba.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 zhangshaokun@hisilicon.com, xieyongji@bytedance.com,
 yang.lee@linux.alibaba.com, stefanha@redhat.com, wanjiabing@vivo.com,
 elic@nvidia.com, lingshan.zhu@intel.com, dan.carpenter@oracle.com
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

The following changes since commit 3dbdb38e286903ec220aaf1fb29a8d94297da246:

  Merge branch 'for-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup (2021-07-01 17:22:14 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to db7b337709a15d33cc5e901d2ee35d3bb3e42b2f:

  virtio-mem: prioritize unplug from ZONE_MOVABLE in Big Block Mode (2021-07-08 07:49:02 -0400)

----------------------------------------------------------------
virtio,vhost,vdpa: features, fixes

Doorbell remapping for ifcvf, mlx5.
virtio_vdpa support for mlx5.
Validate device input in several drivers (for SEV and friends).
ZONE_MOVABLE aware handling in virtio-mem.
Misc fixes, cleanups.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
David Hildenbrand (7):
      virtio-mem: don't read big block size in Sub Block Mode
      virtio-mem: use page_zonenum() in virtio_mem_fake_offline()
      virtio-mem: simplify high-level plug handling in Sub Block Mode
      virtio-mem: simplify high-level unplug handling in Sub Block Mode
      virtio-mem: prioritize unplug from ZONE_MOVABLE in Sub Block Mode
      virtio-mem: simplify high-level unplug handling in Big Block Mode
      virtio-mem: prioritize unplug from ZONE_MOVABLE in Big Block Mode

Eli Cohen (8):
      vdpa/mlx5: Fix umem sizes assignments on VQ create
      vdpa/mlx5: Fix possible failure in umem size calculation
      vdpa/mlx5: Support creating resources with uid == 0
      vdp/mlx5: Fix setting the correct dma_device
      vdpa/mlx5: Add support for running with virtio_vdpa
      vdpa/mlx5: Add support for doorbell bypassing
      vdpa/mlx5: Clear vq ready indication upon device reset
      virtio/vdpa: clear the virtqueue state during probe

Jason Wang (11):
      vp_vdpa: correct the return value when fail to map notification
      virtio-ring: maintain next in extra state for packed virtqueue
      virtio_ring: rename vring_desc_extra_packed
      virtio-ring: factor out desc_extra allocation
      virtio_ring: secure handling of mapping errors
      virtio_ring: introduce virtqueue_desc_add_split()
      virtio: use err label in __vring_new_virtqueue()
      virtio-ring: store DMA metadata in desc_extra for split virtqueue
      vdpa: support packed virtqueue for set/get_vq_state()
      virtio-pci library: introduce vp_modern_get_driver_features()
      vp_vdpa: allow set vq state to initial state after reset

Michael S. Tsirkin (4):
      virtio_net: move tx vq operation under tx queue lock
      virtio_net: move txq wakeups under tx q lock
      virtio: fix up virtio_disable_cb
      virtio_net: disable cb aggressively

Mike Christie (5):
      vhost: remove work arg from vhost_work_flush
      vhost-scsi: remove extra flushes
      vhost-scsi: reduce flushes during endpoint clearing
      vhost: fix poll coding style
      vhost: fix up vhost_work coding style

Shaokun Zhang (1):
      vhost: Remove the repeated declaration

Sohaib (1):
      virtio_blk: cleanups: remove check obsoleted by CONFIG_LBDAF removal

Stefan Hajnoczi (1):
      virtio-blk: limit seg_max to a safe value

Stefano Garzarella (1):
      vhost-iotlb: fix vhost_iotlb_del_range() documentation

Wan Jiabing (1):
      vdpa_sim_blk: remove duplicate include of linux/blkdev.h

Xie Yongji (3):
      virtio-blk: Fix memory leak among suspend/resume procedure
      virtio_net: Fix error handling in virtnet_restore()
      virtio_console: Assure used length from device is limited

Yang Li (1):
      virtio_ring: Fix kernel-doc

Zhu Lingshan (4):
      vDPA/ifcvf: record virtio notify base
      vDPA/ifcvf: implement doorbell mapping for ifcvf
      virtio: update virtio id table, add transitional ids
      vDPA/ifcvf: reuse pre-defined macros for device ids and vendor ids

 drivers/block/virtio_blk.c             |  17 +-
 drivers/char/virtio_console.c          |   4 +-
 drivers/net/virtio_net.c               |  53 +++--
 drivers/vdpa/ifcvf/ifcvf_base.c        |   4 +
 drivers/vdpa/ifcvf/ifcvf_base.h        |  14 +-
 drivers/vdpa/ifcvf/ifcvf_main.c        |  43 ++--
 drivers/vdpa/mlx5/core/mlx5_vdpa.h     |   2 +
 drivers/vdpa/mlx5/core/mr.c            |  97 ++++++---
 drivers/vdpa/mlx5/core/resources.c     |   7 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c      |  67 +++++--
 drivers/vdpa/vdpa_sim/vdpa_sim.c       |   4 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c   |   1 -
 drivers/vdpa/virtio_pci/vp_vdpa.c      |  43 +++-
 drivers/vhost/iotlb.c                  |   2 +-
 drivers/vhost/scsi.c                   |  21 +-
 drivers/vhost/vdpa.c                   |   4 +-
 drivers/vhost/vhost.c                  |   8 +-
 drivers/vhost/vhost.h                  |  21 +-
 drivers/vhost/vsock.c                  |   2 +-
 drivers/virtio/virtio_mem.c            | 346 +++++++++++++++++----------------
 drivers/virtio/virtio_pci_modern_dev.c |  21 ++
 drivers/virtio/virtio_ring.c           | 229 ++++++++++++++++------
 drivers/virtio/virtio_vdpa.c           |  15 ++
 include/linux/mlx5/mlx5_ifc.h          |   4 +-
 include/linux/vdpa.h                   |  25 ++-
 include/linux/virtio_pci_modern.h      |   1 +
 include/uapi/linux/virtio_ids.h        |  12 ++
 27 files changed, 713 insertions(+), 354 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
