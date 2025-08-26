Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8500F3451CC
	for <virtualization@lists.linux.dev>; Tue, 26 Aug 2025 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207872; cv=none; b=nbJzsyVdonm5m78tIMNSwIhgPl1o03Gz1DCpQxihD2CQ9F2ioXhJzQhWfu1k9zHTw5GPSEop5Klv/KHnuYDyGbEs36rTMSc3gUkotGuDCMieAL7wSW19wHxDCEQKAx7X11of/M/mVpgp1k+eXO9T/9hPZYdg/zFTh5Z6Xv3dihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207872; c=relaxed/simple;
	bh=RBVK/hVv7Cv492e9EIM6DicnWjPWJ0/fXcwi/pUoyNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyHTTB8iTuhaVkVdiL+A5Po2UUGtH8IE0Rn3/MolqM3QtFTlbAwtEegtHoedeyCDIbpnZgIYcf+rrDGjeL0dZbtimkAS8AA+G+gJo5pzNSVrxMcZ4w9hMnJKmsWbv2vy5+P1bXDkmdRdIkXyAbhWBi6OFzI5cfNQhBuzmSP9/BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZREqODTM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZREqODTM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756207869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ivLojxMmQNDm3XJ4T+3KolmVVz+U8oHP6tGC+J4C4o=;
	b=ZREqODTMhzrvaJGEgTf+HXGhCH2sztEHPGqH8pYppCne+OPrlVTQnXYZc7sOR6LKs+xkTS
	fqnGDllixtFbYVkNMWmujwfz6oWxiuKB6nXTZZs8L487FsvatEZd1+604cqSnF5QumNpBC
	pBtVBOh/G9rr4eiDloBYSU7s8TWG2rs=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-p8r4JBWhNjWbkILYRlVDvw-1; Tue, 26 Aug 2025 07:31:07 -0400
X-MC-Unique: p8r4JBWhNjWbkILYRlVDvw-1
X-Mimecast-MFC-AGG-ID: p8r4JBWhNjWbkILYRlVDvw_1756207867
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b471a0e5a33so8916089a12.3
        for <virtualization@lists.linux.dev>; Tue, 26 Aug 2025 04:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756207867; x=1756812667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ivLojxMmQNDm3XJ4T+3KolmVVz+U8oHP6tGC+J4C4o=;
        b=ljA1X2XrKcHeuBrEr+GR/AIHtfVWbcoehw94WDyUiRgl6fsBkry0AEonlmVfaBiqcr
         3vhJLoEPrEWb6jy5t3Dw2HFPexcFE3AQRDMFoN3gv9Ck67xLH8pcnPH8Mtf+lPkONX++
         KjtdL0ba3ArhaI90QR3Y3Lr8WYB2+A+QQreqayspiqhPL4EnAeeE8qt7gWIAR6F4kKsM
         Jygj2LwRUVGvwmtlxWAoLuf6JERnZuJdQEwcKub57hSixidK8tm5HJfXaECzMBpEa0lH
         i+ZZo/T8F9Ju1JC199TIBo32hQEQin2NHVlo2w0IASDsQDY8ilwWIFX06i7F6bpkesHH
         TE7A==
X-Forwarded-Encrypted: i=1; AJvYcCWzPqnFvgi/W+wGjuor0uV/NyW8h1rrP/cttczMaS5vCCIEwMz4D2hT61PqYSrz0dNCnC/ULe3k2n8zXTwM5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVibQMfINAsJWHdyRHn77FiQ8yjw3cQohikCVajCL+z8RV0AtV
	QWR4DRExVBsqpVO33vH/CdGvKxwlTykQI6vLZpzsNkzzmwsb/U4TLOlViMB4Z5v7jeJcja7IVDE
	Fj5O/YgTvSfF0knFsSHQ+Uo9vmpwQIaTGOCTuOLTu6OOiR5o6n1frwBea1ZpCf17x0q076zpgH6
	/vyxIY1PYRDXELw8vYXyoqbwnXI++n+EkQEN4PzMw/9wU=
X-Gm-Gg: ASbGncvW59mVodxmzGX+yTb5fjrp5ih12d0F2dC05IwDX8gW1OQPSoQGhO4T/n0d8Hf
	qQgMyCasuAeCIrcWFBiwZ/FBL5wbtTxWRrsjGFR15FpYe73hh18bA3CGuPtKo3g6D6FUS21Dmjl
	eK89Lvjiox22x8XLu8G+38
X-Received: by 2002:a17:90b:38c3:b0:321:1a89:f692 with SMTP id 98e67ed59e1d1-32515e3cfacmr19699977a91.8.1756207866514;
        Tue, 26 Aug 2025 04:31:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaf8YZgWJ0+HDYuM4XR1ubKp5FiGeOYzvPC28hH4AyjclQUqbi3rkdpwMNcpziszLugIRzaTrljK9MsLkpDmo=
X-Received: by 2002:a17:90b:38c3:b0:321:1a89:f692 with SMTP id
 98e67ed59e1d1-32515e3cfacmr19699933a91.8.1756207865950; Tue, 26 Aug 2025
 04:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250821064641.5025-1-jasowang@redhat.com>
In-Reply-To: <20250821064641.5025-1-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 26 Aug 2025 13:30:29 +0200
X-Gm-Features: Ac12FXxy-r6wPefrciOMAbkeP53SUdM8GTDTRkBaqrilIKG6Ni1qHvg3Kd5eeKw
Message-ID: <CAJaqyWcPu5KcjC72epOpM7uYPanWL2Kvi4N5Cn2QC5AHiCwApw@mail.gmail.com>
Subject: Re: [PATCH V6 0/9] Refine virtio mapping API
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, hch@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2hnoBlXROujDtlHKrLyxmAQ4M5b5tyA6uW-UI3e5Npc_1756207867
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 8:46=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Hi all:
>
> Virtio used to be coupled with DMA API. This works fine for the device
> that do real DMA but not the others. For example, VDUSE nees to craft
> with DMA API in order to let the virtio-vdpa driver to work.
>
> This series tries to solve this issue by introducing the mapping API
> in the virtio core. So transport like vDPA can implement their own
> mapping logic without the need to hack with DMA API. The mapping API
> are abstracted with a new map operations in order to be re-used by
> transprot or device. So device like VDUSE can implement its own
> mapping loigc.
>
> For device that uses DMA (for example PCI device), the virtio core
> will still call DMA API directly without the need of implementing map
> ops per device/transport.
>
> Please review.
>
> Changes since V5:
>
> - Rename mapping_token to virtio_map
> - Do not use opaque void * pointer, just use a forward decalration of
>   vduse_iova_domain
> - Remove unused variable and typo fixes
>
> Changes since V4:
>
> - Rename map_token to mapping_token
> - Introduce a union container for opaque token as well as the DMA
>   device so we won't lose the type safety
> - Do not try to set DMA mask for VDUSE device
> - Introduce a new mapper_error op for API completeness
>
> Changes since V3:
>
> - Fix build error of PDS vDPA driver
>
> Changes since V2:
>
> - Drop VDUSE dependenct for HAS_DMA and ARCH_HAS_DMA_OPS
>
> Changes since V1:
>
> - Fix build error of mlx5_vdpa driver
>
>
> Jason Wang (9):
>   virtio_ring: constify virtqueue pointer for DMA helpers
>   virtio_ring: switch to use dma_{map|unmap}_page()
>   virtio: rename dma helpers
>   virtio: introduce virtio_map container union
>   virtio_ring: rename dma_handle to map_handle
>   virtio: introduce map ops in virtio core
>   vdpa: support virtio_map
>   vdpa: introduce map ops
>   vduse: switch to use virtio map API instead of DMA API
>
>  drivers/net/virtio_net.c                 |  28 +-
>  drivers/vdpa/Kconfig                     |   8 +-
>  drivers/vdpa/alibaba/eni_vdpa.c          |   5 +-
>  drivers/vdpa/ifcvf/ifcvf_main.c          |   5 +-
>  drivers/vdpa/mlx5/core/mr.c              |   4 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c        |  15 +-
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c |   6 +-
>  drivers/vdpa/pds/vdpa_dev.c              |   5 +-
>  drivers/vdpa/solidrun/snet_main.c        |   8 +-
>  drivers/vdpa/vdpa.c                      |   5 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c         |   4 +-
>  drivers/vdpa/vdpa_user/iova_domain.c     |   2 +-
>  drivers/vdpa/vdpa_user/iova_domain.h     |   2 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c       |  79 ++--
>  drivers/vdpa/virtio_pci/vp_vdpa.c        |   5 +-
>  drivers/vhost/vdpa.c                     |   6 +-
>  drivers/virtio/virtio_ring.c             | 459 ++++++++++++++---------
>  drivers/virtio/virtio_vdpa.c             |  20 +-
>  include/linux/vdpa.h                     |  25 +-
>  include/linux/virtio.h                   |  46 ++-
>  include/linux/virtio_config.h            |  72 ++++
>  include/linux/virtio_ring.h              |   7 +-
>  22 files changed, 531 insertions(+), 285 deletions(-)
>
> --
> 2.31.1
>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

