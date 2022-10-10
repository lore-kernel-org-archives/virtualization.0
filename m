Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9D4C4332F
	for <virtualization@archiver.kernel.org>; Mon, 10 Oct 2022 17:20:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3490282CCA;
	Mon, 10 Oct 2022 17:20:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3490282CCA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PbTVfV3a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 16CS5-g5PJPs; Mon, 10 Oct 2022 17:20:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B7DA282668;
	Mon, 10 Oct 2022 17:20:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7DA282668
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90BD0C0032;
	Mon, 10 Oct 2022 17:20:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26E36C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:20:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E66BD408C6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:20:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E66BD408C6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PbTVfV3a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CXSIt9iB8EhH
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:20:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B67D240891
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B67D240891
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665422438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=L7mzWGm9Fi3J3wL3BVtMdGC7y0bZYjMeGp/4Tbn7IOo=;
 b=PbTVfV3aPE04rLBkqPDo1F8Hrzlw9aQouX9Je5zxd8XPhS81IFPLVZYypf3DdJH+9wu7cE
 QnsZZ/xW1hIVLS0FD7sVW/oPbB8JOeHBlqt26spf/+9JilyTcYetwkuvKNqCMoVOegjCEo
 qybtgItrH709Iy74gxNaUW13Sf2YQUQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-558-RE9w_z6qNb2z22yevVvXUg-1; Mon, 10 Oct 2022 13:20:37 -0400
X-MC-Unique: RE9w_z6qNb2z22yevVvXUg-1
Received: by mail-wm1-f71.google.com with SMTP id
 v125-20020a1cac83000000b003bd44dc5242so9270557wme.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 10:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L7mzWGm9Fi3J3wL3BVtMdGC7y0bZYjMeGp/4Tbn7IOo=;
 b=E/Yu4oUlexUUSi3C0F86auO7NwCABIxnbyq2eS0k3Ila4KnXyOjbJPFpy+xcbTZyDu
 PN6TvI+OzoZ5lCqo6B6PWA6hUPrRYGBQrGY86GF2Wj4UpLKEV6wRg7kyM7FdhXYfUSkY
 nE4F1QAb7pQapqLm7uw7bqb0ed5cItBcERUV4ASxAO4l8vvEc1H00jvjWRub4WIi03IU
 82ulRryY5ljP1NxwH1BJira1XJMPc53I/9NSHg9sz/ssL57R4dFWYrO+Lm3L+tO4QeP/
 P+u26PiNS3J+VZmGdro/x4qkS9lsg169oXrUS8AA9Gld3+YKES/+vYA8K2uC2LJ8GdPU
 Yv2Q==
X-Gm-Message-State: ACrzQf2gbH/EzZczKVQFOXxkqWnSBFsTreih6k753Q4EIP59HY6/93tf
 A/54JLBllzgYzYuOpBLcO6cKzJ6OwQg3A2EW+ADpEkC97Yt/KR61NA8UrtwD8bsM9UYkgj8hdtu
 /9SVdsrTTLUkJDqkS0PvUvU+M3f/eu9QNC+nRfFC/6g==
X-Received: by 2002:a5d:456b:0:b0:230:9e5b:c64c with SMTP id
 a11-20020a5d456b000000b002309e5bc64cmr3561532wrc.211.1665422436615; 
 Mon, 10 Oct 2022 10:20:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM68dVAhvzTyD7Fyx5nUJiGXtTyQolK/pvb6X+fnB98gJfJ7lgZeRyv+gqj4yQ08CijJAvcdWw==
X-Received: by 2002:a5d:456b:0:b0:230:9e5b:c64c with SMTP id
 a11-20020a5d456b000000b002309e5bc64cmr3561523wrc.211.1665422436338; 
 Mon, 10 Oct 2022 10:20:36 -0700 (PDT)
Received: from redhat.com ([2.55.183.131]) by smtp.gmail.com with ESMTPSA id
 g7-20020a056000118700b0022ac38fb20asm9337483wrx.111.2022.10.10.10.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Oct 2022 10:20:35 -0700 (PDT)
Date: Mon, 10 Oct 2022 13:20:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio: fixes, features
Message-ID: <20221010132030-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xiujianfeng@huawei.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, wangdeming@inspur.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, angus.chen@jaguarmicro.com,
 lingshan.zhu@intel.com, gavinl@nvidia.com
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

The following changes since commit 4fe89d07dcc2804c8b562f6c7896a45643d34b2f:

  Linux 6.0 (2022-10-02 14:09:07 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 71491c54eafa318fdd24a1f26a1c82b28e1ac21d:

  virtio_pci: don't try to use intxif pin is zero (2022-10-07 20:00:44 -0400)

----------------------------------------------------------------
virtio: fixes, features

9k mtu perf improvements
vdpa feature provisioning
virtio blk SECURE ERASE support

Fixes, cleanups all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alvaro Karsz (1):
      virtio_blk: add SECURE ERASE command support

Angus Chen (1):
      virtio_pci: don't try to use intxif pin is zero

Deming Wang (2):
      virtio_ring: split: Operators use unified style
      virtio_ring: make vring_alloc_queue_packed prettier

Gavin Li (2):
      virtio-net: introduce and use helper function for guest gso support checks
      virtio-net: use mtu size as buffer length for big packets

Jason Wang (3):
      vdpa: device feature provisioning
      vdpa_sim_net: support feature provisioning
      vp_vdpa: support feature provisioning

Michael S. Tsirkin (1):
      virtio: drop vp_legacy_set_queue_size

Xiu Jianfeng (1):
      vhost: add __init/__exit annotations to module init/exit funcs

Zhu Lingshan (6):
      vDPA: allow userspace to query features of a vDPA device
      vDPA: only report driver features if FEATURES_OK is set
      vDPA: check VIRTIO_NET_F_RSS for max_virtqueue_paris's presence
      vDPA: check virtio device features to detect MQ
      vDPA: fix spars cast warning in vdpa_dev_net_mq_config_fill
      vDPA: conditionally read MTU and MAC in dev cfg space

 drivers/block/virtio_blk.c           | 110 +++++++++++++++++++++++++++++------
 drivers/net/virtio_net.c             |  48 ++++++++++-----
 drivers/vdpa/vdpa.c                  |  73 ++++++++++++++++++-----
 drivers/vdpa/vdpa_sim/vdpa_sim.c     |  12 +++-
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |   3 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |   2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |   5 +-
 drivers/vdpa/virtio_pci/vp_vdpa.c    |  22 ++++++-
 drivers/vhost/net.c                  |   4 +-
 drivers/virtio/virtio_pci_common.c   |   3 +
 drivers/virtio/virtio_ring.c         |   8 +--
 include/linux/vdpa.h                 |   1 +
 include/linux/virtio_pci_legacy.h    |   2 -
 include/uapi/linux/vdpa.h            |   6 ++
 include/uapi/linux/virtio_blk.h      |  19 ++++++
 15 files changed, 253 insertions(+), 65 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
