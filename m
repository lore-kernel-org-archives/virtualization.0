Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.133
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793798150;
	b=hIdMeEoF5GedqBu8Vgm9ZDWFAQb1z5G6+dJFrpWFlvVGCKlgRHQZLtdIcy8SM4TuMmSm
	 fUdf+AFyYiKjuWE+TNULLp0+o/I4HLJVN4W+RIdN8pQlrgfEmWuO2kFI/34myFi8SxaZW
	 BSo72Bh/ug1VtJWCPJQzRyqBL8jNQHlu0a8A1Y8WTaBIiHzV58zlc4Ql6UR4qNNqDDxZy
	 bmrahl2MWJHeMflN+aakilc7DfmG2KlcztrVr9Uk+gC1XXA3T86ncdwyOuP3doysF2yp8
	 xRwkSyEDqh2z34SxaOZHBWr/xLXknXIDRdSZNKEDAKVsSv7I+RtdBTM3vgO2z7Y/EpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798150;
	h=Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding;
	bh=cweYKUfQfPNBI8VU6FrLwRgYq4BFUF09qYh0EQWkf/Y=;
	b=0c32D7K+sNV4ColjUYYKuGXPPz6nM5wFBAdQfFWypQ15xAdHpB3zN4oCq5TVfYWb6h3J
	 b24P2KT9Ln2mLqHWZzsoCoMgI9hMO9p5+IokuGJmb1fQYs6GpNuddDDkBWMLeUAfOpcNz
	 xVumCcsUDO0gyNCfqP1NBlgUJnZgFF0fzDQFBXO6jOB3mv6ByzSN7hOuYgM0HWhcc2bec
	 4lgxGqa+LzomqzXXDDQ2rhNo9h/90zoGBqF6xyl607jPEI2UaGWmtzUlkO4xRgIowiyl0
	 rcd4XjnGW0wUk+usAEiPSqEj+gfRnMIQsGu3fbaizIeBqnYrwbmh9w0ZHHcnAAhuLGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GgLJywsR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.133
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4227F606A31B
	for <virtualization@lists.linux-foundation.org>; Wed,  4 Nov 2026 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GgLJywsR
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D7EEE400FF
	for <virtualization@lists.linux-foundation.org>; Wed,  4 Nov 2026 13:15:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.073
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TYYOLutdeTJf for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2026 13:15:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2F81040068
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793798148;
	b=KJv7E9CWoU9glxvhKFpie4JX/ZzfagP1MRnxd7bVa9cUCsrKNHqnFaePzinlAZLT4c6G
	 7+gLbUoAcP1BZcGtKyp2I7EFSUfW3va7SU3AKhkp/cC1ZWNHSCYyKj5HVa0nag++hn8Jb
	 i4TNDOpjkyhP71/wp+C9OdqQcFBuNhJVsOLUGLk2NsTO8kL0Zcins/ZMmfc+8vqtP+uvh
	 tz9X+1KBKE1wgbosmZbqHN1S//Fwrr8VEICEfUqZxA2Vi1yMXa+r5A6mylldy9TtgHnS3
	 GY4ufrRn1U0ZQZf5cbWVDUsrRn5eortfyewsmca6vl+paFdrvwIjtmKGaknpbtsA/fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793798148;
	h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 X-Mutt-Fcc:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=cweYKUfQfPNBI8VU6FrLwRgYq4BFUF09qYh0EQWkf/Y=;
	b=MCa448jTPdclYrK2BJNOoToa22rXkuMyc3dRytrgUzALTmQ/7X/iXpP2iPTYi4xyXkRy
	 r73jjxGMYatgc5KBSMQohz2sFPRW5EQqI/o50ZpClwB9IIVYILF2RoZxaIDPrkWqrOxfm
	 PgovNF6gsArOByXAS/lJQ4HOhJuHiLrW8kBmmQxtKbdQL2kJk+7oea9AWhrIbUFBMEiVN
	 TfPtFumpF5soCQbAXPocUNDByX7uoEqW6NMLubf9unfGdPWP6lzSBfJde23fsIclofvGS
	 V0sydxQLUg/zoJVFXszLp4U6Rfa1k1GJJ8LJrLz1+yoEZISvtG9q26E9yLV4kYNV7qA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GgLJywsR;
	arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GgLJywsR
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2F81040068
	for <virtualization@lists.linux-foundation.org>; Wed,  4 Nov 2026 13:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793798143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cweYKUfQfPNBI8VU6FrLwRgYq4BFUF09qYh0EQWkf/Y=;
	b=GgLJywsRfjEmFZg0nrxYgcHv0OFI+rdY5f+7mzBbU1QQHYLozfipX/ztwRKvnMFxDQMonH
	XW/t9c/85/k/swh4l447YMbUfL+8DL8RzmrAGIyhwMaMot/fmzD8ncU5gKcI35C8FKwFdW
	rfoPBDm+WIsWVALDulKxwCeIHeEEi+c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-yOz-W8ASMI-i8Q7Gg1sAjQ-1; Wed, 04 Nov 2026 08:15:42 -0500
X-MC-Unique: yOz-W8ASMI-i8Q7Gg1sAjQ-1
X-Mimecast-MFC-AGG-ID: yOz-W8ASMI-i8Q7Gg1sAjQ_1793798141
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c3f04e0e481so83256566b.1
        for <virtualization@lists.linux-foundation.org>; Wed, 04 Nov 2026 05:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793798141; x=1794402941;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cweYKUfQfPNBI8VU6FrLwRgYq4BFUF09qYh0EQWkf/Y=;
        b=2E4qr3PtgfQpaEN6opDwZsE8Lx6xpYbQoeiCIwtuAU0lDuEtziPaREQQkXhBCFi11C
         Raxmym/s2ELgRHL7R54PX26CWa5ZXLG7E6g3sB10urvk7k40AEFAIOit3GuYQjMOZ4wK
         GcaiH6nclp8py6MPziwp+lUI2zFfnMrvZCDbkpiOmhpadTW+eAgDu4Y/3fJFRB50m9Oj
         B1BO1yA3r8ryfrYSZOKXI4LWIGUspA8mE5hAOKUovgtoVmCy4FAoIz+1E6nNiaPOWxtj
         SB+r7LRkp/jVrcjIO4D0RJgQ3VNngtbN/TobCUHBd8pHWPQnENZ6XD+PVujILFlE3Ant
         LP8w==
X-Forwarded-Encrypted: i=1; AKwUvBwncYdDHi7/WwmCqSiUErHdjX6QliXHoxviynfrIXKNPRQCKIZnUCzDx3kfaO02CyEnlEPjtuJ647UxRB7y7g==@lists.linux-foundation.org
X-Gm-Message-State: APuU4Z8vsu6KUDRQ3tLIeFqHur/hbmXaqMURn8VO1nE790efIfLM9cgI
	eM5iVVn+Uf4KKDrUJdO83J+C5njKtb9HGzWtZUz8vZzyd8PNYMxNz6zc+xWkMQi5leZayjQk7B8
	5lpdfUzAuHvIV6TjiYdlF+Gu6aD/hNtoRlLXb1iIGnWIZ3ORms/5oGSDED5VUQ3kJZST7im6yac
	dvQ6wtbsE=
X-Gm-Gg: AYBFou0Jp+EOnF+ilUCvUIzL1OHU42ndeyAVVKWshZUPnBaXAnqLbWIzzp5z9qbtfsx
	LdlGb+hkMhEOtNEe4MEen1GMyo1vV2cW6Ic3W4/RH5q9fHdnW+YAzcydVVsjK5lt6Mt7RErAYm2
	3DU7mTrEEiFRFJ5QaboCIWPbqel4ElV/sc9WDdDK2+DdJBVqCWJU3f1CzY5ouGKxF3WnLGy//yL
	a+iC5dh94SPOPdblMpbyzHoiu5tgBvrVHa12qkxbLpvY3aiof/8g3Mkd1zXqn7nDaJplkPdAkLU
	Gz8tN2kMuXENS8lgUsNihAkmU64YahCqAAbhRWHj72/vUQ9foNa38EnEmcmW9kIWFUE8G078qS3
	L/nfaID1SemPIEwXeVWlcWgSesyEMf6RrvS8x0seg4Q==
X-Received: by 2002:a17:907:96ac:b0:c49:b8ec:a9e3 with SMTP id a640c23a62f3a-c4ca7abe67amr1635745766b.43.1793798140917;
        Wed, 04 Nov 2026 05:15:40 -0800 (PST)
X-Received: by 2002:a17:907:96ac:b0:c49:b8ec:a9e3 with SMTP id a640c23a62f3a-c4ca7abe67amr1635741066b.43.1793798140297;
        Wed, 04 Nov 2026 05:15:40 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e48d0dcsm68849166b.70.2026.11.04.05.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:15:39 -0800 (PST)
Date: Wed, 4 Nov 2026 08:15:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	2312891301@qq.com, blum@kernel.org, co+6dcbccedc9ec6452@bugs.sh,
	eperezma@redhat.com, fangxy@xiaopeng.com, jasowangio@gmail.com,
	kmehltretter@gmail.com, linfeng.sun.dev@gmail.com,
	lirongqing@baidu.com, longpareto@gmail.com, mst@redhat.com,
	oss.patchbox@gmail.com, p@1g4.org, phx0fer@gmail.com,
	physicalmtea@gmail.com, sergiiushakov@google.com,
	shubham@octane.security, stable@vger.kernel.org,
	stjepan.poljak@gmail.com,
	syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com,
	tavhadia@gmail.com, tjdqudcks0424@naver.com, tz2294@columbia.edu,
	xieyongji@bytedance.com, xmei5@asu.edu, yuz08559@gmail.com,
	zenghui.yu@linux.dev, zhaimingbing@cmss.chinamobile.com,
	zhangjiao2@cmss.chinamobile.com
Subject: [GIT PULL] vhost,virtio,vdpa: bugfixes
Message-ID: <20261104081535-mutt-send-email-mst@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HRp44y2yuL58DB0DJf0hqMSOjN3qHhbkD9gvA-UkExI_1793798141
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 1a577f9402c1780cc1e663f48d5dd54c02051b09:

  virtio_pci: don't take the MSI mutex under cpu_hotplug_lock (2026-11-03 07:32:14 -0500)

----------------------------------------------------------------
vhost,virtio,vdpa: bugfixes

Just a bunch of fixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dudu Lu (1):
      vhost/vringh: Fix IOTLB permission in putu16_iotlb()

Eugenio Pérez (1):
      MAINTAINERS: add missing virtio/vdpa/vduse/vhost headers

Fang Xieyan (4):
      vringh: bound top-level re-entry into indirect tables
      vringh: add regression test for cyclic indirect descriptor
      vringh: reject empty / undersized indirect descriptor tables
      vhost: fix used ring index wrap in vhost_add_used_n_in_order

Jia Jia (5):
      vhost-scsi: preserve event ordering
      vhost-scsi: do not relock event vq mutex on send_evt fallback
      vduse: avoid infinite loop when no affinity CPU is online
      vhost-scsi: do not count PI bytes in the data length
      vhost-scsi: fix page reference leak in misaligned I/O fallback

Karl Mehltretter (1):
      virtio-spi: Fix virtio_spi_config kernel-doc

Li RongQing (1):
      virtio_ring: reset IN_ORDER state in virtqueue_init()

Linfeng Sun (8):
      vdpa_sim: serialize IOTLB updates with dataplane access
      vdpa: invalidate DMA mappings before releasing memory
      vhost: fix dirty logging for in-order used ring entries
      vhost: reject invalid IOTLB update permissions
      vhost-scsi: validate event queue descriptor direction
      vhost-scsi: reject delayed virtqueue setup
      vhost: reject backend enable without a kick file
      vhost-vdpa: initialize state before publishing cdev

Maoxia (1):
      virtio_pci: add missing newline to the pmcsr error message

Mingbing Zhai (1):
      virtio_balloon: initialize wakeup_lock before virtqueues are set up

Sergii Ushakov (1):
      virtio-blk: clamp max_segments to virtqueue ring size

Shubham Antil (1):
      vhost-scsi: zero misaligned I/O bounce pages

Tal Zussman (2):
      vhost-vdpa: fix pinned page leak in vhost_vdpa_pa_map() error path
      vhost-vdpa: unpin mappings by range

Thorsten Blum (1):
      hwrng: virtio - prevent use-after-free after a failed restore

Wei-Shuo Chen (1):
      virtio: use consistent virtqueue terminology

Xiang Mei (1):
      vdpa: fix double free of the reply skb in vdpa_nl_cmd_dev_config_get_doit()

Yu Zhang (1):
      vhost-vdpa: drop the parent's vq callback before the call fd is released

Yuho Choi (3):
      virtio_blk: Reset device on probe error paths after DRIVER_OK
      iommu/virtio: Reset device before deleting virtqueues on probe failure
      vdpa/snet: Don't discard the DPU error in snet_send_ctrl_msg()

Zenghui Yu (Huawei) (1):
      virtio_pci: don't take the MSI mutex under cpu_hotplug_lock

chenglong.ma (1):
      vduse: fix VA/PA confusion in the coherent page fault path

sungbyeongchan (1):
      virtio_ring: use shadow flags when detaching split descriptors

zhang jiao (1):
      virtio_ring: Initialize id field in packed indirect descriptors

 MAINTAINERS                          |   4 ++
 drivers/block/virtio_blk.c           |  45 +++++++++++++-
 drivers/char/hw_random/virtio-rng.c  |   7 +++
 drivers/iommu/virtio-iommu.c         |   6 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |  10 ++-
 drivers/vdpa/solidrun/snet_ctrl.c    |   3 +-
 drivers/vdpa/vdpa.c                  |   7 ++-
 drivers/vdpa/vdpa_sim/vdpa_sim.c     |   7 +++
 drivers/vdpa/vdpa_user/iova_domain.c |  11 +++-
 drivers/vdpa/vdpa_user/vduse_dev.c   |  15 +++--
 drivers/vhost/scsi.c                 |  68 +++++++++++++++++----
 drivers/vhost/test.c                 |   4 ++
 drivers/vhost/vdpa.c                 | 115 ++++++++++++++++++++++++-----------
 drivers/vhost/vhost.c                |  36 ++++++++---
 drivers/vhost/vringh.c               |  29 ++++-----
 drivers/virtio/virtio_balloon.c      |   3 +-
 drivers/virtio/virtio_mmio.c         |   2 +-
 drivers/virtio/virtio_pci_common.c   |  12 +++-
 drivers/virtio/virtio_pci_common.h   |   5 +-
 drivers/virtio/virtio_ring.c         |  13 +++-
 include/uapi/linux/virtio_spi.h      |   2 +-
 tools/virtio/vringh_test.c           |  41 +++++++++++++
 22 files changed, 347 insertions(+), 98 deletions(-)

