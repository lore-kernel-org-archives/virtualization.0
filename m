Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587923A542F
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Jun 2026 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693730; cv=none; b=MwJIyVs//G4TdYDJnRSb3wRN9jWxrKUTvV3DAhTPqpLQQ914H8MW5gDoOj3uPeRmOroWCOdhksqdrMfCJUbiLykh1khBR21CBYdcVDpIWeNFP+htz7MSnVA+xrVxXAyvuX1CkUcFCEsOWUxl9ZItLDZIOK2qNcz23nkrHhP0sz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693730; c=relaxed/simple;
	bh=o4IDyqsIkp4ke7FAFeoPSlssBcMB9tDWRD06iMFMg3A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fWhvT4LodvkeSI6LrL+x09SwGbdGf/D1x6x5NjZJW0/q9WkvxFs4b9CTJFJ0lkxicbSnR/6yM4tFmgQylfXibEAaK9tJ05L6UV3qt1rMKXDT2qdxb/rEivMgLbX/IlSVziEaJvyyyOaLY0kzogsRenOHDrcHoOF9rnrM25tXFzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YybreMs0; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YybreMs0"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC1724ED6F
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Jun 2026 10:55:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J4NflLz69mEM for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Jun 2026 10:55:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CEE0B4EBE3
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CEE0B4EBE3
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YybreMs0
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CEE0B4EBE3
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Jun 2026 10:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781693725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=IH7ay2N+E2zA4nRJyMLO1X7bzBBBVG5OqoVU7vY8dTI=;
	b=YybreMs0B5M+Lnb1ubNalEACnaUaMKJ9qvkpPCQjeuaiQ7Ak4a25fscNv9mzZ3IWGGN3pg
	dj70ZqMLzy3HAhKaDVSKKPlgnw3ApzL8XibZyEaMurJ32rtSGyenwHIfiEKoen81dJzsE9
	4wLedP3gr3Yddt5NjmcR/N84PfMFtPM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-1WKGVGY2OgSSDooGS-bwkw-1; Wed, 17 Jun 2026 06:55:24 -0400
X-MC-Unique: 1WKGVGY2OgSSDooGS-bwkw-1
X-Mimecast-MFC-AGG-ID: 1WKGVGY2OgSSDooGS-bwkw_1781693723
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-46010bc0f1eso3388713f8f.3
        for <virtualization@lists.linux-foundation.org>; Wed, 17 Jun 2026 03:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781693723; x=1782298523;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IH7ay2N+E2zA4nRJyMLO1X7bzBBBVG5OqoVU7vY8dTI=;
        b=dWYnBLFN09qRFoMkUvK9Qolj+/kXOJ05gLBZfehe7zukrSAyQdjaPtrVsC1dNxxZUq
         XNE52DdEA9S4GMJmZjV0AQg+s90XlVVqKuQPBpgXYOJywmmJGWikSRbrUb3k7ABjANhf
         gwGde64AEABVrqlV0H5DEHmycPJEhEbRMIkBFhxiJMPbTvMKvk15sAGE9Z5uqOxgzAr/
         tobgKq9NDTQH/uptSdYNTcU+M56eKebxd9xn+TCDvHdbyaEPlQ9jZUNOuKpclLOa4Jip
         XPiLq32A/ft0hp+/JgfbO84kD6CCePX8GxqqJC9Ee0iQwgj2T+FgaJ+w/Rpzd8MDOTiz
         nFxw==
X-Forwarded-Encrypted: i=1; AFNElJ+cCorVCP3ZmWktGWAePFtEIJHkEJA73dkZ6jC7qymA2s2nQacWiwyAcbz+O8GAKh9itqZJnEIfzkw90htseQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwvVBrhO+OLoShT1ljGMFFONOclWZzIBb7+zqfxQfeudbFrH6h4
	dATkYHHXKMhhZGA8/O3c9EZUeSND6QugeXcP8FAWliEix+Nifq9Y0LnbGosg6MNuF6Q6Hy/LPmB
	vzZqVs5/KjFOprRilbnsrNOfcIiMQQv92NpCMwEg1Dw+OXIi/BPeZL7fud64ce8PI9PztWx1QqO
	cC7Uh4nmQ=
X-Gm-Gg: Acq92OGx6n9kwkcHpOB1q/eF6K4/JdYekjOh8MuS8tuEHi2UQtNutbsD9nd6+ZqkvZw
	VvMw5zXmII6773SYsruVhK/UCUtYwqMnjChhzynBN+l8azHHlJ5RBVCyY5aW/uyYd+36ddE0xzL
	PkGA0WVl/3/z3RgEwQiJxqJtwxngNP30mMTVpvB7X56R/v9aB7dMcqf/rOnCdud+8RdDDjoWc0Q
	ZHqdY4IYSpcC4Boldy8oN621y3KMnANNzWaswUNyMfxY9RFMuABWmOpaq+iy+zQDlVEwpmf5oG/
	jXP7qnPY0y4fB7d4tVkFDxytzWolm1ce+9WLhssBdVf1fY0aezLTVLoMrqkRpRMP0yRW5Jduo7k
	G1jW4esWbiAsfyVwbqhYvVrQJRaSdv+ZO
X-Received: by 2002:a05:600c:37c3:b0:490:e18f:d108 with SMTP id 5b1f17b1804b1-492333cf91cmr52521855e9.19.1781693722758;
        Wed, 17 Jun 2026 03:55:22 -0700 (PDT)
X-Received: by 2002:a05:600c:37c3:b0:490:e18f:d108 with SMTP id 5b1f17b1804b1-492333cf91cmr52521245e9.19.1781693722197;
        Wed, 17 Jun 2026 03:55:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a4f8d7sm146613065e9.5.2026.06.17.03.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 03:55:21 -0700 (PDT)
Date: Wed, 17 Jun 2026 06:55:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, a0yami@mailbox.org,
	ammarfaizi2@openresty.com, arnd@arndb.de, chenhuacai@kernel.org,
	chenhuacai@loongson.cn, christfontanez@gmail.com,
	Damir.Shaikhutdinov@opensynergy.com, david@kernel.org,
	den@openvz.org, enelsonmoore@gmail.com, eperezma@redhat.com,
	ethan@ethancedwards.com, evg28bur@yandex.ru, filip.hejsek@gmail.com,
	francesco@valla.it, graf@amazon.com, harald.mommer@oss.qualcomm.com,
	jasowang@redhat.com, jiri@nvidia.com, johan@kernel.org,
	johannes.thumshirn@wdc.com, lingshan.zhu@kernel.org,
	luis.hernandez093@gmail.com, lulu@redhat.com, mhi@mailbox.org,
	michael.bommarito@gmail.com,
	mikhail.golubev-ciuchea@oss.qualcomm.com, mkl@pengutronix.de,
	mst@redhat.com, mvaralar@redhat.com, nathan@kernel.org,
	oleg@redhat.com, pawel.moll@arm.com, physicalmtea@gmail.com,
	polina.vishneva@virtuozzo.com, q.h.hack.winter@gmail.com,
	rosenp@gmail.com, schalla@marvell.com, shuangyu@yunyoo.cc,
	stefanha@redhat.com, vattunuru@marvell.com, yanlonglong@kylinos.cn,
	yichun@openresty.com, yui.washidu@gmail.com, yuka@umeyashiki.org,
	zhangtianci.1997@bytedance.com
Subject: [GIT PULL] virtio,vhost,vdpa: features, fixes
Message-ID: <20260617065516-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CwS7YvOU4ydIebttT58Z8vtjgKAFlYjIULFbsUdV5gU_1781693723
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 8cb2c9285e4ce9154f45fb15633ebd45dfd8d9cf:

  can: virtio: Fix comment in UAPI header (2026-06-10 02:17:00 -0400)

----------------------------------------------------------------
virtio,vhost,vdpa: features, fixes

- new virtio CAN driver
- support for LoongArch architecture in fw_cfg
- support for firmware notifications in vdpa/octeon_ep
- support for VFs in virtio core

- fixes, cleanups all over the place, notably
    - vhost: fix vhost_get_avail_idx for a non empty ring
      fixing an significant old perf regression
    - plus READ_ONCE annotations mean virtio ring is now
      free of KCSAN warnings

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alexander Graf (1):
      virtio_ring: Add READ_ONCE annotations for device-writable fields

Ammar Faizi (1):
      virtio_pci: fix vq info pointer lookup via wrong index

Arnd Bergmann (1):
      vduse: fix compat handling for VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO

Christian Fontanez (1):
      virtio: add missing kernel-doc for map and vmap members

Cindy Lu (2):
      vdpa/mlx5: update mlx_features with driver state check
      vdpa/mlx5: update MAC address handling in mlx5_vdpa_set_attr()

Denis V. Lunev (1):
      vhost/vsock: Refuse the connection immediately when guest isn't ready

Ethan Carter Edwards (1):
      virtio_console: Fix spelling mistake "colums" -> "columns"

Ethan Nelson-Moore (1):
      vhost: remove unnecessary module_init/exit functions

Evgenii Burenchev (1):
      vdpa/ifcvf: handle dev_set_name() failure in ifcvf_vdpa_dev_add()

Filip Hejsek (1):
      virtio_console: read size from config space during device init

Huacai Chen (1):
      fw_cfg: Add support for LoongArch architecture

Jason Wang (1):
      VDUSE: avoid leaking information to userspace

Jia Jia (1):
      virtio: rtc: tear down old virtqueues before restore

Johan Hovold (3):
      virtio-mmio: fix device release warning on module unload
      vdpa_sim_blk: switch to dynamic root device
      vdpa_sim_net: switch to dynamic root device

Matias Ezequiel Vara Larsen (1):
      can: virtio: Add virtio CAN driver

Maurice Hieronymus (2):
      virtio-balloon: Destroy mutex before freeing virtio_balloon
      virtio-mem: Destroy mutex before freeing virtio_mem

Michael Bommarito (1):
      hwrng: virtio: clamp device-reported used.len at copy_data()

Michael S. Tsirkin (2):
      vhost: fix vhost_get_avail_idx for a non empty ring
      tools/virtio: fix build for kmalloc_obj API and missing stubs

Nathan Chancellor (1):
      can: virtio: Fix comment in UAPI header

Oleg Nesterov (1):
      vhost_task_create: kill unnecessary .exit_signal initialization

Qihang Tang (2):
      vduse: hold vduse_lock across IDR lookup in open path
      vhost/vdpa: validate virtqueue index in mmap and fault paths

Qing Ming (1):
      vhost/net: complete zerocopy ubufs only once

Rosen Penev (1):
      vdpa/mlx5: Use kvzalloc_flex() for MTT command memory

Srujana Challa (2):
      vdpa/octeon_ep: Fix PF->VF mailbox data address calculation
      vdpa/octeon_ep: fix IRQ-to-ring mapping in interrupt handler

Vamsi Attunuru (2):
      vdpa/octeon_ep: Use 4 bytes for mailbox signature
      vdpa/octeon_ep: Add vDPA device event handling for firmware notifications

Yui Washizu (1):
      virtio: add num_vf callback to virtio_bus

Zhang Tianci (2):
      vduse: Requeue failed read to send_list head
      vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter

longlong yan (1):
      tools/virtio: check mmap return value in vringh_test

 MAINTAINERS                              |    9 +
 drivers/char/hw_random/virtio-rng.c      |   23 +-
 drivers/char/virtio_console.c            |   52 +-
 drivers/firmware/Kconfig                 |    2 +-
 drivers/firmware/qemu_fw_cfg.c           |    2 +-
 drivers/net/can/Kconfig                  |   12 +
 drivers/net/can/Makefile                 |    1 +
 drivers/net/can/virtio_can.c             | 1022 ++++++++++++++++++++++++++++++
 drivers/vdpa/ifcvf/ifcvf_main.c          |   11 +-
 drivers/vdpa/mlx5/core/mr.c              |    7 +-
 drivers/vdpa/octeon_ep/octep_vdpa.h      |   22 +-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |  131 +++-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c     |   24 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c     |   23 +-
 drivers/vdpa/vdpa_user/iova_domain.c     |    2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c       |  197 +++++-
 drivers/vhost/net.c                      |   15 +-
 drivers/vhost/vdpa.c                     |   29 +-
 drivers/vhost/vhost.c                    |   23 +-
 drivers/vhost/vsock.c                    |   16 +
 drivers/virtio/virtio.c                  |    9 +
 drivers/virtio/virtio_balloon.c          |    2 +
 drivers/virtio/virtio_mem.c              |    2 +
 drivers/virtio/virtio_mmio.c             |   26 +-
 drivers/virtio/virtio_pci_common.c       |   10 +-
 drivers/virtio/virtio_ring.c             |   77 ++-
 drivers/virtio/virtio_rtc_driver.c       |   28 +-
 include/linux/virtio.h                   |    2 +
 include/uapi/linux/virtio_can.h          |   78 +++
 include/uapi/linux/virtio_console.h      |    2 +-
 kernel/vhost_task.c                      |    1 -
 tools/virtio/linux/dma-mapping.h         |    2 +
 tools/virtio/linux/err.h                 |    1 +
 tools/virtio/linux/kernel.h              |    6 +
 tools/virtio/vringh_test.c               |    5 +
 35 files changed, 1690 insertions(+), 184 deletions(-)
 create mode 100644 drivers/net/can/virtio_can.c
 create mode 100644 include/uapi/linux/virtio_can.h

