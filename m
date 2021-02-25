Return-Path: <SRS0=rmzs=H3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1ABC4332E
	for <virtualization@archiver.kernel.org>; Thu, 25 Feb 2021 19:33:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA3164F18
	for <virtualization@archiver.kernel.org>; Thu, 25 Feb 2021 19:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA3164F18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48C4084215;
	Thu, 25 Feb 2021 19:33:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cEDrjUD89H2m; Thu, 25 Feb 2021 19:33:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD05884201;
	Thu, 25 Feb 2021 19:33:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82166C000B;
	Thu, 25 Feb 2021 19:33:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1DE9C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 19:33:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E65684217
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 19:33:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kuB2Jb5AnKpf
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 19:33:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5DA5284216
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 19:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614281625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=J8XckA0wuy/u0dP7Chp3yO58HxOiKtqQRaFNCMmqR6E=;
 b=OcHT2Bk4AT05myZmeUIywWwmJdsXEKJorUVt3Vr995IeGbrVkKPnUGKTNqLUtbQQ31KSNZ
 cu5QJnF7lPSLc+h1tyby/m4IiOTA0DTz9B98bDfNM4hqFNmoD7o3M0DKwkYDfCDpLjQyBl
 rW8XGRnKnjBeHthYcUwbDfIb7WW7Rlg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-xqboewV9MZSGhDAhyDauZw-1; Thu, 25 Feb 2021 14:33:40 -0500
X-MC-Unique: xqboewV9MZSGhDAhyDauZw-1
Received: by mail-ed1-f72.google.com with SMTP id g20so3386239edy.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 11:33:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=J8XckA0wuy/u0dP7Chp3yO58HxOiKtqQRaFNCMmqR6E=;
 b=T+te+AD4Lxv9Um5LjLFkxE80GahZjBNCrgV16Iej7taYi62a4CGyJ8P1+5tC6NZC0M
 2h+T+44cQ6adUi69Y2y9NfpySmU2Ff60rfQH90MZNYwMEo77TF/A98SEZf7qPjxl1VJI
 Spus38QTaWCaIq2PwuzGq49PjCzpIGzLdRfyR0x92o5kF3iLPetHchNo1AQm9LhQ40+W
 TCF06haObguEYlyJSrUYrg8fxubhBj+AaCsuOfqJ8m7dPhsLH9jEpkdalCta++Q2ro7s
 nATPfndZR+BfvtfcAV6K00eJCmCQ6bfG24Y6By8CXi8bq2BXL6BOzXpAi0aPuLTpyo8y
 qYGQ==
X-Gm-Message-State: AOAM532t7mSeseOc02j4cbsK40tJxdeRfldizsFlpr94Fhkqp8gu71l+
 mjvn5xJS9OBacX2TUYQHarjl9PXfChqWR1rq4FPIbsiAxkr76sBaCa9QdWZm+sLMz/OkLS+GxAs
 Xb7Nrbi//X47Rho2oRbiXdXgVvHspYjd2jT3y9UJldg==
X-Received: by 2002:a17:907:2113:: with SMTP id
 qn19mr4214706ejb.98.1614281619064; 
 Thu, 25 Feb 2021 11:33:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2dN9ZzfgwQ9M65gsI//PlQJrl1Zvqctla4lD8bDjF0K4fbGkjn6jK5ahnGYupXSe2W6FPQw==
X-Received: by 2002:a17:907:2113:: with SMTP id
 qn19mr4214672ejb.98.1614281618920; 
 Thu, 25 Feb 2021 11:33:38 -0800 (PST)
Received: from redhat.com (212.116.168.114.static.012.net.il.
 [212.116.168.114])
 by smtp.gmail.com with ESMTPSA id ca26sm4215205edb.4.2021.02.25.11.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Feb 2021 11:33:38 -0800 (PST)
Date: Thu, 25 Feb 2021 14:33:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio: features, fixes
Message-ID: <20210225143333-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xianting_tian@126.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, edumazet@google.com, elic@nvidia.com,
 anders.roxell@linaro.org, naresh.kamboju@linaro.org, mst@redhat.com,
 joe.jin@oracle.com, virtualization@lists.linux-foundation.org,
 linux@roeck-us.net, aruna.ramakrishna@oracle.com,
 vasyl.vavrychuk@opensynergy.com, arnd@arndb.de, abaci@linux.alibaba.com,
 syzkaller@googlegroups.com, abaci-bugfix@linux.alibaba.com,
 netdev@vger.kernel.org, gustavoars@kernel.org, stable@vger.kernel.org,
 mathias.crombez@faurecia.com, tiantao6@hisilicon.com
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

There are a couple new drivers and support for the new management
interface for mlx under review now. I figured I'll send them separately
if review is done in time, lots of people are waiting for the vdpa tool
patches to I want to make sure they make this release.

The following changes since commit f40ddce88593482919761f74910f42f4b84c004b:

  Linux 5.11 (2021-02-14 14:32:24 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 16c10bede8b3d8594279752bf53153491f3f944f:

  virtio-input: add multi-touch support (2021-02-23 07:52:59 -0500)

----------------------------------------------------------------
virtio: features, fixes

new vdpa features to allow creation and deletion of new devices
virtio-blk support per-device queue depth
fixes, cleanups all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Colin Xu (1):
      virtio_input: Prevent EV_MSC/MSC_TIMESTAMP loop storm for MT.

Dongli Zhang (1):
      vhost scsi: alloc vhost_scsi with kvzalloc() to avoid delay

Gustavo A. R. Silva (1):
      virtio_net: Fix fall-through warnings for Clang

Jason Wang (17):
      virtio-pci: do not access iomem via struct virtio_pci_device directly
      virtio-pci: split out modern device
      virtio-pci-modern: factor out modern device initialization logic
      virtio-pci-modern: introduce vp_modern_remove()
      virtio-pci-modern: introduce helper to set config vector
      virtio-pci-modern: introduce helpers for setting and getting status
      virtio-pci-modern: introduce helpers for setting and getting features
      virtio-pci-modern: introduce vp_modern_generation()
      virtio-pci-modern: introduce vp_modern_set_queue_vector()
      virtio-pci-modern: introduce vp_modern_queue_address()
      virtio-pci-modern: introduce helper to set/get queue_enable
      virtio-pci-modern: introduce helper for setting/geting queue size
      virtio-pci-modern: introduce helper for getting queue nums
      virtio-pci-modern: introduce helper to get notification offset
      virito-pci-modern: rename map_capability() to vp_modern_map_capability()
      virtio-pci: introduce modern device module
      virtio_vdpa: don't warn when fail to disable vq

Jiapeng Zhong (1):
      virtio-mem: Assign boolean values to a bool variable

Joseph Qi (1):
      virtio-blk: support per-device queue depth

Mathias Crombez (1):
      virtio-input: add multi-touch support

Parav Pandit (6):
      vdpa_sim_net: Make mac address array static
      vdpa: Extend routine to accept vdpa device name
      vdpa: Define vdpa mgmt device, ops and a netlink interface
      vdpa: Enable a user to add and delete a vdpa device
      vdpa: Enable user to query vdpa device info
      vdpa_sim_net: Add support for user supported devices

Stefano Garzarella (1):
      vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()

Xianting Tian (1):
      virtio_mmio: fix one typo

 drivers/block/virtio_blk.c             |  11 +-
 drivers/net/virtio_net.c               |   1 +
 drivers/vdpa/Kconfig                   |   1 +
 drivers/vdpa/ifcvf/ifcvf_main.c        |   2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c      |   4 +-
 drivers/vdpa/vdpa.c                    | 503 ++++++++++++++++++++++++++-
 drivers/vdpa/vdpa_sim/vdpa_sim.c       |   3 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.h       |   2 +
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c   | 100 ++++--
 drivers/vhost/scsi.c                   |   9 +-
 drivers/virtio/Kconfig                 |   9 +
 drivers/virtio/Makefile                |   1 +
 drivers/virtio/virtio_input.c          |  26 +-
 drivers/virtio/virtio_mem.c            |   2 +-
 drivers/virtio/virtio_mmio.c           |   2 +-
 drivers/virtio/virtio_pci_common.h     |  22 +-
 drivers/virtio/virtio_pci_modern.c     | 504 ++++-----------------------
 drivers/virtio/virtio_pci_modern_dev.c | 599 +++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_vdpa.c           |   3 +-
 include/linux/vdpa.h                   |  44 ++-
 include/linux/virtio_pci_modern.h      | 111 ++++++
 include/uapi/linux/vdpa.h              |  40 +++
 22 files changed, 1492 insertions(+), 507 deletions(-)
 create mode 100644 drivers/virtio/virtio_pci_modern_dev.c
 create mode 100644 include/linux/virtio_pci_modern.h
 create mode 100644 include/uapi/linux/vdpa.h

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
