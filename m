Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5141917F1
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751353463; cv=none; b=pwIbA9VDJ6ncO5wk7Q0ShtXlq7G6VPXBxH/3ZErh81OAx20zpMfWZ9FJAGxq0IcPwLCnA1K+O50VmmqymxsijzaDPTQx/V21xE7XJNxmzCeyqyPNwTlJNWJDF5BiFt6Lf9FQ26FkKA6BLoTqKV7EsUzAhrP6kAkHdfRhl1p59PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751353463; c=relaxed/simple;
	bh=UBHCbWmJ6VDNppNkhkingW/F47Rfl4Wt7VARuw3yTLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Qt0/IVutRjn/SMYN/DS4w2oDFhsSdnrj23T9YtL7xiUMJMa7D1QOMQRgdpNEhvMDNeaCxQmfm+3pyLWwXgfV6M/LqQ/6/xZLCG5ty6TAkyziwhDns4vFsAym9pKazZMDUWUUmIet6lyTVPvS3cTSrMFuIdv4JpnPlax/kxCJa50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mh1ZO9Kh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mh1ZO9Kh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751353460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LMIP2QD/B6zrGBadq9ojc0NiQgqEZqri/vutr0V7/RY=;
	b=Mh1ZO9KhUzb7HSmC0x5J9HVO6uuiDEIu6xVaCBojOsf2kZXbskAnFOqPowUf44tkNku32X
	9sHic39pgl7WcQwAn70yANLKWfPpZBDWlmuCmtJvSCRjdHEdsTbJiYHlFM/kTAtAmmmA2f
	76TIscM6bHViRlBS9aQ3XT2Q5PeHRhQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-GTiXDViJOJeOg13jgIlg3A-1; Tue, 01 Jul 2025 03:04:19 -0400
X-MC-Unique: GTiXDViJOJeOg13jgIlg3A-1
X-Mimecast-MFC-AGG-ID: GTiXDViJOJeOg13jgIlg3A_1751353458
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso3513193f8f.2
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 00:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751353458; x=1751958258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMIP2QD/B6zrGBadq9ojc0NiQgqEZqri/vutr0V7/RY=;
        b=aYewga3OHt6jz82qdlEYH7mUFzSLVXrsOIQKMPAdwbWqxifHBmupB/MJ6c1I4hDFlw
         hiOdvbMjgNcCBsu80LTzS5/Bg80LgVOO1k0PQFK3U6CVnCGTas+cz8NUy9WLQMWXEYfB
         8DMcS7ZiVpNz/Sa6/XfQjqKJ29pWR709GkYgFGnTbQAuBARtP6Wzk9f+SrtmsxJnZ0Jr
         tmKZWqEbSCgBxJ/vLZcBeAXNR82WqIfwR86LE8bohi1cBvd8LV2k7w/672O+2Echc/y9
         bx2hk9q0XuNnN0OaM+H5HPd5TCaR5dnxCGfXvnu6UPW9FbqrhNfdJ1AUeYPwzalNtBEo
         GAcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz0DwJUCEEIf+CFp90MbI+U5uX/amkxVdsAPLMwmpVPQobJ96PXjB6d8pbMF8YlywX6YVRq7pi5fyBRiBB1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpwmtO6dgPA6ifeU5oumbInPxelQE8QMJBdHGvvj+MCCzcvAe2
	pVULAsBwYm3bAUMFJO7mrnYMsxsJZSBerxCGBojSunYyXjur+BlHFLrsPpXugHJb9fIWxV1fH9H
	d4UNvkoIktGWB4XyFSk0ghrRHR6tqIK9lWuIEzHaPnxhYvFn1mtCVHH33kLAelDkybNQc2G1Zlv
	23
X-Gm-Gg: ASbGncvjj9kEE3WL45B4K6vNPB5eamrS6Q0sfuN3eiJqtDDq7Ub13Gs51dD6zFhbh4T
	gH/r9ZBs2peb7nwW4IlSlP2dXFlTpI4C0RkrC5kqABq5Ua/PBBeoerXnruR6vemRE0IsLKF6f85
	fjCFjnBpL/au9YUxAMmNji6J8sb84KuRD/hpyfAu+SRMuUWw5qx8ohdGWQICwlbs74X7RaYE41G
	XLz6mQ1beFzWuFqlafHcLJ1dflF6Y3aIPy9E2eUxEDjqJSgxpVNBPWzR9Y9/LroJbXNg6oSjDmk
	cpUMjnzOMUu5NbVD
X-Received: by 2002:a5d:4525:0:b0:3a5:8e0e:108b with SMTP id ffacd0b85a97d-3a90d69ccddmr12919900f8f.21.1751353457810;
        Tue, 01 Jul 2025 00:04:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiBXyBSwI/7gO4KGgVTDm7SOZoXqDq7xHmIjgvJ6o86dgNWXInCjLchqsXAjGYhqWuzah/jA==
X-Received: by 2002:a5d:4525:0:b0:3a5:8e0e:108b with SMTP id ffacd0b85a97d-3a90d69ccddmr12919861f8f.21.1751353457319;
        Tue, 01 Jul 2025 00:04:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52cbasm12485993f8f.62.2025.07.01.00.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 00:04:16 -0700 (PDT)
Date: Tue, 1 Jul 2025 03:04:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org, xieyongji@bytedance.com
Subject: Re: [PATCH 0/9] Refine virtio mapping API
Message-ID: <20250701030150-mutt-send-email-mst@kernel.org>
References: <20250701011401.74851-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250701011401.74851-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0TycyJpgwW4mILIHw40DW7Y7t34S324s2O312WDIY04_1751353458
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 01, 2025 at 09:13:52AM +0800, Jason Wang wrote:
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
> Please review.
> 
> Thanks

Cost of all this extra indirection? Especially on systems with
software spectre mitigations/retpoline enabled.

> Jason Wang (9):
>   virtio_ring: constify virtqueue pointer for DMA helpers
>   virtio_ring: switch to use dma_{map|unmap}_page()
>   virtio: rename dma helpers
>   virtio: rename dma_dev to map_token
>   virtio_ring: rename dma_handle to map_handle
>   virtio: introduce map ops in virtio core
>   vdpa: rename dma_dev to map_token
>   vdpa: introduce map ops
>   vduse: switch to use virtio map API instead of DMA API
> 
>  drivers/net/virtio_net.c                 |  32 +-
>  drivers/vdpa/alibaba/eni_vdpa.c          |   5 +-
>  drivers/vdpa/ifcvf/ifcvf_main.c          |   5 +-
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c |   6 +-
>  drivers/vdpa/pds/vdpa_dev.c              |   3 +-
>  drivers/vdpa/solidrun/snet_main.c        |   4 +-
>  drivers/vdpa/vdpa.c                      |   5 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c         |   4 +-
>  drivers/vdpa/vdpa_user/iova_domain.c     |   8 +-
>  drivers/vdpa/vdpa_user/iova_domain.h     |   5 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c       |  34 +-
>  drivers/vdpa/virtio_pci/vp_vdpa.c        |   5 +-
>  drivers/vhost/vdpa.c                     |  11 +-
>  drivers/virtio/virtio_ring.c             | 440 ++++++++++++++---------
>  drivers/virtio/virtio_vdpa.c             |  15 +-
>  include/linux/vdpa.h                     |  22 +-
>  include/linux/virtio.h                   |  36 +-
>  include/linux/virtio_config.h            |  68 ++++
>  include/linux/virtio_ring.h              |   6 +-
>  19 files changed, 476 insertions(+), 238 deletions(-)
> 
> -- 
> 2.34.1

