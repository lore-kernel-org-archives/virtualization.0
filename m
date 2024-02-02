Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7145F17545
	for <virtualization@lists.linux.dev>; Fri,  2 Feb 2024 05:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706853531; cv=none; b=FbwXVprZtDbFK3vdHdPjVwLn57BZw7qU4QC9xscA0bBJmJiHChRZqKxspxXCt5fEXFKNf1tmtgWcd0/76sTcVpoAmucfKiuFduLohNyFk3AY8IVsreUqfMdxs4khJ+GAyfSWVFbYkK86CQrgSFvF2ifMDD0mwcuBdwfaT3SVUt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706853531; c=relaxed/simple;
	bh=IIQi92UAYkBbzJh9jkRd3bkiv9W2OHbBX/sYMUmfMoQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=JcF5ZYvTL1DRGrtZfyGA7+lNTIUCvHD4VVZrtoyGBNpBrNWtGW47kFs7aocWj+Bj+DPL2CFDq9T09qX07c5EmKUXkD8l/DTCL2zd3JkvVYpN83Qcr7FJcg5M5jI0f2QFCFA+oUNGc+qPYBY7DtBLaqb/Chv2DdeisX6lsNwNtXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PGTB+JTP; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PGTB+JTP"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706853518; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=yf4JL/9kQK/THNijAegLfepr3jkCrcs39c9+8/taalM=;
	b=PGTB+JTPNNfAdOjuBMR1BebZwa/FV1qLmKiePuX9qTBUvhAKqbDCvYfcZvXRqOLaB6kajZe7oyteItPkw0T/DHFVDaDdOtPr/o0//XGT/YrLHZnInPZfXUyHJ5bKJOL7ckBqhrTqrQLouOJkyxBW2H2ajUgsWAXqVoUrTM+d7W0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W.w11Mf_1706853515;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.w11Mf_1706853515)
          by smtp.aliyun-inc.com;
          Fri, 02 Feb 2024 13:58:36 +0800
Message-ID: <1706853399.1761992-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio: packed: fix unmap leak for indirect desc table
Date: Fri, 2 Feb 2024 13:56:39 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240201095618.2288-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsMm2QoWUa=JMnFha4ufd1w8Vs1=MtvNeYKm2B4oPgupw@mail.gmail.com>
In-Reply-To: <CACGkMEsMm2QoWUa=JMnFha4ufd1w8Vs1=MtvNeYKm2B4oPgupw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Fri, 2 Feb 2024 11:46:59 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Feb 1, 2024 at 5:56=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> >
> > When use_dma_api and premapped are true, then the do_unmap is false.
> >
> > Because the do_unmap is false, vring_unmap_extra_packed is not called by
> > detach_buf_packed.
> >
> >  if (unlikely(vq->do_unmap)) {
> >                curr =3D id;
> >                for (i =3D 0; i < state->num; i++) {
> >                        vring_unmap_extra_packed(vq,
> >                                                 &vq->packed.desc_extra[=
curr]);
> >                        curr =3D vq->packed.desc_extra[curr].next;
> >                }
> >   }
> >
> > So the indirect desc table is not unmapped. This causes the unmap leak.
> >
> > On the other side, the dma addr and the flags is not updated. That
> > will be used by vring_unmap_extra_packed.
> >
> > For safety in this patch, the flags of desc without indirect flag is
> > also updated.
> >
> > This bug does not occur, because no driver use the premapped with
> > indirect.
> >
> > Fixes: b319940f83c2 ("virtio_ring: skip unmap for premapped")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 49299b1f9ec7..097258a10819 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1340,14 +1340,15 @@ static int virtqueue_add_indirect_packed(struct=
 vring_virtqueue *vq,
> >                                 sizeof(struct vring_packed_desc));
> >         vq->packed.vring.desc[head].id =3D cpu_to_le16(id);
> >
> > -       if (vq->do_unmap) {
> > +       if (vq->use_dma_api) {
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
> > +
> >         /*
> >          * A driver MUST NOT make the first descriptor in the list
> >          * available before all subsequent descriptors comprising
> > @@ -1484,9 +1485,10 @@ static inline int virtqueue_add_packed(struct vi=
rtqueue *_vq,
> >                         if (unlikely(vq->do_unmap)) {
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
> > @@ -1615,13 +1617,11 @@ static void detach_buf_packed(struct vring_virt=
queue *vq,
> >         vq->free_head =3D id;
> >         vq->vq.num_free +=3D state->num;
> >
> > -       if (unlikely(vq->do_unmap)) {
>
> I think we can simply change this to check vq->use_dma_api,

Sure.

> then we
> don't need to move the flags assignment to extra above?

In virtqueue_add_packed, we should update flags,
vring_unmap_extra_packed will check it unconditional.

Thanks

>
> Thanks
>
> > -               curr =3D id;
> > -               for (i =3D 0; i < state->num; i++) {
> > -                       vring_unmap_extra_packed(vq,
> > -                                                &vq->packed.desc_extra=
[curr]);
> > -                       curr =3D vq->packed.desc_extra[curr].next;
> > -               }
> > +       curr =3D id;
> > +       for (i =3D 0; i < state->num; i++) {
> > +               vring_unmap_extra_packed(vq,
> > +                                        &vq->packed.desc_extra[curr]);
> > +               curr =3D vq->packed.desc_extra[curr].next;
> >         }
> >
> >         if (vq->indirect) {
> > --
> > 2.32.0.3.g01195cf9f
> >
>
