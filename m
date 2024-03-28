Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9773224D0
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611137; cv=none; b=M6q3cs6am/H8EfASJa2mFkLqXqlrpU/zYksqcYvaYk/dSJeudPx3d7ODDQeHTSvgZNVrIfUx0m5l/OXHrrhOD40FZKfZ8gSc8JHvClvf0lYF8YStmu5Eppfz/XBVKHxfcOeRj7wGIwrdt9ob/S23iO8dn0L2NTUYhYCqrZ5FOmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611137; c=relaxed/simple;
	bh=NB+ZcMdRlFv1nhFzQJEkcZIMRID0ordT2RdMq+lvTgg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=qaAetDhk7DFNfXNVoFNAJQE4LYgGrYjXD3l6a8mAYmaYFZvjbEUzNK1mr2+8Qx8zq6N2X4H75+Rx56PP3TQ/goOkPDUXkExHXHDn3jHJxrcKrEUTt0Tg+o4LMGakNHyV9vLUJTodj2B27WaxEKQUR8xNlkoioJSVIVn9xU1ab7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lCyZvEsi; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lCyZvEsi"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711611131; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=WlaUiAM+QDhtvEnaj9MvDLchvWViVUAtkZQToFbedzg=;
	b=lCyZvEsixLghRwjodHN7Q1XD0BhY3yhM90bpLiNJMu383GxAj4++UT8dUy0Nag9twEpyYUr3QSJAqdIU397q70ntqVL8W8PdYB6uEsPIA4sMUzNUwpEGMcH3PX9XGLUg2vXqoFvpfV6GtQK/d4bVtPE/nzc1zCuz4tZeP+/qFsY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W3SYYoE_1711611130;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3SYYoE_1711611130)
          by smtp.aliyun-inc.com;
          Thu, 28 Mar 2024 15:32:11 +0800
Message-ID: <1711610846.0120149-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v6 02/10] virtio_ring: packed: remove double check of the unmap ops
Date: Thu, 28 Mar 2024 15:27:26 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
 <20240327111430.108787-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEsG7+mNx4WqhAuhrpk1bhLEwrTzngT5q=CZ_aHkzRasVg@mail.gmail.com>
In-Reply-To: <CACGkMEsG7+mNx4WqhAuhrpk1bhLEwrTzngT5q=CZ_aHkzRasVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 28 Mar 2024 14:56:47 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > In the functions vring_unmap_extra_packed and vring_unmap_desc_packed,
> > multiple checks are made whether unmap is performed and whether it is
> > INDIRECT.
> >
> > These two functions are usually called in a loop, and we should put the
> > check outside the loop.
> >
> > And we unmap the descs with VRING_DESC_F_INDIRECT on the same path with
> > other descs, that make the thing more complex. If we distinguish the
> > descs with VRING_DESC_F_INDIRECT before unmap, thing will be clearer.
> >
> > For desc with VRING_DESC_F_INDIRECT flag:
> > 1. only one desc of the desc table is used, we do not need the loop
> >     Theoretically, indirect descriptors could be chained.
> >     But now, that is not supported by "add", so we ignore this case.
> > 2. the called unmap api is difference from the other desc
> > 3. the vq->premapped is not needed to check
> > 4. the vq->indirect is not needed to check
> > 5. the state->indir_desc must not be null
>
> It doesn't explain the connection to the goal of this series. If it's
> not a must I'd suggest moving it to a separate patch.


The "no store dma ..." depends this.

I will add this message in next version.


>
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> Rethink this, it looks to me it would complicate the codes furtherly.
>
> For example, vring_map_xxx() helpers will check premappred and
> use_dma_api by itself. But in the case of vring_unmap() you want to
> move those checks to the caller. This will result in tricky codes that
> are hard to understand.
>
> We need to be consistent here.
>
> If we try to optimize unmap we need to optimize map as well. But
> generally it would complicate the logic of the caller if we want to
> let the caller to differ. Ideally, the caller of those function should
> know nothing about use_dma_api, premapped and other.


The key is that we can check "use_dma_api, premapped" to skip the loop.
If the vring_unmap_xxx is called, the "use_dma_api, premapped" is checked in
advance, so that is a waste to check thest again.


>
> > ---
> >  drivers/virtio/virtio_ring.c | 78 ++++++++++++++++++------------------
> >  1 file changed, 40 insertions(+), 38 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 03360073bd4a..a2838fe1cc08 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1214,6 +1214,7 @@ static u16 packed_last_used(u16 last_used_idx)
> >         return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
> >  }
> >
> > +/* caller must check vring_need_unmap_buffer() */
> >  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
> >                                      const struct vring_desc_extra *ext=
ra)
> >  {
> > @@ -1221,33 +1222,18 @@ static void vring_unmap_extra_packed(const stru=
ct vring_virtqueue *vq,
> >
> >         flags =3D extra->flags;
> >
> > -       if (flags & VRING_DESC_F_INDIRECT) {
> > -               if (!vq->use_dma_api)
> > -                       return;
> > -
> > -               dma_unmap_single(vring_dma_dev(vq),
> > -                                extra->addr, extra->len,
> > -                                (flags & VRING_DESC_F_WRITE) ?
> > -                                DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > -       } else {
> > -               if (!vring_need_unmap_buffer(vq))
> > -                       return;
> > -
> > -               dma_unmap_page(vring_dma_dev(vq),
> > -                              extra->addr, extra->len,
> > -                              (flags & VRING_DESC_F_WRITE) ?
> > -                              DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > -       }
> > +       dma_unmap_page(vring_dma_dev(vq),
> > +                      extra->addr, extra->len,
> > +                      (flags & VRING_DESC_F_WRITE) ?
> > +                      DMA_FROM_DEVICE : DMA_TO_DEVICE);
> >  }
> >
> > +/* caller must check vring_need_unmap_buffer() */
> >  static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
> >                                     const struct vring_packed_desc *des=
c)
> >  {
> >         u16 flags;
> >
> > -       if (!vring_need_unmap_buffer(vq))
> > -               return;
> > -
> >         flags =3D le16_to_cpu(desc->flags);
> >
> >         dma_unmap_page(vring_dma_dev(vq),
> > @@ -1323,7 +1309,7 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
> >                         total_sg * sizeof(struct vring_packed_desc),
> >                         DMA_TO_DEVICE);
> >         if (vring_mapping_error(vq, addr)) {
> > -               if (vq->premapped)
> > +               if (!vring_need_unmap_buffer(vq))
> >                         goto free_desc;
>
> I would do this to make it much more easier to be read and avoid the warn:
>
> if (vring_mapping_error(vq, addr))
>         goto unmap_release;
>
> unmap_release:
>         if (vring_need_unmap_buffer(vq))
>                 for (i =3D 0, xxx)
> free_desc:
>         kfree(desc);
>
> or it could be
>
> unmap_release:
>       if (!vring_need_unmap_buffer(vq))
>             goto free_desc;
>
> Still tricky but better.

I am ok.


>
> >
> >                 goto unmap_release;
> > @@ -1338,10 +1324,11 @@ static int virtqueue_add_indirect_packed(struct=
 vring_virtqueue *vq,
> >                 vq->packed.desc_extra[id].addr =3D addr;
> >                 vq->packed.desc_extra[id].len =3D total_sg *
> >                                 sizeof(struct vring_packed_desc);
> > -               vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRE=
CT |
> > -                                                 vq->packed.avail_used=
_flags;
> >         }
> >
> > +       vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT |
> > +               vq->packed.avail_used_flags;
>
> An example of the tricky code, I think you do this because you want to
> differ indirect in detach_buf_packed():
>
> flags =3D vq->packed.desc_extra[id].flags;
>
>
> > +
> >         /*
> >          * A driver MUST NOT make the first descriptor in the list
> >          * available before all subsequent descriptors comprising
> > @@ -1382,6 +1369,8 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
> >  unmap_release:
> >         err_idx =3D i;
> >
> > +       WARN_ON(!vring_need_unmap_buffer(vq));
> > +
> >         for (i =3D 0; i < err_idx; i++)
> >                 vring_unmap_desc_packed(vq, &desc[i]);
> >
> > @@ -1475,12 +1464,13 @@ static inline int virtqueue_add_packed(struct v=
irtqueue *_vq,
> >                         desc[i].len =3D cpu_to_le32(sg->length);
> >                         desc[i].id =3D cpu_to_le16(id);
> >
> > -                       if (unlikely(vq->use_dma_api)) {
> > +                       if (vring_need_unmap_buffer(vq)) {
> >                                 vq->packed.desc_extra[curr].addr =3D ad=
dr;
> >                                 vq->packed.desc_extra[curr].len =3D sg-=
>length;
> > -                               vq->packed.desc_extra[curr].flags =3D
> > -                                       le16_to_cpu(flags);
> >                         }
> > +
> > +                       vq->packed.desc_extra[curr].flags =3D le16_to_c=
pu(flags);
> > +
> >                         prev =3D curr;
> >                         curr =3D vq->packed.desc_extra[curr].next;
> >
> > @@ -1530,6 +1520,8 @@ static inline int virtqueue_add_packed(struct vir=
tqueue *_vq,
> >
> >         vq->packed.avail_used_flags =3D avail_used_flags;
> >
> > +       WARN_ON(!vring_need_unmap_buffer(vq));
> > +
> >         for (n =3D 0; n < total_sg; n++) {
> >                 if (i =3D=3D err_idx)
> >                         break;
> > @@ -1599,7 +1591,9 @@ static void detach_buf_packed(struct vring_virtqu=
eue *vq,
> >         struct vring_desc_state_packed *state =3D NULL;
> >         struct vring_packed_desc *desc;
> >         unsigned int i, curr;
> > +       u16 flags;
> >
> > +       flags =3D vq->packed.desc_extra[id].flags;
>
> Can we check vq->indirect && indir_desc here? Then we don't need
> special care to store flags in desc_extra.


No.

When vq->indirect is true, but the desc may has not indirect flag.

Thanks.


>
> >         state =3D &vq->packed.desc_state[id];
> >
> >         /* Clear data ptr. */
> > @@ -1609,22 +1603,32 @@ static void detach_buf_packed(struct vring_virt=
queue *vq,
> >         vq->free_head =3D id;
> >         vq->vq.num_free +=3D state->num;
> >
> > -       if (unlikely(vq->use_dma_api)) {
> > -               curr =3D id;
> > -               for (i =3D 0; i < state->num; i++) {
> > -                       vring_unmap_extra_packed(vq,
> > -                                                &vq->packed.desc_extra=
[curr]);
> > -                       curr =3D vq->packed.desc_extra[curr].next;
> > +       if (!(flags & VRING_DESC_F_INDIRECT)) {
> > +               if (vring_need_unmap_buffer(vq)) {
> > +                       curr =3D id;
> > +                       for (i =3D 0; i < state->num; i++) {
> > +                               vring_unmap_extra_packed(vq,
> > +                                                        &vq->packed.de=
sc_extra[curr]);
> > +                               curr =3D vq->packed.desc_extra[curr].ne=
xt;
> > +                       }
> >                 }
> > -       }
> >
> > -       if (vq->indirect) {
> > +               if (ctx)
> > +                       *ctx =3D state->indir_desc;
> > +       } else {
> > +               const struct vring_desc_extra *extra;
> >                 u32 len;
> >
> > +               if (vq->use_dma_api) {
> > +                       extra =3D &vq->packed.desc_extra[id];
> > +                       dma_unmap_single(vring_dma_dev(vq),
> > +                                        extra->addr, extra->len,
> > +                                        (flags & VRING_DESC_F_WRITE) ?
> > +                                        DMA_FROM_DEVICE : DMA_TO_DEVIC=
E);
> > +               }
> > +
> >                 /* Free the indirect table, if any, now that it's unmap=
ped. */
> >                 desc =3D state->indir_desc;
> > -               if (!desc)
> > -                       return;
> >
> >                 if (vring_need_unmap_buffer(vq)) {
> >                         len =3D vq->packed.desc_extra[id].len;
> > @@ -1634,8 +1638,6 @@ static void detach_buf_packed(struct vring_virtqu=
eue *vq,
> >                 }
> >                 kfree(desc);
> >                 state->indir_desc =3D NULL;
> > -       } else if (ctx) {
> > -               *ctx =3D state->indir_desc;
> >         }
> >  }
> >
> > --
> > 2.32.0.3.g01195cf9f
> >
>
> Thanks
>
