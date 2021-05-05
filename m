Return-Path: <SRS0=Wmx8=KA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EE4C433ED
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 20:11:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39F261006
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 20:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39F261006
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B55C9405EE;
	Wed,  5 May 2021 20:11:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AlNIGl8M72SY; Wed,  5 May 2021 20:11:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1995D405E4;
	Wed,  5 May 2021 20:11:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03FC6C000D;
	Wed,  5 May 2021 20:11:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B8B4C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 20:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D9CF401F5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 20:11:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Uzq6iA3-qgg
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 20:11:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 78775400E2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 20:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620245503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=trH/NfkKL9hdKsJ9LaR25jQCqSBLEA1C4zT+z7TQZuM=;
 b=QVLwlc0TtYccFN/ffftD+qVTCDhW4v3x/wIATXzk07ZCcoj2cA1c4oDM/NQKo9/2h5FhXI
 Ngr3a2vdeQEw0SWBBGTN5KnHayLZaIBhD59c2LnKtLJrpu66KcNwdbhUM0ouDAsvfVkOeX
 KtHHlGrmKzgy0Q6xQud96UAdpq7eNXs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-p6rtsKkRNBq-ZCcAbEbOdg-1; Wed, 05 May 2021 16:11:39 -0400
X-MC-Unique: p6rtsKkRNBq-ZCcAbEbOdg-1
Received: by mail-wm1-f70.google.com with SMTP id
 d199-20020a1c1dd00000b02901492c14476eso692653wmd.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 May 2021 13:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=trH/NfkKL9hdKsJ9LaR25jQCqSBLEA1C4zT+z7TQZuM=;
 b=e8GjrjVAIlQ7SWL31KZSfur5QkR2S20M3tuUVpk+R4IsMfU7qA7eHBcla2d8ojO34z
 D9TEGJXMmUK/hT7e8wCN75mQR3ppLQTgntxTfw7fDZiHp4dFG7u+OqOmW2Gqtvjg4Iep
 7LWZpE0STkguOJcIWeZN/g3e+iGxB9Xy6bLAkPV3Prb0+ZY4hDJutt3qTwhtXS3VGAUE
 Qo/F1Zhm1vm3RqkjNPPSHGjKQe6SDRm1Gl+u5Ea5MxNICRnp/L41aJIeclfMK2M/H33m
 xNh75iVIxJhSuyrYhqZaVIFT4dhCtzBh8Sce1AUkxEL6bV93tYZbotrgzaM5J5e2bghm
 BHvQ==
X-Gm-Message-State: AOAM532zSS/PxOkp2TIUAwN04R/IvOCQtOdrGh4tFpRHRQc//aI7yy6s
 NxqBLRyCYbNeld6EnDq99MHjxki+iZy/HvKsjlvodF5bU2fvi13Yx4yjfZ6e5uyiEoyQD8jDgmv
 W16Tl/pUNmvWA4FtQBSVFN+1vwycWKZ++YwXY/ZfK/Q==
X-Received: by 2002:a05:600c:190c:: with SMTP id
 j12mr11647202wmq.41.1620245498492; 
 Wed, 05 May 2021 13:11:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztjSMo+WrOGeWsi0rPU8vWa/2MQe6CfpFZS59vZKcAjfy+3i8GW0D8k1kGMxQrBXfQFIf4Ug==
X-Received: by 2002:a05:600c:190c:: with SMTP id
 j12mr11647184wmq.41.1620245498339; 
 Wed, 05 May 2021 13:11:38 -0700 (PDT)
Received: from redhat.com ([2a10:800c:8fce:0:8e1b:40f0:6a74:513b])
 by smtp.gmail.com with ESMTPSA id m6sm533139wrp.29.2021.05.05.13.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 May 2021 13:11:38 -0700 (PDT)
Date: Wed, 5 May 2021 16:11:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio,vhost,vdpa: features, fixes
Message-ID: <20210505161135-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mgurtovoy@nvidia.com, lkp@intel.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 liu.xiang@zlingsmart.com, elic@nvidia.com, lingshan.zhu@intel.com
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

The following changes since commit 9f4ad9e425a1d3b6a34617b8ea226d56a119a717:

  Linux 5.12 (2021-04-25 13:49:08 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to d7bce85aa7b92b5de8f69b3bcedfe51d7b1aabe1:

  virtio_pci_modern: correct sparse tags for notify (2021-05-04 04:19:59 -0400)

----------------------------------------------------------------
virtio,vhost,vdpa: features, fixes

A bunch of new drivers including vdpa support for block
and virtio-vdpa. Beginning of vq kick (aka doorbell) mapping support.
Misc fixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eli Cohen (1):
      vdpa/mlx5: Enable user to add/delete vdpa device

Jason Wang (9):
      vdpa: introduce virtio pci driver
      virtio_pci_modern: introduce helper to map vq notify area
      virtio-pci library: switch to use vp_modern_map_vq_notify()
      vp_vdpa: switch to use vp_modern_map_vq_notify()
      virtio_pci_modern: hide vp_modern_get_queue_notify_off()
      virito_pci libray: hide vp_modern_map_capability()
      virtio-pci library: report resource address
      vp_vdpa: report doorbell address
      vhost-vdpa: fix vm_flags for virtqueue doorbell mapping

Liu Xiang (1):
      virtio-balloon: fix a typo in comment of virtballoon_migratepage()

Max Gurtovoy (2):
      virtio-net: don't allocate control_buf if not supported
      vdpa: add vdpa simulator for block device

Michael S. Tsirkin (2):
      virtio_pci_modern: __force cast the notify mapping
      virtio_pci_modern: correct sparse tags for notify

Parav Pandit (2):
      vdpa: Follow kdoc comment style
      vdpa: Follow kdoc comment style

Stefano Garzarella (12):
      vdpa_sim: use iova module to allocate IOVA addresses
      vringh: add 'iotlb_lock' to synchronize iotlb accesses
      vringh: reset kiov 'consumed' field in __vringh_iov()
      vringh: explain more about cleaning riov and wiov
      vringh: implement vringh_kiov_advance()
      vringh: add vringh_kiov_length() helper
      vdpa_sim: cleanup kiovs in vdpasim_free()
      vdpa: add get_config_size callback in vdpa_config_ops
      vhost/vdpa: use get_config_size callback in vhost_vdpa_config_validate()
      vdpa_sim_blk: implement ramdisk behaviour
      vdpa_sim_blk: handle VIRTIO_BLK_T_GET_ID
      vdpa_sim_blk: add support for vdpa management tool

Xie Yongji (1):
      vhost/vdpa: Remove the restriction that only supports virtio-net devices

Zhu Lingshan (10):
      vDPA/ifcvf: get_vendor_id returns a device specific vendor id
      vDPA/ifcvf: enable Intel C5000X-PL virtio-net for vDPA
      vDPA/ifcvf: rename original IFCVF dev ids to N3000 ids
      vDPA/ifcvf: remove the version number string
      vDPA/ifcvf: fetch device feature bits when probe
      vDPA/ifcvf: verify mandatory feature bits for vDPA
      vDPA/ifcvf: deduce VIRTIO device ID from pdev ids
      vDPA/ifcvf: deduce VIRTIO device ID when probe
      vDPA/ifcvf: enable Intel C5000X-PL virtio-block for vDPA
      vDPA/ifcvf: get_config_size should return dev specific config size

 drivers/Makefile                       |   1 +
 drivers/net/virtio_net.c               |  10 +-
 drivers/vdpa/Kconfig                   |  15 +
 drivers/vdpa/Makefile                  |   1 +
 drivers/vdpa/ifcvf/ifcvf_base.c        |  24 +-
 drivers/vdpa/ifcvf/ifcvf_base.h        |  26 +-
 drivers/vdpa/ifcvf/ifcvf_main.c        |  86 +++++-
 drivers/vdpa/mlx5/net/mlx5_vnet.c      |  85 +++++-
 drivers/vdpa/vdpa.c                    |  12 +-
 drivers/vdpa/vdpa_sim/Makefile         |   1 +
 drivers/vdpa/vdpa_sim/vdpa_sim.c       | 127 ++++++---
 drivers/vdpa/vdpa_sim/vdpa_sim.h       |   2 +
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c   | 338 +++++++++++++++++++++++
 drivers/vdpa/virtio_pci/Makefile       |   2 +
 drivers/vdpa/virtio_pci/vp_vdpa.c      | 484 +++++++++++++++++++++++++++++++++
 drivers/vhost/vdpa.c                   |  16 +-
 drivers/vhost/vringh.c                 |  69 +++--
 drivers/virtio/virtio_balloon.c        |   2 +-
 drivers/virtio/virtio_pci_modern.c     |  27 +-
 drivers/virtio/virtio_pci_modern_dev.c |  67 ++++-
 include/linux/vdpa.h                   |  42 +--
 include/linux/virtio_pci_modern.h      |  11 +-
 include/linux/vringh.h                 |  19 +-
 23 files changed, 1295 insertions(+), 172 deletions(-)
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
 create mode 100644 drivers/vdpa/virtio_pci/Makefile
 create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa.c

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
