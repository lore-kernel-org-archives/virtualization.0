Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263F9DF6E
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbL2KZ3S"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 95E3840567
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 08:34:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 95E3840567
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IbL2KZ3S
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ENbCr0rXtGDK
	for <virtualization@lists.linux-foundation.org>;
	Thu, 11 Jan 2024 08:34:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 856A640323
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 08:34:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 856A640323
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704962062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fbUkvBoj8gxLrACYWyhfe3FGuAwpnKYJCy4ANl1OWAQ=;
	b=IbL2KZ3SOVgPfc5+bQca+KkWSr8q295DVikxCMZ8gDPGJ7vOljoGuD8uLMJoKpInElVOsO
	5EWXBuhtYo0bp8nSQnXyImukRZUxeVjqEYHbx0EVGGJGLpTjzsS+YPS6Bsehu0Pe3RJv6k
	txFOOlgW1neA2uyU39hhWhcTAFbwhgs=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-BMIhkKv5Mn-8c4-ve2yFLw-1; Thu, 11 Jan 2024 03:34:21 -0500
X-MC-Unique: BMIhkKv5Mn-8c4-ve2yFLw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3bd575251bbso73092b6e.1
        for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 00:34:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704962060; x=1705566860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbUkvBoj8gxLrACYWyhfe3FGuAwpnKYJCy4ANl1OWAQ=;
        b=NWid1krHXPyRrBj5X+ndI3UY6MMDBz8ABtyYZ5/try6xrl+qPSpSfpl03dOTLG+EdQ
         HVQWKpIwmu+weKKtUWHYma7L3wXqGZVpM58WqI8l+Dop9i22Ssv7RcFsCyK4r7Lxs65q
         utgwgV4PipeSShqI4oAM5JHTLnO25p4OXuHcLdXiY3ZxwVtKDW6TpJFYdxAAoXNubJ7r
         NWaF5UH21+O1iGsmYkuc7M5HoYp/ZZnGERosLAu879GBOG/b8VblLBcrdHGqGPjl6R4t
         YREWRQ4acI6nDjkzOHkxI+XDkFG3G1FJ4RpLuSVTQERqUYSnTaidZPLFYg3/PHRtYIgd
         7Vfg==
X-Gm-Message-State: AOJu0YyWItmjeiSHYO17KrD2bOPbwvHoVkYucNvieZxGlfDzSWXAlasj
	vB2pwRJ0FWinLCNLN9Z4Y9W5/OAE4MvTBvrpiIwggHUqpZkzvgXmLj1mEV6oRoAz6ryf/0tXxc6
	Z1mlrdrIl2EaQz7kvjFPTGmVrurWtslW3A5M0oGsfxhlT3/F98UtxVLgBmHuwarYs6g==
X-Received: by 2002:a05:6808:128b:b0:3bd:3225:4be3 with SMTP id a11-20020a056808128b00b003bd32254be3mr801918oiw.71.1704962060419;
        Thu, 11 Jan 2024 00:34:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBRprWzEj5DmMX32LaMUs1+qfaZPU6alpcl5pE809RY8gFTAICGop4IB9CnQEXSpHBKdpk2dfokvLOl5dCxe8=
X-Received: by 2002:a05:6808:128b:b0:3bd:3225:4be3 with SMTP id
 a11-20020a056808128b00b003bd32254be3mr801909oiw.71.1704962060197; Thu, 11 Jan
 2024 00:34:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com> <20231229073108.57778-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231229073108.57778-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 16:34:09 +0800
Message-ID: <CACGkMEvaTr1iT1M7DXN1PNOAZPM75BGv-wTOkyqb-7Sgjshwaw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 06/27] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 3:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> introduce virtqueue_get_buf_ctx_dma() to collect the dma info when
> get buf from virtio core for premapped mode.
>
> If the virtio queue is premapped mode, the virtio-net send buf may
> have many desc. Every desc dma address need to be unmap. So here we
> introduce a new helper to collect the dma address of the buffer from
> the virtio core.
>
> Because the BAD_RING is called (that may set vq->broken), so
> the relative "const" of vq is removed.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 174 +++++++++++++++++++++++++----------
>  include/linux/virtio.h       |  16 ++++
>  2 files changed, 142 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 51d8f3299c10..1374b3fd447c 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -362,6 +362,45 @@ static struct device *vring_dma_dev(const struct vri=
ng_virtqueue *vq)
>         return vq->dma_dev;
>  }
>
> +/*
> + *     use_dma_api premapped -> do_unmap
> + *  1. false       false        false
> + *  2. true        false        true
> + *  3. true        true         false
> + *
> + * Only #3, we should return the DMA info to the driver.

Btw, I guess you meant "#3 is false" here?

And could we reduce the size of these 3 * 3 matrices? It's usually a
hint that the code is not optmized.

Thanks

