Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D36D4E1C9
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711609025; cv=none; b=I1ZxODMrr82ktxbk12GpoLnm/vK89Gv+0DCjCeqbbcNlyi8KpXR/DPNIAUAfkn7Nqv1uvvcZIve6PkhsZrfb1T/6OQ4SgwqVFIH7ZJ5Eotpa3m5ssNZ/fVOI6qEGN1jMGNvhOgVzVh/Jj0fxRbI571bR4xOF87OxbJPxVnC00ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711609025; c=relaxed/simple;
	bh=iXkcM/kbPxaG7Dl6XHZroMQUMorZdH4sUWDFUR+CYd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jk0TgVjE6BWwzXM61tCa0y4tBPX6qZRZDGb7r9WWRIiDXI4laPRfc88PJV+Xp10KdcgX+7GBoEVNPtjpAWVMsnB7NQKv2acPz2pz3DFwEtG0r4gvb7JQNucIehaen7Iw3kWA+ivBreNrFRxQVIhKepmpr7QbPz79GcpbVYtS/R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PI6JPjUP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PI6JPjUP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711609022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nsK18a2ILjQix0qPhtSFbid27rM+BJi4PiLxBjwl3pQ=;
	b=PI6JPjUPKj2WqtqnbFi0ksfmfIp3aBWJoAbe+B1PuVwi6IPV+cY2eVAz+2w6c4Vx3X6r9m
	lUCHqG5FUkL6vJ3AHsGs+8tma1tZhAbh8z2x3cNNNSRAnszBIW0IG2M1yKSfKBB+R50svS
	Wtxj8Cctgye6Xs4eNHq9PiNWhFQJvJg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-9AGg57iiNTqPlh07xVXN0g-1; Thu, 28 Mar 2024 02:57:00 -0400
X-MC-Unique: 9AGg57iiNTqPlh07xVXN0g-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6e7149bc12fso670186b3a.3
        for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 23:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711609019; x=1712213819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsK18a2ILjQix0qPhtSFbid27rM+BJi4PiLxBjwl3pQ=;
        b=LD8UoQL9JW5iKzNrHQ+XmX5p0WDot/hDMYNakJ7xlGBkrHY6C8fTzNGdz8lPFJB6Ee
         xSB8U11qtJ1H4dW0BPaNDUtNmUO+OA3XOaJxxS1CcOfsIOsziTMWTtFKaPETW4Mon5/5
         gZixV6URsrs5IpHtbFFkteqtVm/YjWgWUq63y4KBLS+q4gMzA8uHA4KZT2+93xkEHfX4
         Zz4lWNLogBMH4eZ9S131NDPNGAzztCffTdJAG5TSKf7eiZd8Pwj3HN3JkGWJEeTMLHfw
         OrO/pUdfoIHq2iOCseM+mBMQNVqnxC/XRgpvFzRS3i/vL46bybhLSoEy7PChmyIWVlJw
         vJ3Q==
X-Gm-Message-State: AOJu0Yys4tAdSRVfaGGd+hEkIqyAWWtlqqG/TTsWft6fhugHQ7veP3C3
	VJOzcKRN7rBy26ftpHaFpFJ/7zeZRVs1iu5PzFeFIoYqWzlHl+T1rQVBoXjsJl1+qarTnEeCKmr
	GtG78yTB26KCikTkOdjcj4q7FRmOn82MSj45gX6CuUEHQCtU1oiTZlE+yjn7nPb6Yx+4J+kWgl9
	R/wD8cB1opSQ1VZsO8jTvB0ylsKR7dL94jl74X+s0=
X-Received: by 2002:a05:6a20:841b:b0:1a3:a89b:a70a with SMTP id c27-20020a056a20841b00b001a3a89ba70amr2186894pzd.37.1711609019282;
        Wed, 27 Mar 2024 23:56:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEddMUjn8tC2lHIpEO3qvN67cxCYRi/vADbnxsX/QgXJYkiSLSMf4a+H2E0/VdbN6DSIYhQ1sbi4bTpiV3OlWY=
X-Received: by 2002:a05:6a20:841b:b0:1a3:a89b:a70a with SMTP id
 c27-20020a056a20841b00b001a3a89ba70amr2186874pzd.37.1711609018938; Wed, 27
 Mar 2024 23:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com> <20240327111430.108787-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240327111430.108787-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 14:56:47 +0800
Message-ID: <CACGkMEsG7+mNx4WqhAuhrpk1bhLEwrTzngT5q=CZ_aHkzRasVg@mail.gmail.com>
Subject: Re: [PATCH vhost v6 02/10] virtio_ring: packed: remove double check
 of the unmap ops
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
> In the functions vring_unmap_extra_packed and vring_unmap_desc_packed,
> multiple checks are made whether unmap is performed and whether it is
> INDIRECT.
>
> These two functions are usually called in a loop, and we should put the
> check outside the loop.
>
> And we unmap the descs with VRING_DESC_F_INDIRECT on the same path with
> other descs, that make the thing more complex. If we distinguish the
> descs with VRING_DESC_F_INDIRECT before unmap, thing will be clearer.
>
> For desc with VRING_DESC_F_INDIRECT flag:
> 1. only one desc of the desc table is used, we do not need the loop
>     Theoretically, indirect descriptors could be chained.
>     But now, that is not supported by "add", so we ignore this case.
> 2. the called unmap api is difference from the other desc
> 3. the vq->premapped is not needed to check
> 4. the vq->indirect is not needed to check
> 5. the state->indir_desc must not be null

It doesn't explain the connection to the goal of this series. If it's
not a must I'd suggest moving it to a separate patch.

>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Rethink this, it looks to me it would complicate the codes furtherly.

For example, vring_map_xxx() helpers will check premappred and
use_dma_api by itself. But in the case of vring_unmap() you want to
move those checks to the caller. This will result in tricky codes that
are hard to understand.

We need to be consistent here.

If we try to optimize unmap we need to optimize map as well. But
generally it would complicate the logic of the caller if we want to
let the caller to differ. Ideally, the caller of those function should
know nothing about use_dma_api, premapped and other.

> ---
>  drivers/virtio/virtio_ring.c | 78 ++++++++++++++++++------------------
>  1 file changed, 40 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 03360073bd4a..a2838fe1cc08 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1214,6 +1214,7 @@ static u16 packed_last_used(u16 last_used_idx)
>         return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
>  }
>
> +/* caller must check vring_need_unmap_buffer() */
>  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>                                      const struct vring_desc_extra *extra=
)
>  {
> @@ -1221,33 +1222,18 @@ static void vring_unmap_extra_packed(const struct=
 vring_virtqueue *vq,
>
>         flags =3D extra->flags;
>
> -       if (flags & VRING_DESC_F_INDIRECT) {
> -               if (!vq->use_dma_api)
> -                       return;
> -
> -               dma_unmap_single(vring_dma_dev(vq),
> -                                extra->addr, extra->len,
> -                                (flags & VRING_DESC_F_WRITE) ?
> -                                DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -       } else {
> -               if (!vring_need_unmap_buffer(vq))
> -                       return;
> -
> -               dma_unmap_page(vring_dma_dev(vq),
> -                              extra->addr, extra->len,
> -                              (flags & VRING_DESC_F_WRITE) ?
> -                              DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -       }
> +       dma_unmap_page(vring_dma_dev(vq),
> +                      extra->addr, extra->len,
> +                      (flags & VRING_DESC_F_WRITE) ?
> +                      DMA_FROM_DEVICE : DMA_TO_DEVICE);
>  }
>
> +/* caller must check vring_need_unmap_buffer() */
>  static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
>                                     const struct vring_packed_desc *desc)
>  {
>         u16 flags;
>
> -       if (!vring_need_unmap_buffer(vq))
> -               return;
> -
>         flags =3D le16_to_cpu(desc->flags);
>
>         dma_unmap_page(vring_dma_dev(vq),
> @@ -1323,7 +1309,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                         total_sg * sizeof(struct vring_packed_desc),
>                         DMA_TO_DEVICE);
>         if (vring_mapping_error(vq, addr)) {
> -               if (vq->premapped)
> +               if (!vring_need_unmap_buffer(vq))
>                         goto free_desc;

I would do this to make it much more easier to be read and avoid the warn:

if (vring_mapping_error(vq, addr))
        goto unmap_release;

unmap_release:
        if (vring_need_unmap_buffer(vq))
                for (i =3D 0, xxx)
free_desc:
        kfree(desc);

or it could be

unmap_release:
      if (!vring_need_unmap_buffer(vq))
            goto free_desc;

Still tricky but better.

>
>                 goto unmap_release;
> @@ -1338,10 +1324,11 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
>                 vq->packed.desc_extra[id].addr =3D addr;
>                 vq->packed.desc_extra[id].len =3D total_sg *
>                                 sizeof(struct vring_packed_desc);
> -               vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT=
 |
> -                                                 vq->packed.avail_used_f=
lags;
>         }
>
> +       vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT |
> +               vq->packed.avail_used_flags;

An example of the tricky code, I think you do this because you want to
differ indirect in detach_buf_packed():

flags =3D vq->packed.desc_extra[id].flags;


> +
>         /*
>          * A driver MUST NOT make the first descriptor in the list
>          * available before all subsequent descriptors comprising
> @@ -1382,6 +1369,8 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>  unmap_release:
>         err_idx =3D i;
>
> +       WARN_ON(!vring_need_unmap_buffer(vq));
> +
>         for (i =3D 0; i < err_idx; i++)
>                 vring_unmap_desc_packed(vq, &desc[i]);
>
> @@ -1475,12 +1464,13 @@ static inline int virtqueue_add_packed(struct vir=
tqueue *_vq,
>                         desc[i].len =3D cpu_to_le32(sg->length);
>                         desc[i].id =3D cpu_to_le16(id);
>
> -                       if (unlikely(vq->use_dma_api)) {
> +                       if (vring_need_unmap_buffer(vq)) {
>                                 vq->packed.desc_extra[curr].addr =3D addr=
;
>                                 vq->packed.desc_extra[curr].len =3D sg->l=
ength;
> -                               vq->packed.desc_extra[curr].flags =3D
> -                                       le16_to_cpu(flags);
>                         }
> +
> +                       vq->packed.desc_extra[curr].flags =3D le16_to_cpu=
(flags);
> +
>                         prev =3D curr;
>                         curr =3D vq->packed.desc_extra[curr].next;
>
> @@ -1530,6 +1520,8 @@ static inline int virtqueue_add_packed(struct virtq=
ueue *_vq,
>
>         vq->packed.avail_used_flags =3D avail_used_flags;
>
> +       WARN_ON(!vring_need_unmap_buffer(vq));
> +
>         for (n =3D 0; n < total_sg; n++) {
>                 if (i =3D=3D err_idx)
>                         break;
> @@ -1599,7 +1591,9 @@ static void detach_buf_packed(struct vring_virtqueu=
e *vq,
>         struct vring_desc_state_packed *state =3D NULL;
>         struct vring_packed_desc *desc;
>         unsigned int i, curr;
> +       u16 flags;
>
> +       flags =3D vq->packed.desc_extra[id].flags;

Can we check vq->indirect && indir_desc here? Then we don't need
special care to store flags in desc_extra.

>         state =3D &vq->packed.desc_state[id];
>
>         /* Clear data ptr. */
> @@ -1609,22 +1603,32 @@ static void detach_buf_packed(struct vring_virtqu=
eue *vq,
>         vq->free_head =3D id;
>         vq->vq.num_free +=3D state->num;
>
> -       if (unlikely(vq->use_dma_api)) {
> -               curr =3D id;
> -               for (i =3D 0; i < state->num; i++) {
> -                       vring_unmap_extra_packed(vq,
> -                                                &vq->packed.desc_extra[c=
urr]);
> -                       curr =3D vq->packed.desc_extra[curr].next;
> +       if (!(flags & VRING_DESC_F_INDIRECT)) {
> +               if (vring_need_unmap_buffer(vq)) {
> +                       curr =3D id;
> +                       for (i =3D 0; i < state->num; i++) {
> +                               vring_unmap_extra_packed(vq,
> +                                                        &vq->packed.desc=
_extra[curr]);
> +                               curr =3D vq->packed.desc_extra[curr].next=
;
> +                       }
>                 }
> -       }
>
> -       if (vq->indirect) {
> +               if (ctx)
> +                       *ctx =3D state->indir_desc;
> +       } else {
> +               const struct vring_desc_extra *extra;
>                 u32 len;
>
> +               if (vq->use_dma_api) {
> +                       extra =3D &vq->packed.desc_extra[id];
> +                       dma_unmap_single(vring_dma_dev(vq),
> +                                        extra->addr, extra->len,
> +                                        (flags & VRING_DESC_F_WRITE) ?
> +                                        DMA_FROM_DEVICE : DMA_TO_DEVICE)=
;
> +               }
> +
>                 /* Free the indirect table, if any, now that it's unmappe=
d. */
>                 desc =3D state->indir_desc;
> -               if (!desc)
> -                       return;
>
>                 if (vring_need_unmap_buffer(vq)) {
>                         len =3D vq->packed.desc_extra[id].len;
> @@ -1634,8 +1638,6 @@ static void detach_buf_packed(struct vring_virtqueu=
e *vq,
>                 }
>                 kfree(desc);
>                 state->indir_desc =3D NULL;
> -       } else if (ctx) {
> -               *ctx =3D state->indir_desc;
>         }
>  }
>
> --
> 2.32.0.3.g01195cf9f
>

Thanks

