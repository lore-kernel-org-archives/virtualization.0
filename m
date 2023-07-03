Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1884FEB64DD
	for <virtualization@archiver.kernel.org>; Mon,  3 Jul 2023 16:33:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 918B582072;
	Mon,  3 Jul 2023 16:33:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 918B582072
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ccnhnC+u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wzCoc56m1wTs; Mon,  3 Jul 2023 16:33:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A1CF782064;
	Mon,  3 Jul 2023 16:33:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A1CF782064
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78D0CC0072;
	Mon,  3 Jul 2023 16:33:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8FDCC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 16:33:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ACFAD40286
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 16:33:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ACFAD40286
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ccnhnC+u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zj6Q9bx_eFpn
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 16:33:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F3AE4003B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F3AE4003B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 16:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688401984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=o9JfmV88VU7bKRr8QoDVSiiCtWQNwua/yZVv7UwouXs=;
 b=ccnhnC+uBCK6wJgvikMKWDVdu+2CIrjBQFfHJEk1q1hNkDgsMR3KO1TrkWh+bjYHi2qj+V
 WUGPllpp7+ZjavcUTmbmAfu0OyWNCO5TTnZ5vWyZVQkmiFUrlt8wVBt8YCpwp+OWtpE1i3
 7qmSZFMuSvnO1GZG5cHIOSX5KjcPEqQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-pE2xA5WAMjuRaVe9COnuWg-1; Mon, 03 Jul 2023 12:33:01 -0400
X-MC-Unique: pE2xA5WAMjuRaVe9COnuWg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fbaade0c71so29288665e9.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Jul 2023 09:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688401980; x=1690993980;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o9JfmV88VU7bKRr8QoDVSiiCtWQNwua/yZVv7UwouXs=;
 b=hU4N2xWqhBqrq5gKu7Ddv0l7KYOeeRB7pVMkGCPPMZuK+TIlbLYb3mRbBGtA3U16z7
 tkv+m2voYEmkceCW70ki5n9NDocmVZeqCbH4yE/l0Io1u8ZGa58CeqClGaRi3vkYKdUM
 DlbVo9MAOlYEZcgkSs1SJ+yPAP3vQY9yQDrrBV7YLxYUM4W9t/2iE0JXg2jioh2QlL5y
 Re5J6ugHvMwtHR7C1aLaLGipE5OgRH7uMEc4QVowHGXdBsqH5dmsHGzGyyhvlvDQohwX
 pKmOZPibbL5EhdjvCuur0DsbBE4MR2pMas0yxb2oaT2nD5TJ7aEqV+pVUTbUOzvjzhha
 cbXA==
X-Gm-Message-State: ABy/qLZV0B5AklyzeXEOXax3/Ol+YWETBsgsClOUq5gAwGOGRyNGgpmh
 J5YQt0VKujf9a4hLL4tz8Hji+h/F4W2KYj68WVTTXMDdWfn/yAJEARarR47Rc19/hMneLINbzB/
 ingNP9mcy8LGeywIZBF0lEYuH5hDeamypoHb+QEP9xg==
X-Received: by 2002:a05:600c:204c:b0:3fb:c9f4:14f3 with SMTP id
 p12-20020a05600c204c00b003fbc9f414f3mr7664427wmg.2.1688401980561; 
 Mon, 03 Jul 2023 09:33:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF3hFeAuV3dUEiLC0bwfsYkvJ+BICpkbXADsRD+NAYyFyEPyRSAlNMR3Fy4eKLuXU7LTEvA3A==
X-Received: by 2002:a05:600c:204c:b0:3fb:c9f4:14f3 with SMTP id
 p12-20020a05600c204c00b003fbc9f414f3mr7664400wmg.2.1688401980209; 
 Mon, 03 Jul 2023 09:33:00 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 m6-20020a7bce06000000b003f733c1129fsm18646129wmc.33.2023.07.03.09.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 09:32:59 -0700 (PDT)
Date: Mon, 3 Jul 2023 12:32:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio: features, fixes, cleanups
Message-ID: <20230703123256-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: peng.fan@nxp.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
 xianting.tian@linux.alibaba.com, krzysztof.kozlowski@linaro.org,
 tianxianting.txt@alibaba-inc.com, horms@kernel.org, maxime.coquelin@redhat.com,
 elic@nvidia.com, virtualization@lists.linux-foundation.org, saeedm@nvidia.com
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

Note: dropped some commits at the last moment, I did verify we get
the same code in the end as what was in linux next for a while now.

The following changes since commit 6995e2de6891c724bfeb2db33d7b87775f913ad1:

  Linux 6.4 (2023-06-25 16:29:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 9e396a2f434f829fb3b98a24bb8db5429320589d:

  vhost: Make parameter name match of vhost_get_vq_desc() (2023-07-03 12:15:15 -0400)

----------------------------------------------------------------
virtio: features, fixes, cleanups

resume support in vdpa/solidrun
structure size optimizations in virtio_pci
new pds_vdpa driver
immediate initialization mechanism for vdpa/ifcvf
interrupt bypass for vdpa/mlx5
multiple worker support for vhost
viirtio net in Intel F2000X-PL support for vdpa/ifcvf

fixes, cleanups all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alvaro Karsz (1):
      vdpa/snet: implement the resume vDPA callback

Dragos Tatulea (1):
      virtio-vdpa: Fix unchecked call to NULL set_vq_affinity

Eli Cohen (1):
      vdpa/mlx5: Support interrupt bypassing

Feng Liu (1):
      virtio_pci: Optimize virtio_pci_device structure size

Krzysztof Kozlowski (1):
      vdpa: solidrun: constify pointers to hwmon_channel_info

Maxime Coquelin (1):
      vduse: fix NULL pointer dereference

Mike Christie (17):
      vhost: create worker at end of vhost_dev_set_owner
      vhost: dynamically allocate vhost_worker
      vhost: add vhost_worker pointer to vhost_virtqueue
      vhost, vhost_net: add helper to check if vq has work
      vhost: take worker or vq instead of dev for queueing
      vhost: take worker or vq for flushing
      vhost: convert poll work to be vq based
      vhost_sock: convert to vhost_vq_work_queue
      vhost_scsi: make SCSI cmd completion per vq
      vhost_scsi: convert to vhost_vq_work_queue
      vhost_scsi: flush IO vqs then send TMF rsp
      vhost: remove vhost_work_queue
      vhost: add helper to parse userspace vring state/file
      vhost: replace single worker pointer with xarray
      vhost: allow userspace to create workers
      vhost_scsi: add support for worker ioctls
      vhost: Allow worker switching while work is queueing

Peng Fan (1):
      tools/virtio: fix build break for aarch64

Shannon Nelson (11):
      virtio: allow caller to override device id in vp_modern
      virtio: allow caller to override device DMA mask in vp_modern
      pds_vdpa: Add new vDPA driver for AMD/Pensando DSC
      pds_vdpa: move enum from common to adminq header
      pds_vdpa: new adminq entries
      pds_vdpa: get vdpa management info
      pds_vdpa: virtio bar setup for vdpa
      pds_vdpa: add vdpa config client commands
      pds_vdpa: add support for vdpa and vdpamgmt interfaces
      pds_vdpa: subscribe to the pds_core events
      pds_vdpa: pds_vdps.rst and Kconfig

Simon Horman (1):
      virtio: Add missing documentation for structure fields

Xianting Tian (4):
      virtio-crypto: call scheduler when we free unused buffs
      virtio-console: call scheduler when we free unused buffs
      virtio_bt: call scheduler when we free unused buffs
      vhost: Make parameter name match of vhost_get_vq_desc()

Zhu Lingshan (8):
      vDPA/ifcvf: virt queue ops take immediate actions
      vDPA/ifcvf: get_driver_features from virtio registers
      vDPA/ifcvf: retire ifcvf_start_datapath and ifcvf_add_status
      vDPA/ifcvf: synchronize irqs in the reset routine
      vDPA/ifcvf: a vendor driver should not set _CONFIG_S_FAILED
      vDPA/ifcvf: dynamic allocate vq data stores
      vDPA/ifcvf: detect and report max allowed vq size
      vDPA/ifcvf: implement new accessors for vq_state

 .../device_drivers/ethernet/amd/pds_vdpa.rst       |  85 +++
 .../networking/device_drivers/ethernet/index.rst   |   1 +
 MAINTAINERS                                        |   4 +
 drivers/bluetooth/virtio_bt.c                      |   1 +
 drivers/char/virtio_console.c                      |   1 +
 drivers/crypto/virtio/virtio_crypto_core.c         |   1 +
 drivers/vdpa/Kconfig                               |  10 +
 drivers/vdpa/Makefile                              |   1 +
 drivers/vdpa/ifcvf/ifcvf_base.c                    | 215 +++---
 drivers/vdpa/ifcvf/ifcvf_base.h                    |  48 +-
 drivers/vdpa/ifcvf/ifcvf_main.c                    | 108 +--
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  | 165 ++++-
 drivers/vdpa/mlx5/net/mlx5_vnet.h                  |  15 +
 drivers/vdpa/pds/Makefile                          |  10 +
 drivers/vdpa/pds/aux_drv.c                         | 140 ++++
 drivers/vdpa/pds/aux_drv.h                         |  26 +
 drivers/vdpa/pds/cmds.c                            | 185 +++++
 drivers/vdpa/pds/cmds.h                            |  18 +
 drivers/vdpa/pds/debugfs.c                         | 289 ++++++++
 drivers/vdpa/pds/debugfs.h                         |  17 +
 drivers/vdpa/pds/vdpa_dev.c                        | 769 +++++++++++++++++++++
 drivers/vdpa/pds/vdpa_dev.h                        |  49 ++
 drivers/vdpa/solidrun/snet_ctrl.c                  |   6 +
 drivers/vdpa/solidrun/snet_hwmon.c                 |   2 +-
 drivers/vdpa/solidrun/snet_main.c                  |  15 +
 drivers/vdpa/solidrun/snet_vdpa.h                  |   1 +
 drivers/vdpa/vdpa_user/vduse_dev.c                 |   6 +-
 drivers/vhost/net.c                                |   8 +-
 drivers/vhost/scsi.c                               | 103 +--
 drivers/vhost/vhost.c                              | 425 ++++++++++--
 drivers/vhost/vhost.h                              |  24 +-
 drivers/vhost/vsock.c                              |   4 +-
 drivers/virtio/virtio_pci_common.h                 |   7 +-
 drivers/virtio/virtio_pci_modern_dev.c             |  33 +-
 drivers/virtio/virtio_vdpa.c                       |   4 +-
 include/linux/pds/pds_adminq.h                     | 247 +++++++
 include/linux/pds/pds_common.h                     |  21 +-
 include/linux/virtio.h                             |   5 +-
 include/linux/virtio_pci_modern.h                  |   6 +
 include/uapi/linux/vhost.h                         |  31 +
 include/uapi/linux/vhost_types.h                   |  16 +
 tools/virtio/Makefile                              |  13 +-
 42 files changed, 2777 insertions(+), 358 deletions(-)
 create mode 100644 Documentation/networking/device_drivers/ethernet/amd/pds_vdpa.rst
 create mode 100644 drivers/vdpa/pds/Makefile
 create mode 100644 drivers/vdpa/pds/aux_drv.c
 create mode 100644 drivers/vdpa/pds/aux_drv.h
 create mode 100644 drivers/vdpa/pds/cmds.c
 create mode 100644 drivers/vdpa/pds/cmds.h
 create mode 100644 drivers/vdpa/pds/debugfs.c
 create mode 100644 drivers/vdpa/pds/debugfs.h
 create mode 100644 drivers/vdpa/pds/vdpa_dev.c
 create mode 100644 drivers/vdpa/pds/vdpa_dev.h

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
