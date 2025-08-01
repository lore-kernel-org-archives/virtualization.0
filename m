Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB02561A2
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Aug 2025 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754054371; cv=none; b=XfwWvPONONtpjDSYmIPS0st/YQFiapU4c/3op+n/I/7S0HApyexa2eK84Jk3DuFjnmMLYLuYLiIGRHv0ExY9cwgm30bdBwryG1rZirKNusjJIXFGapWm+iHct2i9lDJXajTnFWmnJBKf/QIbpGrT3Gtw0U6zmGmlLeMQqTxXt8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754054371; c=relaxed/simple;
	bh=9NerjbYLuoyk/RKlTefAdXQzfB6NwPQkXItsvzNMysk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hFQ1ncjxkLqScqxLkXodgNn2uzjTVe8WG7Vx1rauhoGIjph05UD6oRfcvQn29cC0fIymRl7htgjuGlbeAhbjxOEJVala3viqkgkfP8y5aSWig3kcvH41ptgjc5FOoNqMITRvq/Ngqdv2PLqduTikQennC6p0bggzX8kL7q7C2l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/erIdn8; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/erIdn8"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6152410A3
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Aug 2025 13:19:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xpjqkR88cnEg for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Aug 2025 13:19:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D08B741353
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D08B741353
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h/erIdn8
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D08B741353
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Aug 2025 13:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754054367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YbLdGk22JzqbKEhu/iJYhhYYSjQLfdAdGKKqzGB0K4Q=;
	b=h/erIdn8AC5N+4DTPS6T32kj9AdqcCh2zo02eVznsQRoY975vnMM75b0IFmvqMX8vjIni5
	ILilS0D3eKxfZWzIhHy6kU7gF7/GMlggaT6SbsgNisUyw0AUZeWJwG4MkVJcrlD/KaG5v1
	nSMeKMZCL+yBqr5/CDNthmtP/wUHZDM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-hGOJE47MPMitPnucLuccQw-1; Fri, 01 Aug 2025 09:19:26 -0400
X-MC-Unique: hGOJE47MPMitPnucLuccQw-1
X-Mimecast-MFC-AGG-ID: hGOJE47MPMitPnucLuccQw_1754054364
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so10904165e9.3
        for <virtualization@lists.linux-foundation.org>; Fri, 01 Aug 2025 06:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754054364; x=1754659164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbLdGk22JzqbKEhu/iJYhhYYSjQLfdAdGKKqzGB0K4Q=;
        b=kGkHSJJjbhnybGrKS04g8BBXYVZEQQhOpSG6/f8mI7S/AXfZt7T17K4bxJWn39rQM+
         g1IizMnNYsJrtHpL0hPqkd+UMcogdn9pdVbIsWuinSn+nI6il0jqCr6snbEKjzn4Cy/2
         +pxDML6jqcrL7kHkO0gflYLdrFqq1JYQ+2/ckFM61SU2DSMVd7c/aOW08u+W9nF8TGvy
         o8qExuDj8PGdXuwlfkmouq0VHSuoFYiEhFUhKm2SBsiG8g66Wmzpo8leiogb0J06ZqpH
         Qt1c+sa09VZy7lHOn+lB+9+NCwdegAgNN888WFgWmwWfBWJ/L/5F7yfchyVCwTu14udB
         j/JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAGWZl5eLo1cRZ3KvaOGf67AfPNPrIozviX3n73mjFEHwrizt3v6YKpLJS0IfZ7Nc/6f/+5u++hpohF4rMSQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyGF4/A0lr9uQkFPKGZP94DF9Na+rFjYeCfTjNAlq6Y65IbWJix
	4Ls2M1uXXibJ0IfDJm3DkJHRRp/GId+dzwYitNksAloHYnUmyLBDZqBv2av/FoowuSyko02ENql
	6WuFg/MGvXdniK4R4cIbzPyzM07PataF3S9WH10wjHEyOfiT6us1Hbj5oS3ZpON6vTfH/l1l6FE
	/gNYH8BdA=
X-Gm-Gg: ASbGncuE608I/DkzN/sjcSuyZz0uG6HCGge0U/1wIo1Xs5iogtdG4MjsQryP85UPq4z
	JYzLopHO/FZC5qk+bVz/AxlMxbH8wubyaJdSWNT+POlIN2cEQglr26h1/sNMIZ87zOxi+t8DjrA
	+EcaNjCNdE1IKLUMUFPF0E4nTvfK1tk1Yz3zHONuYOfgn20bI4RktLYiwmofSLY+LNLwj6Ail8f
	5ULNAKePj756a4B3oRzcA9NsoYw12zJkwx8L0ZLNRN1cNrG9EDM/zjWhxORRLRdsBMgfi+QltFe
	WmJtt0agVmlG+gcTqpiwkg7rnfr0K19R
X-Received: by 2002:a05:600c:3143:b0:458:b2c4:b3df with SMTP id 5b1f17b1804b1-458b2c4b55cmr7065095e9.33.1754054364134;
        Fri, 01 Aug 2025 06:19:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmZq6SGlI97jjT0xUjwHMnLWo6+mq6NBKRj1ThNjjX/DhoWqBXT6UeApleX2c0S5DJT9fufQ==
X-Received: by 2002:a05:600c:3143:b0:458:b2c4:b3df with SMTP id 5b1f17b1804b1-458b2c4b55cmr7064765e9.33.1754054363595;
        Fri, 01 Aug 2025 06:19:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458af917d20sm11817765e9.2.2025.08.01.06.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:19:23 -0700 (PDT)
Date: Fri, 1 Aug 2025 09:19:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	acourbot@google.com, alok.a.tiwari@oracle.com,
	anders.roxell@linaro.org, dtatulea@nvidia.com, eperezma@redhat.com,
	eric.auger@redhat.com, gnurou@gmail.com, jasowang@redhat.com,
	jonah.palmer@oracle.com, kraxel@redhat.com, leiyang@redhat.com,
	linux@treblig.org, lulu@redhat.com, michael.christie@oracle.com,
	parav@nvidia.com, si-wei.liu@oracle.com, stable@vger.kernel.org,
	viresh.kumar@linaro.org, wangyuli@uniontech.com, will@kernel.org,
	wquan@redhat.com, xiaopei01@kylinos.cn
Subject: Re: [GIT PULL] virtio, vhost: features, fixes
Message-ID: <20250801091454-mutt-send-email-mst@kernel.org>
References: <20250801070032-mutt-send-email-mst@kernel.org>
 <20250801090250-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250801090250-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zcgtvqzJDgcYtIjHQThpZd5p4NYyzMeo1powTjdjv1U_1754054364
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 01, 2025 at 09:03:35AM -0400, Michael S. Tsirkin wrote:
> On Fri, Aug 01, 2025 at 07:00:32AM -0400, Michael S. Tsirkin wrote:
> > The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf1911:
> > 
> >   Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> > 
> > for you to fetch changes up to c7991b44d7b44f9270dec63acd0b2965d29aab43:
> > 
> >   vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers (2025-07-17 08:33:09 -0400)
> 
> Oh no I am sorry! Please ignore, a bad commit snuck in there - it still
> needs maintainer approval, and I forgot.
> Will resend.
> 

Sent v2 now.
I wanted to apologize for this. I mistakenly put bad commits on the
branch called "master" and when looking at "git log" I did not notice
I was only looking at commits since "master" and not
"origin/master".

I should have reviewed the list of changes in the email before
sending, but as it's autogenerated as opposed the cover letter part
that I write myself, I was focusing on the latter and missed the
bad commits in the former. A less for me to remember to pay attention to that
part, as well.

Thanks!

> > ----------------------------------------------------------------
> > virtio, vhost: features, fixes
> > 
> > vhost can now support legacy threading
> > 	if enabled in Kconfig
> > vsock memory allocation strategies for
> > 	large buffers have been improved,
> > 	reducing pressure on kmalloc
> > vhost now supports the in-order feature
> > 	guest bits missed the merge window
> > 
> > fixes, cleanups all over the place
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > ----------------------------------------------------------------
> > Alexandre Courbot (1):
> >       media: add virtio-media driver
> > 
> > Alok Tiwari (4):
> >       virtio: Fix typo in register_virtio_device() doc comment
> >       vhost-scsi: Fix typos and formatting in comments and logs
> >       vhost: Fix typos
> >       vhost-scsi: Fix check for inline_sg_cnt exceeding preallocated limit
> > 
> > Anders Roxell (1):
> >       vdpa: Fix IDR memory leak in VDUSE module exit
> > 
> > Cindy Lu (1):
> >       vhost: Reintroduce kthread API and add mode selection
> > 
> > Dr. David Alan Gilbert (2):
> >       vhost: vringh: Remove unused iotlb functions
> >       vhost: vringh: Remove unused functions
> > 
> > Dragos Tatulea (2):
> >       vdpa/mlx5: Fix needs_teardown flag calculation
> >       vdpa/mlx5: Fix release of uninitialized resources on error path
> > 
> > Gerd Hoffmann (1):
> >       drm/virtio: implement virtio_gpu_shutdown
> > 
> > Jason Wang (3):
> >       vhost: fail early when __vhost_add_used() fails
> >       vhost: basic in order support
> >       vhost_net: basic in_order support
> > 
> > Michael S. Tsirkin (6):
> >       virtio: document ENOSPC
> >       pci: report surprise removal event
> >       virtio: fix comments, readability
> >       virtio: pack config changed flags
> >       virtio: allow transports to suppress config change
> >       virtio: support device disconnect
> > 
> > Mike Christie (1):
> >       vhost-scsi: Fix log flooding with target does not exist errors
> > 
> > Pei Xiao (1):
> >       vhost: Use ERR_CAST inlined function instead of ERR_PTR(PTR_ERR(...))
> > 
> > Viresh Kumar (2):
> >       virtio-mmio: Remove virtqueue list from mmio device
> >       virtio-vdpa: Remove virtqueue list
> > 
> > WangYuli (1):
> >       virtio: virtio_dma_buf: fix missing parameter documentation
> > 
> > Will Deacon (9):
> >       vhost/vsock: Avoid allocating arbitrarily-sized SKBs
> >       vsock/virtio: Validate length in packet header before skb_put()
> >       vsock/virtio: Move length check to callers of virtio_vsock_skb_rx_put()
> >       vsock/virtio: Resize receive buffers so that each SKB fits in a 4K page
> >       vsock/virtio: Rename virtio_vsock_alloc_skb()
> >       vsock/virtio: Move SKB allocation lower-bound check to callers
> >       vhost/vsock: Allocate nonlinear SKBs for handling large receive buffers
> >       vsock/virtio: Rename virtio_vsock_skb_rx_put()
> >       vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers
> > 
> >  MAINTAINERS                                |    6 +
> >  drivers/gpu/drm/virtio/virtgpu_drv.c       |    8 +-
> >  drivers/media/Kconfig                      |   13 +
> >  drivers/media/Makefile                     |    2 +
> >  drivers/media/virtio/Makefile              |    9 +
> >  drivers/media/virtio/protocol.h            |  288 ++++++
> >  drivers/media/virtio/scatterlist_builder.c |  563 ++++++++++++
> >  drivers/media/virtio/scatterlist_builder.h |  111 +++
> >  drivers/media/virtio/session.h             |  109 +++
> >  drivers/media/virtio/virtio_media.h        |   93 ++
> >  drivers/media/virtio/virtio_media_driver.c |  959 ++++++++++++++++++++
> >  drivers/media/virtio/virtio_media_ioctls.c | 1297 ++++++++++++++++++++++++++++
> >  drivers/pci/pci.h                          |    6 +
> >  drivers/vdpa/mlx5/core/mr.c                |    3 +
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c          |   12 +-
> >  drivers/vdpa/vdpa_user/vduse_dev.c         |    1 +
> >  drivers/vhost/Kconfig                      |   18 +
> >  drivers/vhost/net.c                        |   88 +-
> >  drivers/vhost/scsi.c                       |   24 +-
> >  drivers/vhost/vhost.c                      |  377 +++++++-
> >  drivers/vhost/vhost.h                      |   30 +-
> >  drivers/vhost/vringh.c                     |  118 ---
> >  drivers/vhost/vsock.c                      |   15 +-
> >  drivers/virtio/virtio.c                    |   25 +-
> >  drivers/virtio/virtio_dma_buf.c            |    2 +
> >  drivers/virtio/virtio_mmio.c               |   52 +-
> >  drivers/virtio/virtio_pci_common.c         |   45 +
> >  drivers/virtio/virtio_pci_common.h         |    3 +
> >  drivers/virtio/virtio_pci_legacy.c         |    2 +
> >  drivers/virtio/virtio_pci_modern.c         |    2 +
> >  drivers/virtio/virtio_ring.c               |    4 +
> >  drivers/virtio/virtio_vdpa.c               |   44 +-
> >  include/linux/pci.h                        |   45 +
> >  include/linux/virtio.h                     |   13 +-
> >  include/linux/virtio_config.h              |   32 +
> >  include/linux/virtio_vsock.h               |   46 +-
> >  include/linux/vringh.h                     |   12 -
> >  include/uapi/linux/vhost.h                 |   29 +
> >  include/uapi/linux/virtio_ids.h            |    1 +
> >  kernel/vhost_task.c                        |    2 +-
> >  net/vmw_vsock/virtio_transport.c           |   20 +-
> >  net/vmw_vsock/virtio_transport_common.c    |    3 +-
> >  42 files changed, 4186 insertions(+), 346 deletions(-)
> >  create mode 100644 drivers/media/virtio/Makefile
> >  create mode 100644 drivers/media/virtio/protocol.h
> >  create mode 100644 drivers/media/virtio/scatterlist_builder.c
> >  create mode 100644 drivers/media/virtio/scatterlist_builder.h
> >  create mode 100644 drivers/media/virtio/session.h
> >  create mode 100644 drivers/media/virtio/virtio_media.h
> >  create mode 100644 drivers/media/virtio/virtio_media_driver.c
> >  create mode 100644 drivers/media/virtio/virtio_media_ioctls.c

