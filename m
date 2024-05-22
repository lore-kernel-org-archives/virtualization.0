Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A5582D7C
	for <virtualization@lists.linux-foundation.org>; Wed, 22 May 2024 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716377994; cv=none; b=PL/ECViVIbS9lK4GLP3KhYKMw39m7Da/cH8eSbgyANh8nnzIP5gsybmroqiw7dyw+0tD8cBfNlI6VjXNgoWRWUKrIvpCYWVNOhCSq36AERg2SeiJrG1fC799SaPID+1BdJvuTJ1usIm7JuX6kvSO+/xsnfunhU11pVIksrHO73s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716377994; c=relaxed/simple;
	bh=tvmJoTxlJyTbwxxn4NFBfvnRurJckOrHvHrX3QfLETg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZYTGWUTy4HXiXNzH9hcb/0yts2nVVurI9C7049r6pidPKdILnvwjJkBT5SrUuhz4y4frvGLjXBUwYqHoKbTgFlZdeiRjyDzgU9T4qPo+TnGQkTx6b99ereWmKO3mUc5JF8YSCtVtSSEj6kYa3IVLOVE1rKoBUmDSzzsH4nCaKok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FvrFKm8Q; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FvrFKm8Q"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62C5160688
	for <virtualization@lists.linux-foundation.org>; Wed, 22 May 2024 11:39:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9FQEEBKTyNyN for <virtualization@lists.linux-foundation.org>;
 Wed, 22 May 2024 11:39:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DEDEC60687
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DEDEC60687
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FvrFKm8Q
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DEDEC60687
	for <virtualization@lists.linux-foundation.org>; Wed, 22 May 2024 11:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716377989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86ynT9mBN6OGP/cA7dHJ49fBRwpJKok/tGfohZ5cMwE=;
	b=FvrFKm8QjthuxGnNHT1wgaKLXnvC9KIxZaFRLxBoqoFQBxL2EcVK9mcO1ol/EsoMo2OuFs
	WETB+07jV55Y8ebDWR3vWKaWr/rC9rlTWaU719kCucPcpAXysZJaLRvvOe+Yb3i+FS/WQ4
	cFVRxEHw/PZ0VTxk5Gh0r5KAFy0KKxI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-SwEnED1xNbK3Af5211h6Eg-1; Wed, 22 May 2024 07:39:46 -0400
X-MC-Unique: SwEnED1xNbK3Af5211h6Eg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41ffa918455so66576205e9.3
        for <virtualization@lists.linux-foundation.org>; Wed, 22 May 2024 04:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716377985; x=1716982785;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86ynT9mBN6OGP/cA7dHJ49fBRwpJKok/tGfohZ5cMwE=;
        b=nohWFPrk6Iz/pArYN+O+u75bpBQTp6/CN9XVGQQ7ABQidB/5jC+gKDSFALs82+wXVr
         9bY4Z0PPn4Tdi+E/gsTkajfgeb5FIhlFRwLppFGsAuWBAONe6zDEGgGqZ3LAYU3zyh6i
         +/mm/rXeOt1qkIhyidUnLFAj21Ue0kQRlWCU1JcC55PX3oQpRUJ69a8BGJMO14EgVLVf
         0fMPaQLMifkVlM12GB9Ls3hThTKgZ06sBhCVgehw7XF9Y+PX5LLYAjDzdHehghnN+zDe
         dLq9vOq8MzOVem0P69sHXjXpjSyNm8q+GRWxukYu2BlsTU3qaFin3N2Y2tF3BkiPCCsl
         4I9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQKmQAZtlX1HP8DG8xVlKNINLt8k7XTEfRSc9nmU+Ar4TaHHbtwGaQ1pUa8UaG/hLQrGahzcuo6zwyS05pejXvAzLYbWkj3JR5KQ6hBgIwX/5306cJcLlWiQ==
X-Gm-Message-State: AOJu0Ywiiy8hbGeFyZRJBsSACr+dRKqu38EojooASdI9EfQ8UfxjXUtY
	8hYvqyygfXNUKPBQZMskOgajaaCoF0bVhNVb1XJ+xfN11pvl3llUsKmyqwgPk5XyyAXg2315N8I
	F8LSOcEY8ekRjf+zHHGCWP+v82+J+w0TZayDJ7fD6TzW7wE2MR+AxyF6K768/49GY+1fUUs/MFy
	RyWLk=
X-Received: by 2002:a7b:c5da:0:b0:420:1284:475 with SMTP id 5b1f17b1804b1-420fd303121mr15594725e9.12.1716377985035;
        Wed, 22 May 2024 04:39:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXVOSuHbWxoDbfYUHO5Q3zMnqLIpcM3imLHV/kW/7weRAbJ7RKbqAJgOsChA5NWmvZHsUelg==
X-Received: by 2002:a7b:c5da:0:b0:420:1284:475 with SMTP id 5b1f17b1804b1-420fd303121mr15594215e9.12.1716377984394;
        Wed, 22 May 2024 04:39:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:e862:558a:a573:a176:1825])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8f8asm497045485e9.10.2024.05.22.04.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:39:43 -0700 (PDT)
Date: Wed, 22 May 2024 07:39:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	anton.yakovlev@opensynergy.com, bartosz.golaszewski@linaro.org,
	christophe.jaillet@wanadoo.fr, dave.jiang@intel.com,
	david@redhat.com, eperezma@redhat.com, herbert@gondor.apana.org.au,
	jasowang@redhat.com, jiri@nvidia.com, jiri@resnulli.us,
	johannes@sipsolutions.net, krzysztof.kozlowski@linaro.org,
	lingshan.zhu@intel.com, linus.walleij@linaro.org,
	lizhijian@fujitsu.com, martin.petersen@oracle.com,
	maxime.coquelin@redhat.com, michael.christie@oracle.com,
	sgarzare@redhat.com, stevensd@chromium.org, sudeep.holla@arm.com,
	syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com,
	u.kleine-koenig@pengutronix.de, viresh.kumar@linaro.org,
	xuanzhuo@linux.alibaba.com, yuxue.liu@jaguarmicro.com,
	Srujana Challa <schalla@marvell.com>
Subject: Re: [GIT PULL] virtio: features, fixes, cleanups
Message-ID: <20240522073809-mutt-send-email-mst@kernel.org>
References: <20240522060301-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240522060301-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 22, 2024 at 06:03:08AM -0400, Michael S. Tsirkin wrote:
> Things to note here:

Sorry Linus, author of one of the patchsets I merged wants to drop it now.
I could revert but it seems cleaner to do that, re-test and re-post.
Will drop a duplicate as long as I do it.



> - the new Marvell OCTEON DPU driver is not here: latest v4 keeps causing
>   build failures on mips. I deferred the pull hoping to get it in
>   and I might merge a new version post rc1
>   (supposed to be ok for new drivers as they can't cause regressions),
>   but we'll see.
> - there are also a couple bugfixes under review, to be merged after rc1
> - I merged a trivial patch (removing a comment) that also got
>   merged through net.
>   git handles this just fine and it did not seem worth it
>   rebasing to drop it.
> - there is a trivial conflict in the header file. Shouldn't be any
>   trouble to resolve, but fyi the resolution by Stephen is here
> 	diff --cc drivers/virtio/virtio_mem.c
> 	index e8355f55a8f7,6d4dfbc53a66..000000000000
> 	--- a/drivers/virtio/virtio_mem.c
> 	+++ b/drivers/virtio/virtio_mem.c
> 	@@@ -21,7 -21,7 +21,8 @@@
> 	  #include <linux/bitmap.h>
> 	  #include <linux/lockdep.h>
> 	  #include <linux/log2.h>
> 	 +#include <linux/vmalloc.h>
> 	+ #include <linux/suspend.h>
>   Also see it here:
>   https://lore.kernel.org/all/20240423145947.142171f6@canb.auug.org.au/
> 
> 
> 
> The following changes since commit 18daea77cca626f590fb140fc11e3a43c5d41354:
> 
>   Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2024-04-30 12:40:41 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> 
> for you to fetch changes up to 0b8dbbdcf2e42273fbac9b752919e2e5b2abac21:
> 
>   Merge tag 'for_linus' into vhost (2024-05-12 08:15:28 -0400)
> 
> ----------------------------------------------------------------
> virtio: features, fixes, cleanups
> 
> Several new features here:
> 
> - virtio-net is finally supported in vduse.
> 
> - Virtio (balloon and mem) interaction with suspend is improved
> 
> - vhost-scsi now handles signals better/faster.
> 
> - virtio-net now supports premapped mode by default,
>   opening the door for all kind of zero copy tricks.
> 
> Fixes, cleanups all over the place.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Christophe JAILLET (1):
>       vhost-vdpa: Remove usage of the deprecated ida_simple_xx() API
> 
> David Hildenbrand (1):
>       virtio-mem: support suspend+resume
> 
> David Stevens (2):
>       virtio_balloon: Give the balloon its own wakeup source
>       virtio_balloon: Treat stats requests as wakeup events
> 
> Eugenio Pérez (2):
>       MAINTAINERS: add Eugenio Pérez as reviewer
>       MAINTAINERS: add Eugenio Pérez as reviewer
> 
> Jiri Pirko (1):
>       virtio: delete vq in vp_find_vqs_msix() when request_irq() fails
> 
> Krzysztof Kozlowski (24):
>       virtio: balloon: drop owner assignment
>       virtio: input: drop owner assignment
>       virtio: mem: drop owner assignment
>       um: virt-pci: drop owner assignment
>       virtio_blk: drop owner assignment
>       bluetooth: virtio: drop owner assignment
>       hwrng: virtio: drop owner assignment
>       virtio_console: drop owner assignment
>       crypto: virtio - drop owner assignment
>       firmware: arm_scmi: virtio: drop owner assignment
>       gpio: virtio: drop owner assignment
>       drm/virtio: drop owner assignment
>       iommu: virtio: drop owner assignment
>       misc: nsm: drop owner assignment
>       net: caif: virtio: drop owner assignment
>       net: virtio: drop owner assignment
>       net: 9p: virtio: drop owner assignment
>       vsock/virtio: drop owner assignment
>       wifi: mac80211_hwsim: drop owner assignment
>       nvdimm: virtio_pmem: drop owner assignment
>       rpmsg: virtio: drop owner assignment
>       scsi: virtio: drop owner assignment
>       fuse: virtio: drop owner assignment
>       sound: virtio: drop owner assignment
> 
> Li Zhijian (1):
>       vdpa: Convert sprintf/snprintf to sysfs_emit
> 
> Maxime Coquelin (6):
>       vduse: validate block features only with block devices
>       vduse: Temporarily fail if control queue feature requested
>       vduse: enable Virtio-net device type
>       vduse: validate block features only with block devices
>       vduse: Temporarily fail if control queue feature requested
>       vduse: enable Virtio-net device type
> 
> Michael S. Tsirkin (2):
>       Merge tag 'stable/vduse-virtio-net' into vhost
>       Merge tag 'for_linus' into vhost
> 
> Mike Christie (9):
>       vhost-scsi: Handle vhost_vq_work_queue failures for events
>       vhost-scsi: Handle vhost_vq_work_queue failures for cmds
>       vhost-scsi: Use system wq to flush dev for TMFs
>       vhost: Remove vhost_vq_flush
>       vhost_scsi: Handle vhost_vq_work_queue failures for TMFs
>       vhost: Use virtqueue mutex for swapping worker
>       vhost: Release worker mutex during flushes
>       vhost_task: Handle SIGKILL by flushing work and exiting
>       kernel: Remove signal hacks for vhost_tasks
> 
> Uwe Kleine-König (1):
>       virtio-mmio: Convert to platform remove callback returning void
> 
> Xuan Zhuo (7):
>       virtio_ring: introduce dma map api for page
>       virtio_ring: enable premapped mode whatever use_dma_api
>       virtio_net: replace private by pp struct inside page
>       virtio_net: big mode support premapped
>       virtio_net: enable premapped by default
>       virtio_net: rx remove premapped failover code
>       virtio_net: remove the misleading comment
> 
> Yuxue Liu (2):
>       vp_vdpa: Fix return value check vp_vdpa_request_irq
>       vp_vdpa: don't allocate unused msix vectors
> 
> Zhu Lingshan (1):
>       MAINTAINERS: apply maintainer role of Intel vDPA driver
> 
>  MAINTAINERS                                   |  10 +-
>  arch/um/drivers/virt-pci.c                    |   1 -
>  drivers/block/virtio_blk.c                    |   1 -
>  drivers/bluetooth/virtio_bt.c                 |   1 -
>  drivers/char/hw_random/virtio-rng.c           |   1 -
>  drivers/char/virtio_console.c                 |   2 -
>  drivers/crypto/virtio/virtio_crypto_core.c    |   1 -
>  drivers/firmware/arm_scmi/virtio.c            |   1 -
>  drivers/gpio/gpio-virtio.c                    |   1 -
>  drivers/gpu/drm/virtio/virtgpu_drv.c          |   1 -
>  drivers/iommu/virtio-iommu.c                  |   1 -
>  drivers/misc/nsm.c                            |   1 -
>  drivers/net/caif/caif_virtio.c                |   1 -
>  drivers/net/virtio_net.c                      | 248 +++++++++++++++++---------
>  drivers/net/wireless/virtual/mac80211_hwsim.c |   1 -
>  drivers/nvdimm/virtio_pmem.c                  |   1 -
>  drivers/rpmsg/virtio_rpmsg_bus.c              |   1 -
>  drivers/scsi/virtio_scsi.c                    |   1 -
>  drivers/vdpa/vdpa.c                           |   2 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c            |  24 ++-
>  drivers/vdpa/virtio_pci/vp_vdpa.c             |  27 ++-
>  drivers/vhost/scsi.c                          |  70 +++++---
>  drivers/vhost/vdpa.c                          |   6 +-
>  drivers/vhost/vhost.c                         | 130 ++++++++++----
>  drivers/vhost/vhost.h                         |   3 +-
>  drivers/virtio/virtio_balloon.c               |  85 +++++----
>  drivers/virtio/virtio_input.c                 |   1 -
>  drivers/virtio/virtio_mem.c                   |  69 ++++++-
>  drivers/virtio/virtio_mmio.c                  |   6 +-
>  drivers/virtio/virtio_pci_common.c            |   4 +-
>  drivers/virtio/virtio_ring.c                  |  59 +++++-
>  fs/coredump.c                                 |   4 +-
>  fs/fuse/virtio_fs.c                           |   1 -
>  include/linux/sched/vhost_task.h              |   3 +-
>  include/linux/virtio.h                        |   7 +
>  include/uapi/linux/virtio_mem.h               |   2 +
>  kernel/exit.c                                 |   5 +-
>  kernel/signal.c                               |   4 +-
>  kernel/vhost_task.c                           |  53 ++++--
>  net/9p/trans_virtio.c                         |   1 -
>  net/vmw_vsock/virtio_transport.c              |   1 -
>  sound/virtio/virtio_card.c                    |   1 -
>  42 files changed, 578 insertions(+), 265 deletions(-)

