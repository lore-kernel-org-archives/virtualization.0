Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE99FC433EF
	for <virtualization@archiver.kernel.org>; Mon, 27 Jun 2022 15:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45C1F826C8;
	Mon, 27 Jun 2022 15:50:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 45C1F826C8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SN6LFtaZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sX9MkmSdfvK0; Mon, 27 Jun 2022 15:50:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CE6DD8244D;
	Mon, 27 Jun 2022 15:50:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE6DD8244D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84FA6C0039;
	Mon, 27 Jun 2022 15:50:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1149CC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 15:50:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB7B240472
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 15:50:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CB7B240472
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SN6LFtaZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YcwTHpZnpIiC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 15:50:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C90864021C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C90864021C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 15:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656345037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=d2N3t1uLLFd3tbeSCYzNndzlSKHoLHoiZV7zauWsqwQ=;
 b=SN6LFtaZA9loga4a+zsprkppHXSNgPe1rc/weX3p/Z0UjoQdM8+qAI2IeKPJN/l0PNXnsf
 L2RaRlqLjKPqEbo0YLG36z6tBz1euFyWY98sZZ1TjJbFWJp4awdLlTdvvduTtZEeDoPqbI
 Ue9B1ryDlGsA0tAiJzdPJiV2r+rKHNQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-2Ll_NXOcMgu4Doyn78Pjtg-1; Mon, 27 Jun 2022 11:50:36 -0400
X-MC-Unique: 2Ll_NXOcMgu4Doyn78Pjtg-1
Received: by mail-ed1-f72.google.com with SMTP id
 h16-20020a05640250d000b00435bab1a7b4so7488382edb.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 08:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=d2N3t1uLLFd3tbeSCYzNndzlSKHoLHoiZV7zauWsqwQ=;
 b=5R89+3JRqOCoIpJKFLv6O+e2HmhSRmBkEQpRJEy9I2ocW2LpGBd2Hl06htOJKxNa6t
 svocgoy/q9e57RUWFmFMkiPSfgpX4sOjxNxijyWfMoC84e3zZBMwqZqxzlIaPqwauX1p
 GJqxcwTZowsuGlvqBbPiEvl6/yTU3+XkDmDiYCZY3BJlBM/+egcqzZG5EtMxSrtZGB/B
 SF2OP/hcFV4h9MiACWXO79C8H/ERIamBw4WvjpEEB93+Rwu1cwRMtNQ4IcYnbRTtpmod
 5BkY0DV65RdFKTt7WblpbWatQg8Up7XLNwTAH9TJQ+eLt7mZcuwfg+siOATBsPSx+IKc
 1tTg==
X-Gm-Message-State: AJIora+EzKd52ShmFnUxnh9VwZ+s/ba/4/7SaHLAOqUKLBXArda3LrqC
 xg2FXUngYyGxeB3r01IA1KfVfIn8YBgvHsFyjgF9Sk9HY+HjK6VXZ06KPyvb8vlFBMjA76ahz4J
 R+zCsyr6JJswxHKXfLPSJA8xpYpT+wXdeBISEBF3nBQ==
X-Received: by 2002:a05:6402:2929:b0:435:6dfc:c4f2 with SMTP id
 ee41-20020a056402292900b004356dfcc4f2mr17235994edb.284.1656345034861; 
 Mon, 27 Jun 2022 08:50:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t9WduttwuVIwVX53FDNgXbP08lIvO3IwG/IkW/gZFLxJ/LK30Gor89dpwiWdlE1Y3HvzMjUQ==
X-Received: by 2002:a05:6402:2929:b0:435:6dfc:c4f2 with SMTP id
 ee41-20020a056402292900b004356dfcc4f2mr17235967edb.284.1656345034631; 
 Mon, 27 Jun 2022 08:50:34 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:207e:1f30:b6f8:324d:b101:20ff])
 by smtp.gmail.com with ESMTPSA id
 c20-20020a056402101400b004358cec9ce1sm7776739edu.65.2022.06.27.08.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jun 2022 08:50:33 -0700 (PDT)
Date: Mon, 27 Jun 2022 11:50:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio,vdpa: fixes
Message-ID: <20220627115024-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: stephan.gerhold@kernkonzept.com, kvm@vger.kernel.org, mst@redhat.com,
 huangjie.albert@bytedance.com, netdev@vger.kernel.org, wangdeming@inspur.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, liubo03@inspur.com, elic@nvidia.com,
 gautam.dawar@xilinx.com
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

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to c7cc29aaebf9eaa543b4c70801e0ecef1101b3c8:

  virtio_ring: make vring_create_virtqueue_split prettier (2022-06-27 08:05:35 -0400)

----------------------------------------------------------------
virtio,vdpa: fixes

Fixes all over the place, most notably we are disabling
IRQ hardening (again!).

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Bo Liu (1):
      virtio: Remove unnecessary variable assignments

Deming Wang (1):
      virtio_ring: make vring_create_virtqueue_split prettier

Eli Cohen (2):
      vdpa/mlx5: Update Control VQ callback information
      vdpa/mlx5: Initialize CVQ vringh only once

Jason Wang (3):
      virtio: disable notification hardening by default
      virtio-net: fix race between ndo_open() and virtio_device_ready()
      caif_virtio: fix race between virtio_device_ready() and ndo_open()

Parav Pandit (1):
      vduse: Tie vduse mgmtdev and its device

Stefano Garzarella (1):
      vhost-vdpa: call vhost_vdpa_cleanup during the release

Stephan Gerhold (2):
      virtio_mmio: Add missing PM calls to freeze/restore
      virtio_mmio: Restore guest page size on resume

huangjie.albert (1):
      virtio_ring : keep used_wrap_counter in vq->last_used_idx

 drivers/net/caif/caif_virtio.c         | 10 +++-
 drivers/net/virtio_net.c               |  8 ++-
 drivers/s390/virtio/virtio_ccw.c       |  9 +++-
 drivers/vdpa/mlx5/net/mlx5_vnet.c      | 33 ++++++++-----
 drivers/vdpa/vdpa_user/vduse_dev.c     | 60 ++++++++++++++---------
 drivers/vhost/vdpa.c                   |  2 +-
 drivers/virtio/Kconfig                 | 13 +++++
 drivers/virtio/virtio.c                |  2 +
 drivers/virtio/virtio_mmio.c           | 26 ++++++++++
 drivers/virtio/virtio_pci_modern_dev.c |  2 -
 drivers/virtio/virtio_ring.c           | 89 +++++++++++++++++++++++-----------
 include/linux/virtio_config.h          |  2 +
 12 files changed, 187 insertions(+), 69 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
