Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743AD3E47B
	for <virtualization@lists.linux.dev>; Mon, 22 Sep 2025 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758503180; cv=none; b=KNhvbSdrFdLU1nPgqxSXRAhxCW31UQLgI3M7fEB871Z4XFJsUrwGqE+7g7tLp8Zblo1EdQnKD69WwrF9qwXv8xmdWXSAzknsLuXYVlTO0JKrDelyTG2XmJgzSulEWTACSEGacF4H7Wu9IsyPAzHjcxcPZ8g8dLR7IMa/7+pNQNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758503180; c=relaxed/simple;
	bh=y/p2o6rvKbyU1DRs4WihioqxuiP3IGdmZf1j+OmTGQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ug1Mkw57icCWzqrprNWCvP0ammpXwRKeNm2SBSyE++YSG7OGuljDxY/MQ+6yvi1VyIxAk469Zg7Y6efTY3wgw7LEw6gMGLMeyINb9I5rgYcgE3EHupEINZvy74ikcmtGfEfngwsA3TEmuEAjt/Q/L0VXjLQR82bBy/mL9lZr9NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPfhzPwa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPfhzPwa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758503177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDg8R1Cj1vMrEJ0X4UgoObYXEm8Kkjuao5nW9kUfAbI=;
	b=KPfhzPwabFQYHPJv8h2vWEuGoHm8u0MQ36W40nVVDoyeP1tJDlhxa+ZZc3ZKsq6R31OZ0A
	0GBrFhuzBLDafMrqaQCEb0o298UgQi+qO3PO0iFLH/kdYmDd1vEz8qChv+Mw6sKgaXJcwT
	B6FFLsI3qygqCOTQmGFZ20EGj3vfDPw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-N6W_9GhCPYaZs51JNUtk5Q-1; Sun, 21 Sep 2025 21:06:16 -0400
X-MC-Unique: N6W_9GhCPYaZs51JNUtk5Q-1
X-Mimecast-MFC-AGG-ID: N6W_9GhCPYaZs51JNUtk5Q_1758503174
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3307af9b55eso3020772a91.2
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 18:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758503174; x=1759107974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDg8R1Cj1vMrEJ0X4UgoObYXEm8Kkjuao5nW9kUfAbI=;
        b=bNaeAaworLcsH5n2t3XpT3gV33eXJ+q8DwSsrSmGspi+zmquyqAFXctieH9yV/08st
         TfZDnvcsBWar+km6P37Pk/gfVSYFM+IHj2JrnWCmu9OxIu/oglSe7OzPsh1JH51eNPXA
         J7obDvDG0PUR1qU8DpfVP+a4jhG0Oaoa1tFgaMdJGYwcsnotAz4Jrg5soqucx9LVJ174
         5EARyjeR+NlKI+mzLhoI0iIwzJpGnR/9G8XNqKmaaad2nKKpl7aW/slq0vmfzYB5eQ7T
         PB4tbt9+MeUOhXe5/mKiPlM9FRslCmhSeKx5uo9YKy1kpycm8kfn8eF+acmj+6/OpLAr
         rSsg==
X-Forwarded-Encrypted: i=1; AJvYcCW1LJg6dRQl5aUdd4oJB4v+0y/GcyQ2hPvjrC5X8E6hdjKVR9gN5/xt26Bjx4RLEIkJZNy3yXhSve2aAiAvzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFJAM+XcowUJ8NK2cv5gzx4iKZb8giHJj0f3hoq2t+OgPpxdDC
	Dp5VMkRRU9XWE8BoH9Mf5BdTSjO0BCOTrHPklk+FrdWAZLlPUgISDoqvaKoY+49Jkodn3cqO08t
	qd6owkXNbrJVV4A73uVx4zU9NTi5R7FXmVXi/YT6XxPITTqpqk769lfdKVXzEa4otDgrRiye6j2
	Pu3+rF14nkV6pUtueb8NRUZUvhK56lh7eH0+Og/1Kh4VA=
X-Gm-Gg: ASbGncsjy0JzIVTUdJffo+ahbF0pvQUheWkomnDfTFNu9g49KO4MtIoaJKqdXEqdPVj
	j+uF5DYNtDC5BirFhEq+0RaHOZfaAY94zB6NRXKOwOaD9IyUQfwXkaHgRKXoSqBKyfhwxPp8g3U
	BUufZIGPA+tDUv2M9WNK9BpA==
X-Received: by 2002:a17:90b:3e86:b0:32b:cafc:e339 with SMTP id 98e67ed59e1d1-33098398714mr12444782a91.36.1758503174208;
        Sun, 21 Sep 2025 18:06:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIYrw1/gpupdolfZKeQfxe7cKWIQL7P2V2Qr4ck7OGNhqg20Js+9UFm18BbbDDJwQ4MNtpPBZsSsZF4Ocl2nk=
X-Received: by 2002:a17:90b:3e86:b0:32b:cafc:e339 with SMTP id
 98e67ed59e1d1-33098398714mr12444765a91.36.1758503173820; Sun, 21 Sep 2025
 18:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250821064641.5025-1-jasowang@redhat.com> <20250921181435-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250921181435-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Sep 2025 09:06:02 +0800
X-Gm-Features: AS18NWCRJf-df9McSDQkbpImLBRr2jkffKi3bG-8b6_NZGULobt_GkYNY9v5ehA
Message-ID: <CACGkMEuEOOkv7pkSo21mdqPpRZJm59SQX_ZGG1Br_v_iN-vWiA@mail.gmail.com>
Subject: Re: [PATCH V6 0/9] Refine virtio mapping API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	hch@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _NDJPQgJoHMUdRDHydw93QASjcc29oqwDqkPgsJfyDg_1758503174
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 6:15=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Aug 21, 2025 at 02:46:32PM +0800, Jason Wang wrote:
> > Hi all:
> >
> > Virtio used to be coupled with DMA API. This works fine for the device
> > that do real DMA but not the others. For example, VDUSE nees to craft
> > with DMA API in order to let the virtio-vdpa driver to work.
> >
> > This series tries to solve this issue by introducing the mapping API
> > in the virtio core. So transport like vDPA can implement their own
> > mapping logic without the need to hack with DMA API. The mapping API
> > are abstracted with a new map operations in order to be re-used by
> > transprot or device. So device like VDUSE can implement its own
> > mapping loigc.
> >
> > For device that uses DMA (for example PCI device), the virtio core
> > will still call DMA API directly without the need of implementing map
> > ops per device/transport.
> >
> > Please review.
>
> I sent some typos i found.
> Pls send fixups on top to fix them so testing in linux-next is not invali=
dated.
> Thanks!
>

Will do, I see the HEAD in linux-next is

vdpa: support virtio_map

Is this intended? Would you want me to send fixes on top?

Thanks

>
>
> > Changes since V5:
> >
> > - Rename mapping_token to virtio_map
> > - Do not use opaque void * pointer, just use a forward decalration of
> >   vduse_iova_domain
> > - Remove unused variable and typo fixes
> >
> > Changes since V4:
> >
> > - Rename map_token to mapping_token
> > - Introduce a union container for opaque token as well as the DMA
> >   device so we won't lose the type safety
> > - Do not try to set DMA mask for VDUSE device
> > - Introduce a new mapper_error op for API completeness
> >
> > Changes since V3:
> >
> > - Fix build error of PDS vDPA driver
> >
> > Changes since V2:
> >
> > - Drop VDUSE dependenct for HAS_DMA and ARCH_HAS_DMA_OPS
> >
> > Changes since V1:
> >
> > - Fix build error of mlx5_vdpa driver
> >
> >
> > Jason Wang (9):
> >   virtio_ring: constify virtqueue pointer for DMA helpers
> >   virtio_ring: switch to use dma_{map|unmap}_page()
> >   virtio: rename dma helpers
> >   virtio: introduce virtio_map container union
> >   virtio_ring: rename dma_handle to map_handle
> >   virtio: introduce map ops in virtio core
> >   vdpa: support virtio_map
> >   vdpa: introduce map ops
> >   vduse: switch to use virtio map API instead of DMA API
> >
> >  drivers/net/virtio_net.c                 |  28 +-
> >  drivers/vdpa/Kconfig                     |   8 +-
> >  drivers/vdpa/alibaba/eni_vdpa.c          |   5 +-
> >  drivers/vdpa/ifcvf/ifcvf_main.c          |   5 +-
> >  drivers/vdpa/mlx5/core/mr.c              |   4 +-
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c        |  15 +-
> >  drivers/vdpa/octeon_ep/octep_vdpa_main.c |   6 +-
> >  drivers/vdpa/pds/vdpa_dev.c              |   5 +-
> >  drivers/vdpa/solidrun/snet_main.c        |   8 +-
> >  drivers/vdpa/vdpa.c                      |   5 +-
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c         |   4 +-
> >  drivers/vdpa/vdpa_user/iova_domain.c     |   2 +-
> >  drivers/vdpa/vdpa_user/iova_domain.h     |   2 +-
> >  drivers/vdpa/vdpa_user/vduse_dev.c       |  79 ++--
> >  drivers/vdpa/virtio_pci/vp_vdpa.c        |   5 +-
> >  drivers/vhost/vdpa.c                     |   6 +-
> >  drivers/virtio/virtio_ring.c             | 459 ++++++++++++++---------
> >  drivers/virtio/virtio_vdpa.c             |  20 +-
> >  include/linux/vdpa.h                     |  25 +-
> >  include/linux/virtio.h                   |  46 ++-
> >  include/linux/virtio_config.h            |  72 ++++
> >  include/linux/virtio_ring.h              |   7 +-
> >  22 files changed, 531 insertions(+), 285 deletions(-)
> >
> > --
> > 2.31.1
>

