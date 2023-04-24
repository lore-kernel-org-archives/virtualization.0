Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88376C77B61
	for <virtualization@archiver.kernel.org>; Mon, 24 Apr 2023 21:48:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C0A1408C2;
	Mon, 24 Apr 2023 21:48:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1C0A1408C2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FaaEZjYG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z7c_TLWmSmVk; Mon, 24 Apr 2023 21:48:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 19BB6408C1;
	Mon, 24 Apr 2023 21:48:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 19BB6408C1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC881C0036;
	Mon, 24 Apr 2023 21:48:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 260F6C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 21:48:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E94FB80E9F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 21:48:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E94FB80E9F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FaaEZjYG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ezwnNOVYcSUI
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 21:48:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B996480E72
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B996480E72
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 21:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682372930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=LTku6/Nsh4EQKQDxDWLRcPwgB6PJh1RSdW2LJYHZfVo=;
 b=FaaEZjYGZiEVeCtRWI+yMNx+C9uy7xkWmkY+/hBZDaBY5sWq+p8ZXQmDxv4dqqt0ia5Y2v
 G1x/xtCyWX3/ziG8iv7CYIhqjZ4QA3GZW4kliBR4yHzyR5qN6YPMofd99MMy0TTS5/SJ9R
 D0TB36JzL0/G8LfdrtJeCMqHy6H/fnY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-vaQStosgPs6KWd2lXKXA3Q-1; Mon, 24 Apr 2023 17:48:48 -0400
X-MC-Unique: vaQStosgPs6KWd2lXKXA3Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f1754de18cso28466555e9.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 14:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682372928; x=1684964928;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LTku6/Nsh4EQKQDxDWLRcPwgB6PJh1RSdW2LJYHZfVo=;
 b=YOfKLEawiWoKNajFSZe/XYj5F1NBcVtJj5tqkDeh5TZxaKMBgN1n/yBFm1d/EqxGOP
 F7tppIRdHn8v/4xhqHP3PvsoTHdPBE+Prv/GZo7VzTwTQW0jeck1bVs7FWSDkayJQ+e/
 UovCJBWlv96MYq4F6wQXCl4LkB3qziZYyinC0ScOKd6ttIkocf8L3clIIZIsz1XSDl8c
 J86dX/7UoSzq65NjRz/loIMiVvKgzzaqKuJHgUifUVPavHtID9/tsyaEYJ5FD+gtaOPv
 Dmh+UKT6lm972axXpwjAYYKALjnqvZ2BEdwcpsfulsTwGCoql8xAek2ZymOqHSVo1f27
 dhVw==
X-Gm-Message-State: AAQBX9ejAUzPzrR3ugAuaIHzK4QJtGPxJ3Pg1fXTw9VKORf2k1N8Y8gz
 LFcQUPMQRIi6HwBjYECeksZbw8H7u2peZP2rJyrBP6L1YKHzp/BjZ/Nw43cdo4GJwM8FcxXxzxX
 +0tc44guo2WWseRfGrX+kDSfbgoslv5BcMBgGBR27/w==
X-Received: by 2002:a05:600c:3783:b0:3f1:6fb4:44cf with SMTP id
 o3-20020a05600c378300b003f16fb444cfmr8608243wmr.28.1682372927737; 
 Mon, 24 Apr 2023 14:48:47 -0700 (PDT)
X-Google-Smtp-Source: AKy350YG+bu9VkCDkBDU5OqH7npNiCVJnyD1y1MZ7cwDgboNxSYoUBRLO5K70UIGq6nLW+I8k2nrAg==
X-Received: by 2002:a05:600c:3783:b0:3f1:6fb4:44cf with SMTP id
 o3-20020a05600c378300b003f16fb444cfmr8608223wmr.28.1682372927445; 
 Mon, 24 Apr 2023 14:48:47 -0700 (PDT)
Received: from redhat.com ([2.55.17.255]) by smtp.gmail.com with ESMTPSA id
 h18-20020a5d6892000000b002f9bfac5baesm11626239wru.47.2023.04.24.14.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Apr 2023 14:48:46 -0700 (PDT)
Date: Mon, 24 Apr 2023 17:48:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio,vhost,vdpa: features, fixes, cleanups
Message-ID: <20230424174842-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, huangjie.albert@bytedance.com,
 simon.horman@corigine.com, virtualization@lists.linux-foundation.org,
 rongtao@cestc.cn, rtoax@foxmail.com, elic@nvidia.com,
 xuanzhuo@linux.alibaba.com, lulu@redhat.com, eperezma@redhat.com,
 viktor@daynix.com, jacob.e.keller@intel.com, fmdefrancesco@gmail.com,
 christophe.jaillet@wanadoo.fr, peter@n8pjl.ca, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, xieyongji@bytedance.com,
 mie@igel.co.jp, horms@kernel.org
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

Most exciting stuff this time around has to do with performance.

The following changes since commit 6a8f57ae2eb07ab39a6f0ccad60c760743051026:

  Linux 6.3-rc7 (2023-04-16 15:23:53 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to c82729e06644f4e087f5ff0f91b8fb15e03b8890:

  vhost_vdpa: fix unmap process in no-batch mode (2023-04-21 03:02:36 -0400)

----------------------------------------------------------------
virtio,vhost,vdpa: features, fixes, cleanups

reduction in interrupt rate in virtio
perf improvement for VDUSE
scalability for vhost-scsi
non power of 2 ring support for packed rings
better management for mlx5 vdpa
suspend for snet
VIRTIO_F_NOTIFICATION_DATA
shared backend with vdpa-sim-blk
user VA support in vdpa-sim
better struct packing for virtio

fixes, cleanups all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Albert Huang (1):
      virtio_ring: don't update event idx on get_buf

Alvaro Karsz (5):
      vdpa/snet: support getting and setting VQ state
      vdpa/snet: support the suspend vDPA callback
      virtio-vdpa: add VIRTIO_F_NOTIFICATION_DATA feature support
      vdpa/snet: implement kick_vq_with_data callback
      vdpa/snet: use likely/unlikely macros in hot functions

Christophe JAILLET (1):
      virtio: Reorder fields in 'struct virtqueue'

Cindy Lu (1):
      vhost_vdpa: fix unmap process in no-batch mode

Eli Cohen (3):
      vdpa/mlx5: Avoid losing link state updates
      vdpa/mlx5: Make VIRTIO_NET_F_MRG_RXBUF off by default
      vdpa/mlx5: Extend driver support for new features

Feng Liu (3):
      virtio_ring: Avoid using inline for small functions
      virtio_ring: Use const to annotate read-only pointer params
      virtio_ring: Allow non power of 2 sizes for packed virtqueue

Jacob Keller (1):
      vhost: use struct_size and size_add to compute flex array sizes

Mike Christie (5):
      vhost-scsi: Delay releasing our refcount on the tpg
      vhost-scsi: Drop device mutex use in vhost_scsi_do_plug
      vhost-scsi: Check for a cleared backend before queueing an event
      vhost-scsi: Drop vhost_scsi_mutex use in port callouts
      vhost-scsi: Reduce vhost_scsi_mutex use

Rong Tao (2):
      tools/virtio: virtio_test: Fix indentation
      tools/virtio: virtio_test -h,--help should return directly

Shunsuke Mie (2):
      virtio_ring: add a struct device forward declaration
      tools/virtio: fix build caused by virtio_ring changes

Simon Horman (3):
      vdpa: address kdoc warnings
      vringh: address kdoc warnings
      MAINTAINERS: add vringh.h to Virtio Core and Net Drivers

Stefano Garzarella (12):
      vringh: fix typos in the vringh_init_* documentation
      vdpa: add bind_mm/unbind_mm callbacks
      vhost-vdpa: use bind_mm/unbind_mm device callbacks
      vringh: replace kmap_atomic() with kmap_local_page()
      vringh: define the stride used for translation
      vringh: support VA with iotlb
      vdpa_sim: make devices agnostic for work management
      vdpa_sim: use kthread worker
      vdpa_sim: replace the spinlock with a mutex to protect the state
      vdpa_sim: add support for user VA
      vdpa_sim: move buffer allocation in the devices
      vdpa_sim_blk: support shared backend

Viktor Prutyanov (1):
      virtio: add VIRTIO_F_NOTIFICATION_DATA feature support

Xie Yongji (11):
      lib/group_cpus: Export group_cpus_evenly()
      vdpa: Add set/get_vq_affinity callbacks in vdpa_config_ops
      virtio-vdpa: Support interrupt affinity spreading mechanism
      vduse: Refactor allocation for vduse virtqueues
      vduse: Support set_vq_affinity callback
      vduse: Support get_vq_affinity callback
      vduse: Add sysfs interface for irq callback affinity
      vdpa: Add eventfd for the vdpa callback
      vduse: Signal vq trigger eventfd directly if possible
      vduse: Delay iova domain creation
      vduse: Support specifying bounce buffer size via sysfs

Xuan Zhuo (1):
      MAINTAINERS: make me a reviewer of VIRTIO CORE AND NET DRIVERS

 MAINTAINERS                          |   2 +
 drivers/s390/virtio/virtio_ccw.c     |  22 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c    | 261 +++++++++++++---------
 drivers/vdpa/solidrun/Makefile       |   1 +
 drivers/vdpa/solidrun/snet_ctrl.c    | 330 ++++++++++++++++++++++++++++
 drivers/vdpa/solidrun/snet_hwmon.c   |   2 +-
 drivers/vdpa/solidrun/snet_main.c    | 146 ++++++------
 drivers/vdpa/solidrun/snet_vdpa.h    |  20 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 166 +++++++++++---
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  14 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  93 ++++++--
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  38 ++--
 drivers/vdpa/vdpa_user/vduse_dev.c   | 414 +++++++++++++++++++++++++++++------
 drivers/vhost/scsi.c                 | 102 +++++----
 drivers/vhost/vdpa.c                 |  44 +++-
 drivers/vhost/vhost.c                |   6 +-
 drivers/vhost/vringh.c               | 191 ++++++++++++----
 drivers/virtio/virtio_mmio.c         |  18 +-
 drivers/virtio/virtio_pci_modern.c   |  22 +-
 drivers/virtio/virtio_ring.c         |  89 +++++---
 drivers/virtio/virtio_vdpa.c         | 120 +++++++++-
 include/linux/vdpa.h                 |  52 ++++-
 include/linux/virtio.h               |  16 +-
 include/linux/virtio_ring.h          |   3 +
 include/linux/vringh.h               |  26 ++-
 include/uapi/linux/virtio_config.h   |   6 +
 lib/group_cpus.c                     |   1 +
 tools/include/linux/types.h          |   5 +
 tools/virtio/linux/compiler.h        |   2 +
 tools/virtio/linux/kernel.h          |   5 +-
 tools/virtio/linux/uaccess.h         |  11 +-
 tools/virtio/virtio_test.c           |  12 +-
 32 files changed, 1760 insertions(+), 480 deletions(-)
 create mode 100644 drivers/vdpa/solidrun/snet_ctrl.c

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
