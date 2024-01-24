Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A811428F
	for <virtualization@lists.linux.dev>; Wed, 24 Jan 2024 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706079264; cv=none; b=h/uX29AuM3FFfMtFRjcETkFCZl2tTpuiYLOMhhhayyRMq7EYbK0XW9gGS1m1d4du56XWL8whiwPHF+OSjdBt/cC+d6DVY+LCM2XvJEBvcfkTG8kjUk2va4ApMGscdf5qQVLYCgbOBiDIk8QzwnCMD4O5gF5e5xO2x1x51KIP5E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706079264; c=relaxed/simple;
	bh=bXLHhCWG8ib/Q4jwzuKltCw5EdLI7RU1NLepwC90sjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tm10dUxob5qqSDLyGs1NggjBduqTrwGQ4cJy4JZaOH8IIKTNXAg0O68EmrVMmE0P90Gu4qmTX3TEeQVD3eRAUyKPXzS3InX4yjJtW5P44CKGs56MDJeVdbSiPobTgSuiFHrKopjZXPUu2luGwSWF3WiiHWid6rvbZmyf0Wkkv4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJ9hIGJD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJ9hIGJD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706079262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1zAT6ss45JjnUY5iL6ZvjV72g+BOh7hKWM+9TGSW6bc=;
	b=DJ9hIGJDQ8WCoS53pO0YYx4pNJfjGjP1om4OmDCQccBd1VL8gFJqVWVWKFslA8i1ekp1ba
	NqZBrp8TSRL/rDZEY4sYQayiClWSXtJ2O9nWe3Yd9fkf4hYtiUY83avIamXsk/TmY/8YO9
	OQxrYmOAMnKsm5OJRqXEBXYTXpfED+4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-P81S8GCfM-eKztqQOi6krw-1; Wed, 24 Jan 2024 01:54:18 -0500
X-MC-Unique: P81S8GCfM-eKztqQOi6krw-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-598b8e2b2bfso7236661eaf.2
        for <virtualization@lists.linux.dev>; Tue, 23 Jan 2024 22:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706079257; x=1706684057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zAT6ss45JjnUY5iL6ZvjV72g+BOh7hKWM+9TGSW6bc=;
        b=riZ5pSaQVwTL4/vf5BfyC7yxlaK/gnFe7jGZr5h+zEPLfrL2wFMZ4OVO2UlNq8jB9I
         Kr28+MjtHJGnx4MCrzQPoloi4xTy88Lyd6qHqwGnAQrBGDFz1IC54eueRHpTamaR6OSY
         ZvvY1f4Vix71qFns9faKtimTMhnJQanOcpi0So06P57v1TLOPndE6zXdN7PPW9LNsqkl
         0ZiMYgIPpDhoWxcrbNxS4rcBoib+IWehfL17P2T3Y2bOf5Ys0Lzg/N9Au0m2r2+k7Y8z
         rez2RpH09IX9XCYyCUm2HI7fFEPFMe/2h4E88PKFB6z/yQg+hWnKQ3ovSQQ54g2kPCyb
         xstA==
X-Gm-Message-State: AOJu0Yxsawx6UH/POs3AeDXn4U8qRzYy7xg6LB7OmboXrQK8GmI1zflR
	sQpzXniaqTvtLBdQDy8y9Iz3w2HgU2GmFt564Ho5oy1AK2qVX+/91qZRez62FQUmpQNX/65myaG
	qOS6P5Y8RqwlUA0PoVr3kqZ7uC7sc/gXm2phDn39TImWC51qosVVUEOHKbHbVRd5eSEt87f9l9U
	5K6qnYdLeEtqS76J+L5U8ePhmg0BFKJTIQNHxHbN4=
X-Received: by 2002:a05:6358:7e08:b0:176:26f9:6ee with SMTP id o8-20020a0563587e0800b0017626f906eemr6831359rwm.31.1706079257295;
        Tue, 23 Jan 2024 22:54:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4wg1Xr84P5XC3BDGgQgN8EKtSEfqpTutDbjs81fUUJ1q/bNxKOs2e6bAN2g5lhNpSmOlexAaiF/fcthWgOIY=
X-Received: by 2002:a05:6358:7e08:b0:176:26f9:6ee with SMTP id
 o8-20020a0563587e0800b0017626f906eemr6831344rwm.31.1706079257009; Tue, 23 Jan
 2024 22:54:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com> <20240116075924.42798-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240116075924.42798-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Jan 2024 14:54:05 +0800
Message-ID: <CACGkMEvv-ggpiVYeziPaPE4qK7dbZv4BxYeUkFJ9jFqzyhnx0Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> introduce virtqueue_get_buf_ctx_dma() to collect the dma info when
> get buf from virtio core for premapped mode.
>
> If the virtio queue is premapped mode, the virtio-net send buf may
> have many desc.

This feature is not specific to virtio-net, so we can let "for example ..."

> Every desc dma address need to be unmap. So here we
> introduce a new helper to collect the dma address of the buffer from
> the virtio core.

Let's explain why we can't (or suboptimal to) depend on a driver to do this=
.

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
> index 49299b1f9ec7..82f72428605b 100644
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

So the code has a check for dma:

        if (!dma)
                return false;

For whatever the case, we need a better comment here.

So we had: use_dma_api, premapped, do_unmap and dma now. I must say
I'm totally lost in this maze. It's a strong hint the API is too
complicated and needs to be tweaked.

For example, is it legal to have do_unmap be false buf DMA is true?

Here're suggestions:

1) rename premapped to buffer_is_premapped
2) rename do_unmap to buffer_need_unmap or introduce a helper

bool vring_need_unmap_buffer()
{
        return use_dma_api && !premapped;
}

3) split the getting dma info logic into an helper like vritqueue_get_dma_i=
nfo()

so we can do

if (!vring_need_unmap_buffer()) {
        virtqueue_get_dma_info()
        return;
}

4) explain why we still need to check dma assuming we had
vring_need_unmap_buffer():

If vring_need_unmap_buffer() is true, we don't need to care about dma at al=
l.

If vring_need_unmap_buffer() is false, we must return dma info
otherwise there's a leak?

> + *
> + * Return:
> + * true: the virtio core must unmap the desc
> + * false: the virtio core skip the desc unmap

Might it be better to say "It's up to the driver to unmap"?

> + */
> +static bool vring_need_unmap(struct vring_virtqueue *vq,
> +                            struct virtio_dma_head *dma,
> +                            dma_addr_t addr, unsigned int length)
> +{
> +       if (vq->do_unmap)
> +               return true;
> +
> +       if (!vq->premapped)
> +               return false;
> +
> +       if (!dma)
> +               return false;

So the logic here is odd.

if (!dma)
        return false;
...
        return false;

A strong hint to split the below getting info logic into another
helper. The root cause is the function do more than just a "yes or
no".

> +
> +       if (unlikely(dma->next >=3D dma->num)) {
> +               BAD_RING(vq, "premapped vq: collect dma overflow: %pad %u=
\n",
> +                        &addr, length);
> +               return false;
> +       }
> +
> +       dma->items[dma->next].addr =3D addr;
> +       dma->items[dma->next].length =3D length;
> +
> +       ++dma->next;
> +
> +       return false;
> +}
> +

Thanks

....

