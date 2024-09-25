Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C8170A01
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262690; cv=none; b=JhJ4j7j+b3q6a4NeKsfpFM/CLMArmrzDt10jKqCU73AXOs7moPDRg0o5yEp1MeY/JtK3NqRaQkllH1ag/JJWQu0uO+avldQgo+ZRUq4OFDcjEA1gpQ4ZCYhwyA/h2Wfu+/hMnbxzT3/+7eHrcBe+EUm/+dKvmqfBg+VaGH/2aPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262690; c=relaxed/simple;
	bh=KxXb61FAQz73vWD6iz+3YIxIH9LHwmthexAgAZxB96U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lFP0NM8Gvq5AK2XpN6et7O1Yh51SjI5jXQCeim1G/eFoECpYwQrIvbQ63myufcuP4kx7VQHa23by57YY5n9jUZtOiiHHY+XYeGRLwq/ptwascQuyx0+f68aF64N3c/yMlMTCSqyOPKID0xBjEkxPT5at2EW4UqvofHUiCV9wvB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sy0QWx95; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sy0QWx95"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8B6C44037C
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 11:11:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m3pTfRrcPnZF for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Sep 2024 11:11:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 098B54015F
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 098B54015F
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sy0QWx95
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 098B54015F
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 11:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727262685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lrgmjBMekMZhsTk36YB1tFATV8bsekZPfFmvOHdNLxc=;
	b=Sy0QWx95DUAdpze/Oe8VSuIbHBC15ZQQJCn7cRaOxtBRk0SGOOIBfyuT/GiOfB4tVAs7fb
	dbkfdhSS0zw+Z743BnMOEc8psFLeb1BIVndsR76TM/vvKsaYYuR6d5sShNEeeDhsX1ocAU
	tQ7uDt4CYelghgCZ4DqwoIq2xthMngI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-TzXDkUv4MkKlz1qmiDz-_Q-1; Wed, 25 Sep 2024 07:11:22 -0400
X-MC-Unique: TzXDkUv4MkKlz1qmiDz-_Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-378929f1a4eso3373339f8f.1
        for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 04:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727262681; x=1727867481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrgmjBMekMZhsTk36YB1tFATV8bsekZPfFmvOHdNLxc=;
        b=Kxv5SN/ojI4fbKQVxp4+SLETh0OfHfVRvfMaeuXVqVgBkggKa6e1k7OL2hq51eM26B
         6YiuLie6i+WaTY13HMqBfm+pWlp2/KDXC2uCGzW1ckX3uGuQwogFI5bQsHM/ry7bhCbQ
         olqOx4F0fU9NOiIyklRvbP2GGW6czV/C/wJADiOMWn+Tu37EFQ9sRi47qXvKtxbI0Jl4
         vzfJLJ97/hDLOWtegyTOOLU48I4EV7391GJa/qtyiQ0FqMyxUcft1q1JXY9kTHHDuZ6x
         xXCLnuIElDvTKTqsEdzfbXEmonoMSukozl9XiKExPtSPqd+RtXZgyhNjR2GHJneh+DMB
         hQPw==
X-Forwarded-Encrypted: i=1; AJvYcCUEqjSXGhgFHJkiNW+uyQPT1UiLBTcBqDxiT4+bv9lgPcyAlLJ3pf7eiRUKPIGq/JNcK/bV1rHweACafrYPgA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YypkvQ1Bk2l2C3yvHyIKIct4edZqP9yT6c6LCDfkJnU+HYFQfYY
	1gLHJ4N5EZojtxvdzNHU3H8wCYB8x7fA3aulL70t0LDLIoGipm3qeRSD42/OtRmwzRgLhSNYrZn
	jSPnl4f4g6XJUrmzH+WNPY0itgbAjNCFU6BqsZGpoVjcAVQXc6u/+SOIcEBURo60vOIH2Ijg6rf
	Fq59I=
X-Received: by 2002:a05:6000:ccd:b0:374:c16d:6282 with SMTP id ffacd0b85a97d-37cc24c77a6mr1259204f8f.55.1727262681296;
        Wed, 25 Sep 2024 04:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKf6HgXDgT9Q2MhhcNUKK2fTxzihTzqJd9EDbYBP2zW/FIpi2gHaOGeN8FwCr5rqMSmYRAag==
X-Received: by 2002:a05:6000:ccd:b0:374:c16d:6282 with SMTP id ffacd0b85a97d-37cc24c77a6mr1259173f8f.55.1727262680773;
        Wed, 25 Sep 2024 04:11:20 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7405:9900:56a3:401a:f419:5de9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2a909asm3693458f8f.22.2024.09.25.04.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 04:11:20 -0700 (PDT)
Date: Wed, 25 Sep 2024 07:11:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, david@redhat.com, dtatulea@nvidia.com,
	eperezma@redhat.com, jasowang@redhat.com, leiyang@redhat.com,
	leonro@nvidia.com, lihongbo22@huawei.com,
	luigi.leonardi@outlook.com, lulu@redhat.com, marco.pinn95@gmail.com,
	mgurtovoy@nvidia.com, pankaj.gupta.linux@gmail.com,
	philipchen@chromium.org, pizhenwei@bytedance.com,
	yuehaibing@huawei.com, zhujun2@cmss.chinamobile.com
Subject: Re: [GIT PULL] virtio: features, fixes, cleanups
Message-ID: <20240925071019-mutt-send-email-mst@kernel.org>
References: <20240924165046-mutt-send-email-mst@kernel.org>
 <fqvpau7doh7lf7mytane7n5yww7w2lrc4y6pyshainrl52rfyl@xi6kk7hbwyhc>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <fqvpau7doh7lf7mytane7n5yww7w2lrc4y6pyshainrl52rfyl@xi6kk7hbwyhc>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 25, 2024 at 09:38:49AM +0200, Stefano Garzarella wrote:
> On Tue, Sep 24, 2024 at 04:50:46PM GMT, Michael S. Tsirkin wrote:
> > The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:
> > 
> >  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)
> > 
> > are available in the Git repository at:
> > 
> >  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> > 
> > for you to fetch changes up to 1bc6f4910ae955971097f3f2ae0e7e63fa4250ae:
> > 
> >  vsock/virtio: avoid queuing packets when intermediate queue is empty (2024-09-12 02:54:10 -0400)
> > 
> > ----------------------------------------------------------------
> > virtio: features, fixes, cleanups
> > 
> > Several new features here:
> > 
> > 	virtio-balloon supports new stats
> > 
> > 	vdpa supports setting mac address
> > 
> > 	vdpa/mlx5 suspend/resume as well as MKEY ops are now faster
> > 
> > 	virtio_fs supports new sysfs entries for queue info
> > 
> > 	virtio/vsock performance has been improved
> > 
> > Fixes, cleanups all over the place.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > ----------------------------------------------------------------
> > Cindy Lu (3):
> >      vdpa: support set mac address from vdpa tool
> >      vdpa_sim_net: Add the support of set mac address
> >      vdpa/mlx5: Add the support of set mac address
> > 
> > Dragos Tatulea (18):
> >      vdpa/mlx5: Fix invalid mr resource destroy
> >      net/mlx5: Support throttled commands from async API
> >      vdpa/mlx5: Introduce error logging function
> >      vdpa/mlx5: Introduce async fw command wrapper
> >      vdpa/mlx5: Use async API for vq query command
> >      vdpa/mlx5: Use async API for vq modify commands
> >      vdpa/mlx5: Parallelize device suspend
> >      vdpa/mlx5: Parallelize device resume
> >      vdpa/mlx5: Keep notifiers during suspend but ignore
> >      vdpa/mlx5: Small improvement for change_num_qps()
> >      vdpa/mlx5: Parallelize VQ suspend/resume for CVQ MQ command
> >      vdpa/mlx5: Create direct MKEYs in parallel
> >      vdpa/mlx5: Delete direct MKEYs in parallel
> >      vdpa/mlx5: Rename function
> >      vdpa/mlx5: Extract mr members in own resource struct
> >      vdpa/mlx5: Rename mr_mtx -> lock
> >      vdpa/mlx5: Introduce init/destroy for MR resources
> >      vdpa/mlx5: Postpone MR deletion
> > 
> > Hongbo Li (1):
> >      fw_cfg: Constify struct kobj_type
> > 
> > Jason Wang (1):
> >      vhost_vdpa: assign irq bypass producer token correctly
> > 
> > Lei Yang leiyang@redhat.com (1):
> >      ack! vdpa/mlx5: Parallelize device suspend/resume
>        ^
> This commit (fbb072d2d19133222e202ea7c267cfc1f6bd83b0) looked strange
> from the title, indeed inside it looks empty, so maybe the intent was to
> "squash" it with the previous commit acba6a443aa4 ("vdpa/mlx5:
> Parallelize VQ suspend/resume for CVQ MQ command") to bring back the
> Tested-by, right?
> 
> Thanks,
> Stefano

Good catch Stefano, the intent was to add the ack to all
commits in the series, I created an empty commit to
record that and then forgot to remove it.
Updated the tag, thanks!


> > 
> > Luigi Leonardi (1):
> >      vsock/virtio: avoid queuing packets when intermediate queue is empty
> > 
> > Marco Pinna (1):
> >      vsock/virtio: refactor virtio_transport_send_pkt_work
> > 
> > Max Gurtovoy (2):
> >      virtio_fs: introduce virtio_fs_put_locked helper
> >      virtio_fs: add sysfs entries for queue information
> > 
> > Philip Chen (1):
> >      virtio_pmem: Check device status before requesting flush
> > 
> > Stefano Garzarella (1):
> >      MAINTAINERS: add virtio-vsock driver in the VIRTIO CORE section
> > 
> > Yue Haibing (1):
> >      vdpa: Remove unused declarations
> > 
> > Zhu Jun (1):
> >      tools/virtio:Fix the wrong format specifier
> > 
> > zhenwei pi (3):
> >      virtio_balloon: introduce oom-kill invocations
> >      virtio_balloon: introduce memory allocation stall counter
> >      virtio_balloon: introduce memory scan/reclaim info
> > 
> > MAINTAINERS                                   |   1 +
> > drivers/firmware/qemu_fw_cfg.c                |   2 +-
> > drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  21 +-
> > drivers/nvdimm/nd_virtio.c                    |   9 +
> > drivers/vdpa/ifcvf/ifcvf_base.h               |   3 -
> > drivers/vdpa/mlx5/core/mlx5_vdpa.h            |  47 ++-
> > drivers/vdpa/mlx5/core/mr.c                   | 291 +++++++++++++---
> > drivers/vdpa/mlx5/core/resources.c            |  76 +++-
> > drivers/vdpa/mlx5/net/mlx5_vnet.c             | 477 +++++++++++++++++---------
> > drivers/vdpa/pds/cmds.h                       |   1 -
> > drivers/vdpa/vdpa.c                           |  79 +++++
> > drivers/vdpa/vdpa_sim/vdpa_sim_net.c          |  21 +-
> > drivers/vhost/vdpa.c                          |  16 +-
> > drivers/virtio/virtio_balloon.c               |  18 +
> > fs/fuse/virtio_fs.c                           | 164 ++++++++-
> > include/linux/vdpa.h                          |   9 +
> > include/uapi/linux/vdpa.h                     |   1 +
> > include/uapi/linux/virtio_balloon.h           |  16 +-
> > net/vmw_vsock/virtio_transport.c              | 144 +++++---
> > tools/virtio/ringtest/main.c                  |   2 +-
> > 20 files changed, 1098 insertions(+), 300 deletions(-)
> > 

