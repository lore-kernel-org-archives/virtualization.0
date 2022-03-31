Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1898FC433F5
	for <virtualization@archiver.kernel.org>; Thu, 31 Mar 2022 13:48:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BA8D419F7;
	Thu, 31 Mar 2022 13:48:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rkxwJR1NHUCs; Thu, 31 Mar 2022 13:48:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A7A4240932;
	Thu, 31 Mar 2022 13:48:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6050EC002C;
	Thu, 31 Mar 2022 13:48:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE1D6C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Mar 2022 13:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EAC4183FFD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Mar 2022 13:48:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GDna0h4Go9cO
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Mar 2022 13:48:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C62D83FFC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Mar 2022 13:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648734504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=bBNe6ZwO14A+VdUorhiFqNd6kC6eQKqel5DMkynNcGs=;
 b=VbR1c/K5sWI0GUF+QalZecm/8I/aB+wJUjO0JlBrqlI9lHzWSF5oC+Dtw/qL3ys8O1MUyn
 8s47P0mCD4Rmb0OAFjkdxaaepVeTscoVqevuBtGrr/SWMPjSei8cPAf9eCtwk3yFzfhFTX
 +4kU7xKjEbX5/7FAkSpBuUyhKVjpHD4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-_ICkVRBnMf6qd8NWN_nhiA-1; Thu, 31 Mar 2022 09:48:23 -0400
X-MC-Unique: _ICkVRBnMf6qd8NWN_nhiA-1
Received: by mail-ed1-f70.google.com with SMTP id
 v15-20020a50f08f000000b0041902200ab4so14964914edl.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Mar 2022 06:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=bBNe6ZwO14A+VdUorhiFqNd6kC6eQKqel5DMkynNcGs=;
 b=GDuYmXBI9wxyWsNxZPji9ZRivH3+08+q2/JxliIiWxWe5BR587iM+zBeoLREdjNc2q
 nq3bqMStYFk+9U75AewrO8QnKhwRg8mxGAwvDhl5KUTx8KuuDwttmvBGqJ/Vg4RaewvJ
 /1CRVU5Xt6D/Zu+O4xi7tgWiuZXRP0u5uqTzfjdK9pbX0/PFnOeBTdQgEVKz0QrQEkyi
 hqIY3lAgZhEu1D3CnPWkoRcppsd7CWNYfXCvA/omv1IcYiMmmZ70fgozV8CEEZkNoVSQ
 CgZyS5F+O+p7tGiFRiu2so4MdEwR1ahND9MTR3w3BYHLD7QsAPeCaWEdDBx4KdqDgCVq
 qCwQ==
X-Gm-Message-State: AOAM532/fpLNSurjU/mkk/MpZNTQelCT91vKG6OlgSLy1rOKLVVkLj/U
 w7FpUZFQm6k40rM78+ug7nYIAmb0UHVZ5ggvhR8DkI8/GYRkA4oTzAHjbnJ7Bs71yHgMlGineIK
 Ky/3Jlyai9iO9J6oSBjP+E4mtnWVenisZpcOfFWEzKA==
X-Received: by 2002:a17:906:69d1:b0:6ce:7201:ec26 with SMTP id
 g17-20020a17090669d100b006ce7201ec26mr5115677ejs.105.1648734501769; 
 Thu, 31 Mar 2022 06:48:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaOztpuiraqUm6TPegDkLmbLYAkWCcmmS2jBymLmYa/zJNRyuCbXtPFJnMPQ//0YMBauubEw==
X-Received: by 2002:a17:906:69d1:b0:6ce:7201:ec26 with SMTP id
 g17-20020a17090669d100b006ce7201ec26mr5115639ejs.105.1648734501541; 
 Thu, 31 Mar 2022 06:48:21 -0700 (PDT)
Received: from redhat.com ([2.53.153.13]) by smtp.gmail.com with ESMTPSA id
 h8-20020a1709066d8800b006e09a49a713sm8018933ejt.159.2022.03.31.06.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Mar 2022 06:48:21 -0700 (PDT)
Date: Thu, 31 Mar 2022 09:48:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio: features, fixes
Message-ID: <20220331094816-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linmiaohe@huawei.com, andrew@daynix.com, kvm@vger.kernel.org,
 trix@redhat.com, keirf@google.com, virtualization@lists.linux-foundation.org,
 mail@anirudhrb.com, willy@infradead.org, elic@nvidia.com,
 helei.sig11@bytedance.com, maz@kernel.org, mst@redhat.com,
 pizhenwei@bytedance.com, longpeng2@huawei.com, gdawar@xilinx.com,
 nathan@kernel.org, qiudayu@archeros.com, Jonathan.Cameron@huawei.com,
 gautam.dawar@xilinx.com, lkp@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lingshan.zhu@intel.com
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

The following changes since commit f443e374ae131c168a065ea1748feac6b2e76613:

  Linux 5.17 (2022-03-20 13:14:17 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to ad6dc1daaf29f97f23cc810d60ee01c0e83f4c6b:

  vdpa/mlx5: Avoid processing works if workqueue was destroyed (2022-03-28 16:54:30 -0400)

----------------------------------------------------------------
virtio: features, fixes

vdpa generic device type support
More virtio hardening for broken devices
On the same theme, revert some virtio hotplug hardening patches -
they were misusing some interrupt flags, will have to be reverted.
RSS support in virtio-net
max device MTU support in mlx5 vdpa
akcipher support in virtio-crypto
shared IRQ support in ifcvf vdpa
a minor performance improvement in vhost
Enable virtio mem for ARM64
beginnings of advance dma support

Cleanups, fixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Andrew Melnychenko (4):
      drivers/net/virtio_net: Fixed padded vheader to use v1 with hash.
      drivers/net/virtio_net: Added basic RSS support.
      drivers/net/virtio_net: Added RSS hash report.
      drivers/net/virtio_net: Added RSS hash report control.

Anirudh Rayabharam (1):
      vhost: handle error while adding split ranges to iotlb

Eli Cohen (2):
      net/mlx5: Add support for configuring max device MTU
      vdpa/mlx5: Avoid processing works if workqueue was destroyed

Gautam Dawar (1):
      Add definition of VIRTIO_F_IN_ORDER feature bit

Gavin Shan (1):
      drivers/virtio: Enable virtio mem for ARM64

Jason Wang (2):
      Revert "virtio-pci: harden INTX interrupts"
      Revert "virtio_pci: harden MSI-X interrupts"

Keir Fraser (1):
      virtio: pci: check bar values read from virtio config space

Longpeng (3):
      vdpa: support exposing the config size to userspace
      vdpa: change the type of nvqs to u32
      vdpa: support exposing the count of vqs to userspace

Miaohe Lin (1):
      mm/balloon_compaction: make balloon page compaction callbacks static

Michael Qiu (1):
      vdpa/mlx5: re-create forwarding rules after mac modified

Michael S. Tsirkin (2):
      tools/virtio: fix after premapped buf support
      tools/virtio: compile with -pthread

Stefano Garzarella (2):
      vhost: cache avail index in vhost_enable_notify()
      virtio: use virtio_device_ready() in virtio_device_restore()

Xuan Zhuo (3):
      virtio_ring: rename vring_unmap_state_packed() to vring_unmap_extra_packed()
      virtio_ring: remove flags check for unmap split indirect desc
      virtio_ring: remove flags check for unmap packed indirect desc

Zhu Lingshan (5):
      vDPA/ifcvf: make use of virtio pci modern IO helpers in ifcvf
      vhost_vdpa: don't setup irq offloading when irq_num < 0
      vDPA/ifcvf: implement device MSIX vector allocator
      vDPA/ifcvf: implement shared IRQ feature
      vDPA/ifcvf: cacheline alignment for ifcvf_hw

zhenwei pi (4):
      virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
      virtio-crypto: introduce akcipher service
      virtio-crypto: implement RSA algorithm
      virtio-crypto: rename skcipher algs

 drivers/crypto/virtio/Kconfig                      |   3 +
 drivers/crypto/virtio/Makefile                     |   3 +-
 .../crypto/virtio/virtio_crypto_akcipher_algs.c    | 585 +++++++++++++++++++++
 drivers/crypto/virtio/virtio_crypto_common.h       |   7 +-
 drivers/crypto/virtio/virtio_crypto_core.c         |   6 +-
 drivers/crypto/virtio/virtio_crypto_mgr.c          |  17 +-
 ...crypto_algs.c => virtio_crypto_skcipher_algs.c} |   4 +-
 drivers/net/virtio_net.c                           | 389 +++++++++++++-
 drivers/vdpa/ifcvf/ifcvf_base.c                    | 140 ++---
 drivers/vdpa/ifcvf/ifcvf_base.h                    |  24 +-
 drivers/vdpa/ifcvf/ifcvf_main.c                    | 323 ++++++++++--
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  |  84 ++-
 drivers/vdpa/vdpa.c                                |   6 +-
 drivers/vhost/iotlb.c                              |   6 +-
 drivers/vhost/vdpa.c                               |  45 +-
 drivers/vhost/vhost.c                              |   3 +-
 drivers/virtio/Kconfig                             |   7 +-
 drivers/virtio/virtio.c                            |   5 +-
 drivers/virtio/virtio_pci_common.c                 |  48 +-
 drivers/virtio/virtio_pci_common.h                 |   7 +-
 drivers/virtio/virtio_pci_legacy.c                 |   5 +-
 drivers/virtio/virtio_pci_modern.c                 |  18 +-
 drivers/virtio/virtio_pci_modern_dev.c             |   9 +-
 drivers/virtio/virtio_ring.c                       |  53 +-
 include/linux/balloon_compaction.h                 |  22 -
 include/linux/vdpa.h                               |   9 +-
 include/uapi/linux/vhost.h                         |   7 +
 include/uapi/linux/virtio_config.h                 |   6 +
 include/uapi/linux/virtio_crypto.h                 |  82 ++-
 mm/balloon_compaction.c                            |   6 +-
 tools/virtio/Makefile                              |   3 +-
 tools/virtio/linux/dma-mapping.h                   |   4 +-
 32 files changed, 1639 insertions(+), 297 deletions(-)
 create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
 rename drivers/crypto/virtio/{virtio_crypto_algs.c => virtio_crypto_skcipher_algs.c} (99%)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
