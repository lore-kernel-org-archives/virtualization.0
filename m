Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9899A1E9919
	for <virtualization@lists.linux.dev>; Mon, 25 Aug 2025 03:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756091947; cv=none; b=EmqijIObvgJjrl7Z+BOh9IQF6b8830fl/2lmym+yijHUR811t2+HfpPovxRbMh6A+umVLbpwdJV+O/NYuX/7ZudzmaVDOtirk8WW7Vxeo7PIpRkv3Puee7GpEEtcTmx1GbsfbDB06ZEaHceiXafPC4kpkhgWxbyW5upJ/aofcK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756091947; c=relaxed/simple;
	bh=PuUbuNvyeLiLOXqEFw4faj6HQcjwdCPqnfZaWCW/qkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDxovWfOpgypmVLuA5fAEqQCSgCLEz/chPYKS2FJ5d7SwgAGMXVkh5OEAJ8zy9/10aIjdQrMkqC6MrY0If8ZVJsjOZa74BRMth7FW6ZuScvCXsnWF3au+7yWh4GDYbXNgUOTlYR8saEEp3w551UcUfX50wqpET56/5tLpi54r6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KOlZUR7M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOlZUR7M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756091944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mkkr6dnBIuydFfXmGU4SfGiQP5HauMl51h1/p3ffeuI=;
	b=KOlZUR7Mzn7snHYO+J94jyyhDDSy6wvuaUtCVm0l/oHcnua2Rm3ZioUGO7U0/VM/FjlpxU
	gv5JndLtJgJI4Sf8LlgoXEkfu+tnxFVNq0iQaE6FWkN9YFIBrZPK5RBIeylRvrnubmbqUH
	ZdcP1/UfzunlvOEwv/ibtQO6QRQMFZM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-QdBV0EQaMpaJbpVvCyZDug-1; Sun, 24 Aug 2025 23:19:02 -0400
X-MC-Unique: QdBV0EQaMpaJbpVvCyZDug-1
X-Mimecast-MFC-AGG-ID: QdBV0EQaMpaJbpVvCyZDug_1756091942
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-61c6d735f25so269826a12.0
        for <virtualization@lists.linux.dev>; Sun, 24 Aug 2025 20:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756091941; x=1756696741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkkr6dnBIuydFfXmGU4SfGiQP5HauMl51h1/p3ffeuI=;
        b=I9AYk4ZXqO4D19Mw9QHk+YCmaPw4JYv5D8y6LlnyuRXRdjFoEjBWruA+E+TOJ3zDZf
         rhmdKGuOnP4E0L1UjGUvODgydyobm+PhNKgTa9Qh9iiFG9FcNbprwdwsO98TDFbHWbNT
         RHOxgW3tzJvsi4xGqd/6RsYuuoTXbXyEfaneqyQTIIhzUO7HJITktgWCPyiQudNdzY/M
         Ehqb0tvGpqIqw+4KXuJ6n+xMhc8MyiE9G4WtPRVLDf2RywhxcuFSGm8Wq8FAIOkWmxWo
         BU62CcclsPFrvvD+FHRMtgVbfE+Uilg/YUgPPj9mnbqmVXc2eP4lvhysaqpZJ0brUfw5
         7TGA==
X-Forwarded-Encrypted: i=1; AJvYcCXzTA1zQ+fJX4aA9LyJCtXS04gMYG24tKIBz8ngHDzLn7gmRx/+IPiwoY5+4q+agrvtrawq1Man+UZVy38M7A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxo2LLgQQFmsybcD9ZE1Yzp/IDFrPsVAlJP52mP0+UTkNse2QG5
	NVcO8TPUhaCYUI6R0oUnglcPksGGKMGmLvxb4JhEN7vLCfhw8H7jyUIN8Jv3BbGGk6fgNjuCKVj
	60jGKZpka2ImvLp7eR2z6i/LETtiHvp74pmYJeYNmQsgZLe+zi1mQSR4yPAzkUw1g7/L1Xce5I4
	csV1ED3lwR2sMJctVcwg1DuzGC/rAsKuISjXvjFYTOXJw=
X-Gm-Gg: ASbGncu4WTbFvbEY73UqmdQvxBGQzpPVFe2OP8uXIOoV7+Lh43C6PfjpJeLZ52PeCAP
	nq+ES4a2CkOt2Lkri6beXGqVzGpt9ZF0mFdogCGw0r2a2lEHPDj1DKzJNdNoghaZdEdKv/4e2qF
	j7UKf5OcoaBQ7UGG4kaITPMA==
X-Received: by 2002:a05:6402:40d3:b0:61c:37f3:81df with SMTP id 4fb4d7f45d1cf-61c37f38ecdmr5584826a12.24.1756091941529;
        Sun, 24 Aug 2025 20:19:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUHpr+UmaF/UPIc0miOCPZ8Y2NNYsZioaKb50s3hxgE7GvvhOQDF1VyOiPbo78gZwh2DAf5XVxFTEfTBQQ2z4=
X-Received: by 2002:a05:6402:40d3:b0:61c:37f3:81df with SMTP id
 4fb4d7f45d1cf-61c37f38ecdmr5584811a12.24.1756091941117; Sun, 24 Aug 2025
 20:19:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250821064641.5025-1-jasowang@redhat.com>
In-Reply-To: <20250821064641.5025-1-jasowang@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 25 Aug 2025 11:18:24 +0800
X-Gm-Features: Ac12FXwv6JFOS3OGRBYgKSn1mV44XXfCE_i9G8olouMUz6d6LV5uIEzVWRAeWF0
Message-ID: <CAPpAL=yicLJsn1d+_QbLDAekEQappfkvO9oUedFCG9U9hPT5iQ@mail.gmail.com>
Subject: Re: [PATCH V6 0/9] Refine virtio mapping API
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	hch@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vS4rBpr8-kSzdrlkJnFOlK9ImVl27105s6CBAOpfuHs_1756091942
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested pass with virtio-net regression tests,everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Aug 21, 2025 at 2:50=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
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
>

