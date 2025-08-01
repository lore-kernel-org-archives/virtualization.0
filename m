Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCFB2522B5
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Aug 2025 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754054010; cv=none; b=Diyq9a/NLLFnc003ir9TLrJJWbQ3RVdmLpIEUk+Qgg+a0x1ip1MDymCb98OUtJF7Dpy0EAwKGgCgu5D/Frde5X8uaOf1Mx64wA68t8Gy+wxMX+MChZ4gyjicEbrVYJBfu6k69KBv9ahlCuBB0fCNS4p8lZNYVvmLRSVJ2MFGR5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754054010; c=relaxed/simple;
	bh=NDqaf9lbxEaRm64yxxyEsy03EPkdWuBKt9nEAdu2dVk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JEVc7adRQPFBsNtSxiC2Pkv17n1vNGS7n7a3skKjxaZ6OtX8zxpaydJFvZA0jd04tTe/UMtJ/zz59PpJAfaPBQyE9kEZ/YKhiXjiNEbQSRPkLKslhjUKNZ/NzIo5s0861ORKW2CrBeZxotATcToY1GlHFlHgLfvkUKTy9YrZrXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQS0luzf; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQS0luzf"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6355140A26
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Aug 2025 13:13:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S5vkQbD-76eP for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Aug 2025 13:13:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6A57140308
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6A57140308
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gQS0luzf
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6A57140308
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Aug 2025 13:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754054006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=cw5+teQN0AMP87x3H2Uh+QGhf4VtRQnjJ3fqJ5dQbO0=;
	b=gQS0luzfv+My2kIgiC0iDqeiok//hAVNx5PysmwAn3GyIWaZJsLaqQmoeCn5lY4uJs+6BF
	/kzn5HkSY391Yhc60LVoU+Hkg4rBhHC9iwwCxojAIbnGpFMqgEyZ60iv3Z1Fj/RIdY0tBP
	YYFLehiHiaQZEOrtiHltrlG04zYDvH0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-BuosvIT4NMKcDucwYh9lBQ-1; Fri, 01 Aug 2025 09:13:25 -0400
X-MC-Unique: BuosvIT4NMKcDucwYh9lBQ-1
X-Mimecast-MFC-AGG-ID: BuosvIT4NMKcDucwYh9lBQ_1754054005
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b78329f007so912935f8f.1
        for <virtualization@lists.linux-foundation.org>; Fri, 01 Aug 2025 06:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754054002; x=1754658802;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cw5+teQN0AMP87x3H2Uh+QGhf4VtRQnjJ3fqJ5dQbO0=;
        b=v2hxNbcozrsRvMqKNfY8vR7Q4gUAGej8fpbNZqvff/muTHq0MzAR4jAoUwztMEcTyh
         vmPNJYtyrZT5VH2e58/bAz7lM1y/1T4xeyoIwwSoWo5c0Zeh8BGawq2wnJL9ddkE9gMT
         qvhA4JLxGr9Pc8Br85DzcRngl9z3VEbAGvdMVEwItlowH1G6PXWoy4do2CfW+YUDLB0n
         AP+unUrw3yQ+RmoYw5kAqg7PjnzoZV+6Ue2fFmFMFbdVvS4G7zPpU3jlzDXnH01FXdkc
         ssUZhp49KI8uUkQQdtr1qFWSr7iXE29AymXRjBTBeGORXuMWqXKdU5mN+fopAt8PDwhm
         9ozA==
X-Forwarded-Encrypted: i=1; AJvYcCVqFOONhVta7uqeoEuJ0Ds5c6ZA1wcAn6mz1ZIb2YV79IVPcFFYrL8j59DTJ6sV0DDyXte8urVJYPeawRYeWQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyhPunUrhL5hkKKrHfquOdAD8YxWTzNJsoVwAQu5YnGnYY2qehl
	JOOScvPJem5pBdAcktijw4Kl3KAahDUl6ALiOgBHGOyOhdp03yDohp76ejBWitTGHDTgMooYrf+
	DG947prIg4dITUWyaBMxVTf69+l6JqNnIbX1QCW+VqBLmKCRFWRTmgOIkoABZRM3yYcqw2veb2B
	CE/ySYsfU=
X-Gm-Gg: ASbGncv10LtoDrZSDABleFASfTBEcRhbeK6O+f0ieygtZnuXArLCycV6jN1jFn/AnRY
	EbDaJ5+Hpw05MeMYYebE1cB+UNTWLEvno4Ti5eSJbEbazaVwp5Ktdh56wSZ6YJnqVhqQi9ddL0k
	ClmqgDVgIR4KwJJnftmfqsw+2+pZUlZYD9syTpuSA1KE2X4nxt6jFJrrdiwbNUOBb4Pb1tcMs16
	xf6z3VR+enceusF3sj6VCVvprZk/Hv5zLzZ4lIYbu65dVY4isonoVa7YjO3xYJqZR5BzV/NiYsD
	2Fj+poaAkp08IGSijfcZIQKsVsYPF95S
X-Received: by 2002:a05:6000:2311:b0:3b7:81a6:45c1 with SMTP id ffacd0b85a97d-3b794fc2b76mr8552829f8f.6.1754054002389;
        Fri, 01 Aug 2025 06:13:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ3kgk/LB9Em5/+L4oKnLTGpba8hhaIHh5AL+aBInP59wFrNOjQfBJh5ZGXhgf1vfWGUgM8w==
X-Received: by 2002:a05:6000:2311:b0:3b7:81a6:45c1 with SMTP id ffacd0b85a97d-3b794fc2b76mr8552779f8f.6.1754054001893;
        Fri, 01 Aug 2025 06:13:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48de68sm5859929f8f.67.2025.08.01.06.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:13:21 -0700 (PDT)
Date: Fri, 1 Aug 2025 09:13:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alok.a.tiwari@oracle.com, anders.roxell@linaro.org,
	dtatulea@nvidia.com, eperezma@redhat.com, eric.auger@redhat.com,
	jasowang@redhat.com, jonah.palmer@oracle.com, kraxel@redhat.com,
	leiyang@redhat.com, linux@treblig.org, lulu@redhat.com,
	michael.christie@oracle.com, mst@redhat.com, parav@nvidia.com,
	si-wei.liu@oracle.com, stable@vger.kernel.org,
	viresh.kumar@linaro.org, wangyuli@uniontech.com, will@kernel.org,
	wquan@redhat.com, xiaopei01@kylinos.cn
Subject: [GIT PULL v2] virtio, vhost: features, fixes
Message-ID: <20250801091318-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yVsii-zyTsH0leT-krzsxrJm_0q47t2t2F8S-THSH7E_1754054005
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf1911:

  Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 6693731487a8145a9b039bc983d77edc47693855:

  vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers (2025-08-01 09:11:09 -0400)

Changes from v1:
	drop commits that I put in there by mistake. Sorry!

----------------------------------------------------------------
virtio, vhost: features, fixes

vhost can now support legacy threading
	if enabled in Kconfig
vsock memory allocation strategies for
	large buffers have been improved,
	reducing pressure on kmalloc
vhost now supports the in-order feature
	guest bits missed the merge window

fixes, cleanups all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alok Tiwari (4):
      virtio: Fix typo in register_virtio_device() doc comment
      vhost-scsi: Fix typos and formatting in comments and logs
      vhost: Fix typos
      vhost-scsi: Fix check for inline_sg_cnt exceeding preallocated limit

Anders Roxell (1):
      vdpa: Fix IDR memory leak in VDUSE module exit

Cindy Lu (1):
      vhost: Reintroduce kthread API and add mode selection

Dr. David Alan Gilbert (2):
      vhost: vringh: Remove unused iotlb functions
      vhost: vringh: Remove unused functions

Dragos Tatulea (2):
      vdpa/mlx5: Fix needs_teardown flag calculation
      vdpa/mlx5: Fix release of uninitialized resources on error path

Gerd Hoffmann (1):
      drm/virtio: implement virtio_gpu_shutdown

Jason Wang (3):
      vhost: fail early when __vhost_add_used() fails
      vhost: basic in order support
      vhost_net: basic in_order support

Michael S. Tsirkin (2):
      virtio: fix comments, readability
      virtio: document ENOSPC

Mike Christie (1):
      vhost-scsi: Fix log flooding with target does not exist errors

Pei Xiao (1):
      vhost: Use ERR_CAST inlined function instead of ERR_PTR(PTR_ERR(...))

Viresh Kumar (2):
      virtio-mmio: Remove virtqueue list from mmio device
      virtio-vdpa: Remove virtqueue list

WangYuli (1):
      virtio: virtio_dma_buf: fix missing parameter documentation

Will Deacon (9):
      vhost/vsock: Avoid allocating arbitrarily-sized SKBs
      vsock/virtio: Validate length in packet header before skb_put()
      vsock/virtio: Move length check to callers of virtio_vsock_skb_rx_put()
      vsock/virtio: Resize receive buffers so that each SKB fits in a 4K page
      vsock/virtio: Rename virtio_vsock_alloc_skb()
      vsock/virtio: Move SKB allocation lower-bound check to callers
      vhost/vsock: Allocate nonlinear SKBs for handling large receive buffers
      vsock/virtio: Rename virtio_vsock_skb_rx_put()
      vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers

 drivers/gpu/drm/virtio/virtgpu_drv.c    |   8 +-
 drivers/vdpa/mlx5/core/mr.c             |   3 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c       |  12 +-
 drivers/vdpa/vdpa_user/vduse_dev.c      |   1 +
 drivers/vhost/Kconfig                   |  18 ++
 drivers/vhost/net.c                     |  88 +++++---
 drivers/vhost/scsi.c                    |  24 +-
 drivers/vhost/vhost.c                   | 377 ++++++++++++++++++++++++++++----
 drivers/vhost/vhost.h                   |  30 ++-
 drivers/vhost/vringh.c                  | 118 ----------
 drivers/vhost/vsock.c                   |  15 +-
 drivers/virtio/virtio.c                 |   7 +-
 drivers/virtio/virtio_dma_buf.c         |   2 +
 drivers/virtio/virtio_mmio.c            |  52 +----
 drivers/virtio/virtio_ring.c            |   4 +
 drivers/virtio/virtio_vdpa.c            |  44 +---
 include/linux/virtio.h                  |   2 +-
 include/linux/virtio_vsock.h            |  46 +++-
 include/linux/vringh.h                  |  12 -
 include/uapi/linux/vhost.h              |  29 +++
 kernel/vhost_task.c                     |   2 +-
 net/vmw_vsock/virtio_transport.c        |  20 +-
 net/vmw_vsock/virtio_transport_common.c |   3 +-
 23 files changed, 575 insertions(+), 342 deletions(-)

