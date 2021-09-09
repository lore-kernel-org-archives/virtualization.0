Return-Path: <SRS0=8M8J=N7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD60C433F5
	for <virtualization@archiver.kernel.org>; Thu,  9 Sep 2021 13:56:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C326120F
	for <virtualization@archiver.kernel.org>; Thu,  9 Sep 2021 13:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C3C326120F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E90440352;
	Thu,  9 Sep 2021 13:56:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ao5cS11HmaeB; Thu,  9 Sep 2021 13:56:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 80FBF40330;
	Thu,  9 Sep 2021 13:56:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58A5BC000F;
	Thu,  9 Sep 2021 13:56:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A754CC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 13:56:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8807540116
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 13:56:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X5M-lL-kZn5d
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 13:56:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F2C4400B5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 13:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631195775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=FJ3vx9ItWF84RR27z81TE9j4hUoJb+a4RSamUREx5R8=;
 b=dn05rc+PBT7TETFotzbxttrddwrDru9isvwU9Ms1pjh5HYouKcFep9EbXwV6rA34jZf7F1
 mLfhGjLm4cXsWsGsdi850s6GQ/f8U4cjvt2nigXQ0ODQ9JeOZS15zFGjey4g5nGZ38aDNY
 jUI9X75y+AfbzsCiFMZusy/dTphbH0o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-Kf0JT628PXifIKWOx_poWQ-1; Thu, 09 Sep 2021 09:56:14 -0400
X-MC-Unique: Kf0JT628PXifIKWOx_poWQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 bo11-20020a170906d04b00b005d477e1e41fso842947ejb.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Sep 2021 06:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=FJ3vx9ItWF84RR27z81TE9j4hUoJb+a4RSamUREx5R8=;
 b=AvIG0kHO7syzWfXJ+K777mfz3AfcRgFsiEiSsFkf/9h2q3irN37lyr3+EYZeUqJuh3
 l/PPxVuBP+JBmVpSB3Pk7EDCi73fUbq+XUoJHcTchz+Qh9lHShfKV1Y/5XkGbBl7ufyl
 rx8iEfmm3i5UK5iYkGSz6oQHYmXKHp1RAFWbH3E7YBtuQgabQ1L/JwpvqDUqFyG9PyPu
 zyyduP65v1Oa5DNRuXiYmd/jURbzwTwaUtm6rG9x+Ztuww6spLJ6zHWmaOrnkRcYIfbm
 bzL6eYoqcwJDMO6WBOkCkIHn195Pwe6R2f88p/YLKeVmuZLbhz8JeJvP3fpktCrx2NV8
 q1Gg==
X-Gm-Message-State: AOAM532uKTb0FQxpBK/vPPDBCMfsWGP+H0kxh5xckcJjEMywQWiXBdF6
 yJfTV0tSBKjScYzdcRjqHX8BerpFGc8c6mQ6qNf0ISXrQCzj7pNCCMh5kzw1siyVHNeN4mvWOPB
 ECsHBXZ2fQ9KbB6Aw/YW1vn0+pLhStZT/Nq2MktOEoQ==
X-Received: by 2002:a17:906:12c8:: with SMTP id
 l8mr3453447ejb.515.1631195772679; 
 Thu, 09 Sep 2021 06:56:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4tBPafNVgPmrZd3KYi1ABh5Zl7/eVhQcwR6Yr2RpP9yEYDIYrmgjs2t9Ub19JNtKWg/PAtg==
X-Received: by 2002:a17:906:12c8:: with SMTP id
 l8mr3453415ejb.515.1631195772487; 
 Thu, 09 Sep 2021 06:56:12 -0700 (PDT)
Received: from redhat.com ([2.55.145.189])
 by smtp.gmail.com with ESMTPSA id t19sm987072ejb.115.2021.09.09.06.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Sep 2021 06:56:11 -0700 (PDT)
Date: Thu, 9 Sep 2021 09:56:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio,vdpa,vhost: features, fixes
Message-ID: <20210909095608-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mgurtovoy@nvidia.com, lingshan.zhu@intel.com, kvm@vger.kernel.org,
 mst@redhat.com, xianting.tian@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, xieyongji@bytedance.com, viresh.kumar@linaro.org,
 arseny.krasnov@kaspersky.com, will@kernel.org, elic@nvidia.com
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

The following changes since commit 7d2a07b769330c34b4deabeed939325c77a7ec2f:

  Linux 5.14 (2021-08-29 15:04:50 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 7bc7f61897b66bef78bb5952e3d1e9f3aaf9ccca:

  Documentation: Add documentation for VDUSE (2021-09-06 07:20:58 -0400)

----------------------------------------------------------------
virtio,vdpa,vhost: features, fixes

vduse driver supporting blk
virtio-vsock support for end of record with SEQPACKET
vdpa: mac and mq support for ifcvf and mlx5
vdpa: management netlink for ifcvf
virtio-i2c, gpio dt bindings

misc fixes, cleanups

NB: when merging this with
b542e383d8c0 ("eventfd: Make signal recursion protection a task bit")
from Linus' tree, replace eventfd_signal_count with
eventfd_signal_allowed, and drop the export of eventfd_wake_count from
("eventfd: Export eventfd_wake_count to modules").

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Arseny Krasnov (6):
      virtio/vsock: rename 'EOR' to 'EOM' bit.
      virtio/vsock: add 'VIRTIO_VSOCK_SEQ_EOR' bit.
      vhost/vsock: support MSG_EOR bit processing
      virtio/vsock: support MSG_EOR bit processing
      af_vsock: rename variables in receive loop
      vsock_test: update message bounds test for MSG_EOR

Cai Huoqing (2):
      vhost scsi: Convert to SPDX identifier
      vdpa: Make use of PFN_PHYS/PFN_UP/PFN_DOWN helper macro

Eli Cohen (6):
      vdpa/mlx5: Remove redundant header file inclusion
      vdpa/mlx5: function prototype modifications in preparation to control VQ
      vdpa/mlx5: Decouple virtqueue callback from struct mlx5_vdpa_virtqueue
      vdpa/mlx5: Ensure valid indices are provided
      vdpa/mlx5: Add support for control VQ and MAC setting
      vdpa/mlx5: Add multiqueue support

Max Gurtovoy (1):
      virtio-blk: remove unneeded "likely" statements

Viresh Kumar (5):
      dt-bindings: virtio: Add binding for virtio devices
      dt-bindings: i2c: Add bindings for i2c-virtio
      dt-bindings: gpio: Add bindings for gpio-virtio
      uapi: virtio_ids: Sync ids with specification
      virtio: Bind virtio device to device-tree node

Xianting Tian (1):
      virtio-balloon: Use virtio_find_vqs() helper

Xie Yongji (14):
      vdpa_sim: Use iova_shift() for the size passed to alloc_iova()
      iova: Export alloc_iova_fast() and free_iova_fast()
      eventfd: Export eventfd_wake_count to modules
      file: Export receive_fd() to modules
      vdpa: Fix some coding style issues
      vdpa: Add reset callback in vdpa_config_ops
      vhost-vdpa: Handle the failure of vdpa_reset()
      vhost-iotlb: Add an opaque pointer for vhost IOTLB
      vdpa: Add an opaque pointer for vdpa_config_ops.dma_map()
      vdpa: factor out vhost_vdpa_pa_map() and vhost_vdpa_pa_unmap()
      vdpa: Support transferring virtual addressing during DMA mapping
      vduse: Implement an MMU-based software IOTLB
      vduse: Introduce VDUSE - vDPA Device in Userspace
      Documentation: Add documentation for VDUSE

Zhu Lingshan (4):
      vDPA/ifcvf: introduce get_dev_type() which returns virtio dev id
      vDPA/ifcvf: implement management netlink framework for ifcvf
      vDPA/ifcvf: detect and use the onboard number of queues directly
      vDPA/ifcvf: enable multiqueue and control vq

 .../devicetree/bindings/gpio/gpio-virtio.yaml      |   59 +
 .../devicetree/bindings/i2c/i2c-virtio.yaml        |   51 +
 Documentation/devicetree/bindings/virtio/mmio.yaml |    3 +-
 .../devicetree/bindings/virtio/virtio-device.yaml  |   41 +
 Documentation/userspace-api/index.rst              |    1 +
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
 Documentation/userspace-api/vduse.rst              |  233 +++
 drivers/block/virtio_blk.c                         |    4 +-
 drivers/iommu/iova.c                               |    2 +
 drivers/vdpa/Kconfig                               |   11 +
 drivers/vdpa/Makefile                              |    1 +
 drivers/vdpa/ifcvf/ifcvf_base.c                    |    8 +-
 drivers/vdpa/ifcvf/ifcvf_base.h                    |   25 +-
 drivers/vdpa/ifcvf/ifcvf_main.c                    |  257 ++-
 drivers/vdpa/mlx5/core/mlx5_vdpa.h                 |   26 +-
 drivers/vdpa/mlx5/core/mr.c                        |   81 +-
 drivers/vdpa/mlx5/core/resources.c                 |   35 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  |  555 ++++++-
 drivers/vdpa/vdpa.c                                |    9 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c                   |   29 +-
 drivers/vdpa/vdpa_user/Makefile                    |    5 +
 drivers/vdpa/vdpa_user/iova_domain.c               |  545 +++++++
 drivers/vdpa/vdpa_user/iova_domain.h               |   73 +
 drivers/vdpa/vdpa_user/vduse_dev.c                 | 1641 ++++++++++++++++++++
 drivers/vdpa/virtio_pci/vp_vdpa.c                  |   17 +-
 drivers/vhost/iotlb.c                              |   20 +-
 drivers/vhost/scsi.c                               |   14 +-
 drivers/vhost/vdpa.c                               |  188 ++-
 drivers/vhost/vsock.c                              |   28 +-
 drivers/virtio/virtio.c                            |   57 +-
 drivers/virtio/virtio_balloon.c                    |    4 +-
 fs/eventfd.c                                       |    1 +
 fs/file.c                                          |    6 +
 include/linux/file.h                               |    7 +-
 include/linux/vdpa.h                               |   62 +-
 include/linux/vhost_iotlb.h                        |    3 +
 include/uapi/linux/vduse.h                         |  306 ++++
 include/uapi/linux/virtio_ids.h                    |   12 +
 include/uapi/linux/virtio_vsock.h                  |    3 +-
 net/vmw_vsock/af_vsock.c                           |   10 +-
 net/vmw_vsock/virtio_transport_common.c            |   23 +-
 tools/testing/vsock/vsock_test.c                   |    8 +-
 42 files changed, 4136 insertions(+), 329 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
 create mode 100644 Documentation/devicetree/bindings/virtio/virtio-device.yaml
 create mode 100644 Documentation/userspace-api/vduse.rst
 create mode 100644 drivers/vdpa/vdpa_user/Makefile
 create mode 100644 drivers/vdpa/vdpa_user/iova_domain.c
 create mode 100644 drivers/vdpa/vdpa_user/iova_domain.h
 create mode 100644 drivers/vdpa/vdpa_user/vduse_dev.c
 create mode 100644 include/uapi/linux/vduse.h

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
