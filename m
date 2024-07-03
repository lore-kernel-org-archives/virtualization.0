Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A6A17554A
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720011046; cv=none; b=YG0ri8CV/PDjGFjmFVce9h1QBRbYoEFIV6Zl1Y20NdTCNPewmptYP7HM33Lb3OmbQs3wJ5h8JWDmhpdgpfKUd3Ok4GhndPL78IDvCQoRzp3wXiZ5QPiFYdTNWdtYEoL1hibeqxJSAeZuO7Uf7ChGIcBq6Hn4QHAomhhvRYlNC0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720011046; c=relaxed/simple;
	bh=wDJwEnKUFIhZr6a8YRWR7LevGjkAaLoYa+X0JOtjSzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hWtuVsABFFtWxdAzwuW75/HodnVSRwBJFr/9i6Bl88X28f190b6kzDkgMHZ/9zY/8xzhC+ml4gs8PtmI1HeJBf7GNKIvOuM2taGfhNkc49Xtdy2hh06pDLscJ/yRf3W2PvUKWTLLEaq9uxm5AbLtyzmvbU5BEfzPtq2xxZ+jLQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fYCo/AYG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYCo/AYG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720011043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SyMhpeZgEzTQhARUwygRkUnQ6Ejep36qq0S++BEP2HI=;
	b=fYCo/AYG5qp8zgzP05opQPj5lXwifA8hrSiRlo/mQQDzQnOlr/50LHCGM2GmlVLfuLHNP2
	4UPeP57GxqSnLGnzLw9nIEd07CafrAFmZdU8PYtFHxhdlGFGlxTdwprgDEK/lJKgTeFYMC
	3CSywSBxlD1Ff7pNyG2CvHJolSL6xLA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-2PFihK2DOeqWiFspA0zFQw-1; Wed, 03 Jul 2024 08:50:42 -0400
X-MC-Unique: 2PFihK2DOeqWiFspA0zFQw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42566c4aa0fso42627075e9.1
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 05:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720011041; x=1720615841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyMhpeZgEzTQhARUwygRkUnQ6Ejep36qq0S++BEP2HI=;
        b=EfY+kcTgHxQ9SfZdp66ilQX0zJvX6/8PA6sDkHso7zp6ZkPp6MM0zNrfY8AbKrg3/A
         UYp7pjXQ20bJ0Eue8NiNYrbyykeqDr03zH0rDdrO1NPyJpqC4euleQsopFKFls4JCwun
         KRazEiaHuKRzCA504oZ+jFiNzueht4RXXImIGbFXJATliaSrRyRG8k7/TH1m9UtOUtTJ
         MmfbIWsndYiC63WCFPDtzsP7HJasafxaXfa+JqI1CGGcG2CRW2/nP3xqsqz7N4MaRavM
         LmoCJITmsUUQU458j86mOoxlpJ5nq1NwZTjITHwGj3JCVhU1yjQJC7m51anhq+bP6qw6
         gLbw==
X-Gm-Message-State: AOJu0Yzffx6WfYG6XnkcR1td2VSZf4QzT92R5GYg4Nef0RksyAqQIJme
	ICLX3qB9YB6SHD2+a8qrTURPHbeZgeHbi9gixG/1Fp1aye8s8sqa22FJIW3/VQOB0W6AOwEAbbx
	vvpfv/QXWS6gqSr/5y1V47wGjF+qEsJtHyPnvuckhtG0sTMpsU/PcD6AtsJvn+uX3
X-Received: by 2002:a05:600c:705:b0:424:a4f1:8c3e with SMTP id 5b1f17b1804b1-4257a074b50mr86251195e9.34.1720011041173;
        Wed, 03 Jul 2024 05:50:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvPrfmjm8jpMpHjJfar6a9f7sZxl9FGztTUH8i4T3HiDBZtt7VIbcGk15GMnWEiXI+ouSGZw==
X-Received: by 2002:a05:600c:705:b0:424:a4f1:8c3e with SMTP id 5b1f17b1804b1-4257a074b50mr86251025e9.34.1720011040544;
        Wed, 03 Jul 2024 05:50:40 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cdc5csm15795732f8f.18.2024.07.03.05.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:50:40 -0700 (PDT)
Date: Wed, 3 Jul 2024 08:50:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio 00/19] virtio: consolidate vq info args of
 find_vqs()
Message-ID: <20240703084954-mutt-send-email-mst@kernel.org>
References: <20240703123913.969202-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240703123913.969202-1-jiri@resnulli.us>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 03, 2024 at 02:38:54PM +0200, Jiri Pirko wrote:
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

Thanks a lot Jiri, looks very good.
Some minor comments.


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
>  drivers/virtio/virtio_pci_common.c            | 49 ++++++++-------
>  drivers/virtio/virtio_pci_common.h            |  4 +-
>  drivers/virtio/virtio_pci_modern.c            |  5 +-
>  drivers/virtio/virtio_vdpa.c                  | 13 ++--
>  fs/fuse/virtio_fs.c                           | 22 +++----
>  include/linux/virtio_config.h                 | 60 +++++++++----------
>  net/vmw_vsock/virtio_transport.c              | 16 ++---
>  sound/virtio/virtio_card.c                    | 23 ++++---
>  29 files changed, 240 insertions(+), 302 deletions(-)
> 
> -- 
> 2.45.2

