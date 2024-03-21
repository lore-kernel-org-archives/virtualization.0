Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B6BE4E
	for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009279; cv=none; b=nBAUbPysqIbcOEaIPUrcBqapYJN2b+qjdUXd5C8MMe85ScfwDAr+OFucF/HqoQGk56s08Hf7wOR8rIxTvKfrIlwscVdTqB4kTSLZSR1txdadEkSBlJYzW55Oe1YirtB0R7JOr2WA2q/sEB7+N+FV+1fZwopdcT1r88vTtszLxwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009279; c=relaxed/simple;
	bh=FQ9/99AzWEN2KSFnQAaimh8EVpHMWb/vBgPgnz4qBTo=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=ofgztO05vbHhRZFTCa/uL1zEAqMSXM2+6YuHOVs39O9cTVo8synyFrk+/RFy4XMSL1t7b2ywEz06y+NlB0DoDlu8SZji0GaQGpG2slEdhcc00y9VzPadxZG6tHAI9OdYGHaCk3tjXtK5IoflReGOWiTCBW437uCMqqCpxKp6hzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jBaTvVP+; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jBaTvVP+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711009269; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=EqQ4bkSb/XLfISlbX9PN2a8ugSba+NZmIerwF5wTXPg=;
	b=jBaTvVP+HcQadLHClGezWW/YkeewgyKGJjr7tbXkTmPbdEV1KSS1lHY3e1/96Ab4wdFOl60uWdLumYIfGYEn8OYgWeIotBf+zL/w9h7WiG5yHrMBkKIpyAgDAf4JB9VxSiIbjxqBgNpww3gMHSWeS1JNpISxgkf4THnumeTHeSQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W3-BwmK_1711009267;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3-BwmK_1711009267)
          by smtp.aliyun-inc.com;
          Thu, 21 Mar 2024 16:21:08 +0800
Message-ID: <1711009209.0488706-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v4 02/10] virtio_ring: packed: remove double check of the unmap ops
Date: Thu, 21 Mar 2024 16:20:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
 <20240312033557.6351-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEtd1L=Cm0DWLZbfSazxxHr+iPP77B1kM=PmjdqeYoAz4w@mail.gmail.com>
In-Reply-To: <CACGkMEtd1L=Cm0DWLZbfSazxxHr+iPP77B1kM=PmjdqeYoAz4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 21 Mar 2024 13:57:06 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Mar 12, 2024 at 11:36=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
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
> > 1. only one desc of the desc table is used, we do not need the loop
> > 2. the called unmap api is difference from the other desc
> > 3. the vq->premapped is not needed to check
> > 4. the vq->indirect is not needed to check
> > 5. the state->indir_desc must not be null
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 78 ++++++++++++++++++------------------
> >  1 file changed, 40 insertions(+), 38 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index c2779e34aac7..0dfbd17e5a87 100644
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
>
> Theoretically, indirect descriptors could be chained. It is supported
> without this patch but not here.


YES. But now, that is not supported by "add", so I think we
do not need to think about it.

Thanks.

>
> Thanks
>
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
