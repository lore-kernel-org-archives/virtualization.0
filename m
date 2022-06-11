Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0027CCA47A
	for <virtualization@archiver.kernel.org>; Sat, 11 Jun 2022 07:49:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37A0C82F20;
	Sat, 11 Jun 2022 07:49:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vuvu7zeunC_d; Sat, 11 Jun 2022 07:49:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C2327828A5;
	Sat, 11 Jun 2022 07:49:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 891B9C0039;
	Sat, 11 Jun 2022 07:49:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73F8FC002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Jun 2022 07:49:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A84D41848
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Jun 2022 07:49:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id si2lAqwmUD46
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Jun 2022 07:49:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BCA1A4182E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Jun 2022 07:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654933738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=qyk9g0ELjVAhO4lsyGp9C9P5YSNZEspWcN+xPCYvwJY=;
 b=AEGMAtBnoMcvnzAo8MuKtzOFmXzFnvNgHXdPpuulzK2WQaDEFCcmnbNWgCmrzjEcyhd0jQ
 8al7TWUOH+RLRmonZWVCVO09OWw/fTYDn7P6XdG7smhc6i/6x4DXRzKnydw2IJ0JSD9rhI
 a8AzBEPdK6snAb6t/LSyCUsMUzDSSvU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-wjTLTk9XMgW7teNIvck8Rg-1; Sat, 11 Jun 2022 03:48:54 -0400
X-MC-Unique: wjTLTk9XMgW7teNIvck8Rg-1
Received: by mail-ed1-f69.google.com with SMTP id
 y13-20020a056402358d00b0042dfb820070so961124edc.6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Jun 2022 00:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=qyk9g0ELjVAhO4lsyGp9C9P5YSNZEspWcN+xPCYvwJY=;
 b=teid3ofPmaTg5LpfY8JTU9xJDuIreievP4SpB0ilpkLrG+lHDR8Gu7HQQhunj+7OTF
 5SGB0cirupedgLarziUgt+Yz7n5a3gzD0RJ4RUOelI454IwSYTmjjPkv079Fqu6dllr0
 uKuAmYU0QSvugF7koMVAXHT39hOJAAKyZSGqUw3IR3E2vrUoNnmPF7Rurd5CTL1E5cIa
 SYo4B0J/JvGEGzUz82xCSLZOM23BE8keGOnhZ1OJpvSSaZRNKll6mzYECfbcv/xBFb5g
 m1vKsGYzSRbxiAe5sgb/UCKBJTjs/A/Lz9GFAPWrfEB1UqarITtImaNGDQsc9siWXRFG
 xnhg==
X-Gm-Message-State: AOAM530YIxdCJzDBCTVNCgyXrX+VDdDCVNY/UGlWvkJH+T1FFdAuegzq
 KPaJTrEUcqdK0ojMayrsxvJq4jq+ITd8T32nRxP4Xu+B/ut++kDH68ko3SCdFRQFJWJn6GP266R
 xuFCR+4qIb9JQzRHgoL7L67E/vjzb4+f/LJxRuAj5SA==
X-Received: by 2002:a05:6402:2553:b0:431:6e08:56de with SMTP id
 l19-20020a056402255300b004316e0856demr31201068edb.406.1654933733337; 
 Sat, 11 Jun 2022 00:48:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwLx5bFdq30xI5P4i3ZyKGrtOytrp9e+V51+s6ADqB5Q4i9rEt7pLobi3Np6OXDutzcfAAxQ==
X-Received: by 2002:a05:6402:2553:b0:431:6e08:56de with SMTP id
 l19-20020a056402255300b004316e0856demr31201044edb.406.1654933733098; 
 Sat, 11 Jun 2022 00:48:53 -0700 (PDT)
Received: from redhat.com ([212.116.178.142]) by smtp.gmail.com with ESMTPSA id
 zj11-20020a170907338b00b006ff0fe78cb7sm664853ejb.133.2022.06.11.00.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jun 2022 00:48:52 -0700 (PDT)
Date: Sat, 11 Jun 2022 03:48:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio,vdpa: fixes
Message-ID: <20220611034848-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xieyongji@bytedance.com, wangxiang@cdjrlc.com, pilgrimtao@gmail.com,
 kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 vincent.whitchurch@axis.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 johannes@sipsolutions.net, oliver.sang@intel.com, liubo03@inspur.com,
 fam.zheng@bytedance.com, elic@nvidia.com, gautam.dawar@xilinx.com,
 dan.carpenter@oracle.com,
 syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com
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

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to eacea844594ff338db06437806707313210d4865:

  um: virt-pci: set device ready in probe() (2022-06-10 20:38:06 -0400)

----------------------------------------------------------------
virtio,vdpa: fixes

Fixes all over the place, most notably fixes for latent
bugs in drivers that got exposed by suppressing
interrupts before DRIVER_OK, which in turn has been
done by 8b4ec69d7e09 ("virtio: harden vring IRQ").

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Bo Liu (1):
      virtio: Fix all occurences of the "the the" typo

Dan Carpenter (2):
      vdpa/mlx5: fix error code for deleting vlan
      vdpa/mlx5: clean up indenting in handle_ctrl_vlan()

Jason Wang (2):
      virtio-rng: make device ready before making request
      vdpa: make get_vq_group and set_group_asid optional

Vincent Whitchurch (1):
      um: virt-pci: set device ready in probe()

Xiang wangx (1):
      vdpa/mlx5: Fix syntax errors in comments

Xie Yongji (2):
      vringh: Fix loop descriptors check in the indirect cases
      vduse: Fix NULL pointer dereference on sysfs access

chengkaitao (1):
      virtio-mmio: fix missing put_device() when vm_cmdline_parent registration failed

 arch/um/drivers/virt-pci.c             |  7 ++++++-
 drivers/char/hw_random/virtio-rng.c    |  2 ++
 drivers/vdpa/mlx5/net/mlx5_vnet.c      |  9 +++++----
 drivers/vdpa/vdpa_user/vduse_dev.c     |  7 +++----
 drivers/vhost/vdpa.c                   |  2 ++
 drivers/vhost/vringh.c                 | 10 ++++++++--
 drivers/virtio/virtio_mmio.c           |  3 ++-
 drivers/virtio/virtio_pci_modern_dev.c |  2 +-
 include/linux/vdpa.h                   |  5 +++--
 9 files changed, 32 insertions(+), 15 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
