Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94C3184
	for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 22:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758492948; cv=none; b=d+nZaT/5LwtNyKooSEugVCnS0mwvPMXLQFd0mY7kISQcUleiWsPOTdXjxvIWZVeJO2+80UcC4jGXbMQAvmpzt4NEfEo5jeSK+d9JONwl6MoFzDA9QeN2d2acd3kyNRNqkm7PIZRsqvFRk3g8FDwMhojeh/AHdITsec62MJxNuxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758492948; c=relaxed/simple;
	bh=UE2+sCKcRM0D9EqELobfcIehPj4nrD3ENegoQdfRKL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hswl6Mz4DvVIgjzdEEr+9IszEpx7KQqssQoFBhPmS4XkLjOyf6Xgl+4YQ9z1oUeRWvblo56Q3YMwjcvQ9GhwI0d7Wpk+pJBhQDv8FJKA/+PJcv6VZ4gr8x1PlUlAH+GPZm6JM/AvLKyAnSy5OdFdX31NDJgZktT9qD5OqjlLlcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQ9xsGHv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQ9xsGHv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758492945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=issag+Emck8nYiAlp365ctL+iXmBkoGCcqhig3VAAWc=;
	b=dQ9xsGHvaj5ho2kstHaimm8Ls1JpwfqSSIJgMzz9tU5kXpgugBZs0QEIunrvGp0uWAcjYq
	46oRWOFb4JYVeAjwEmkkDeqX9ygbvcvTm39kpJzVH4tLRDeTIEs3bTf9f4md/8/YkB/OqV
	7Vacertw0Hmt6GMRdGqFAzhKqxvTCpk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-44Hm2sl0MbeU0TLBrSc-Tg-1; Sun, 21 Sep 2025 18:15:44 -0400
X-MC-Unique: 44Hm2sl0MbeU0TLBrSc-Tg-1
X-Mimecast-MFC-AGG-ID: 44Hm2sl0MbeU0TLBrSc-Tg_1758492943
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ef21d77d2eso3060434f8f.1
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 15:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758492943; x=1759097743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=issag+Emck8nYiAlp365ctL+iXmBkoGCcqhig3VAAWc=;
        b=Dq2lZk0HKs+EJwF45lY8IsZ4QYyayVYdZ/buL84xa7PCS0akAiP/Y5pJYABQ2SnMgZ
         WIhQmtcPRGok/YD1KTrSAqOi733ok2IZCZS7Edj3Nqh6xRRlCQRoqgnLSWHKMzyDCDC5
         MzD8is0GpEIf1nA55mEphTfFrDX5s8RBqNsaT6CQuxTeiDzZUxZkDKhdZ0HAwKb7dzbl
         gX1wdmgI6e4MEOrOr7+ThE3VswpIufpu/EaiX9/eBhjpnPE7ArkFylNGLBCN3YL5Zuko
         BVigiIlkIHXyT732u6lpAvhavRNzWV86NiDRLqVUIrKPzD/ScFOdFLheyV4OB3l1CFz1
         1VdA==
X-Forwarded-Encrypted: i=1; AJvYcCUGY+auQYAsPv1f52IV6T/XyFK1GeFKUUhBYiuu0UVd6cDlhLXcgsAl2NT4H5yae82aTG83HB2UvhRJGOXvsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDrbpznLZQ9bPPIfB9/n6wd29XxD9eNDiv0MaCHFj9nimmdcaG
	hAowKEvHdpoqt5pL9BJdaOIM2a4zh802a1Zb+is4ajw7+FhdYbQ6weZJT3WKzaFiZt1Slzl9r/n
	C7eDBiGIptUVHTmlwRXdMY1axoTNOvJJDirRDuz/VmqYmqUEa1uYjomT6aoWwa1VPdGo3
X-Gm-Gg: ASbGncsy4kgiQ6yDB/o7+lCKD9Lfhh9MtDghUGruXfHRTwWNFEnBigp1NEWS7JOCVgs
	3FEbuVbx9YTKPZ4lt+hwKKJMmjfcdhbVRkJ6rAZkRTnIeWe/iBXh8yKrVZynpfBqsjjTGzBKnFL
	uGjzXaO4u1AHe/JaH/TKhgmjr+w46wNfCrnnEodFGDgegcSVKNNMiKkeBklXNnfJir6tXIWtdqO
	tXJ5fdHWcqG+Y04AhPSbvk3RLa9pm+GmMZwVRvtd0XujRtrQrp2S3aafqrazxuDvmyCXnwnlMVx
	JF7/K/GSYEXQ6/qb+ZYJFXoXM8GthkKkWZs=
X-Received: by 2002:a05:6000:2486:b0:3e9:f852:491 with SMTP id ffacd0b85a97d-3ee86b845b9mr10991337f8f.56.1758492943124;
        Sun, 21 Sep 2025 15:15:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5jSHy9tCekUFhaB50y2EweyLHn5Bx3Q8YuDkLzLOfeR9o5bHpT9MJjrrnHFOUxqNdrfiSsw==
X-Received: by 2002:a05:6000:2486:b0:3e9:f852:491 with SMTP id ffacd0b85a97d-3ee86b845b9mr10991326f8f.56.1758492942751;
        Sun, 21 Sep 2025 15:15:42 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407d33sm17370478f8f.18.2025.09.21.15.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 15:15:41 -0700 (PDT)
Date: Sun, 21 Sep 2025 18:15:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org
Subject: Re: [PATCH V6 0/9] Refine virtio mapping API
Message-ID: <20250921181435-mutt-send-email-mst@kernel.org>
References: <20250821064641.5025-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250821064641.5025-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cbyYM7gN_C1f-7yW3krsxnoOsp0j3QSOjUUaDHQu1ok_1758492943
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 21, 2025 at 02:46:32PM +0800, Jason Wang wrote:
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

I sent some typos i found.
Pls send fixups on top to fix them so testing in linux-next is not invalidated.
Thanks!



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

