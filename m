Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6CD18756D
	for <virtualization@lists.linux.dev>; Tue,  5 Nov 2024 04:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730780915; cv=none; b=CJhQAkFiUSdqrnr4bpyT5M1tH6zrn9irQPsiUUYiJyF6yMpDZP+mD4GPDwrI/gWE47bMroOvEUqx4y0VM5iKvOoqdKGKlUgyCGyv461jcPUd4o8a2ERTYcwVxJlzi1M5ulIC1YxVaPJ4AFxogy894ISyKm5g0t8cbUyG0GXthw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730780915; c=relaxed/simple;
	bh=jCOhmUK6IbEIRDl5mkQTmEZnPSs5BTtuXv8Ub6PBav4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nK4OhXZvE98fEFQznelbADUA27OU1xIT1Pc05U2KwMfwEHNvUclUU+vWk9WDc361jST7BY59g8MlfleI+crrdxKPdJ8YvShPZO+pGEdDDHIYB7/bs3mGHpkoi7V8AyvczukllKrfrCpAxM191yvDNnLlGyKH0V2wW+u0bdG6rDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GPa7LcP4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPa7LcP4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730780911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2WNP/eiwwlyjDkpO5BsHHqJGwhWGw0F0hz9Z4SjJmr0=;
	b=GPa7LcP4Eb7V2qW4TX/LHanKbM/JtEYljVyxUXHtPMXy4ETvRLyvkrd+fTy906ZcyidehI
	rFWgKR3sal3eF/WOwf8bD+JO54HE1sfJ5rBPukwRGweGsF3r2w0A2uKRfKlvL+MX7v0RtI
	Ic2ZvfgR9v33BGUhb4uZDnl/+IcG8PI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-DO-54hPSPu29i67Wn2KgNw-1; Mon, 04 Nov 2024 23:28:30 -0500
X-MC-Unique: DO-54hPSPu29i67Wn2KgNw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e2bac0c38aso6536796a91.2
        for <virtualization@lists.linux.dev>; Mon, 04 Nov 2024 20:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730780910; x=1731385710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WNP/eiwwlyjDkpO5BsHHqJGwhWGw0F0hz9Z4SjJmr0=;
        b=eE4N4SvSuazO/XmgMLnIrCJ4CxvnacSyjuUc/qanYO4fyRZEIjbLTLkXYNZGKKqgb2
         bNeJJa1iKyBdQhjs3/ikysTzPeZGntLu5N8J71AMzpmbpFKa3qGJFZimU3IJkW0j3Z4f
         yab13/o0Wj6cPKLvDOLGq9pUSv3aDekiLi+d0OScByU06doxKJNTQTOVD8jJXck0CKgB
         BmtU9uNhoydtNAznxM6utNzPC8yfIsRHOtDhWHDkPDg3xSJyFI1ffR/0BSO79WL4OvmV
         HHxHLeBCFnIzZ6s/eItOFBaMIzl+NrPHbfMWp20OAVnkBa5g+ooxGxbRlyShsSjQGpEM
         DZbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK9e7jKyBk7QwVYR06+C111Id13eDZB1ohSXesyPzqCKHfmIcYOL9i2RM+qreoGBkk1YtWqlnlTpoD71m3Nw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/U60mp2WJbR7tU4cdL7hucQQc2muwLjFBs9eqRjcOyqEBllLu
	7n9CXKou3HeUYXkbqyRxv5Zt5j8E6YG3YY0ZKH9VB/Ix3t9t0+EH7vn8Ij9NGbgEvWKD1w5X9N+
	nPOQTjDFPE0o1c1qtXDS6ZYSQz5BTsYAimc+aRL964hv3Rc6W+0bUJULPoYJebsfsMPREMuML9A
	S6USSQME5uxzDjXl+vNrwrXVFcCXQW38J8mNcx/IA=
X-Received: by 2002:a17:90b:2703:b0:2e2:bad3:e393 with SMTP id 98e67ed59e1d1-2e93c1239b8mr23888096a91.3.1730780909401;
        Mon, 04 Nov 2024 20:28:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCqHP1v9rviscFmYSIZGGEle1Y/T+Yx3tavSzj80nHe7tuCQVnZBAYxDS5nHUdLvz4jkM+KeZYvQfYErHiRy0=
X-Received: by 2002:a17:90b:2703:b0:2e2:bad3:e393 with SMTP id
 98e67ed59e1d1-2e93c1239b8mr23888074a91.3.1730780908928; Mon, 04 Nov 2024
 20:28:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com> <20241030082453.97310-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241030082453.97310-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 12:28:18 +0800
Message-ID: <CACGkMEuO4Y04nLLJDXD_atHz8-yD=sk1QLYPidoJSPtAn+ycqQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 05/13] virtio_ring: introduce add api for premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:25=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Two APIs are introduced to submit premapped per-buffers.
>
> int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
>                                  struct scatterlist *sg, unsigned int num=
,
>                                  void *data,
>                                  void *ctx,
>                                  bool premapped,
>                                  gfp_t gfp);
>
> int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
>                                   struct scatterlist *sg, unsigned int nu=
m,
>                                   void *data,
>                                   bool premapped,
>                                   gfp_t gfp);
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 48 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       | 13 ++++++++++
>  2 files changed, 61 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a89295b79e66..525308d82728 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2272,6 +2272,29 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
>
> +/**
> + * virtqueue_add_outbuf_premapped - expose output buffers to other end
> + * @vq: the struct virtqueue we're talking about.
> + * @sg: scatterlist (must be well-formed and terminated!)
> + * @num: the number of entries in @sg readable by other side
> + * @data: the token identifying the buffer.
> + * @gfp: how to do memory allocations (if necessary).
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> + */
> +int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
> +                                  struct scatterlist *sg, unsigned int n=
um,
> +                                  void *data,
> +                                  bool premapped,

We don't need this parameter consider:

1) we've already had virtqueue_add_outbuf() which implies the buf has
been mapped
2) no explanation for "premapped" in the function doc

Thanks

> +                                  gfp_t gfp)
> +{
> +       return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, premapped, g=
fp);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_add_outbuf_premapped);
> +
>  /**
>   * virtqueue_add_inbuf - expose input buffers to other end
>   * @vq: the struct virtqueue we're talking about.
> @@ -2318,6 +2341,31 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
>
> +/**
> + * virtqueue_add_inbuf_premapped - expose input buffers to other end
> + * @vq: the struct virtqueue we're talking about.
> + * @sg: scatterlist (must be well-formed and terminated!)
> + * @num: the number of entries in @sg writable by other side
> + * @data: the token identifying the buffer.
> + * @ctx: extra context for the token
> + * @gfp: how to do memory allocations (if necessary).
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> + */
> +int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
> +                                 struct scatterlist *sg, unsigned int nu=
m,
> +                                 void *data,
> +                                 void *ctx,
> +                                 bool premapped,
> +                                 gfp_t gfp)
> +{
> +       return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, premapped, gf=
p);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_premapped);
> +
>  /**
>   * virtqueue_dma_dev - get the dma dev
>   * @_vq: the struct virtqueue we're talking about.
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 306137a15d07..19afa49b92d0 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -56,6 +56,19 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
>                             void *ctx,
>                             gfp_t gfp);
>
> +int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
> +                                 struct scatterlist *sg, unsigned int nu=
m,
> +                                 void *data,
> +                                 void *ctx,
> +                                 bool premapped,
> +                                 gfp_t gfp);
> +
> +int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
> +                                  struct scatterlist *sg, unsigned int n=
um,
> +                                  void *data,
> +                                  bool premapped,
> +                                  gfp_t gfp);
> +
>  int virtqueue_add_sgs(struct virtqueue *vq,
>                       struct scatterlist *sgs[],
>                       unsigned int out_sgs,
> --
> 2.32.0.3.g01195cf9f
>

