Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ABA15854A
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727249947; cv=none; b=fxmz6+Cd2MOkK1qKDL7ML5MgTAvohifMX6IisVDYUNLKq8C08ItSDAkPL9mVMlFr8VKBBE/H5Hdf1k0RuTpTll+WyMLZ9MPDlQo+7hh5kAJ9dwZhQ2Pqr8VTinG/kwm1vpQJ9Q1F7/pMdIfQOdkwCzBGYBXXPhYznxtoD0yaQ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727249947; c=relaxed/simple;
	bh=hA2NN7kzc70Me5M2AjVJID4so0HqKPa/tbvMgUFH6sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EZSlep+MgerG59R33qRdsR8tXcs63UwBCeyGasyzHB54rjVLjIGM9x9G6Tb6GDJUwWKQg/hTwlL2AwGzRZgh24fhvAEX0akoItMBQ01H56Oybc2SZc1ZVEuFeLsJBBfx9VSbDJdrBqm816F5sOO7eTfo636jQAm0Ldz5vdrkUdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C1ZKiExQ; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1ZKiExQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C9EE54040A
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 07:39:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zX7KRZcd8TxB for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Sep 2024 07:39:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 41AD940180
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 41AD940180
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C1ZKiExQ
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 41AD940180
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 07:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727249941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k5IxqMkt8qD5qrDFPPLWnZIAs2xArm/m3qqUsZKT8ng=;
	b=C1ZKiExQ7x44H6hBRoYpVE4Ihzl4bVGNvrXiWRBoPb0ZAhRWEwV7mhgUJcgAHcKfgRaaKv
	sz7mqJI0bQLwFsLCMz6o+wwZQ8ghTUgEZWoJVvM5XWIG411EfVVxK+X1sjFaS/ynHCCtB/
	9dhmw/uD+fwjgsUzBjtxdUzqfn0P7Vs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-OPVWof3MNiaGKzQLtfDsfg-1; Wed, 25 Sep 2024 03:38:57 -0400
X-MC-Unique: OPVWof3MNiaGKzQLtfDsfg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8d15eff783so419212666b.3
        for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 00:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727249936; x=1727854736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5IxqMkt8qD5qrDFPPLWnZIAs2xArm/m3qqUsZKT8ng=;
        b=lnDrVILkc0SZy6i8l4WjkVM7521Bd6jyb+uqc4RK455+5msb6R7MnwhdHj0b3RE6Nj
         ErpGhBDlLDApCRhaaNwa4VSXqFw1g8Ko1y2yevHsNT+5bkKh8uaK8w/V1zlDXDMPc1mh
         bOZQCT/qebu8olxhoV5p9WA4szQgIz1jlNOYfvpFQE8nyEJInVP5/GkjjtPMGtY1im7S
         tpzcofTDfD0cvbNGCrtxC6ZycKP2zL8EDfxKbppyCYOUsy290nMAQJmRxUpr5H6PE8zP
         ul4PSeNmY1/hjh08u+3Qss+mL2TUSJdr7Mnz1zxdkv7wLykjNz8B6fHOjCKXDB2qp+fz
         UmTA==
X-Forwarded-Encrypted: i=1; AJvYcCVA4v99sFjR/O1xHjrBO/HkBl4vyEytqUyGEesdqoWbTYpvgcikq4poj5S3kQ2a2QvCsLPWMt159e/wVStefg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx0JxOV+oq4GmcSzD7/CC44YD2LDgTTzJPlD3PeHO7wf4/phitC
	Ey+Xg1iYN1NGGUlrvqe5Z0C+37fhJwtO8IgMO4zfkoeG5Tzv3fyKOe2BtPsnMxltcOy8U4hOuXE
	CjuS82NmBKHSB96G45g6XSuNvQnuKJXcKZANqM5a3BMDuB61otYF1To1e72/PutAmnmFwibrQxB
	a1NW4=
X-Received: by 2002:a17:907:2ce5:b0:a8d:2ec3:94f4 with SMTP id a640c23a62f3a-a93a066f942mr170020766b.54.1727249936534;
        Wed, 25 Sep 2024 00:38:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXFFtVfLBhqbQGBA31zqKMXEIhRN2UiES5o0Cy7oKF+caZsB3g/KGz5JFCowqi/0EgISF3lg==
X-Received: by 2002:a17:907:2ce5:b0:a8d:2ec3:94f4 with SMTP id a640c23a62f3a-a93a066f942mr170015966b.54.1727249935830;
        Wed, 25 Sep 2024 00:38:55 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9393134b3esm176178266b.198.2024.09.25.00.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 00:38:55 -0700 (PDT)
Date: Wed, 25 Sep 2024 09:38:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	david@redhat.com, dtatulea@nvidia.com, eperezma@redhat.com, jasowang@redhat.com, 
	leiyang@redhat.com, leonro@nvidia.com, lihongbo22@huawei.com, 
	luigi.leonardi@outlook.com, lulu@redhat.com, marco.pinn95@gmail.com, mgurtovoy@nvidia.com, 
	pankaj.gupta.linux@gmail.com, philipchen@chromium.org, pizhenwei@bytedance.com, 
	yuehaibing@huawei.com, zhujun2@cmss.chinamobile.com
Subject: Re: [GIT PULL] virtio: features, fixes, cleanups
Message-ID: <fqvpau7doh7lf7mytane7n5yww7w2lrc4y6pyshainrl52rfyl@xi6kk7hbwyhc>
References: <20240924165046-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240924165046-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Sep 24, 2024 at 04:50:46PM GMT, Michael S. Tsirkin wrote:
>The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:
>
>  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)
>
>are available in the Git repository at:
>
>  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
>
>for you to fetch changes up to 1bc6f4910ae955971097f3f2ae0e7e63fa4250ae:
>
>  vsock/virtio: avoid queuing packets when intermediate queue is empty (2024-09-12 02:54:10 -0400)
>
>----------------------------------------------------------------
>virtio: features, fixes, cleanups
>
>Several new features here:
>
>	virtio-balloon supports new stats
>
>	vdpa supports setting mac address
>
>	vdpa/mlx5 suspend/resume as well as MKEY ops are now faster
>
>	virtio_fs supports new sysfs entries for queue info
>
>	virtio/vsock performance has been improved
>
>Fixes, cleanups all over the place.
>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
>----------------------------------------------------------------
>Cindy Lu (3):
>      vdpa: support set mac address from vdpa tool
>      vdpa_sim_net: Add the support of set mac address
>      vdpa/mlx5: Add the support of set mac address
>
>Dragos Tatulea (18):
>      vdpa/mlx5: Fix invalid mr resource destroy
>      net/mlx5: Support throttled commands from async API
>      vdpa/mlx5: Introduce error logging function
>      vdpa/mlx5: Introduce async fw command wrapper
>      vdpa/mlx5: Use async API for vq query command
>      vdpa/mlx5: Use async API for vq modify commands
>      vdpa/mlx5: Parallelize device suspend
>      vdpa/mlx5: Parallelize device resume
>      vdpa/mlx5: Keep notifiers during suspend but ignore
>      vdpa/mlx5: Small improvement for change_num_qps()
>      vdpa/mlx5: Parallelize VQ suspend/resume for CVQ MQ command
>      vdpa/mlx5: Create direct MKEYs in parallel
>      vdpa/mlx5: Delete direct MKEYs in parallel
>      vdpa/mlx5: Rename function
>      vdpa/mlx5: Extract mr members in own resource struct
>      vdpa/mlx5: Rename mr_mtx -> lock
>      vdpa/mlx5: Introduce init/destroy for MR resources
>      vdpa/mlx5: Postpone MR deletion
>
>Hongbo Li (1):
>      fw_cfg: Constify struct kobj_type
>
>Jason Wang (1):
>      vhost_vdpa: assign irq bypass producer token correctly
>
>Lei Yang leiyang@redhat.com (1):
>      ack! vdpa/mlx5: Parallelize device suspend/resume
        ^
This commit (fbb072d2d19133222e202ea7c267cfc1f6bd83b0) looked strange
from the title, indeed inside it looks empty, so maybe the intent was to
"squash" it with the previous commit acba6a443aa4 ("vdpa/mlx5:
Parallelize VQ suspend/resume for CVQ MQ command") to bring back the
Tested-by, right?

Thanks,
Stefano

>
>Luigi Leonardi (1):
>      vsock/virtio: avoid queuing packets when intermediate queue is empty
>
>Marco Pinna (1):
>      vsock/virtio: refactor virtio_transport_send_pkt_work
>
>Max Gurtovoy (2):
>      virtio_fs: introduce virtio_fs_put_locked helper
>      virtio_fs: add sysfs entries for queue information
>
>Philip Chen (1):
>      virtio_pmem: Check device status before requesting flush
>
>Stefano Garzarella (1):
>      MAINTAINERS: add virtio-vsock driver in the VIRTIO CORE section
>
>Yue Haibing (1):
>      vdpa: Remove unused declarations
>
>Zhu Jun (1):
>      tools/virtio:Fix the wrong format specifier
>
>zhenwei pi (3):
>      virtio_balloon: introduce oom-kill invocations
>      virtio_balloon: introduce memory allocation stall counter
>      virtio_balloon: introduce memory scan/reclaim info
>
> MAINTAINERS                                   |   1 +
> drivers/firmware/qemu_fw_cfg.c                |   2 +-
> drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  21 +-
> drivers/nvdimm/nd_virtio.c                    |   9 +
> drivers/vdpa/ifcvf/ifcvf_base.h               |   3 -
> drivers/vdpa/mlx5/core/mlx5_vdpa.h            |  47 ++-
> drivers/vdpa/mlx5/core/mr.c                   | 291 +++++++++++++---
> drivers/vdpa/mlx5/core/resources.c            |  76 +++-
> drivers/vdpa/mlx5/net/mlx5_vnet.c             | 477 +++++++++++++++++---------
> drivers/vdpa/pds/cmds.h                       |   1 -
> drivers/vdpa/vdpa.c                           |  79 +++++
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c          |  21 +-
> drivers/vhost/vdpa.c                          |  16 +-
> drivers/virtio/virtio_balloon.c               |  18 +
> fs/fuse/virtio_fs.c                           | 164 ++++++++-
> include/linux/vdpa.h                          |   9 +
> include/uapi/linux/vdpa.h                     |   1 +
> include/uapi/linux/virtio_balloon.h           |  16 +-
> net/vmw_vsock/virtio_transport.c              | 144 +++++---
> tools/virtio/ringtest/main.c                  |   2 +-
> 20 files changed, 1098 insertions(+), 300 deletions(-)
>

