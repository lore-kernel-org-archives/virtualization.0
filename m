Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6F11957E2
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720093032; cv=none; b=Brn4/E5re8XyqZZdfN77+PXiP+kvvIFeTTeCddQ4O15RC3Fs2GT38HI1NV/35fjf3pGmnBdo1UseTDv1bjD6uFYDuEde+DajJ3MHEgTTLKSX5/bDr8h0TxVZjLQluRp2fkka/xHhiRoDwm/eBnf7T7eMYcKyXYXUmTTK/50xGdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720093032; c=relaxed/simple;
	bh=8R5B2gtvoAWS0y4lO8DIVaHliDDjajA0ttpgU/btZZ4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=cJJbTXZqVE3228kdhX1vTcnJvTmLsYg9psbbHEUl+goAeHgTwGbzDK7BTe3Rk+pagvdAGe+t7pW0DvjEp2JegCU7Tq++c1/Seh9EqbQ058zRCFqb3m03RAMmcv2NjLWAwoAptLQBTw/uuEG82Z+hbfOKeQFZ5qa4QinJ2GamsEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=V81dFe4S; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="V81dFe4S"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720093026; h=Message-ID:Subject:Date:From:To;
	bh=YnCIu7D2EoWOiNzUKEzRFf27Tu2jV5exSs8EzAJi+GM=;
	b=V81dFe4S66V6tSfL42OaesAJly9YlrvTH5FErS+vebKt2ZgNKC8ZQPuLMOmjJtphXhSGMwvCS+rqRjpTL/CP4uRweMy2N/BCx+a9wfIxn6uuwfCTx8ottnvJRHyQJaFasa9Wr0/StzowDRj2WuQuCzcikZtepq4sb1EIZwbN+Cc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W9qjSmM_1720093024;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W9qjSmM_1720093024)
          by smtp.aliyun-inc.com;
          Thu, 04 Jul 2024 19:37:05 +0800
Message-ID: <1720092809.2040446-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH virtio v2 00/19] virtio: consolidate vq info args of find_vqs()
Date: Thu, 4 Jul 2024 19:33:29 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com,
 parav@nvidia.com,
 feliu@nvidia.com,
 hengqi@linux.alibaba.com,
 virtualization@lists.linux.dev
References: <20240704064350.1097716-1-jiri@resnulli.us>
In-Reply-To: <20240704064350.1097716-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Do you know this: http://lore.kernel.org/all/20240424091533.86949-1-xuanzhuo@linux.alibaba.com

This seems to do the same thing. That works in process.

Thanks.

On Thu,  4 Jul 2024 08:43:31 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> From: Jiri Pirko <jiri@nvidia.com>
>
> Currently, virtio_find_vqs() and virtio_find_vqs_ctx() accept array of
> names, callbacks and ctx (in case of the second one) as separate args.
> That became inconvenient as the ctx addition showed.
>
> For virtio_net control queue, an indication of queue flavour (slow path)
> is going to be needed to be passed to PCI transport in order to
> assign vectors properly, another array added to virtio_find_vqs_ctx()
> arg list would not be nice and convenient.
>
> Instead, introduce a structure to carry vq callback, name and ctx. Pass
> array of these structures to virtio_find_vqs() and all the way down to
> transport find_vqs() op implementation.
>
> That allows to easily extend what needs to be passed down. Also, it
> makes the code a bit more cleaner. We get rid of separate
> virtio_find_vqs_ctx() helper.
>
> This patchset does the conversion in steps, using temporary _info() op
> and helper. Note they are renamed back.
>
> Patch #1 does one forgotten conversion to virtio_find_single_vq().
> Patches #2 and #3 do preparations for find_vqs_info() op introduction.
> Patch #4 introduces new op find_vqs_info() to replace find_vqs() it also
>   introduces struct virtio_queue_info and virtio_find_vqs_info() helper.
> Patches #5 and #6 convert transports to implement find_vqs_info() op
>   that accepts array of virtio_queue_info structs.
> Patch #7 converts virtio_find_single_vq() to use the new way as well.
> Patch #8 removes original find_vqs() op.
> Patch #9 renames find_vqs_info() to find_vqs() and completes first part
>   of conversion this patches does.
> Patches #10-#17 convert virtio_find_vqs() and virtio_find_vqs_ctx()
>   users to use new virtio_find_vqs_info() helper.
> Patch #18 removes no longer used virtio_find_vqs() and
>   virtio_find_vqs_ctx() helpers.
> Patch #19 finalizes the conversion by renaming virtio_find_vqs_info()
>   to virtio_find_vqs().
>
> ---
> v1->v2:
> - added forgotten VIRTIO_SND_VQ_MAX for array size in virtio_card.c
> - s/virtio_queue_info/virtqueue_info/
> - fixed comments for struct virtqueue_info
> - rebased on top of recent code changes (virtio_fs.c)
> - see individual patches changelog for more details
>
> Jiri Pirko (19):
>   caif_virtio: use virtio_find_single_vq() for single virtqueue finding
>   virtio: make virtio_find_vqs() call virtio_find_vqs_ctx()
>   virtio: make virtio_find_single_vq() call virtio_find_vqs()
>   virtio: introduce virtio_queue_info struct and find_vqs_info() config
>     op
>   virtio_pci: convert vp_*find_vqs() ops to find_vqs_info()
>   virtio: convert find_vqs() op implementations to find_vqs_info()
>   virtio: call virtio_find_vqs_info() from virtio_find_single_vq()
>     directly
>   virtio: remove the original find_vqs() op
>   virtio: rename find_vqs_info() op to find_vqs()
>   virtio_blk: convert to use virtio_find_vqs_info()
>   virtio_console: convert to use virtio_find_vqs_info()
>   virtio_crypto: convert to use virtio_find_vqs_info()
>   virtio_net: convert to use virtio_find_vqs_info()
>   scsi: virtio_scsi: convert to use virtio_find_vqs_info()
>   virtiofs: convert to use virtio_find_vqs_info()
>   virtio_balloon: convert to use virtio_find_vqs_info()
>   virtio: convert the rest virtio_find_vqs() users to
>     virtio_find_vqs_info()
>   virtio: remove unused virtio_find_vqs() and virtio_find_vqs_ctx()
>     helpers
>   virtio: rename virtio_find_vqs_info() to virtio_find_vqs()
>
>  arch/um/drivers/virt-pci.c                    |  8 ++-
>  arch/um/drivers/virtio_uml.c                  | 12 ++--
>  drivers/block/virtio_blk.c                    | 20 +++----
>  drivers/bluetooth/virtio_bt.c                 | 13 ++--
>  drivers/char/virtio_console.c                 | 43 ++++++-------
>  drivers/crypto/virtio/virtio_crypto_core.c    | 31 ++++------
>  drivers/firmware/arm_scmi/virtio.c            | 11 ++--
>  drivers/gpio/gpio-virtio.c                    | 10 ++--
>  drivers/gpu/drm/virtio/virtgpu_kms.c          |  9 ++-
>  drivers/iommu/virtio-iommu.c                  | 11 ++--
>  drivers/net/caif/caif_virtio.c                |  8 +--
>  drivers/net/virtio_net.c                      | 34 ++++-------
>  drivers/net/wireless/virtual/mac80211_hwsim.c | 12 ++--
>  drivers/platform/mellanox/mlxbf-tmfifo.c      | 10 ++--
>  drivers/remoteproc/remoteproc_virtio.c        | 12 ++--
>  drivers/rpmsg/virtio_rpmsg_bus.c              |  8 ++-
>  drivers/s390/virtio/virtio_ccw.c              | 13 ++--
>  drivers/scsi/virtio_scsi.c                    | 32 ++++------
>  drivers/virtio/virtio_balloon.c               | 32 ++++------
>  drivers/virtio/virtio_input.c                 |  9 +--
>  drivers/virtio/virtio_mmio.c                  | 12 ++--
>  drivers/virtio/virtio_pci_common.c            | 48 ++++++++-------
>  drivers/virtio/virtio_pci_common.h            |  3 +-
>  drivers/virtio/virtio_pci_modern.c            |  5 +-
>  drivers/virtio/virtio_vdpa.c                  | 13 ++--
>  fs/fuse/virtio_fs.c                           | 22 +++----
>  include/linux/virtio_config.h                 | 60 +++++++++----------
>  net/vmw_vsock/virtio_transport.c              | 16 ++---
>  sound/virtio/virtio_card.c                    | 23 ++++---
>  29 files changed, 238 insertions(+), 302 deletions(-)
>
> --
> 2.45.2
>
