Return-Path: <SRS0=fv7C=OC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AD6C433FE
	for <virtualization@archiver.kernel.org>; Sun, 12 Sep 2021 00:05:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B473961152
	for <virtualization@archiver.kernel.org>; Sun, 12 Sep 2021 00:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B473961152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75B0A8275A;
	Sun, 12 Sep 2021 00:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uZTUYXFiIek8; Sun, 12 Sep 2021 00:05:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D123382662;
	Sun, 12 Sep 2021 00:05:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF680C000F;
	Sun, 12 Sep 2021 00:05:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 297BEC000D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 00:05:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24987401B7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 00:05:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y7JvuypKwmQI
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 00:05:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CFA8540196
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 00:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631405112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=IT3HnjaxFEROeN2QLWVUnViJA5HfWYlX8v34IjIoBJ4=;
 b=iwOxFI3O1eMizoFlzRjGVGhvTbFUTC1dCT7O1XJUOqIxVefC3dzYEzIpOSEVi0q/RyVkNL
 c1Stv973Eq6RZteOWsGd0QXpiH983R2sfdgGkMb67flmv8BmrUpo27C6l992+dxorsSQxC
 1TSBdV8qXd4WFzwHklHZ1rmlo23KKJw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-l71TVu3NOuSv5dKMFn4L3g-1; Sat, 11 Sep 2021 20:05:10 -0400
X-MC-Unique: l71TVu3NOuSv5dKMFn4L3g-1
Received: by mail-wm1-f71.google.com with SMTP id
 k5-20020a7bc3050000b02901e081f69d80so2873856wmj.8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Sep 2021 17:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=IT3HnjaxFEROeN2QLWVUnViJA5HfWYlX8v34IjIoBJ4=;
 b=2o7a/zxYvRKEJZ5BbmrcU5Mi+uKA2ZWE16emkE5j12oOvRxM+IHRobbmNKIqDkZHOl
 sfNIBneiCjrEBaSF1rN0nTxQ1Z+oVdX2P8fhw64v08vHwp3CEx4xYRQFi6eg9R65SbL/
 zzVlIbdko8Hbb6gpZOmnKuTJKqZ8CmNaF6sKcGzyRdG5cA2hDbTAZDPOLWPcsQb9Ufrb
 r36hkFdNS++fFuaZ+GSzchWJZXJU7BIHCDKpMMdfs6oPRnVcmK6xdPJrNc8AXTMw9RKA
 46Oj+NsbiYmtbOEADLHBi8b1QJiAMofASsNrBjgeUM6fc78u4dDsvG0NocNfUl6NZmzT
 QLvA==
X-Gm-Message-State: AOAM53287ce4GgYeX4+v0fiiMPPdyXg8+VRTNLGzaQyv9uezf+dSDk4E
 GZBjNs6NTXeUPH+1XDsLW8lcb88dGlPl/gU3rdZEqeKmmWIV1CvPXRxt0QbW/6DIOHdcQ7AnmQg
 1vJjdUZEvZP1JB+FR82FTPmi4IZFeRZCUtSAmwVqtVw==
X-Received: by 2002:a7b:cb45:: with SMTP id v5mr4300615wmj.184.1631405109548; 
 Sat, 11 Sep 2021 17:05:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJxDHhrbMVL4dF3568IhBCMK63Z2YRX3A33U25nv3obGFgziyRVxdJ4k5PO4+KjiDxM/Zjgg==
X-Received: by 2002:a7b:cb45:: with SMTP id v5mr4300606wmj.184.1631405109371; 
 Sat, 11 Sep 2021 17:05:09 -0700 (PDT)
Received: from redhat.com ([2.55.27.174])
 by smtp.gmail.com with ESMTPSA id t18sm2841775wrp.97.2021.09.11.17.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Sep 2021 17:05:08 -0700 (PDT)
Date: Sat, 11 Sep 2021 20:05:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL V2] virtio,vdpa,vhost: features, fixes
Message-ID: <20210911200504-mutt-send-email-mst@kernel.org>
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
 arseny.krasnov@kaspersky.com, elic@nvidia.com
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

Changes from v1:
	dropped vdpa bits until we are sure how they are
	supposed to interact with recent upstream changes

The following changes since commit 7d2a07b769330c34b4deabeed939325c77a7ec2f:

  Linux 5.14 (2021-08-29 15:04:50 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus_v2

for you to fetch changes up to 6105d1fe6f4c24ce8c13e2e6568b16b76e04983d:

  virtio-blk: remove unneeded "likely" statements (2021-09-06 07:20:56 -0400)

----------------------------------------------------------------
virtio,vdpa,vhost: features, fixes

virtio-vsock support for end of record with SEQPACKET
vdpa: mac and mq support for ifcvf and mlx5
vdpa: management netlink for ifcvf
virtio-i2c, gpio dt bindings

misc fixes, cleanups

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

Xie Yongji (1):
      vdpa_sim: Use iova_shift() for the size passed to alloc_iova()

Zhu Lingshan (4):
      vDPA/ifcvf: introduce get_dev_type() which returns virtio dev id
      vDPA/ifcvf: implement management netlink framework for ifcvf
      vDPA/ifcvf: detect and use the onboard number of queues directly
      vDPA/ifcvf: enable multiqueue and control vq

 .../devicetree/bindings/gpio/gpio-virtio.yaml      |  59 +++
 .../devicetree/bindings/i2c/i2c-virtio.yaml        |  51 ++
 Documentation/devicetree/bindings/virtio/mmio.yaml |   3 +-
 .../devicetree/bindings/virtio/virtio-device.yaml  |  41 ++
 drivers/block/virtio_blk.c                         |   4 +-
 drivers/vdpa/Kconfig                               |   1 +
 drivers/vdpa/ifcvf/ifcvf_base.c                    |   8 +-
 drivers/vdpa/ifcvf/ifcvf_base.h                    |  25 +-
 drivers/vdpa/ifcvf/ifcvf_main.c                    | 224 ++++++---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h                 |  26 +-
 drivers/vdpa/mlx5/core/mr.c                        |  81 +++-
 drivers/vdpa/mlx5/core/resources.c                 |  35 ++
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  | 517 ++++++++++++++++++---
 drivers/vdpa/vdpa_sim/vdpa_sim.c                   |   3 +-
 drivers/vhost/scsi.c                               |  14 +-
 drivers/vhost/vdpa.c                               |  24 +-
 drivers/vhost/vsock.c                              |  28 +-
 drivers/virtio/virtio.c                            |  57 ++-
 drivers/virtio/virtio_balloon.c                    |   4 +-
 include/uapi/linux/virtio_ids.h                    |  12 +
 include/uapi/linux/virtio_vsock.h                  |   3 +-
 net/vmw_vsock/af_vsock.c                           |  10 +-
 net/vmw_vsock/virtio_transport_common.c            |  23 +-
 tools/testing/vsock/vsock_test.c                   |   8 +-
 24 files changed, 1030 insertions(+), 231 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
 create mode 100644 Documentation/devicetree/bindings/virtio/virtio-device.yaml

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
