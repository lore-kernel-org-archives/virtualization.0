Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E800BC433EF
	for <virtualization@archiver.kernel.org>; Sun, 12 Dec 2021 23:00:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7744F60BC5;
	Sun, 12 Dec 2021 23:00:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MTYW6CptD7fg; Sun, 12 Dec 2021 23:00:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 98BE960B31;
	Sun, 12 Dec 2021 23:00:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59051C002F;
	Sun, 12 Dec 2021 23:00:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DC88C0012
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 23:00:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 76053852B1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 23:00:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CkLqhs8DsiUb
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 23:00:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 55D4A852A8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 23:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639350001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=WYVQFnDIbcgI5d/vqJyK9JfPBSSPc6zKfbYcO57Li1U=;
 b=Joh3/qeuSFOI5deknBo7WZZn9+bH9icI/hYbUGfRYmaQ8wzdS78kDYYMZANYsgTcuvCrNI
 ZB9syrk4BgPykxph2p5ZAt/iDDbiRxEy97xADVcnNflNuCtzTmlVnsjc5zgA+YoAgn+cVg
 57RMtSuiket/tKUVtEqed0UpCh0633s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-gIYQCbP5PyKzsdlc1sBf_w-1; Sun, 12 Dec 2021 17:59:59 -0500
X-MC-Unique: gIYQCbP5PyKzsdlc1sBf_w-1
Received: by mail-wm1-f69.google.com with SMTP id
 j193-20020a1c23ca000000b003306ae8bfb7so8770500wmj.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 14:59:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=WYVQFnDIbcgI5d/vqJyK9JfPBSSPc6zKfbYcO57Li1U=;
 b=I0GBXHW2QhrMOzfQ4HzeGB9ZBhzHMrpzuVEjm3PPpwr8kdhCYiBKnuvn08mPBgUU4N
 TL7xJxVrcYuxA+xxYsByw5i8mN544Yk9bA4CWeiQ8x3gZMJN3FcEWMP4UiWTTmyWigPG
 ZF/YxpnZhxtn8l4eJFmBI/uuGgRtV/UghVtNFiovr9dLn1tXUj/nFgJfy4JTW9xAA0Ee
 Qw4chZ2rIFrmmJfodURi/k5wqFK+jdpqeCYea+71aylgvOeKGB3DSJuCgQbE6nPzx4TI
 7HUd7aVzEp1bUT4LCOMLxDRgYGjReCpguJ5yfjOGFr0ZIIs4uowwIyt+lrPK6AoWZaEX
 gW8w==
X-Gm-Message-State: AOAM530eaJ20gDj7mrvVpyc40PeAdetExCzbb8n4XSkE1/jmjxPJM0bM
 JfGr+CEIkNzrpKTfiCOxHASjOHHzHNCVD8UEV9tXNWvi+Gj3UYuIadF/LMuOiSlyMBLQvcUUPjO
 wEHqO/fF9Co+b/T3PH5DWBCfyy7x+BBMprRRv59kXoQ==
X-Received: by 2002:a05:600c:1987:: with SMTP id
 t7mr32456835wmq.24.1639349998304; 
 Sun, 12 Dec 2021 14:59:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2bTppYN2huiK2nylUvg6FCr00HLDzfg04TlPUjrDVfn+bIvC2GBhAeUTenJbfKS0A/G9aQQ==
X-Received: by 2002:a05:600c:1987:: with SMTP id
 t7mr32456804wmq.24.1639349998099; 
 Sun, 12 Dec 2021 14:59:58 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:107e:eefb:294:6ac8:eff6:22df])
 by smtp.gmail.com with ESMTPSA id bd18sm5203284wmb.43.2021.12.12.14.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Dec 2021 14:59:57 -0800 (PST)
Date: Sun, 12 Dec 2021 17:59:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] vhost: cleanups and fixes
Message-ID: <20211212175951-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, will@kernel.org, hch@lst.de,
 lkp@intel.com, maz@kernel.org, suzuki.poulose@arm.com, steven.price@arm.com,
 xieyongji@bytedance.com, dan.carpenter@oracle.com, jroedel@suse.de,
 arnd@arndb.de, konrad.wilk@oracle.com, qperret@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 robin.murphy@arm.com
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

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to bb47620be322c5e9e372536cb6b54e17b3a00258:

  vdpa: Consider device id larger than 31 (2021-12-08 15:41:50 -0500)

----------------------------------------------------------------
virtio,vdpa: bugfixes

Misc bugfixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Arnd Bergmann (1):
      virtio: always enter drivers/virtio/

Dan Carpenter (3):
      vduse: fix memory corruption in vduse_dev_ioctl()
      vdpa: check that offsets are within bounds
      vduse: check that offset is within bounds in get_config()

Parav Pandit (1):
      vdpa: Consider device id larger than 31

Wei Wang (1):
      virtio/vsock: fix the transport to work with VMADDR_CID_ANY

Will Deacon (1):
      virtio_ring: Fix querying of maximum DMA mapping size for virtio device

 drivers/Makefile                        | 3 +--
 drivers/vdpa/vdpa.c                     | 3 ++-
 drivers/vdpa/vdpa_user/vduse_dev.c      | 6 ++++--
 drivers/vhost/vdpa.c                    | 2 +-
 drivers/virtio/virtio_ring.c            | 2 +-
 net/vmw_vsock/virtio_transport_common.c | 3 ++-
 6 files changed, 11 insertions(+), 8 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
