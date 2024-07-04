Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81F21946C0
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720093244; cv=none; b=UDU0qkoZtVkkD7JyJUQ5DVBAILzTWD/65uEAxnRZ/8RB1FlSFRgh1GSLxOEfKFkLFIlMU7zHlLyaT8QmMuMdMe5PbJU9DQ0u1iSLHr1jttAW8NBYN2G0p3oVLq0hq1vx0NF9Uz16JfWgjxCb1p5aKXrKInc4UhQ6dX/NAMXsLMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720093244; c=relaxed/simple;
	bh=WRBlHcTdjQpUI6FPvznRM1/yDMKq8l7QNnsGCmQgjEY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=HvA6FZt/NEnWk39oe28qSY+zfrzToaGlZ2VjdaKwU0ZK58vVD2HxkAV34O7w6xfi67S4FdVyxPJkrnBuJzuQZ1xhqMV5li631ICBydRw1Wbmn9Q3WY8VjqqfAoukJJBTYtWKP98XQfLlDpmIGUW0nbwKlZ5aHTy57mkaow/wJjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BrfIJvcD; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BrfIJvcD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720093239; h=Message-ID:Subject:Date:From:To;
	bh=bjF7lLYeL+KOlRd+Y8bWuA5iygKVeJhKffq0LgZJgZ0=;
	b=BrfIJvcDD6BmnFvnSQ/gYoaj0n960ydL+yv9HXv6qVqqS5Vn1LO4YHPWSX5Ti2w+vf1MAaC7jJrhR9E+HieFvMtabGHKWIxCQ+AuRDd/tx2QPm8nSqn7xSrnqs8rZ3tNUY5QyNvx2BRcv3MAvO3mQxstb6SXwj4Xz9YBL4ck+FY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W9qjsE-_1720093238;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W9qjsE-_1720093238)
          by smtp.aliyun-inc.com;
          Thu, 04 Jul 2024 19:40:39 +0800
Message-ID: <1720093115.9907808-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH virtio 00/19] virtio: consolidate vq info args of find_vqs()
Date: Thu, 4 Jul 2024 19:38:35 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev,
 jasowang@redhat.com,
 eperezma@redhat.com,
 parav@nvidia.com,
 feliu@nvidia.com,
 hengqi@linux.alibaba.com,
 Jiri Pirko <jiri@resnulli.us>
References: <20240703123913.969202-1-jiri@resnulli.us>
 <20240703084954-mutt-send-email-mst@kernel.org>
 <ZoVRIwZGbQNKwfqA@nanopsycho.orion>
 <20240703093649-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240703093649-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 3 Jul 2024 09:37:10 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, Jul 03, 2024 at 03:24:51PM +0200, Jiri Pirko wrote:
> > Wed, Jul 03, 2024 at 02:50:36PM CEST, mst@redhat.com wrote:
> > >On Wed, Jul 03, 2024 at 02:38:54PM +0200, Jiri Pirko wrote:
> > >> From: Jiri Pirko <jiri@nvidia.com>
> > >>
> > >> Currently, virtio_find_vqs() and virtio_find_vqs_ctx() accept array of
> > >> names, callbacks and ctx (in case of the second one) as separate args.
> > >> That became inconvenient as the ctx addition showed.
> > >>
> > >> For virtio_net control queue, an indication of queue flavour (slow path)
> > >> is going to be needed to be passed to PCI transport in order to
> > >> assign vectors properly, another array added to virtio_find_vqs_ctx()
> > >> arg list would not be nice and convenient.
> > >>
> > >> Instead, introduce a structure to carry vq callback, name and ctx. Pass
> > >> array of these structures to virtio_find_vqs() and all the way down to
> > >> transport find_vqs() op implementation.
> > >>
> > >> That allows to easily extend what needs to be passed down. Also, it
> > >> makes the code a bit more cleaner. We get rid of separate
> > >> virtio_find_vqs_ctx() helper.
> > >>
> > >> This patchset does the conversion in steps, using temporary _info() op
> > >> and helper. Note they are renamed back.
> > >
> > >Thanks a lot Jiri, looks very good.
> > >Some minor comments.
> >
> > Will fix and send v2 tomorrow. I have my admin queue patchset rebased on
> > top of this and code will be ready for control queue to benefit from
> > vector allocation.
>
>
> Excellent, I hope it makes it in next in time for the next merge window.

Hi, Michael, you know I was working on this.

Is the virtio community already in such a mess?

>
> >
> > >
> > >
> > >> Patch #1 does one forgotten conversion to virtio_find_single_vq().
> > >> Patches #2 and #3 do preparations for find_vqs_info() op introduction.
> > >> Patch #4 introduces new op find_vqs_info() to replace find_vqs() it also
> > >>   introduces struct virtio_queue_info and virtio_find_vqs_info() helper.
> > >> Patches #5 and #6 convert transports to implement find_vqs_info() op
> > >>   that accepts array of virtio_queue_info structs.
> > >> Patch #7 converts virtio_find_single_vq() to use the new way as well.
> > >> Patch #8 removes original find_vqs() op.
> > >> Patch #9 renames find_vqs_info() to find_vqs() and completes first part
> > >>   of conversion this patches does.
> > >> Patches #10-#17 convert virtio_find_vqs() and virtio_find_vqs_ctx()
> > >>   users to use new virtio_find_vqs_info() helper.
> > >> Patch #18 removes no longer used virtio_find_vqs() and
> > >>   virtio_find_vqs_ctx() helpers.
> > >> Patch #19 finalizes the conversion by renaming virtio_find_vqs_info()
> > >>   to virtio_find_vqs().
> > >>
> > >> Jiri Pirko (19):
> > >>   caif_virtio: use virtio_find_single_vq() for single virtqueue finding
> > >>   virtio: make virtio_find_vqs() call virtio_find_vqs_ctx()
> > >>   virtio: make virtio_find_single_vq() call virtio_find_vqs()
> > >>   virtio: introduce virtio_queue_info struct and find_vqs_info() config
> > >>     op
> > >>   virtio_pci: convert vp_*find_vqs() ops to find_vqs_info()
> > >>   virtio: convert find_vqs() op implementations to find_vqs_info()
> > >>   virtio: call virtio_find_vqs_info() from virtio_find_single_vq()
> > >>     directly
> > >>   virtio: remove the original find_vqs() op
> > >>   virtio: rename find_vqs_info() op to find_vqs()
> > >>   virtio_blk: convert to use virtio_find_vqs_info()
> > >>   virtio_console: convert to use virtio_find_vqs_info()
> > >>   virtio_crypto: convert to use virtio_find_vqs_info()
> > >>   virtio_net: convert to use virtio_find_vqs_info()
> > >>   scsi: virtio_scsi: convert to use virtio_find_vqs_info()
> > >>   virtiofs: convert to use virtio_find_vqs_info()
> > >>   virtio_balloon: convert to use virtio_find_vqs_info()
> > >>   virtio: convert the rest virtio_find_vqs() users to
> > >>     virtio_find_vqs_info()
> > >>   virtio: remove unused virtio_find_vqs() and virtio_find_vqs_ctx()
> > >>     helpers
> > >>   virtio: rename virtio_find_vqs_info() to virtio_find_vqs()
> > >>
> > >>  arch/um/drivers/virt-pci.c                    |  8 ++-
> > >>  arch/um/drivers/virtio_uml.c                  | 12 ++--
> > >>  drivers/block/virtio_blk.c                    | 20 +++----
> > >>  drivers/bluetooth/virtio_bt.c                 | 13 ++--
> > >>  drivers/char/virtio_console.c                 | 43 ++++++-------
> > >>  drivers/crypto/virtio/virtio_crypto_core.c    | 31 ++++------
> > >>  drivers/firmware/arm_scmi/virtio.c            | 11 ++--
> > >>  drivers/gpio/gpio-virtio.c                    | 10 ++--
> > >>  drivers/gpu/drm/virtio/virtgpu_kms.c          |  9 ++-
> > >>  drivers/iommu/virtio-iommu.c                  | 11 ++--
> > >>  drivers/net/caif/caif_virtio.c                |  8 +--
> > >>  drivers/net/virtio_net.c                      | 34 ++++-------
> > >>  drivers/net/wireless/virtual/mac80211_hwsim.c | 12 ++--
> > >>  drivers/platform/mellanox/mlxbf-tmfifo.c      | 10 ++--
> > >>  drivers/remoteproc/remoteproc_virtio.c        | 12 ++--
> > >>  drivers/rpmsg/virtio_rpmsg_bus.c              |  8 ++-
> > >>  drivers/s390/virtio/virtio_ccw.c              | 13 ++--
> > >>  drivers/scsi/virtio_scsi.c                    | 32 ++++------
> > >>  drivers/virtio/virtio_balloon.c               | 32 ++++------
> > >>  drivers/virtio/virtio_input.c                 |  9 +--
> > >>  drivers/virtio/virtio_mmio.c                  | 12 ++--
> > >>  drivers/virtio/virtio_pci_common.c            | 49 ++++++++-------
> > >>  drivers/virtio/virtio_pci_common.h            |  4 +-
> > >>  drivers/virtio/virtio_pci_modern.c            |  5 +-
> > >>  drivers/virtio/virtio_vdpa.c                  | 13 ++--
> > >>  fs/fuse/virtio_fs.c                           | 22 +++----
> > >>  include/linux/virtio_config.h                 | 60 +++++++++----------
> > >>  net/vmw_vsock/virtio_transport.c              | 16 ++---
> > >>  sound/virtio/virtio_card.c                    | 23 ++++---
> > >>  29 files changed, 240 insertions(+), 302 deletions(-)
> > >>
> > >> --
> > >> 2.45.2
> > >
>
