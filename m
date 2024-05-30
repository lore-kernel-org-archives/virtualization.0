Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927791761BC
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070007; cv=none; b=VGePQZ52ecI/x/mudJ3fX0h/BoEr/Oc9xalvCbn3OOPCoP94r8FE7zbrmdR5n88Qs+7G9WYZSlrHvx0CoxUf9jVpBX7XPCCtQNxu26Mgdlj7J9SaLo1a+SfmSYpkNF70MdSHMrunT98+ykSuVnX4R5PKTQOIbqkU1l0ErTGFrjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070007; c=relaxed/simple;
	bh=a5RoNmw3LEtmCv84g3foK1aKa72JGF8L3MC+ZOG8Gz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JkwJ1D1M3tDhqvZpQLsD7IwwJqb3xY0duIR0UFB6Ul33fkb4UqEqjTUFGcw4fPJymvPssUHzCszbmHOI33MUIVUMmh7H3uYamLWdoE7Ud1pIU/5+0HCesHyz+Q+P2B4CBg5l1/lSn24NOgwBFUKy3izMuLgodYssSFgKvrUdZWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ju7MmyE6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ju7MmyE6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717070004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QaJ08O7JdNI93KJGm73XMZhzelj+VajVlq/Gw0RkfEU=;
	b=Ju7MmyE6qG9/MOUH5DUqudiPA4RyUzZTYBSMXu2oM5w4IKirQEIrsFGdveekV+Ukrx3MCF
	DvVeJooWgUUsJjGGIOh7b/8V76El64LbqaWJhN5ATnqaUSZshFvslo25vJIYlvuSRCQxn9
	jmB91y1sb7micHRZ5K3KyguEv6FNpfA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-jx06R_7aOoK9zTZcuTys1Q-1; Thu, 30 May 2024 07:53:23 -0400
X-MC-Unique: jx06R_7aOoK9zTZcuTys1Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42114bcc41cso5691145e9.0
        for <virtualization@lists.linux.dev>; Thu, 30 May 2024 04:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717070002; x=1717674802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaJ08O7JdNI93KJGm73XMZhzelj+VajVlq/Gw0RkfEU=;
        b=hMi0Ca1B9cRl6YfkVikwmB/RK/M2Wt57KvEVHB7Z5vih1uaBa+HMDcC7vQ/3nxrSKT
         /+FQGS+qCJeB/e5zHVcVjJW7L4KuFpmvErn+9oXIfdQz3T7dz3yhgye1ehIlKfy/J+uK
         Wm4fXorain0fbm3B48QmW69Vd6NgV3X5i3wBt2ZeK0sQrTbYC8UCAERqSwYALk3W36R6
         SRANyEmFyz55iSVfzxqM2FSl5DLFl/aVDgg23wJIZraG4vywLTuCKI9lmqSQnMV/RxJb
         7BEiqhJN15XdwDfxpFr3lQmKM/dP1nQ+v58VIx4INUIpmRhja825K8ogf8Mpm26FypLI
         6kbA==
X-Forwarded-Encrypted: i=1; AJvYcCU5cxPMe/5pwjYr/XYhBiHG9lPmHY67WuPtrHI8H6GsH+9qkUtEDkMFN384yfWixWJpjokLVm77S6XWgQ6v9wDm7e9oxAxXQ3D4p6+rHwU=
X-Gm-Message-State: AOJu0YxDW0o6B30Jto07xAIvA74P2l1+dOf9qwZTJ+K2q1/5tgw7br5D
	NgSKmXUpraA2GlUpSkqKC58vnq+Wci+bsqw4uvKqr/IXusbM21r03yewAhvnZkdmdZRtsehY32d
	0E9e7TQ7nyLzNb/XeQELcOR9/PJ1T94346mcxXKocZnuw18fXKCpiKP11yQ9rSxuX
X-Received: by 2002:a05:600c:3c9e:b0:41f:eba9:ced4 with SMTP id 5b1f17b1804b1-42127817a46mr21345955e9.16.1717070002021;
        Thu, 30 May 2024 04:53:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEceci61giza+Mfylw+1jbKk7Vb1KMIlL8tVEyZVSFKJGK4nLI8VQ/9gqBvA2EqJRwnujJi8g==
X-Received: by 2002:a05:600c:3c9e:b0:41f:eba9:ced4 with SMTP id 5b1f17b1804b1-42127817a46mr21345615e9.16.1717070001403;
        Thu, 30 May 2024 04:53:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:fb20:c957:3427:ac94:f0a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212706ea02sm23212155e9.30.2024.05.30.04.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 04:53:20 -0700 (PDT)
Date: Thu, 30 May 2024 07:53:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 00/12] virtnet_net: prepare for af-xdp
Message-ID: <20240530075003-mutt-send-email-mst@kernel.org>
References: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 30, 2024 at 07:23:54PM +0800, Xuan Zhuo wrote:
> This patch set prepares for supporting af-xdp zerocopy.
> There is no feature change in this patch set.
> I just want to reduce the patch num of the final patch set,
> so I split the patch set.
> 
> Thanks.
> 
> v2:
>     1. Add five commits. That provides some helper for sq to support premapped
>        mode. And the last one refactors distinguishing xmit types.
> 
> v1:
>     1. resend for the new net-next merge window
> 


It's great that you are working on this but
I'd like to see the actual use of this first.

> 
> Xuan Zhuo (12):
>   virtio_net: independent directory
>   virtio_net: move core structures to virtio_net.h
>   virtio_net: add prefix virtnet to all struct inside virtio_net.h
>   virtio_net: separate virtnet_rx_resize()
>   virtio_net: separate virtnet_tx_resize()
>   virtio_net: separate receive_mergeable
>   virtio_net: separate receive_buf
>   virtio_ring: introduce vring_need_unmap_buffer
>   virtio_ring: introduce dma map api for page
>   virtio_ring: introduce virtqueue_dma_map_sg_attrs
>   virtio_ring: virtqueue_set_dma_premapped() support to disable
>   virtio_net: refactor the xmit type
> 
>  MAINTAINERS                                   |   2 +-
>  drivers/net/Kconfig                           |   9 +-
>  drivers/net/Makefile                          |   2 +-
>  drivers/net/virtio/Kconfig                    |  12 +
>  drivers/net/virtio/Makefile                   |   8 +
>  drivers/net/virtio/virtnet.h                  | 248 ++++++++
>  .../{virtio_net.c => virtio/virtnet_main.c}   | 596 +++++++-----------
>  drivers/virtio/virtio_ring.c                  | 118 +++-
>  include/linux/virtio.h                        |  12 +-
>  9 files changed, 606 insertions(+), 401 deletions(-)
>  create mode 100644 drivers/net/virtio/Kconfig
>  create mode 100644 drivers/net/virtio/Makefile
>  create mode 100644 drivers/net/virtio/virtnet.h
>  rename drivers/net/{virtio_net.c => virtio/virtnet_main.c} (93%)
> 
> --
> 2.32.0.3.g01195cf9f

