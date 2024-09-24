Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044013BC35
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727211059; cv=none; b=q4ILZzoeD/dwpWa8hjFLxktrvQPMqgcoBRsg5aox5yza3YYQ5nEkQJjzdBh+ldM4JD8lf5NxiCa0ffjM4TUJswhxv6aEcBB3Tw8ziFnlhD2ZxXX9PhRaOUkt4LFL1fuKNM8kG+pjUgeywUpX6Hz8Nt+HlYEptn7tFSfjQpJtn1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727211059; c=relaxed/simple;
	bh=q1Fzh6XcLCvsZX97wtdGvG+wbgRVQb9FWzltMHxrYhU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A/M9MOkQYBmyBro7JY7yM9W27xULFgKyeFi5wNVPGDxbVRb3CkFMhmIJGpgkACwPALkAdROteFP0Ie/oFv1uUbkB9gJ9JdjR5fP0l3SUHR0xJu0wwIvsDjYJdZLuyjz+p5ng7gLc1a7DPkVGDdJhio77dIuDEW091durACcEpkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XuVsvKdt; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XuVsvKdt"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C6B3240E90
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 20:50:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 50NQt99rrFLh for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Sep 2024 20:50:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 405DA40E89
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 405DA40E89
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XuVsvKdt
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 405DA40E89
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 20:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727211054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Ha73YKMkXYy714HDQl55jm40mWYNmGrnegcmLNCX6UI=;
	b=XuVsvKdtbddFmvyhBgg5KQsLKtsRxYVy0lJ7n+m1DIwADGtrWygpIojbUzoWlZxkj0VhMs
	LUmY5nZ5uwrRWj+s9FYG4aelFLENAvxd8pghWhpqxoYJ4g8mhiwFRLzQvTb3hrKqb8jZjU
	8q8aBfPypiEUEIdGfJ9btJOiZwIWTls=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-XTbxMAvuNKOwToEz59qJ0g-1; Tue, 24 Sep 2024 16:50:52 -0400
X-MC-Unique: XTbxMAvuNKOwToEz59qJ0g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb89fbb8bso38165955e9.3
        for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 13:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727211051; x=1727815851;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha73YKMkXYy714HDQl55jm40mWYNmGrnegcmLNCX6UI=;
        b=pihwArH2ct0/FU/SuKvW7MnFRAzFC2wCp4NVWBwtp6DE43JTyS5tIzP3Izu4Vo7g6a
         WN0l/oe1Drm76xcddKa1EPGBvjQv+ysWQicVqAwfGKeUkq7LigHDXgqnbKiid+xs42xv
         /T7+G9X+aZLuOpe+Xb8J7H3suSG6ZWHramstr/FuaqWZJzQ1qI6Fi/qvrPGn734HhZCG
         82EBfSl1c/c9WSxrqfgOiXLRecRpaXjvFpZ89iofMb9L7mNrZK1YLco2F+tQpHHll2yD
         wGM01lghMlGw+2FreyBG/izTGAuINllxsTNx6QFQUXe1PaYTzdwm8HSUQoOgMiXxog8P
         2wtA==
X-Forwarded-Encrypted: i=1; AJvYcCVugxo5hbFw5jlyn8a4D/xHXW5KCMjE1HkNSPM0zBXTO25PPnqkZnktZlfGg/ccNe1KufWhjFJjozYnjy29fg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy6pHV5/jSvcwghmCVQFcScGhpMHH+HNQUlz0fe3tqW+8uRk/gB
	fNz3xjyKKvCL639TDx+qM20F3hwK1H0ZWnnk1C+fplT10k1L6hEvqqGGRfwTeSltyqeLRbWW5xB
	ivD+1GPHmJNDC2zXBK7xdXS3AVr+JzJhNAaHi7x7nYnHJmb3VRXnLu34TwnyLg1C4Klst8wkVzC
	0EIfA=
X-Received: by 2002:a05:600c:1e0b:b0:426:5dc8:6a63 with SMTP id 5b1f17b1804b1-42e96242214mr1865645e9.30.1727211051379;
        Tue, 24 Sep 2024 13:50:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiXHIUYfLg/ApdHxFIkfiGLw4xDQ4Vi/t8oKMffgZIEevAFQUBrtSqrnnQvLLtODlevmJANQ==
X-Received: by 2002:a05:600c:1e0b:b0:426:5dc8:6a63 with SMTP id 5b1f17b1804b1-42e96242214mr1865395e9.30.1727211050977;
        Tue, 24 Sep 2024 13:50:50 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7405:9900:56a3:401a:f419:5de9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754a7aedsm170062615e9.31.2024.09.24.13.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 13:50:50 -0700 (PDT)
Date: Tue, 24 Sep 2024 16:50:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	david@redhat.com, dtatulea@nvidia.com, eperezma@redhat.com,
	jasowang@redhat.com, leiyang@redhat.com, leonro@nvidia.com,
	lihongbo22@huawei.com, luigi.leonardi@outlook.com, lulu@redhat.com,
	marco.pinn95@gmail.com, mgurtovoy@nvidia.com, mst@redhat.com,
	pankaj.gupta.linux@gmail.com, philipchen@chromium.org,
	pizhenwei@bytedance.com, sgarzare@redhat.com, yuehaibing@huawei.com,
	zhujun2@cmss.chinamobile.com
Subject: [GIT PULL] virtio: features, fixes, cleanups
Message-ID: <20240924165046-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:

  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 1bc6f4910ae955971097f3f2ae0e7e63fa4250ae:

  vsock/virtio: avoid queuing packets when intermediate queue is empty (2024-09-12 02:54:10 -0400)

----------------------------------------------------------------
virtio: features, fixes, cleanups

Several new features here:

	virtio-balloon supports new stats

	vdpa supports setting mac address

	vdpa/mlx5 suspend/resume as well as MKEY ops are now faster

	virtio_fs supports new sysfs entries for queue info

	virtio/vsock performance has been improved

Fixes, cleanups all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Cindy Lu (3):
      vdpa: support set mac address from vdpa tool
      vdpa_sim_net: Add the support of set mac address
      vdpa/mlx5: Add the support of set mac address

Dragos Tatulea (18):
      vdpa/mlx5: Fix invalid mr resource destroy
      net/mlx5: Support throttled commands from async API
      vdpa/mlx5: Introduce error logging function
      vdpa/mlx5: Introduce async fw command wrapper
      vdpa/mlx5: Use async API for vq query command
      vdpa/mlx5: Use async API for vq modify commands
      vdpa/mlx5: Parallelize device suspend
      vdpa/mlx5: Parallelize device resume
      vdpa/mlx5: Keep notifiers during suspend but ignore
      vdpa/mlx5: Small improvement for change_num_qps()
      vdpa/mlx5: Parallelize VQ suspend/resume for CVQ MQ command
      vdpa/mlx5: Create direct MKEYs in parallel
      vdpa/mlx5: Delete direct MKEYs in parallel
      vdpa/mlx5: Rename function
      vdpa/mlx5: Extract mr members in own resource struct
      vdpa/mlx5: Rename mr_mtx -> lock
      vdpa/mlx5: Introduce init/destroy for MR resources
      vdpa/mlx5: Postpone MR deletion

Hongbo Li (1):
      fw_cfg: Constify struct kobj_type

Jason Wang (1):
      vhost_vdpa: assign irq bypass producer token correctly

Lei Yang leiyang@redhat.com (1):
      ack! vdpa/mlx5: Parallelize device suspend/resume

Luigi Leonardi (1):
      vsock/virtio: avoid queuing packets when intermediate queue is empty

Marco Pinna (1):
      vsock/virtio: refactor virtio_transport_send_pkt_work

Max Gurtovoy (2):
      virtio_fs: introduce virtio_fs_put_locked helper
      virtio_fs: add sysfs entries for queue information

Philip Chen (1):
      virtio_pmem: Check device status before requesting flush

Stefano Garzarella (1):
      MAINTAINERS: add virtio-vsock driver in the VIRTIO CORE section

Yue Haibing (1):
      vdpa: Remove unused declarations

Zhu Jun (1):
      tools/virtio:Fix the wrong format specifier

zhenwei pi (3):
      virtio_balloon: introduce oom-kill invocations
      virtio_balloon: introduce memory allocation stall counter
      virtio_balloon: introduce memory scan/reclaim info

 MAINTAINERS                                   |   1 +
 drivers/firmware/qemu_fw_cfg.c                |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  21 +-
 drivers/nvdimm/nd_virtio.c                    |   9 +
 drivers/vdpa/ifcvf/ifcvf_base.h               |   3 -
 drivers/vdpa/mlx5/core/mlx5_vdpa.h            |  47 ++-
 drivers/vdpa/mlx5/core/mr.c                   | 291 +++++++++++++---
 drivers/vdpa/mlx5/core/resources.c            |  76 +++-
 drivers/vdpa/mlx5/net/mlx5_vnet.c             | 477 +++++++++++++++++---------
 drivers/vdpa/pds/cmds.h                       |   1 -
 drivers/vdpa/vdpa.c                           |  79 +++++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c          |  21 +-
 drivers/vhost/vdpa.c                          |  16 +-
 drivers/virtio/virtio_balloon.c               |  18 +
 fs/fuse/virtio_fs.c                           | 164 ++++++++-
 include/linux/vdpa.h                          |   9 +
 include/uapi/linux/vdpa.h                     |   1 +
 include/uapi/linux/virtio_balloon.h           |  16 +-
 net/vmw_vsock/virtio_transport.c              | 144 +++++---
 tools/virtio/ringtest/main.c                  |   2 +-
 20 files changed, 1098 insertions(+), 300 deletions(-)

