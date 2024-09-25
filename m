Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20C54962B
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262599; cv=none; b=d9qyDd0knuc7H19ehV2wNKpr2pg0wl/EL+nE+iGd/QyiqYBQs2WtMTIQwxmNrgf0NwIoQ00rpdXgY/b9JM1U7v/K+2nbhGsgMMxha/J2bTTnXlPpFIPDYKmY3jmgTh58TMXRhLgcw5tAuIl3k98slrsI83MTM4QyCojsAOyc9aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262599; c=relaxed/simple;
	bh=xtxsvm8uRDT0k+Fdso/owoT8wFfjLj3xm055kPKyiKk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oxlJzQecLFI+gf5ax9Xd5Prwf3CQWb8LDhoZ628cVPfo3rQO7gn6KWaiGXbw9TgBnKqryjRxpIxkQ8E/bgGom7X6VAHAYevoY5v4b/GfT9OERXiYhTQBHqIUw3qte19sNW7a5ht3YafV8IV+iQKH6WFfJT6+XEI27I+t2FnPYQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3ow9NCj; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3ow9NCj"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81F0C60DF0
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 11:09:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ykSzEFyX_0Yf for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Sep 2024 11:09:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6BA6B6072A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6BA6B6072A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a3ow9NCj
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6BA6B6072A
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 11:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727262595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GYARqqH/zIw2gIrAZ+tTLBZyNzYt/nqsl4mA84ZpEqE=;
	b=a3ow9NCjxICxby1QpdwZaMQH0cafnWgeyxlwQVMCc7jPuk2CFY2P+XF4vVmKdyXnTuL6GI
	njHHrpik0/JLpHZcxbr9zhGDGfEHuovG38tONVWvMN+0xsi533RxeSQq/NljBG0pgd+Lp3
	v14Vcs+/iFFTtaijU/f+VvWcdNA8LPQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-q4HhGasvPNOzjhmP_sRn9Q-1; Wed, 25 Sep 2024 07:09:54 -0400
X-MC-Unique: q4HhGasvPNOzjhmP_sRn9Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37cc4f28e88so348074f8f.3
        for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 04:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727262593; x=1727867393;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYARqqH/zIw2gIrAZ+tTLBZyNzYt/nqsl4mA84ZpEqE=;
        b=GoqHY6/EzJna/fvhf3Bg+fDSuaDFUl1q0q9aTFJboY7lZuo+X8ofG7aguP++zrooFw
         eKutKZL+vxx6+w+5oxihIzC8JL1M80qXmtW3TTsYTtGgAidn6jD2eOjE/qncr3iJEk4Z
         5ZnRSsIHA4TyQLP1EK1/RQGQpljedpTO3eCmp8xlpA94ZJL/yvTsyNWYXljWApRF70po
         M7/TiPnHRZaKajN3g/sfeCQxd8u9AgeDzvQFDxpKnJ25WLkYuoUGa/QebJN97/EVoFJ2
         g4mTkPucBkqOE03v9nBndQYkxz+pqhcfrdrEYSu+cgZiJTFzgkCAhPKJyuGrCkr0lUE1
         HHBA==
X-Forwarded-Encrypted: i=1; AJvYcCVvVI9420D1PYiTuP3wsc4fIzIMjdvxZezJO4Kwse9X2p+GPgqa5d9bGDp/VyX8lC8KeF0RuHoFICVUJQAgbg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyXdt2fRIJ4Tb9LzNP98/gNRYoklKXvdvvaS6z5TERq6b1BJwrl
	B96XWLuYfUP7zEFKcrLVPVdLB3jh+oPD2SSPVsxJVyxjgCewKf4+A2AiDq+hMYM5IJGxQGQWzoJ
	TAry6Bt/e9TWTq5HAtXw+P1nkit/SUs3z3LauDx8Q3JPUUFV21J+gvA+j626pYRPSbVgAoCqQaK
	dCu8k=
X-Received: by 2002:a05:6000:18c9:b0:374:c3e4:d6b1 with SMTP id ffacd0b85a97d-37cc24b25b5mr1902400f8f.44.1727262592656;
        Wed, 25 Sep 2024 04:09:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVT6hBQDAGQX3+vy1AsamAzh0r2GQEW+rZO8mUVTLUvy6RGX+GkdPmK+Lzdj53mjsxARrWvA==
X-Received: by 2002:a05:6000:18c9:b0:374:c3e4:d6b1 with SMTP id ffacd0b85a97d-37cc24b25b5mr1902383f8f.44.1727262592214;
        Wed, 25 Sep 2024 04:09:52 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7405:9900:56a3:401a:f419:5de9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a07e69sm14908845e9.21.2024.09.25.04.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 04:09:51 -0700 (PDT)
Date: Wed, 25 Sep 2024 07:09:49 -0400
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
Subject: [GIT PULL v2] virtio: features, fixes, cleanups
Message-ID: <20240925070949-mutt-send-email-mst@kernel.org>
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

Changes from v1:
	add a missing ack, removing an empty commit that I used to
	record it.  no code changes.

The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:

  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to efcd71af38be403fa52223092f79ada446e121ba:

  vsock/virtio: avoid queuing packets when intermediate queue is empty (2024-09-25 07:07:44 -0400)

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

