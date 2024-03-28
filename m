Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820CF23768
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711609032; cv=none; b=nYJ/Df9D9j+3t9j1otwWmvN05/ShsSEiIv43Gowm3qc/AmOqqjTNKRBMWJwWsluM/gpKeNTDkMWeRSdEmZpvOLilxVHOWAiSZLTjaYrLAWGWkwxm8orz1J5SKY8ITBcFXU0bTpuwqGupUROWDx9DeTuv/L7b62FdVE/K9PchDmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711609032; c=relaxed/simple;
	bh=N4cxrIOodXFQsySnYSPbqwTqKx+K6fmyBks90JBXXcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EL4WSghd3jv2YUaOzzLPSJQ3riLFR589EWFmGyPSJYChGV+8JRFbjcocm1R5TJ1LIthyDCJC4BFxtTlesmDwzo503mzfSwoieTYH5+hFSjwZcAkK+ffdb1WqcbsADNPfYQAc6ULyrN4UzkP5OcG52qEkx2MiXCJ57s1J0tNLOxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Io8ntg4s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Io8ntg4s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711609029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aAF5BWLYLUl1WtsxmRNfOE7/6Pm25dxLAI5kYse1bsE=;
	b=Io8ntg4sSs1rhi/N7kTkQvZRj873H/dPIrWMDDqI6nsLrpAn2se90DpbuZBTwrZrHdFNS2
	lixs5YmNLH/px/9wKwnXiBGUVEnxMl7UAV/62XgceJWQnAgBobqrhwiccoC5YWErVB9kjB
	+vjQ3hxc5lmS/wI9bflSKgUFXsClFWo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-AnQpvMF3PUizMXt6vbieeQ-1; Thu, 28 Mar 2024 02:57:07 -0400
X-MC-Unique: AnQpvMF3PUizMXt6vbieeQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29de982f09aso536767a91.1
        for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 23:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711609026; x=1712213826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAF5BWLYLUl1WtsxmRNfOE7/6Pm25dxLAI5kYse1bsE=;
        b=cNk3j0lvMrBMB7s2tLgZmUPr8qM7GWaJHWY51fDMPP/dQR7Wvn7Yy8H7y7+htiodc3
         ojOGu+806/4FH+eJ3kPebP0tQgIWZ2rtQKB8qm+MciBX9mxELmVPqf69zF8x/a4rjZaN
         1NkBqtEi0bbyi4NhWU1zSwVhpaYudBY6EK05u/y04Js8hcXGgyhZ65+S1J6znok+Qck8
         ARb9uZYgHAEyusUTuHAAD2+ayfusP74jBsetAUJjcQcBgBKNy4ac0n5VDegomZctbXvZ
         ryfmu6xtjLa7Oexg4OBFfh+y3ejPciGtW1bGiBaZlTNLrpK/LtTnNZtrmn26YpVc3M0d
         RJ4A==
X-Gm-Message-State: AOJu0YzHTjk/szVSauK7WL/tU2AkSOPwXqK2s3bR/A/gg9XG7CZ7Ohaz
	1O1h9j8APorSCnAzanSXGqZOdJOVcLf8zI2iAOzor9DAWs+/XfK4oV2QDJdNYMg8pP7i/ZTJtrX
	Xm53IG9RvtSdsJMAZ5f3+doVYB9HfVPIWFaVNaptQci+pL95HCTazTJdAZJoyFxNuKPm6TESp15
	ARPJitxWWuMQslIrnjC0hyTGaMuZ3rjqXC71nVCjE=
X-Received: by 2002:a17:90a:d70b:b0:2a1:ff27:3fa3 with SMTP id y11-20020a17090ad70b00b002a1ff273fa3mr1207802pju.28.1711609026463;
        Wed, 27 Mar 2024 23:57:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIyK8ML46kX2gNZLuSos+Fqv11Z6R20m/msywDP7iCSCvzFu9xr33X4VxBwH7mChXBdbw3VjSXgUw7MDUHr8A=
X-Received: by 2002:a17:90a:d70b:b0:2a1:ff27:3fa3 with SMTP id
 y11-20020a17090ad70b00b002a1ff273fa3mr1207789pju.28.1711609026146; Wed, 27
 Mar 2024 23:57:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com> <20240327111430.108787-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240327111430.108787-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 14:56:55 +0800
Message-ID: <CACGkMEvGTiZUepzRL9dMNaxZUenKzrqPnnd9594aWjF-KcXCrw@mail.gmail.com>
Subject: Re: [PATCH vhost v6 03/10] virtio_ring: packed: structure the
 indirect desc table
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> This commit structure the indirect desc table.
> Then we can get the desc num directly when doing unmap.
>
> And save the dma info to the struct, then the indirect
> will not use the dma fields of the desc_extra. The subsequent
> commits will make the dma fields are optional.

Nit: It's better to add something like "so we can't reuse the
desc_extra[] array"

> But for
> the indirect case, we must record the dma info.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 61 +++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a2838fe1cc08..e3343cf55774 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -74,7 +74,7 @@ struct vring_desc_state_split {
>
>  struct vring_desc_state_packed {
>         void *data;                     /* Data for callback. */
> -       struct vring_packed_desc *indir_desc; /* Indirect descriptor, if =
any. */
> +       struct vring_desc_extra *indir_desc; /* Indirect descriptor, if a=
ny. */

Should be "DMA info with indirect descriptor, if any" ?

>         u16 num;                        /* Descriptor list length. */
>         u16 last;                       /* The last desc state in a list.=
 */
>  };
> @@ -1243,10 +1243,13 @@ static void vring_unmap_desc_packed(const struct =
vring_virtqueue *vq,
>                        DMA_FROM_DEVICE : DMA_TO_DEVICE);
>  }
>
> -static struct vring_packed_desc *alloc_indirect_packed(unsigned int tota=
l_sg,
> -                                                      gfp_t gfp)
> +static struct vring_desc_extra *alloc_indirect_packed(unsigned int total=
_sg,
> +                                                     gfp_t gfp)
>  {
> -       struct vring_packed_desc *desc;
> +       struct vring_desc_extra *in_extra;
> +       u32 size;
> +
> +       size =3D sizeof(*in_extra) + sizeof(struct vring_packed_desc) * t=
otal_sg;
>
>         /*
>          * We require lowmem mappings for the descriptors because
> @@ -1255,9 +1258,10 @@ static struct vring_packed_desc *alloc_indirect_pa=
cked(unsigned int total_sg,
>          */
>         gfp &=3D ~__GFP_HIGHMEM;
>
> -       desc =3D kmalloc_array(total_sg, sizeof(struct vring_packed_desc)=
, gfp);
>
> -       return desc;
> +       in_extra =3D kmalloc(size, gfp);
> +
> +       return in_extra;
>  }
>
>  static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> @@ -1268,6 +1272,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                                          void *data,
>                                          gfp_t gfp)
>  {
> +       struct vring_desc_extra *in_extra;
>         struct vring_packed_desc *desc;
>         struct scatterlist *sg;
>         unsigned int i, n, err_idx;
> @@ -1275,10 +1280,12 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
>         dma_addr_t addr;
>
>         head =3D vq->packed.next_avail_idx;
> -       desc =3D alloc_indirect_packed(total_sg, gfp);
> -       if (!desc)
> +       in_extra =3D alloc_indirect_packed(total_sg, gfp);
> +       if (!in_extra)
>                 return -ENOMEM;
>
> +       desc =3D (struct vring_packed_desc *)(in_extra + 1);
> +
>         if (unlikely(vq->vq.num_free < 1)) {
>                 pr_debug("Can't add buf len 1 - avail =3D 0\n");
>                 kfree(desc);
> @@ -1315,17 +1322,16 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
>                 goto unmap_release;
>         }
>
> +       if (vq->use_dma_api) {
> +               in_extra->addr =3D addr;
> +               in_extra->len =3D total_sg * sizeof(struct vring_packed_d=
esc);
> +       }

Any reason why we don't do it after the below assignment of descriptor fiel=
ds?

> +
>         vq->packed.vring.desc[head].addr =3D cpu_to_le64(addr);
>         vq->packed.vring.desc[head].len =3D cpu_to_le32(total_sg *
>                                 sizeof(struct vring_packed_desc));
>         vq->packed.vring.desc[head].id =3D cpu_to_le16(id);
>
> -       if (vq->use_dma_api) {
> -               vq->packed.desc_extra[id].addr =3D addr;
> -               vq->packed.desc_extra[id].len =3D total_sg *
> -                               sizeof(struct vring_packed_desc);
> -       }
> -
>         vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT |
>                 vq->packed.avail_used_flags;
>
> @@ -1356,7 +1362,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>         /* Store token and indirect buffer state. */
>         vq->packed.desc_state[id].num =3D 1;
>         vq->packed.desc_state[id].data =3D data;
> -       vq->packed.desc_state[id].indir_desc =3D desc;
> +       vq->packed.desc_state[id].indir_desc =3D in_extra;
>         vq->packed.desc_state[id].last =3D id;
>
>         vq->num_added +=3D 1;
> @@ -1375,7 +1381,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                 vring_unmap_desc_packed(vq, &desc[i]);
>
>  free_desc:
> -       kfree(desc);
> +       kfree(in_extra);
>
>         END_USE(vq);
>         return -ENOMEM;
> @@ -1589,7 +1595,6 @@ static void detach_buf_packed(struct vring_virtqueu=
e *vq,
>                               unsigned int id, void **ctx)
>  {
>         struct vring_desc_state_packed *state =3D NULL;
> -       struct vring_packed_desc *desc;
>         unsigned int i, curr;
>         u16 flags;
>
> @@ -1616,27 +1621,27 @@ static void detach_buf_packed(struct vring_virtqu=
eue *vq,
>                 if (ctx)
>                         *ctx =3D state->indir_desc;
>         } else {
> -               const struct vring_desc_extra *extra;
> -               u32 len;
> +               struct vring_desc_extra *in_extra;
> +               struct vring_packed_desc *desc;
> +               u32 num;
> +
> +               in_extra =3D state->indir_desc;
>
>                 if (vq->use_dma_api) {
> -                       extra =3D &vq->packed.desc_extra[id];
>                         dma_unmap_single(vring_dma_dev(vq),
> -                                        extra->addr, extra->len,
> +                                        in_extra->addr, in_extra->len,
>                                          (flags & VRING_DESC_F_WRITE) ?
>                                          DMA_FROM_DEVICE : DMA_TO_DEVICE)=
;

Can't we just reuse vring_unmap_extra_packed() here?

Thanks


>                 }
>
> -               /* Free the indirect table, if any, now that it's unmappe=
d. */
> -               desc =3D state->indir_desc;
> -
>                 if (vring_need_unmap_buffer(vq)) {
> -                       len =3D vq->packed.desc_extra[id].len;
> -                       for (i =3D 0; i < len / sizeof(struct vring_packe=
d_desc);
> -                                       i++)
> +                       num =3D in_extra->len / sizeof(struct vring_packe=
d_desc);
> +                       desc =3D (struct vring_packed_desc *)(in_extra + =
1);
> +
> +                       for (i =3D 0; i < num; i++)
>                                 vring_unmap_desc_packed(vq, &desc[i]);
>                 }
> -               kfree(desc);
> +               kfree(in_extra);
>                 state->indir_desc =3D NULL;
>         }
>  }
> --
> 2.32.0.3.g01195cf9f
>

