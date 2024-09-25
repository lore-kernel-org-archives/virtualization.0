Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC0B146A6C
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262354; cv=none; b=t30GEEosf8dTVBA6Sk127gyAA4TZyI2ed/XQd+t3NU2u5tPhRuCkdRiend19D+XMymu62W0EZy/taWtFENrSbvxgX0G2byAof9Hbmi0Rnk8bX2gyNK+7n9nLZ43b4xr/GfCqdEEUs5jav8KZOHvmSKDQs6pAKAl66Sj25bRpsms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262354; c=relaxed/simple;
	bh=Sqkc7COafVaLxQmdycBqaTIn4GumFYjZAn2h85fxp/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BvHubUE6oA+bRwkpgrwMQ2QoGv8Ox6MxJyK99W8D2dsgQZRPsTsuJMEk5ZWH27O/Oy25lIVbZZqdbbaj+M94LBDu9OVtQvT8QFMC7PnjlIBgfHK+o+95i2/2h8fixYBC8iun0B/M51fW/b0FmZ/kTm9Ww6c3jb9L2VPv2uBVEys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DVcm2MKB; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVcm2MKB"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D12561119
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 11:05:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JbYxvWtfxGmu for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Sep 2024 11:05:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 45BC960DF0
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 45BC960DF0
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DVcm2MKB
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 45BC960DF0
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 11:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727262349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6LM+n56GH7KXiVYxjlnpXafBN650KcAqdINciF2Xu3w=;
	b=DVcm2MKBeu9j+PPgsyUHPuvHXWlIKnU8gxBNpzcxlhj9y8ZR876nlEEvwJ79chQT0Xt12E
	UZ7gZBC11y5iOfPut/hMhA9MsEjWxjsCvB2K19e1dFCFTjk9gHnROf/n87Kk9yOZuLucZC
	mbPESShi6JyNftoWvKEBP5YZtdWGUIw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-OhzBX_IRPxO6-NKBgT-X3g-1; Wed, 25 Sep 2024 07:05:48 -0400
X-MC-Unique: OhzBX_IRPxO6-NKBgT-X3g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37a4d65df57so1152532f8f.1
        for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 04:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727262347; x=1727867147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LM+n56GH7KXiVYxjlnpXafBN650KcAqdINciF2Xu3w=;
        b=lNNEbcb/AyfVuMTcs6hIIK6tGo+ArJ9YdzgQ1kUVxP8jjjS6xmMxoo466y9GJY/u/Z
         ZO6Ctfpgb4tHnC24lYSY8fKYL9pPIqV222m1TU+G4Wle1ykRkpwU3aid1eB+1tyKhrgG
         oL6obm+Ne9VmAf3XLu8o9kuGKLyrBJLPYytVv8ilmxHGiAmCwNlqGZQZPiV2LRdaQQHL
         gh179Lh3APj80jVm5D/vQWPXf3mwY5btu2/DEzPUz5ynHnoNeWQtn0/T1mOpHexHKMJT
         pc6HUvePF30RUvT+xoZM879TNkj2vHb4pHvjHGu/pPfyuXVI4MtfO4SlNK2xSm2oOtUy
         qqRg==
X-Forwarded-Encrypted: i=1; AJvYcCWUrfjQocFYSY0lzxbZCbMhZB7GNruXQdexSYb4FremF3u2Bokl8a0rf35obwK1frqopESljmwD1qN6OCO/2Q==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw94D8yDZF1V2p+DKpdVmR3lhWBKwmdxLTPR7T492/jAEtwAXE1
	OY5cBdNuIt3ahExBgBPXV8E99Kws4h0LBxfeDs5HgBi78EfdPn2N2TQ/ZvpuqCCPfA5sCVzWtBX
	nvxR9WUss71yth8ymQsPtlmIEwAb8oiT8B6ImBdeKIgm+6h/ZNC1z+P0FLRCVd+z5fMr7eUFaWv
	isi8I=
X-Received: by 2002:a5d:5d83:0:b0:37c:cbbb:10c with SMTP id ffacd0b85a97d-37ccbbb02bdmr443654f8f.52.1727262347213;
        Wed, 25 Sep 2024 04:05:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyxK9W0yQxQwL6c10VX2K+N65TxtVt2ovya9Ro/obn2l6EIadff65SJpEzepj3XEwoB84y/w==
X-Received: by 2002:a5d:5d83:0:b0:37c:cbbb:10c with SMTP id ffacd0b85a97d-37ccbbb02bdmr443620f8f.52.1727262346651;
        Wed, 25 Sep 2024 04:05:46 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7405:9900:56a3:401a:f419:5de9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cc9d0decesm699449f8f.80.2024.09.25.04.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 04:05:43 -0700 (PDT)
Date: Wed, 25 Sep 2024 07:05:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	david@redhat.com, dtatulea@nvidia.com, eperezma@redhat.com,
	jasowang@redhat.com, leiyang@redhat.com, leonro@nvidia.com,
	lihongbo22@huawei.com, luigi.leonardi@outlook.com, lulu@redhat.com,
	marco.pinn95@gmail.com, mgurtovoy@nvidia.com,
	pankaj.gupta.linux@gmail.com, philipchen@chromium.org,
	pizhenwei@bytedance.com, sgarzare@redhat.com, yuehaibing@huawei.com,
	zhujun2@cmss.chinamobile.com
Subject: Re: [GIT PULL] virtio: features, fixes, cleanups
Message-ID: <20240925070508-mutt-send-email-mst@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 24, 2024 at 04:50:46PM -0400, Michael S. Tsirkin wrote:
> The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:
> 
>   Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> 
> for you to fetch changes up to 1bc6f4910ae955971097f3f2ae0e7e63fa4250ae:
> 
>   vsock/virtio: avoid queuing packets when intermediate queue is empty (2024-09-12 02:54:10 -0400)

Ouch. Pls ignore, will fix and resend.

> ----------------------------------------------------------------
> virtio: features, fixes, cleanups
> 
> Several new features here:
> 
> 	virtio-balloon supports new stats
> 
> 	vdpa supports setting mac address
> 
> 	vdpa/mlx5 suspend/resume as well as MKEY ops are now faster
> 
> 	virtio_fs supports new sysfs entries for queue info
> 
> 	virtio/vsock performance has been improved
> 
> Fixes, cleanups all over the place.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Cindy Lu (3):
>       vdpa: support set mac address from vdpa tool
>       vdpa_sim_net: Add the support of set mac address
>       vdpa/mlx5: Add the support of set mac address
> 
> Dragos Tatulea (18):
>       vdpa/mlx5: Fix invalid mr resource destroy
>       net/mlx5: Support throttled commands from async API
>       vdpa/mlx5: Introduce error logging function
>       vdpa/mlx5: Introduce async fw command wrapper
>       vdpa/mlx5: Use async API for vq query command
>       vdpa/mlx5: Use async API for vq modify commands
>       vdpa/mlx5: Parallelize device suspend
>       vdpa/mlx5: Parallelize device resume
>       vdpa/mlx5: Keep notifiers during suspend but ignore
>       vdpa/mlx5: Small improvement for change_num_qps()
>       vdpa/mlx5: Parallelize VQ suspend/resume for CVQ MQ command
>       vdpa/mlx5: Create direct MKEYs in parallel
>       vdpa/mlx5: Delete direct MKEYs in parallel
>       vdpa/mlx5: Rename function
>       vdpa/mlx5: Extract mr members in own resource struct
>       vdpa/mlx5: Rename mr_mtx -> lock
>       vdpa/mlx5: Introduce init/destroy for MR resources
>       vdpa/mlx5: Postpone MR deletion
> 
> Hongbo Li (1):
>       fw_cfg: Constify struct kobj_type
> 
> Jason Wang (1):
>       vhost_vdpa: assign irq bypass producer token correctly
> 
> Lei Yang leiyang@redhat.com (1):
>       ack! vdpa/mlx5: Parallelize device suspend/resume


Ouch. Pls ignore, will fix and resend.

> 
> Luigi Leonardi (1):
>       vsock/virtio: avoid queuing packets when intermediate queue is empty
> 
> Marco Pinna (1):
>       vsock/virtio: refactor virtio_transport_send_pkt_work
> 
> Max Gurtovoy (2):
>       virtio_fs: introduce virtio_fs_put_locked helper
>       virtio_fs: add sysfs entries for queue information
> 
> Philip Chen (1):
>       virtio_pmem: Check device status before requesting flush
> 
> Stefano Garzarella (1):
>       MAINTAINERS: add virtio-vsock driver in the VIRTIO CORE section
> 
> Yue Haibing (1):
>       vdpa: Remove unused declarations
> 
> Zhu Jun (1):
>       tools/virtio:Fix the wrong format specifier
> 
> zhenwei pi (3):
>       virtio_balloon: introduce oom-kill invocations
>       virtio_balloon: introduce memory allocation stall counter
>       virtio_balloon: introduce memory scan/reclaim info
> 
>  MAINTAINERS                                   |   1 +
>  drivers/firmware/qemu_fw_cfg.c                |   2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  21 +-
>  drivers/nvdimm/nd_virtio.c                    |   9 +
>  drivers/vdpa/ifcvf/ifcvf_base.h               |   3 -
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h            |  47 ++-
>  drivers/vdpa/mlx5/core/mr.c                   | 291 +++++++++++++---
>  drivers/vdpa/mlx5/core/resources.c            |  76 +++-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c             | 477 +++++++++++++++++---------
>  drivers/vdpa/pds/cmds.h                       |   1 -
>  drivers/vdpa/vdpa.c                           |  79 +++++
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c          |  21 +-
>  drivers/vhost/vdpa.c                          |  16 +-
>  drivers/virtio/virtio_balloon.c               |  18 +
>  fs/fuse/virtio_fs.c                           | 164 ++++++++-
>  include/linux/vdpa.h                          |   9 +
>  include/uapi/linux/vdpa.h                     |   1 +
>  include/uapi/linux/virtio_balloon.h           |  16 +-
>  net/vmw_vsock/virtio_transport.c              | 144 +++++---
>  tools/virtio/ringtest/main.c                  |   2 +-
>  20 files changed, 1098 insertions(+), 300 deletions(-)

