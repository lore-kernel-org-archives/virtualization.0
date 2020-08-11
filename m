Return-Path: <SRS0=ofWe=BV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BFEC433E3
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 08:56:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8EFA20756
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 08:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZfVtKnrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EFA20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 111582046B;
	Tue, 11 Aug 2020 08:56:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z2ViYqkS6Y1m; Tue, 11 Aug 2020 08:56:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5579520341;
	Tue, 11 Aug 2020 08:56:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FB1EC013C;
	Tue, 11 Aug 2020 08:56:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3978C004D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 08:56:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D5D66854DF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 08:56:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KoQ-Z6GCnu9u
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 08:56:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6AEF383F11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 08:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597136183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=d88xcVVVwUczUwSPBmg1oFZLtRXHohyyivhvTCzox5c=;
 b=ZfVtKnrQy2+ll3udE0z7QQEMpTxd+3kCFg6tYlIVwODRNFzv41YlFM1QhKh5LGaKeTlxUr
 ChU1DgfQVncsFdzArq7T2nopNrIvHOZxf29VsqZbEIGe6SvVc+99jW6mqk560hXo6sKGBI
 rDRm1/ar03FyecR5sD8HEzOTafw4hfU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-D0k72DtBOzGCclFn1hW2uA-1; Tue, 11 Aug 2020 04:56:21 -0400
X-MC-Unique: D0k72DtBOzGCclFn1hW2uA-1
Received: by mail-wm1-f69.google.com with SMTP id z1so609527wmf.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 01:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=d88xcVVVwUczUwSPBmg1oFZLtRXHohyyivhvTCzox5c=;
 b=X3hk1MbG6kJa5ymIhmdeB8mE1esK/L0jhTovsL/FCu9wQ36qeJtK9r2bJvlYL2+K69
 vonYePvhFcDqXdWmVZYnrFVOHghFqxV64VJZxjclkau71NAFWEMAq1bDx2E/rVnjgDOs
 tknllPnmwCtj+8xzKKbjlaoxMu7g8euIddI96pTUSpZ+dmBYcWaNMudnokWUOEADwvQy
 icAF3YL0G4p7O7ppV+DbzbeW73o9yUbcER9TavG2HuQfWSpWEo+NsdrVNK9xPRUD3+NG
 8ke6nmd+RfVwO+9DDBUx5JVGr2yZA2iwbPveG+eueJtaOIWfF1WhQzyIm2U7tS95yDKy
 CMfQ==
X-Gm-Message-State: AOAM5308cUQtvCVI0MvijdDrnEk0DcIBaTuLu4Ruz1cpefPHonx2QcjJ
 FJULHzevzxQ0N8J+VEL2hjPrfqiWpX+UnsLg/LqJVrtrKf6fZYOncH4+omJOJ3U6RZb4lBU80DI
 OL1yzARjdrXAQmZ3UXXDdkJRgcxEq/Jge+hYuKg043A==
X-Received: by 2002:adf:f248:: with SMTP id b8mr30092863wrp.247.1597136180005; 
 Tue, 11 Aug 2020 01:56:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytzwO8E3CNR4SmeuTaD5pfM/K8artOAdX7C77z9smbpOM/a84oJwE9y6glNyYTcgPnJ5upKw==
X-Received: by 2002:adf:f248:: with SMTP id b8mr30092826wrp.247.1597136179687; 
 Tue, 11 Aug 2020 01:56:19 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
 by smtp.gmail.com with ESMTPSA id
 c4sm25337308wrt.41.2020.08.11.01.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 01:56:18 -0700 (PDT)
Date: Tue, 11 Aug 2020 04:56:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio: features, fixes
Message-ID: <20200811045613-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, michaelgur@mellanox.com, linux-kernel@vger.kernel.org,
 meirl@mellanox.com, eli@mellanox.com, maxg@mellanox.com, elic@nvidia.com,
 maorg@mellanox.com, liao.pingfang@zte.com.cn, lkp@intel.com, lulu@redhat.com,
 rong.a.chen@intel.com, mst@redhat.com, saeedm@mellanox.com,
 andy.shevchenko@gmail.com, dan.carpenter@oracle.com, wang.yi59@zte.com.cn,
 parav@mellanox.com, leonro@mellanox.com, wenan.mao@linux.alibaba.com,
 alex.dewar@gmx.co.uk, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, cohuck@redhat.com, gustavoars@kernel.org,
 stable@vger.kernel.org, vgoyal@redhat.com, colin.king@canonical.com,
 lingshan.zhu@intel.com, tariqt@mellanox.com
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

OK, some patches in the series add buggy code which is then fixed by
follow-up patches, but none of the bugs fixed are severe regressions on
common configs (e.g. compiler warnings, lockdep/rt errors, or bugs in
new drivers). So I thought it's more important to preserve the credit
for the fixes.

I had to pull 5 patches from git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux mlx5-next
to get the mlx5 things to work, this seems to be how mellanox guys are
always managing things, and they told me they are ok with it.

The following changes since commit bcf876870b95592b52519ed4aafcf9d95999bc9c:

  Linux 5.8 (2020-08-02 14:21:45 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 8a7c3213db068135e816a6a517157de6443290d6:

  vdpa/mlx5: fix up endian-ness for mtu (2020-08-10 10:38:55 -0400)

----------------------------------------------------------------
virtio: fixes, features

IRQ bypass support for vdpa and IFC
MLX5 vdpa driver
Endian-ness fixes for virtio drivers
Misc other fixes

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alex Dewar (1):
      vdpa/mlx5: Fix uninitialised variable in core/mr.c

Colin Ian King (1):
      vdpa/mlx5: fix memory allocation failure checks

Dan Carpenter (2):
      vdpa/mlx5: Fix pointer math in mlx5_vdpa_get_config()
      vdpa: Fix pointer math bug in vdpasim_get_config()

Eli Cohen (9):
      net/mlx5: Support setting access rights of dma addresses
      net/mlx5: Add VDPA interface type to supported enumerations
      net/mlx5: Add interface changes required for VDPA
      net/vdpa: Use struct for set/get vq state
      vdpa: Modify get_vq_state() to return error code
      vdpa/mlx5: Add hardware descriptive header file
      vdpa/mlx5: Add support library for mlx5 VDPA implementation
      vdpa/mlx5: Add shared memory registration code
      vdpa/mlx5: Add VDPA driver for supported mlx5 devices

Gustavo A. R. Silva (1):
      vhost: Use flex_array_size() helper in copy_from_user()

Jason Wang (6):
      vhost: vdpa: remove per device feature whitelist
      vhost-vdpa: refine ioctl pre-processing
      vhost: generialize backend features setting/getting
      vhost-vdpa: support get/set backend features
      vhost-vdpa: support IOTLB batching hints
      vdpasim: support batch updating

Liao Pingfang (1):
      virtio_pci_modern: Fix the comment of virtio_pci_find_capability()

Mao Wenan (1):
      virtio_ring: Avoid loop when vq is broken in virtqueue_poll

Maor Gottlieb (2):
      net/mlx5: Export resource dump interface
      net/mlx5: Add support in query QP, CQ and MKEY segments

Max Gurtovoy (2):
      vdpasim: protect concurrent access to iommu iotlb
      vdpa: remove hard coded virtq num

Meir Lichtinger (1):
      RDMA/mlx5: ConnectX-7 new capabilities to set relaxed ordering by UMR

Michael Guralnik (2):
      net/mlx5: Enable QP number request when creating IPoIB underlay QP
      net/mlx5: Enable count action for rules with allow action

Michael S. Tsirkin (44):
      virtio: VIRTIO_F_IOMMU_PLATFORM -> VIRTIO_F_ACCESS_PLATFORM
      virtio: virtio_has_iommu_quirk -> virtio_has_dma_quirk
      virtio_balloon: fix sparse warning
      virtio_ring: sparse warning fixup
      virtio: allow __virtioXX, __leXX in config space
      virtio_9p: correct tags for config space fields
      virtio_balloon: correct tags for config space fields
      virtio_blk: correct tags for config space fields
      virtio_console: correct tags for config space fields
      virtio_crypto: correct tags for config space fields
      virtio_fs: correct tags for config space fields
      virtio_gpu: correct tags for config space fields
      virtio_input: correct tags for config space fields
      virtio_iommu: correct tags for config space fields
      virtio_mem: correct tags for config space fields
      virtio_net: correct tags for config space fields
      virtio_pmem: correct tags for config space fields
      virtio_scsi: correct tags for config space fields
      virtio_config: disallow native type fields
      mlxbf-tmfifo: sparse tags for config access
      vdpa: make sure set_features is invoked for legacy
      vhost/vdpa: switch to new helpers
      virtio_vdpa: legacy features handling
      vdpa_sim: fix endian-ness of config space
      virtio_config: cread/write cleanup
      virtio_config: rewrite using _Generic
      virtio_config: disallow native type fields (again)
      virtio_config: LE config space accessors
      virtio_caif: correct tags for config space fields
      virtio_config: add virtio_cread_le_feature
      virtio_balloon: use LE config space accesses
      virtio_input: convert to LE accessors
      virtio_fs: convert to LE accessors
      virtio_crypto: convert to LE accessors
      virtio_pmem: convert to LE accessors
      drm/virtio: convert to LE accessors
      virtio_mem: convert to LE accessors
      virtio-iommu: convert to LE accessors
      virtio_config: drop LE option from config space
      virtio_net: use LE accessors for speed/duplex
      Merge branch 'mlx5-next' of git://git.kernel.org/.../mellanox/linux into HEAD
      virtio_config: fix up warnings on parisc
      vdpa_sim: init iommu lock
      vdpa/mlx5: fix up endian-ness for mtu

Parav Pandit (2):
      net/mlx5: Avoid RDMA file inclusion in core driver
      net/mlx5: Avoid eswitch header inclusion in fs core layer

Tariq Toukan (1):
      net/mlx5: kTLS, Improve TLS params layout structures

Zhu Lingshan (7):
      vhost: introduce vhost_vring_call
      kvm: detect assigned device via irqbypass manager
      vDPA: add get_vq_irq() in vdpa_config_ops
      vhost_vdpa: implement IRQ offloading in vhost_vdpa
      ifcvf: implement vdpa_config_ops.get_vq_irq()
      irqbypass: do not start cons/prod when failed connect
      vDPA: dont change vq irq after DRIVER_OK

 arch/um/drivers/virtio_uml.c                       |    2 +-
 arch/x86/kvm/x86.c                                 |   12 +-
 drivers/crypto/virtio/virtio_crypto_core.c         |   46 +-
 drivers/gpu/drm/virtio/virtgpu_kms.c               |   16 +-
 drivers/gpu/drm/virtio/virtgpu_object.c            |    2 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c                |    4 +-
 drivers/iommu/virtio-iommu.c                       |   34 +-
 drivers/net/ethernet/mellanox/mlx5/core/alloc.c    |   11 +-
 .../ethernet/mellanox/mlx5/core/diag/rsc_dump.c    |    6 +
 .../ethernet/mellanox/mlx5/core/diag/rsc_dump.h    |   33 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h  |    2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls.h    |    2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c |   14 +-
 .../mellanox/mlx5/core/en_accel/tls_rxtx.c         |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   10 -
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |   10 +
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |    7 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |    3 +
 drivers/net/virtio_net.c                           |    9 +-
 drivers/nvdimm/virtio_pmem.c                       |    4 +-
 drivers/platform/mellanox/mlxbf-tmfifo.c           |   13 +-
 drivers/scsi/virtio_scsi.c                         |    4 +-
 drivers/vdpa/Kconfig                               |   19 +
 drivers/vdpa/Makefile                              |    1 +
 drivers/vdpa/ifcvf/ifcvf_base.c                    |    4 +-
 drivers/vdpa/ifcvf/ifcvf_base.h                    |    6 +-
 drivers/vdpa/ifcvf/ifcvf_main.c                    |   31 +-
 drivers/vdpa/mlx5/Makefile                         |    4 +
 drivers/vdpa/mlx5/core/mlx5_vdpa.h                 |   91 +
 drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h             |  168 ++
 drivers/vdpa/mlx5/core/mr.c                        |  486 +++++
 drivers/vdpa/mlx5/core/resources.c                 |  284 +++
 drivers/vdpa/mlx5/net/main.c                       |   76 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  | 1974 ++++++++++++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.h                  |   24 +
 drivers/vdpa/vdpa.c                                |    4 +
 drivers/vdpa/vdpa_sim/vdpa_sim.c                   |  124 +-
 drivers/vhost/Kconfig                              |    1 +
 drivers/vhost/net.c                                |   22 +-
 drivers/vhost/vdpa.c                               |  183 +-
 drivers/vhost/vhost.c                              |   39 +-
 drivers/vhost/vhost.h                              |   11 +-
 drivers/virtio/virtio_balloon.c                    |   30 +-
 drivers/virtio/virtio_input.c                      |   32 +-
 drivers/virtio/virtio_mem.c                        |   30 +-
 drivers/virtio/virtio_pci_modern.c                 |    1 +
 drivers/virtio/virtio_ring.c                       |    7 +-
 drivers/virtio/virtio_vdpa.c                       |    9 +-
 fs/fuse/virtio_fs.c                                |    4 +-
 include/linux/mlx5/cq.h                            |    1 -
 include/linux/mlx5/device.h                        |   13 +-
 include/linux/mlx5/driver.h                        |    2 +
 include/linux/mlx5/mlx5_ifc.h                      |  134 +-
 include/linux/mlx5/qp.h                            |    2 +-
 include/linux/mlx5/rsc_dump.h                      |   51 +
 include/linux/vdpa.h                               |   66 +-
 include/linux/virtio_caif.h                        |    6 +-
 include/linux/virtio_config.h                      |  191 +-
 include/linux/virtio_ring.h                        |   19 +-
 include/uapi/linux/vhost.h                         |    2 +
 include/uapi/linux/vhost_types.h                   |   11 +
 include/uapi/linux/virtio_9p.h                     |    4 +-
 include/uapi/linux/virtio_balloon.h                |   10 +-
 include/uapi/linux/virtio_blk.h                    |   26 +-
 include/uapi/linux/virtio_config.h                 |   10 +-
 include/uapi/linux/virtio_console.h                |    8 +-
 include/uapi/linux/virtio_crypto.h                 |   26 +-
 include/uapi/linux/virtio_fs.h                     |    2 +-
 include/uapi/linux/virtio_gpu.h                    |    8 +-
 include/uapi/linux/virtio_input.h                  |   18 +-
 include/uapi/linux/virtio_iommu.h                  |   12 +-
 include/uapi/linux/virtio_mem.h                    |   14 +-
 include/uapi/linux/virtio_net.h                    |    8 +-
 include/uapi/linux/virtio_pmem.h                   |    4 +-
 include/uapi/linux/virtio_scsi.h                   |   20 +-
 tools/virtio/linux/virtio_config.h                 |    6 +-
 virt/lib/irqbypass.c                               |   16 +-
 78 files changed, 4116 insertions(+), 487 deletions(-)
 create mode 100644 drivers/vdpa/mlx5/Makefile
 create mode 100644 drivers/vdpa/mlx5/core/mlx5_vdpa.h
 create mode 100644 drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h
 create mode 100644 drivers/vdpa/mlx5/core/mr.c
 create mode 100644 drivers/vdpa/mlx5/core/resources.c
 create mode 100644 drivers/vdpa/mlx5/net/main.c
 create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.c
 create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h
 create mode 100644 include/linux/mlx5/rsc_dump.h

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
